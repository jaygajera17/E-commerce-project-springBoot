INSERT INTO product (description, image, name, price, quantity, weight, category_id)
SELECT * FROM (
    SELECT 'Sweet Alphonso mangoes with a rich aroma and buttery texture.', 'https://images.unsplash.com/photo-1553279768-865429fa0078?auto=format&fit=crop&w=900&q=80', 'Alphonso Mango', 249, 45, 350, 1
) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM product WHERE name = 'Alphonso Mango');

INSERT INTO product (description, image, name, price, quantity, weight, category_id)
SELECT * FROM (
    SELECT 'Crisp green grapes that work well for snacking and chilled fruit bowls.', 'https://images.unsplash.com/photo-1537640538966-79f369143f8f?auto=format&fit=crop&w=900&q=80', 'Green Grapes', 139, 80, 250, 1
) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM product WHERE name = 'Green Grapes');

INSERT INTO product (description, image, name, price, quantity, weight, category_id)
SELECT * FROM (
    SELECT 'Tender baby spinach leaves cleaned and packed for quick salads and sauteing.', 'https://images.unsplash.com/photo-1576045057995-568f588f82fb?auto=format&fit=crop&w=900&q=80', 'Baby Spinach', 89, 60, 180, 2
) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM product WHERE name = 'Baby Spinach');

INSERT INTO product (description, image, name, price, quantity, weight, category_id)
SELECT * FROM (
    SELECT 'Colorful bell peppers with a balanced crunch for stir fry and roasting.', 'https://images.unsplash.com/photo-1563565375-f3fdfdbefa83?auto=format&fit=crop&w=900&q=80', 'Rainbow Bell Pepper Pack', 119, 50, 300, 2
) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM product WHERE name = 'Rainbow Bell Pepper Pack');

INSERT INTO product (description, image, name, price, quantity, weight, category_id)
SELECT * FROM (
    SELECT 'Skinless chicken breast fillets trimmed for lean weekday meals.', 'https://images.unsplash.com/photo-1604503468506-a8da13d82791?auto=format&fit=crop&w=900&q=80', 'Chicken Breast Fillet', 299, 35, 500, 3
) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM product WHERE name = 'Chicken Breast Fillet');

INSERT INTO product (description, image, name, price, quantity, weight, category_id)
SELECT * FROM (
    SELECT 'Freshwater rohu cuts packed for curry, fry, or light steaming.', 'https://images.unsplash.com/photo-1544943910-4c1dc44aab44?auto=format&fit=crop&w=900&q=80', 'Rohu Curry Cut', 279, 28, 500, 4
) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM product WHERE name = 'Rohu Curry Cut');

INSERT INTO product (description, image, name, price, quantity, weight, category_id)
SELECT * FROM (
    SELECT 'Thick Greek yogurt with a smooth finish and high protein content.', 'https://images.unsplash.com/photo-1488477181946-6428a0291777?auto=format&fit=crop&w=900&q=80', 'Greek Yogurt Cup', 75, 70, 200, 5
) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM product WHERE name = 'Greek Yogurt Cup');

INSERT INTO product (description, image, name, price, quantity, weight, category_id)
SELECT * FROM (
    SELECT 'Stone-baked sourdough loaf with a chewy crust and airy crumb.', 'https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=900&q=80', 'Sourdough Bread', 149, 32, 400, 6
) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM product WHERE name = 'Sourdough Bread');

INSERT INTO product (description, image, name, price, quantity, weight, category_id)
SELECT * FROM (
    SELECT 'Cold-pressed orange juice with no added sugar and bright citrus notes.', 'https://images.unsplash.com/photo-1600271886742-f049cd451bba?auto=format&fit=crop&w=900&q=80', 'Cold Pressed Orange Juice', 110, 40, 1000, 7
) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM product WHERE name = 'Cold Pressed Orange Juice');

INSERT INTO product (description, image, name, price, quantity, weight, category_id)
SELECT * FROM (
    SELECT 'Mini chocolate brownies for dessert platters and coffee breaks.', 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?auto=format&fit=crop&w=900&q=80', 'Mini Brownie Box', 189, 24, 240, 8
) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM product WHERE name = 'Mini Brownie Box');
