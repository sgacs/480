DELIMITER //

CREATE TRIGGER after_payment_insert
AFTER INSERT ON Payment
FOR EACH ROW
BEGIN
    UPDATE Patient p
    SET p.balance = p.balance - NEW.amount
    WHERE p.patient_id = NEW.patient_id;
END;//

DELIMITER ;