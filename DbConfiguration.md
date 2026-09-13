# Configuration description
## The part contains a description of each element of the DB-configuration.

  The configuration is the same as YAML and describes by tables rolled from the Liquibase. First table is `unit`:

  | Column            | Type        | Example value | Description                                                                                                                                                                          |
  |-------------------|-------------|---------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
  | name              | VARCHAR(64) | My unit       | Describes a unit name to getting necessary configuration linked to the unit name. Note, the name must be equal with `ratatoskr.db.unitName` value otherwise the config won't be work |
  | licence           | TEXT        | PERSONAL      | The valid license encoded as a Base64-string                                                                                                                                         |
  | messenger_token   | TEXT        | 123456789     | The Telegram token for a bot to sending alerts. If emply the Telegram alerting will be disabled                                                                                      |
  | messenger_chat_id | TEXT        | 54321         | The Telegram chat id for a channel where alerts are collected. If emply the Telegram alerting will be disabled                                                                       |

  A **`route`** table has next columns:

  | Column              | Type        | Example value | Description                                                                                              |
  |---------------------|-------------|---------------|----------------------------------------------------------------------------------------------------------|
  | unit_id             | INT         | 1             | The link to an id column of the `unit` table                                                             |
  | name                | VARCHAR(64) | MySiteName    | The name of route                                                                                        |
  | pool_size           | INT         | 20            | Max count of virtual threads which the route can maintain                                                |
  | tls_cache_size      | INT         | 100           | Count of clients the connections of which can be resumed without repeat of heavy handshake               |
  | tls_cache_timeout   | INT         | 1800          | Timeout in seconds for clients the connections of which can be resumed without repeat of heavy handshake |
  | filter_id           | INT         | 1             | The link to an id column of the `filter` table                                                           |
  | gateway_port        | INT         | 443           | Port number for listening connections                                                                    |
  | gateway_keystore_id | INT         | 1             | The link to an id column of the `keystore` table for incoming TLS connections                            |
  | gateway_tls_enabled | BOOL        | FALSE         | Enables and disables TLS-mode. When false the gateway operates with traffic without any impact           |
  | gateway_tls_mutual  | BOOL        | FALSE         | If true the gateway will require a client certificate                                                    |
  | target_port         | INT         | 80            | Port number for establishing of connections with a target server or machine                              |
  | target_host         | TEXT        | 192.168.0.1   | IP-address or hostname of target server or machine                                                       |
  | target_keystore_id  | INT         | 1             | The link to an id column of the `keystore` table for target TLS connections                              |
  | target_tls_enabled  | BOOL        | TRUE          | Enable or disable TLS-mode with target server or machine                                                 |
  | useSystemCa         | bool        | true          | Setting the system CA authorities as trusted                                                             |

  A **`keystore`** table has next columns:

  | Column      | Type  | Example value                                    | Description                                                                 |
  |-------------|-------|--------------------------------------------------|-----------------------------------------------------------------------------|
  | description | TEXT  | My keystore for a connecting with my wifi-router | The description field and doesn't impact to work                            |
  | content     | TEXT  | uPbDUVzb6Omrj4IEtOqAwJ0CAicQ                     | The Base64-encoded PKSC12-keystore which contains certificate chain and key |
  | password    | TEXT  | qwerty1234                                       | The password for the given keystore and for a key inside the keystore       |

  A **`filter`** table has next columns:

  | Column       | Type   | Example value                  | Description                                                                                                                                                                                    |
  |--------------|--------|--------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
  | description  | TEXT   | My filter                      | The description field and doesn't impact to work                                                                                                                                               |
  | mode         | TEXT   | blacklist/whitelist            | Mode for filtration. If user is picked up a blacklist connections from enumerated IP-addresses will be dropped. If user select the whitelist all connections will be dropped except enumerated |

  A **`filter_ip_addr`** table has next columns:

  | Column     | Type | Example value | Description                                                        |
  |------------|------|---------------|--------------------------------------------------------------------|
  | ip         | TEXT | 192.168.0.2   | IP-address for applying filtration                                 |
  | filter_id  | INT  | 1             | The link to an id column of the `filter` table for filtration mode |
