# Documentation aka user tutorial (v.5)

### 0. First setup
a) Before some actions the user have to load the Ratatoskr package from the [release page](https://github.com/natsuru-san/Ratatoskr/releases) in depend on CPU-architecture of a goal-machine (arm or x86). The setting up is easy and a command above is enough:

  * root@machine:#~`dpkg -i ratatoskr_5.1.*`

    or

  * root@machine:#~`apt install ./ratatoskr_5.1.*`

  Since an installation moment you may run it as a service using the command:

  * root@machine:#~`service ratatoskr start`

  After performing the daemon is working with a single route given as an example in `/etc/ratatoskr.yaml`. The logging of the work you may see through the command:

  * root@machine:#~`journalctl -u ratatoskr`

  or if in real time

  * root@machine:#~`journalctl -u ratatoskr -f`

b) Next step is a configuring JVM args located in the path "*/usr/lib/ratatoskr/ratatoskr.args*" inside a variable "*JVM_ARGS*".

  * If your goal machine has 512mb RAM or less highly recommended add the `-XX:ParallelGCThreads=1` argument. The argument restricts an embedded garbage collector by the one thread. Otherwise, the GC will utilize more memory than enough and the OS will invoke OOM-killer. It is not relevant for machines having 1gb RAM or more.

  * Adjust `-XX:InitialHeapSize=1300m` and`-XX:MaxHeapSize=1300m` to restrict memory consuming. The "*InitialHeapSize*" means the heap size at app starting. The "*MaxHeapSize*" is the main restriction of heap consuming memory. Total memory consuming is the heap size plus 35mb approximately.

  * Set the `-XX:MaxNewSize=1024m` to 80% from "*MaxHeapSize*". It is needed because the cryptographic algorithms require much memory during handshakes. On the contrary long-living objects occupy memory in depend on connection pool size specified by user and the size is small.

  * You may erase these arguments also if you don't want to calculate values of the args :)

  * For debug memory consuming the `-XX:+PrintGC` may be useful.

  Note that the "*APP_ARGS*" variable does not need to be adjusted unless absolutely necessary.

### 1. YAML static configuration

To use the kind of configuration you have to edit the file using the command **`nano /etc/ratatoskr.yaml`** for your needs. A description of elements you may see in [YamlConfiguration.md](YamlConfiguration.md).

### 2. Database configuration
The database configuration is dynamic and may be set on the air. In enabled db connection the Ratatoskr uses to checking database for new routes every minute. If it discovers changes it apply new configuration immediately. In this configuration a fallback mode is available. If the database connection is lost for a long time the next restart won't crash the app because the last info about routes and their params was saved to an encrypted file "*/usr/lib/ratatoskr/fallback.rfc*" and it will read the file. The RFC-file also contains keystores and passwords which can't be ejected from it.

a) The first step is the rolling Liquibase scripts. Before rolling set up necessary packages:
`sudo apt install git maven openjdk-25-jre`.

b) After installation clone this repository by using the command `git clone https://github.com/natsuru-san/Ratatoskr.git` and `cd Ratatoskr` after the previous. Note, the repository contains the only one branch with actual Liquibase scripts for the newest version. For previous versions of the repo you may look for source code on the release page.

c) Define values for variables and perform them:

`export DB_LIQUI_HOST="192.168.0.255"`

`export DB_LIQUI_PORT="5432"`

`export DB_LIQUI_NAME="my_db"`

`export DB_LIQUI_USER="my_user"`

`export DB_LIQUI_PASSWORD="mYpAsSwOrD"`

`export DB_LIQUI_SCHEMA="my_schema"`

  * Note the database user must have rights to create, alter and delete tables!

d) Perform the command: `mvn liquibase:update`.

e) To use the configuration you must set db-params to the "*/etc/ratatoskr.yaml*":

  * *ratatoskr.db.enabled* must be set in `true`.
  * *ratatoskr.db.unitName* must be set as name of the service. Usually it is a server name.
  * *ratatoskr.db.url* must start from `jdbc:postgresql://` and contained hostname, port, database name, schema name.
  * *ratatoskr.db.login*
  * *ratatoskr.db.password*

f) Fill tables with data. All tables are an analog of the YAML-configuration and its describe in [DbConfiguration.md](DbConfiguration.md) as a reference.

### 3. Commandline arguments
The app also contains util functions are helping configuration setting. The list of arguments are being go to replenish in the near future.

* **Reference command** shows help page:

  `ratatoskr --help`

* **Hardware SHA256 printer** shows an identifier encoded into the sha256 string (the real HWID won't be printed!):

  `ratatoskr --print-hardware-id`

* **Keystore encoder** prints a base64 string to the adding it in the database column "*keystore.content*":

  `ratatoskr --get-encoded-keystore /path/to/keystore.p12`

### 4. Certificate generating

It is described for an example and testing in the [CertGenerating.md](CertGenerating.md)