--3.1task
CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    balance DECIMAL(10, 2) DEFAULT 0.00
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    shop VARCHAR(100) NOT NULL,
    product VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

INSERT INTO accounts (name, balance) VALUES
    ('Alice', 1000.00),
    ('Bob', 500.00),
    ('Wally', 750.00);

INSERT INTO products (shop, product, price) VALUES
    ('Joe''s Shop', 'Coke', 2.50),
    ('Joe''s Shop', 'Pepsi', 3.00);

--3.2 task
BEGIN;
UPDATE accounts SET balance = balance - 100.00
    WHERE name = 'Alice';
UPDATE accounts SET balance = balance + 100.00
    WHERE name = 'Bob';
COMMIT;
--questions
--1.after the transaction Alica's balance = 900,Job's balance = 600
--2.Because it is one action.Both updates must happen together.This keeps the money safe.
--3.Alice loses money.Bob gets nothing.The database becomes wrong.

--3.3tasks
BEGIN;
UPDATE accounts SET balance = balance - 100.00 WHERE name = 'Alice';
SAVEPOINT my_savepoint;

UPDATE accounts SET balance = balance + 100.00 WHERE name = 'Bob';
ROLLBACK TO my_savepoint;

UPDATE accounts SET balance = balance + 100.00 WHERE name = 'Wally';
COMMIT;

--questions
--a) What was Alice's balance after the UPDATE but before ROLLBACK? Her balance was 500.

--b) What is Alice's balance after ROLLBACK? Her balance is 1000 again.

--c) In what situations would you use ROLLBACK in a real application?When you make a mistake.When the data is wrong.When you want to undo changes.

--3.4 task
BEGIN;

UPDATE accounts
SET balance = balance - 100.00
WHERE name = 'Alice';

SAVEPOINT my_savepoint;

UPDATE accounts
SET balance = balance + 100.00
WHERE name = 'Bob';
ROLLBACK TO my_savepoint;

UPDATE accounts
SET balance = balance + 100.00
WHERE name = 'Wally';

COMMIT;

--question
--a) Alice = 900, Bob = 500, Wally = 850.
--b) No, Bob was not credited because his update was rolled back.
--c) SAVEPOINT helps undo only one part without restarting the whole transaction.
