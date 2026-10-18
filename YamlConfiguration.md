# Configuration description
## The part contains a description of each element of the YAML-configuration which placed in `/etc/ratatoskr.yaml`.

  The configuration begins from the root object named `ratatoskr` which is an object. The block contains next elements:

  | Parameter           | Type         | Example value | Description                                                                                                                                              |
  |---------------------|--------------|---------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
  | licence             | string       | PERSONAL      | The valid license encoded as a Base64-string                                                                                                             |
  | banner              | bool         | true/false    | The switcher is appearing or hiding the ratatoskr logo at the application start                                                                          |
  | gracefulTimeSeconds | unsigned int | 60            | The time in seconds for graceful shutdown of route. If the time is exceeded the route termination will be forcible                                       |
  | serverPort          | unsigned int | 8080          | A builtin http-server port for metrics or database changes applying                                                                                      |
  | autoApplyMinutes    | unsigned int | 10            | A database changes auto applying time in minutes. If the time reached the app is going to receive and apply changes automaticly. Ignores for yaml-config |
  | db                  | object       |               | The block of a database configuration                                                                                                                    |
  | alerts              | object       |               | Alerting params for important events                                                                                                                     |

  A **`db`** bloch has these elements:

  | Parameter   | Type          | Example value                                                         | Description                                                                                                                  |
  |-------------|---------------|-----------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------|
  | enabled     | bool          | false                                                                 | Enables or disables the DB-features. If enabled the `routes` will be ignored                                                 |
  | unitName    | string        | My unit                                                               | Describes a unit name from a *unit* table to getting necessary configuration linked to the unit name                         |
  | url         | string        | jdbc:postgresql://host:5432/applications?currentSchema=ratatoskr_test | A postgres url for connecting for your Postgres database                                                                     |
  | login       | string        | user_login                                                            | Database login                                                                                                               |
  | password    | string        | pAsSwOrD                                                              | Database password. Note, you should avoid passwords with brackets or special symbols because the app is not tested with them |
  | hikariPool  | unsigned int  | 5                                                                     | Database pool size. Usually 1-2 connections are enough                                                                       |

  A **`alerts`** block has next parameters:

  | Parameter       | Type         | Example value              | Description                                                                                                            |
  |-----------------|--------------|----------------------------|------------------------------------------------------------------------------------------------------------------------|
  | telegram        | object       |                            | The Telegram block with token and chat id for a bot to sending alerts. If emply the Telegram alerting will be disabled |
  | spreadType      | string       | none                       | Type of alerting. Available options are 'telegram', 'rest' or 'none'                                                   |
  | alertSuccessful | bool         | true                       | Enables successful connections alerts                                                                                  |
  | url             | string       | `http://exapmle.com/alert` | URL for the 'rest' alerting. Doesn't have any influence if user chose 'telegram' or 'none'                             |
  | template        | string       | { %s }                     | A user defined template with '%s' for custom alerting                                                                  |
  | bufferSize      | unsigned int | 100                        | The buffer size for alerts                                                                                             |

  A **`telegram`** block has next parameters:

  | Parameter | Type   | Example value | Description                                                                                                      |
  |-----------|--------|---------------|------------------------------------------------------------------------------------------------------------------|
  | token     | string | 123456789     | The Telegram token for a bot to sending alerts. If emply the Telegram alerting will be disabled                  |
  | chatId    | string | 54321         | The Telegram chat id for a channel where alerts are collected. If emply the Telegram alerting will be disabled   |

  A **`routes`** block has next parameters:

  | Parameter   | Type         | Example value | Description                                                                                     |
  |-------------|--------------|---------------|-------------------------------------------------------------------------------------------------|
  | name        | string       | MySiteName    | The name of route                                                                               |
  | poolSize    | unsigned int | 20            | Max count of virtual threads which the route can maintain                                       |
  | gateway     | object       |               | The block describes a server which listens a port and receives connections                      |
  | target      | object       |               | The block describes a target destination where the received from gateway traffic will be routed |

  A **`gateway`** block has next parameters:

  | Parameter | Type               | Example value | Description                                                   |
  |-----------|--------------------|---------------|---------------------------------------------------------------|
  | keystore  | object             |               | The block describes a keystore path and password for it       |
  | filter    | object             |               | The block describes a filtration of IP-addresses              |
  | tls       | object             |               | The block describes encryption params of the gateway and mode |
  | port      | unsigned short int | 8080          | Port number for listening and establishing of connections     |

  A **`target`** block has next parameters:

  | Parameter | Type               | Example value | Description                                               |
  |-----------|--------------------|---------------|-----------------------------------------------------------|
  | keystore  | object             |               | The block describes a keystore path and password for it   |
  | tls       | bool               | false         | Enable or disable TLS-mode with target server             |
  | host      | string             | 192.168.0.1   | IP-address or hostname of target server                   |
  | port      | unsigned short int | 8080          | Port number for listening and establishing of connections |

  Both of a gateway and target blocks have a **`keystore`** block:

  | Parameter | Type   | Example value                           | Description                        |
  |-----------|--------|-----------------------------------------|------------------------------------|
  | caChain   | string | /home/natsuru/Desktop/ssl/certs/ca.pem  | The path to a certificate chain    |
  | tls       | string | /home/natsuru/Desktop/ssl/certs/tls.pem | The path to a user certificate     |
  | key       | string | /home/natsuru/Desktop/ssl/certs/key.pem | The path to a user certificate key |

  The gateway block contains a **`tls`** block describing TLS-mode:

  | Parameter     | Type           | Example value | Description                                                                                              |
  |---------------|----------------|---------------|----------------------------------------------------------------------------------------------------------|
  | enabled       | bool           | true          | Enables and disables TLS-mode. When false the gateway operates with traffic without any impact           |
  | mutual        | bool           | true          | If true the gateway will require a client certificate                                                    |
  | cacheSize     | unsigned int   | 20            | Count of clients the connections of which can be resumed without repeat of heavy handshake               |
  | cacheTimeout  | unsigned int   | 3600          | Timeout in seconds for clients the connections of which can be resumed without repeat of heavy handshake |

  The gateway block contains a **`filter`** block describing rules of accepting connections:

  | Parameter | Type   | Example value                  | Description                                                                                                                                                                                    |
  |-----------|--------|--------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
  | list      | string | 192.168.0.2,127.0.0.7,10.0.0.4 | IP-addresses for filtration                                                                                                                                                                    |
  | mode      | string | blacklist/whitelist            | Mode for filtration. If user is picked up a blacklist connections from enumerated IP-addresses will be dropped. If user select the whitelist all connections will be dropped except enumerated |

