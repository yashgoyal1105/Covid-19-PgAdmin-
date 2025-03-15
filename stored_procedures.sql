-- Stored Procedure for inserting values in the table
CREATE PROCEDURE InsertCarSale(
    IN car_brand VARCHAR(50),
    IN car_model VARCHAR(50),
    IN car_price DECIMAL(10,2)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO car_sales (car_brand, car_model, price) 
    VALUES (car_brand, car_model, car_price);
END;
$$;

CALL InsertCarSale('BMW', 'X5', 60000.00);
CAll InsertCarSale('Mahindra', 'Thar', 30000.00);
CAll InsertCarSale('Maruti', 'Beleno', 20000.00);
CAll InsertCarSale('Audi', 'Q7', 80000.00)

select *from car_sales


-- stored procedure for totalsales
CREATE FUNCTION GetTotalSalesFunc()
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE total_sales INT;
BEGIN
    SELECT COUNT(*) INTO total_sales FROM car_sales;
    RETURN total_sales;
END;
$$;

SELECT GetTotalSalesFunc();

select * from car_sales order by sale_id;


-- stored procedure for updating car_price:
CREATE PROCEDURE UpdateCarPrices(
    IN p_car_brand VARCHAR(50),
    IN p_car_model VARCHAR(50),
    IN p_new_price DECIMAL(10,2)
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE car_sales 
    SET price = p_new_price 
    WHERE car_brand = p_car_brand AND car_model = p_car_model;
END;
$$;

DROP FUNCTION IF EXISTS UpdateCarPrice(VARCHAR, VARCHAR, DECIMAL);

CALL UpdateCarPrices('Toyota', 'Corolla', 28000.00);

select * from car_sales
