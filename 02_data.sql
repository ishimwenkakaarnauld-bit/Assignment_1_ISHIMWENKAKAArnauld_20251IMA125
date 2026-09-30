-- CUSTOMERS (6)
INSERT INTO customers VALUES (1, 'Alice Uwase',          'alice.uwase@example.com',   'Kigali');
INSERT INTO customers VALUES (2, 'Eric Mugisha',         'eric.mugisha@example.com',  'Kigali');
INSERT INTO customers VALUES (3, 'Grace Ingabire',       'grace.ingabire@example.com','Musanze');
INSERT INTO customers VALUES (4, 'Jean Claude Habimana', 'jc.habimana@example.com',   'Huye');
INSERT INTO customers VALUES (5, 'Diane Mukamana',       'diane.mukamana@example.com','Rubavu');
INSERT INTO customers VALUES (6, 'Patrick Nsengiyumva',  'patrick.n@example.com',     'Kigali');

-- PRODUCTS (8, across 4 categories)
INSERT INTO products VALUES (1, 'Rice 5kg',        'Grocery',   6500);
INSERT INTO products VALUES (2, 'Cooking Oil 3L',  'Grocery',   9000);
INSERT INTO products VALUES (3, 'Sugar 1kg',       'Grocery',   1800);
INSERT INTO products VALUES (4, 'Fresh Milk 1L',   'Dairy',     1200);
INSERT INTO products VALUES (5, 'Yogurt 500ml',    'Dairy',     1500);
INSERT INTO products VALUES (6, 'Orange Juice 1L', 'Beverages', 2500);
INSERT INTO products VALUES (7, 'Bottled Water 1.5L','Beverages', 800);
INSERT INTO products VALUES (8, 'Laundry Soap 1kg','Household', 3200);

-- ORDERS (15)
INSERT INTO orders VALUES (1,  1, DATE '2026-01-05');
INSERT INTO orders VALUES (2,  2, DATE '2026-01-12');
INSERT INTO orders VALUES (3,  3, DATE '2026-01-20');
INSERT INTO orders VALUES (4,  1, DATE '2026-02-03');
INSERT INTO orders VALUES (5,  4, DATE '2026-02-10');
INSERT INTO orders VALUES (6,  2, DATE '2026-02-18');
INSERT INTO orders VALUES (7,  5, DATE '2026-02-25');
INSERT INTO orders VALUES (8,  1, DATE '2026-03-04');
INSERT INTO orders VALUES (9,  3, DATE '2026-03-15');
INSERT INTO orders VALUES (10, 4, DATE '2026-03-22');
INSERT INTO orders VALUES (11, 2, DATE '2026-04-02');
INSERT INTO orders VALUES (12, 5, DATE '2026-04-14');
INSERT INTO orders VALUES (13, 1, DATE '2026-04-28');
INSERT INTO orders VALUES (14, 3, DATE '2026-05-09');
INSERT INTO orders VALUES (15, 2, DATE '2026-05-20');

-- ORDER ITEMS (25)
INSERT INTO order_items VALUES (1,  1, 1, 2);
INSERT INTO order_items VALUES (2,  1, 4, 3);
INSERT INTO order_items VALUES (3,  2, 2, 1);
INSERT INTO order_items VALUES (4,  3, 6, 4);
INSERT INTO order_items VALUES (5,  3, 7, 6);
INSERT INTO order_items VALUES (6,  4, 3, 5);
INSERT INTO order_items VALUES (7,  5, 5, 4);
INSERT INTO order_items VALUES (8,  5, 8, 1);
INSERT INTO order_items VALUES (9,  6, 1, 1);
INSERT INTO order_items VALUES (10, 6, 6, 2);
INSERT INTO order_items VALUES (11, 7, 4, 6);
INSERT INTO order_items VALUES (12, 8, 2, 2);
INSERT INTO order_items VALUES (13, 8, 7, 10);
INSERT INTO order_items VALUES (14, 9, 8, 2);
INSERT INTO order_items VALUES (15, 9, 5, 3);
INSERT INTO order_items VALUES (16, 10, 1, 3);
INSERT INTO order_items VALUES (17, 11, 3, 4);
INSERT INTO order_items VALUES (18, 11, 6, 3);
INSERT INTO order_items VALUES (19, 12, 2, 1);
INSERT INTO order_items VALUES (20, 12, 4, 2);
INSERT INTO order_items VALUES (21, 13, 8, 3);
INSERT INTO order_items VALUES (22, 14, 1, 2);
INSERT INTO order_items VALUES (23, 14, 7, 8);
INSERT INTO order_items VALUES (24, 15, 5, 5);
INSERT INTO order_items VALUES (25, 15, 2, 2);

COMMIT;