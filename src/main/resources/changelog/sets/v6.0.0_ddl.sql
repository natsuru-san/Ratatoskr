ALTER TABLE route DROP COLUMN use_system_ca;

ALTER TABLE keystore DROP COLUMN content;
ALTER TABLE keystore DROP COLUMN password;
ALTER TABLE keystore ADD COLUMN ca_chain text;
ALTER TABLE keystore ADD COLUMN tls_certificate text;
ALTER TABLE keystore ADD COLUMN tls_key text;

ALTER TABLE unit RENAME COLUMN messenger_token TO alert_telegram_token;
ALTER TABLE unit RENAME COLUMN messenger_chat_id TO alert_telegram_chat_id;
ALTER TABLE unit ADD COLUMN alert_successful BOOLEAN DEFAULT TRUE NOT NULL;
ALTER TABLE unit ADD COLUMN alert_rest_template TEXT DEFAULT NULL;
ALTER TABLE unit ADD COLUMN alert_spread_type VARCHAR(8) DEFAULT 'none';
ALTER TABLE unit ADD COLUMN alert_rest_url VARCHAR(4096) DEFAULT NULL;
ALTER TABLE unit ADD COLUMN alert_buffer_size INTEGER DEFAULT 100 NOT NULL;