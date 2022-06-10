SET session total.users = 10;
SET session total.banks = 5;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id INTEGER,
    name VARCHAR(100),
    email VARCHAR(100)
);
INSERT INTO users
SELECT 
    id,
    'User ' || id AS name,
    'user.' || id || '@example.com' AS email
FROM
     generate_series(1, current_setting('total.users')::INTEGER) id;

DROP TABLE IF EXISTS banks;
CREATE TABLE banks (
    id INTEGER,
    name VARCHAR(100)
);
INSERT INTO banks
SELECT 
    id,
    'Bank ' || id AS name
FROM
     generate_series(1, current_setting('total.banks')::INTEGER) id;
     
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
    id SERIAL,
    user_id INTEGER,
    bank_id INTEGER,
    active INTEGER
);
INSERT INTO accounts (user_id, bank_id, active)
SELECT 
    user_id,
    bank_id,
    (random() * 1)::INTEGER AS active
FROM
     generate_series(1, current_setting('total.users')::INTEGER) user_id,
     generate_series(1, current_setting('total.banks')::INTEGER) bank_id;

DROP TABLE IF EXISTS transfers;
CREATE TABLE transfers (
    source_account_id INTEGER,
    target_account_id INTEGER,
    amount INTEGER,
    processed INTEGER
);

-- ALTER TABLE transfers
-- ADD CONSTRAINT same_account_check
-- CHECK (source_account_id != target_account_id);

INSERT INTO transfers
SELECT 
    source_account_id,
    (random() * (SELECT COUNT(*) FROM accounts))::integer AS target_account_id,
    (random() * 100)::INTEGER AS amount,
    (random() * 1)::INTEGER AS processed    
FROM
     generate_series(1, (SELECT COUNT(*) FROM accounts)) AS source_account_id;