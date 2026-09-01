CREATE TABLE unit (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(64) NOT NULL UNIQUE,
    licence BOOLEAN DEFAULT FALSE NOT NULL,
    messenger_token TEXT,
    messenger_chat_id TEXT
);

CREATE TABLE keystore (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    description TEXT,
    content TEXT NOT NULL,
    password TEXT NOT NULL
);

CREATE TABLE filter (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    description TEXT,
    mode TEXT NOT NULL
);

CREATE TABLE filter_ip_addr (
    ip TEXT,
    filter_id INT NOT NULL,
    CONSTRAINT fk_filter_id FOREIGN KEY (filter_id) REFERENCES filter(id)
);

CREATE TABLE route (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    unit_id INT NOT NULL,
    name VARCHAR(64) NOT NULL,
    authorities TEXT,
    pool_size SMALLINT NOT NULL,
    tls_cache_size INT,
    tls_cache_timeout INT,
    filter_id INT,
    gateway_port INT NOT NULL,
    gateway_keystore_id INT,
    gateway_tls_enabled BOOLEAN DEFAULT FALSE NOT NULL,
    gateway_tls_mutual BOOLEAN DEFAULT FALSE NOT NULL,
    target_port INT NOT NULL,
    target_host TEXT NOT NULL,
    target_keystore_id INT,
    target_tls_enabled BOOLEAN DEFAULT FALSE NOT NULL,
    target_tls_mutual BOOLEAN DEFAULT FALSE NOT NULL,
    CONSTRAINT fk_unit_id FOREIGN KEY (unit_id) REFERENCES unit(id),
    CONSTRAINT fk_gateway_keystore_id FOREIGN KEY (gateway_keystore_id) REFERENCES keystore(id),
    CONSTRAINT fk_target_keystore_id FOREIGN KEY (target_keystore_id) REFERENCES keystore(id),
    CONSTRAINT fk_filter_id FOREIGN KEY (filter_id) REFERENCES filter(id)
);