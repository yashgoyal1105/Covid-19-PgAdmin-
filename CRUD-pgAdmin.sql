-- create
CREATE TABLE automobile (
    id SERIAL PRIMARY KEY,
    brand VARCHAR(50),
    model VARCHAR(50),
    year INT,
    price DECIMAL(10,2)
);

-- Insert
INSERT INTO automobile (brand, model, year, price) 
VALUES 
('Toyota', 'Camry', 2022, 30000.00),
('Honda', 'Civic', 2021, 25000.00),
('Ford', 'Mustang', 2023, 55000.00);

-- Read
SELECT * FROM automobile;

-- Update
UPDATE automobile 
SET price = 32000.00 
WHERE brand = 'Toyota' AND model = 'Camry';

-- Delete
DELETE FROM automobile 
WHERE brand = 'Ford' AND model = 'Mustang';

SELECT * FROM automobile order by id;



