-- Triggers to update patient balance

DELIMITER //

CREATE TRIGGER after_payable_insert
AFTER INSERT ON Payable
FOR EACH ROW
BEGIN
    UPDATE Patient p
    SET p.balance = p.balance + NEW.amount
    WHERE p.patient_id = (SELECT patient_id FROM Invoice WHERE invoice_id = NEW.invoice_id);
END;//

DELIMITER ;