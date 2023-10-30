-- PostgreSQL SQL Dump
-- version 13.5
-- https://www.postgresql.org/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 10, 2022 at 06:02 PM
-- Server version: 13.5
-- PHP Version: 8.0.2

SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL READ COMMITTED;

SET search_path = public, pg_catalog;

-- Database: springproject

-- --------------------------------------------------------

--
-- Table structure for table "categories"
--

CREATE TABLE categories (
  categoryid serial PRIMARY KEY,
  name varchar(255) NOT NULL
);

--
-- Dumping data for table "categories"
--

INSERT INTO categories (name) VALUES
('category11'),
('category22'),
('category122'),
('category232'),
('fruit3');

-- --------------------------------------------------------

--
-- Table structure for table "login"
--

CREATE TABLE login (
  id serial PRIMARY KEY,
  password varchar(20) NOT NULL,
  username varchar(20) NOT NULL
);

--
-- Dumping data for table "login"
--

INSERT INTO login (password, username) VALUES
('123', '1');

-- --------------------------------------------------------

--
-- Table structure for table "products"
--

CREATE TABLE products (
  id serial PRIMARY KEY,
  name varchar(255) NOT NULL,
  image text NOT NULL,
  categoryid int NOT NULL,
  quantity int NOT NULL,
  price int NOT NULL,
  weight int NOT NULL,
  description text NOT NULL
);

--
-- Dumping data for table "products"
--

INSERT INTO products (name, image, categoryid, quantity, price, weight, description) VALUES
('first', '1.jpg', 6, 7275275, 24, 27, ''),
('second', '2.jpg', 6, 7275275, 24, 27, ''),
('third', '', 11, 5, 30, 10, 'red python');

-- --------------------------------------------------------

--
-- Table structure for table "users"
--

CREATE TABLE users (
  user_id serial PRIMARY KEY,
  username varchar(45) NOT NULL,
  password varchar(64) NOT NULL,
  role varchar(250) NOT NULL DEFAULT 'ROLE_USERS',
  enabled smallint,
  email varchar(110) NOT NULL
);

--
-- Dumping data for table "users"
--

INSERT INTO users (username, password, role, enabled, email) VALUES
('nikhil', '123', 'ROLE_USER', 1, 'nikhilr7373@gmail.com'),
('admin', '123', 'ROLE_ADMIN', 1, 'admin0@ecom.in');

-- Constraints
--

ALTER TABLE products ADD CONSTRAINT products_category_fk FOREIGN KEY (categoryid) REFERENCES categories(categoryid) ON DELETE CASCADE;

-- AUTO_INCREMENT sequences are handled automatically by serial types in PostgreSQL.
select * from categories;

---if constarint error persist add the data to the required tables (intentially not given )