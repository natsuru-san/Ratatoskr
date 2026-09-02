# Documentation aka user tutorial (v.5)

### 0. First setup
a) Before some actions the user have to load the Ratatoskr package from the [release page](https://github.com/natsuru-san/Ratatoskr/releases) in depend on CPU-architecture of a goal-machine (arm or x86). The setting up is easy and a command above is enough:

  * user@machine:#~`dpkg -i ratatoskr_5.1.*`

    or

  * user@machine:#~`apt install ./ratatoskr_5.1.*`

b) Next step is a configuring JVM args located in the path "*/usr/lib/ratatoskr/ratatoskr.args*" inside a variable "*JVM_ARGS*".

  * If your goal machine has 512mb RAM or less highly recommended add the `-XX:ParallelGCThreads=1` argument. The argument restricts an embedded garbage collector by the one thread. Otherwise, the GC will utilize more memory than enough and the OS will invoke OOM-killer. It is not relevant for machines having 1gb RAM or more.

  * Adjust `-XX:InitialHeapSize=1300m` and`-XX:MaxHeapSize=1300m` to restrict memory consuming. The "*InitialHeapSize*" means the heap size at app starting. The "*MaxHeapSize*" is the main restriction of heap consuming memory.

  * Set the `-XX:MaxNewSize=1024m` to 80% from "*MaxHeapSize*". It is needed because the cryptographic algorithms require much memory during handshakes. On the contrary long-living objects occupy memory in depend on connection pool size specified by user and the size is small.

  * You may erase these arguments also if you don't want to calculate values of the args :)

  * For debug memory consuming the `-XX:+PrintGC` may be useful.

  Note that the "*APP_ARGS*" variable does not need to be adjusted unless absolutely necessary.

### 1. YAML static configuration
  * Further open the "*/etc/ratatoskr.yaml*" and define with what config do you want to use the service. You are available to use this "YAML" config and a database config. For using database configuration please read the paragraph #2 (*Database configuration*).

  * If you are the person, and you are going to use this app for self set the *ratatoskr.license* value to `PERSONAL`. Otherwise, you have to contact with author to get a valid license key.

  * Block *ratatoskr.database.enabled* must be set `false`

  * To get alerts to a Telegram bot write a valid token to *ratatoskr.logger.token* and chat identifier to *ratatoskr.logger.chatId*. Empty values mean that Telegram alerts disabled.

  * Add routes to *ratatoskr.routes*. The block is an array. So you may run multiple routes per one time with various configurations. Parameters of one route for example:

    | Parameter   | Type         | Example value | Description                                                                                     |
    |-------------|--------------|---------------|-------------------------------------------------------------------------------------------------|
    | name        | string       | MySiteName    | The name of route                                                                               |
    | poolSize    | unsigned int | 20            | Max count of virtual threads which the route can maintain                                       |
    | useSystemCa | bool         | true          | Setting the system CA authorities as trusted                                                    |
    | gateway     | object       |               | The block describes a server which listens a port and receives connections                      |
    | target      | object       |               | The block describes a target destination where the received from gateway traffic will be routed |

    A gateway block has next parameters:

    | Parameter | Type               | Example value | Description                                                   |
    |-----------|--------------------|---------------|---------------------------------------------------------------|
    | keystore  | object             |               | The block describes a keystore path and password for it       |
    | filter    | object             |               | The block describes a filtration of IP-addresses              |
    | tls       | object             |               | The block describes encryption params of the gateway and mode |
    | port      | unsigned short int | 8080          | Port number for listening and establishing of connections     |

    A target block has next parameters:

    | Parameter | Type               | Example value | Description                                               |
    |-----------|--------------------|---------------|-----------------------------------------------------------|
    | keystore  | object             |               | The block describes a keystore path and password for it   |
    | tls       | bool               | false         | Enable or disable TLS-mode with target server             |
    | host      | string             | 192.168.0.1   | IP-address or hostname of target server                   |
    | port      | unsigned short int | 8080          | Port number for listening and establishing of connections |

    Both of a gateway and target blocks have a keystore block:

    | Parameter | Type   | Example value                               | Description                                                           |
    |-----------|--------|---------------------------------------------|-----------------------------------------------------------------------|
    | path      | string | /home/natsuru/Desktop/ssl/certs/natsuru.p12 | The path to a keystore which contains certificate chain and key       |
    | pass      | string | qwerty1234                                  | The password for the given keystore and for a key inside the keystore |

    The gateway block contains a tls-block describing TLS-mode:

    | Parameter     | Type           | Example value | Description                                                                                              |
    |---------------|----------------|---------------|----------------------------------------------------------------------------------------------------------|
    | enabled       | bool           | true          | Enables and disables TLS-mode. When false the gateway operates with traffic without any impact           |
    | mutual        | bool           | true          | If true the gateway will require a client certificate                                                    |
    | cacheSize     | unsigned int   | 20            | Count of clients the connections of which can be resumed without repeat of heavy handshake               |
    | cacheTimeout  | unsigned int   | 3600          | Timeout in seconds for clients the connections of which can be resumed without repeat of heavy handshake |

    The gateway block contains a filter-block describing rules of accepting connections:

    | Parameter | Type   | Example value                  | Description                                                                                                                                                                                    |
    |-----------|--------|--------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | list      | string | 192.168.0.2,127.0.0.7,10.0.0.4 | IP-addresses for filtration                                                                                                                                                                    |
    | mode      | string | blacklist/whitelist            | Mode for filtration. If user is picked up a blacklist connections from enumerated IP-addresses will be dropped. If user select the whitelist all connections will be dropped except enumerated |

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

f) Fill tables with data. All tables are an analog of the YAML-configuration, so you may use the first paragraph (*YAML static configuration*) as a reference. But there is one exception: a keystore table has a content column instead the path and receives p12-keystores as Base64 text.