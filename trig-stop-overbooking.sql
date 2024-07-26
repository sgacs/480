DELIMITER //
CREATE TRIGGER PreventOverBooking
BEFORE INSERT ON PatientRoom
FOR EACH ROW
BEGIN
    DECLARE current_occupancy INT;
    DECLARE room_capacity INT;
    
    SELECT capacity INTO room_capacity
    FROM Room
    WHERE room_number = NEW.room_number;
    
    SELECT COUNT(*) INTO current_occupancy
    FROM PatientRoom
    WHERE room_number = NEW.room_number
    AND check_out_date >= NEW.check_in_date;
    
    IF current_occupancy >= room_capacity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Room is at full capacity for the specified dates';
    END IF;
END //
DELIMITER ;