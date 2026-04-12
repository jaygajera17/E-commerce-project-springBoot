CREATE TABLE IF NOT EXISTS category (
    category_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NULL
);

INSERT INTO category (name)
SELECT category_name
FROM (
    SELECT 'Fruits' AS category_name
    UNION ALL SELECT 'Vegetables'
    UNION ALL SELECT 'Meat'
    UNION ALL SELECT 'Fish'
    UNION ALL SELECT 'Dairy'
    UNION ALL SELECT 'Bakery'
    UNION ALL SELECT 'Drinks'
    UNION ALL SELECT 'Sweets'
    UNION ALL SELECT 'Other'
) AS categories
WHERE NOT EXISTS (SELECT 1 FROM category);

CREATE TABLE IF NOT EXISTS customer (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(255) NULL,
    email VARCHAR(255) NULL,
    password VARCHAR(255) NULL,
    role VARCHAR(255) NULL,
    username VARCHAR(255) NULL,
    CONSTRAINT uk_customer_username UNIQUE (username)
);

INSERT INTO customer (address, email, password, role, username)
SELECT *
FROM (
    SELECT '123, Albany Street', 'admin@nyan.cat', '$2a$10$qSF.16A43bqxoWEnT.iywurQs/U.iM1p0Y6l.tg7bgSU.S/11xmXu', 'ROLE_ADMIN', 'admin'
    UNION ALL
    SELECT '765, 5th Avenue', 'lisa@gmail.com', '$2a$10$ZhgpbHQISdbx6MUTP6A6M.5dN1QRDQVQyYFxoCmAOMr/j5uURO0q2', 'ROLE_NORMAL', 'lisa'
) AS customers
WHERE NOT EXISTS (SELECT 1 FROM customer);

CREATE TABLE IF NOT EXISTS product (
    product_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255) NULL,
    image VARCHAR(255) NULL,
    name VARCHAR(255) NULL,
    price INT NULL,
    quantity INT NULL,
    weight INT NULL,
    category_id INT NULL,
    customer_id INT NULL,
    CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES category (category_id),
    CONSTRAINT fk_product_customer FOREIGN KEY (customer_id) REFERENCES customer (id)
);
