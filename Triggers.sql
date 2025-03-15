CREATE TABLE car_sales (
    sale_id SERIAL PRIMARY KEY,
    car_brand VARCHAR(50),
    car_model VARCHAR(50),
    sale_date DATE DEFAULT CURRENT_DATE,
    price DECIMAL(10,2),
    status VARCHAR(20) DEFAULT 'Pending'
);

INSERT INTO car_sales (car_brand, car_model, price) 
VALUES 
('Toyota', 'Corolla', 25000.00),
('Honda', 'Accord', 28000.00),
('Ford', 'F-150', 40000.00);


-- prevents sales below 10000 dollars
CREATE OR REPLACE FUNCTION check_price()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.price < 10000 THEN
        RAISE EXCEPTION 'Price cannot be less than $10,000!';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_low_price
BEFORE INSERT OR UPDATE ON car_sales
FOR EACH ROW
EXECUTE FUNCTION check_price();

-- will show an error
INSERT INTO car_sales (car_brand, car_model, price) 
VALUES 
('Maruti', 'alto-k10', 9999.00);

-- it will run because the price is over $10,000
INSERT INTO car_sales (car_brand, car_model, price) 
VALUES 
('Maruti', 'alto-k10', 11000.00);


-- trigger function 
CREATE OR REPLACE FUNCTION update_status()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.price > 30000 THEN
        NEW.status = 'Completed';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER auto_update_status
BEFORE INSERT OR UPDATE ON car_sales
FOR EACH ROW
EXECUTE FUNCTION update_status();


SELECT * FROM car_sales WHERE car_brand = 'Toyota';

UPDATE car_sales 
set price = 35000
where car_brand = 'Toyota' and sale_id = 7;

SELECT * FROM car_sales WHERE car_brand = 'Toyota';

