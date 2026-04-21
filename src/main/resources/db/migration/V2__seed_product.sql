INSERT INTO product(description, image, name, price, quantity, weight, category_id)
SELECT * FROM (
                  SELECT 'Fresh red apples', 'https://freepngimg.com/save/9557-apple-fruit-transparent/744x744', 'Apple', 120, 100, 200, 1
              ) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM product WHERE name = 'Apple'
);

-- Repeat pattern for others
