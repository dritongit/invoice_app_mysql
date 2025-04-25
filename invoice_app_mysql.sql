-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 25, 2025 at 07:00 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `invoice_app`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ArticleCreate` (IN `p_article_id` VARCHAR(36), IN `user_id` VARCHAR(36), IN `name` VARCHAR(255), IN `description` VARCHAR(255), IN `taxed` VARCHAR(255), IN `tax_rate` VARCHAR(255), IN `discounted` VARCHAR(255), IN `discount_percent` VARCHAR(255), IN `discount_value` VARCHAR(255), IN `unit_price` VARCHAR(255))   BEGIN 
		DECLARE exit handler for SQLEXCEPTION BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;

        INSERT INTO error_logs (object_name, error_description) VALUES ('ArticleCreate', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to Create Article!' AS response_text;
    END;
		INSERT INTO `article` (`article_id`, `name`, `description`, `taxed`, `rate`, `unit_price`, `created_by`, `deleted`, `created_at`, `dicounted`, `discount_percent`, `discount_value`) 
																 VALUES (p_article_id, `name`, description, taxed, tax_rate, unit_price, user_id, NULL, NOW(), discounted, discount_percent, discount_value);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ArticleDelete` (IN `in_article_id` VARCHAR(36), IN `in_user_id` VARCHAR(36))   BEGIN 
		DECLARE exit handler for SQLEXCEPTION BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;

        INSERT INTO error_logs (object_name, error_description) VALUES ('ArticleDelete', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to delete article!' AS response_text;
    END;
		
		UPDATE article SET deleted = NOW() WHERE article_id = in_article_id AND created_by = in_user_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ArticleReadAll` (IN `user_id` VARCHAR(36))   BEGIN 
		DECLARE exit handler for SQLEXCEPTION BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;

        INSERT INTO error_logs (object_name, error_description) VALUES ('ArticleReadAll', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to award prize!' AS response_text;
    END;
		
		SELECT * FROM article WHERE created_by = user_id AND deleted IS NULL;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ArticleReadById` (IN `user_id` VARCHAR(36), IN `in_article_id` INT)   BEGIN 
		DECLARE exit handler for SQLEXCEPTION BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;

        INSERT INTO error_logs (object_name, error_description) VALUES ('ArticleReadById', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to award prize!' AS response_text;
    END;

		 SELECT * FROM article WHERE article_id = in_article_id AND created_by = user_id AND deleted IS NULL;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ArticleUpdate` (IN `user_id` VARCHAR(36), IN `atricle_id` VARCHAR(36), IN `name` VARCHAR(255), IN `description` VARCHAR(255), IN `taxed` VARCHAR(255), IN `tax_rate` VARCHAR(255), IN `discounted` VARCHAR(255), IN `discount_percent` VARCHAR(255), IN `discount_value` VARCHAR(255), IN `unit_price` VARCHAR(255))   BEGIN 
		DECLARE exit handler for SQLEXCEPTION BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;

        INSERT INTO error_logs (object_name, error_description) VALUES ('ArticleUpdate', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to update!' AS response_text;
    END;
    
		UPDATE `article` SET  `name` =  `name`, 
													`description` = description, 
													`taxed` = taxed, 
													`rate` = tax_rate, 
													`unit_price` = unit_price, 
													`dicounted` = discounted, 
													`discount_percent` = discount_percent, 
													`discount_value` = discount_value 
										WHERE `article_id` = atricle_id and created_by = user_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ContactCreate` (IN `contact_id` VARCHAR(36), IN `user_id` VARCHAR(36), IN `name` VARCHAR(255), IN `alternative` VARCHAR(255), IN `address1` VARCHAR(255), IN `address2` VARCHAR(255), IN `address3` VARCHAR(255), IN `town` VARCHAR(255), IN `region` VARCHAR(255), IN `email1` VARCHAR(255), IN `email2` VARCHAR(255), IN `postcode` VARCHAR(10))   BEGIN
		DECLARE exit handler for SQLEXCEPTION BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;

        INSERT INTO error_logs (object_name, error_description) VALUES ('ContactCreate', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to create contact!' AS response_text;
    END;
    
    INSERT INTO `invoice_app`.`contact` (`contact_id`, `name`, `alternative`, `address1`, `address2`, `address3`, `town`, `region`, `postcode`, `email1`, `email2`, `created_at`, `created_by`) 
                                 VALUES (contact_id, name, alternative, address1, address2, address3, town, region, postcode, email1, email2, NOW(), user_id);
                                 
    SELECT "Contact created successfully" as message;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ContactDelete` (IN `in_contact_id` VARCHAR(36), IN `in_user_id` VARCHAR(36))   BEGIN
		DECLARE exit handler for SQLEXCEPTION BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;

        INSERT INTO error_logs (object_name, error_description) VALUES ('ContactUpdate', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to create contact!' AS response_text;
    END;
    
    UPDATE contact SET deleted_at = NOW() WHERE contact_id = in_contact_id AND created_by = in_user_id;
                        
    SELECT "Contact deleted successfully" as message;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ContactReadAll` (IN `in_user_id` VARCHAR(36), IN `in_search` VARCHAR(255))   BEGIN
		DECLARE exit handler for SQLEXCEPTION BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;

        INSERT INTO error_logs (object_name, error_description) VALUES ('ContactReadAll', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to award prize!' AS response_text;
    END;
    
    IF in_search IS NULL OR in_search = '' THEN
      SELECT * FROM contact where created_by = in_user_id AND deleted_at is NULL ORDER BY created_at DESC;
    ELSE
     SELECT * FROM contact 
        WHERE created_by = in_user_id 
        AND deleted_at IS NULL
        AND (name LIKE CONCAT('%', in_search, '%') 
             OR email1 LIKE CONCAT('%', in_search, '%') 
             OR alternative LIKE CONCAT('%', in_search, '%'))
        ORDER BY created_at DESC;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ContactReadById` (IN `in_user_id` VARCHAR(36), IN `in_contact_id` VARCHAR(36))   BEGIN
		DECLARE exit handler for SQLEXCEPTION BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;

        INSERT INTO error_logs (object_name, error_description) VALUES ('ContactReadById', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to get contact!' AS response_text;
    END;
  SELECT * FROM contact WHERE contact_id = in_contact_id and created_by = in_user_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ContactSearchByName` (IN `in_user_id` VARCHAR(36), IN `in_text` VARCHAR(255))   BEGIN
		DECLARE exit handler for SQLEXCEPTION BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;

        INSERT INTO error_logs (object_name, error_description) VALUES ('ContactReadByName', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to get contact!' AS response_text;
    END;
    SELECT * FROM contact WHERE `name` LIKE CONCAT('%', in_text, '%') 
    OR alternative LIKE CONCAT('%', in_text, '%');

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ContactUpdate` (IN `in_contact_id` VARCHAR(36), IN `user_id` VARCHAR(36), IN `name` VARCHAR(255), IN `alternative` VARCHAR(255), IN `address1` VARCHAR(255), IN `address2` VARCHAR(255), IN `address3` VARCHAR(255), IN `town` VARCHAR(255), IN `region` VARCHAR(255), IN `email1` VARCHAR(255), IN `email2` VARCHAR(255), IN `postcode` VARCHAR(10))   BEGIN
		DECLARE exit handler for SQLEXCEPTION BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;

        INSERT INTO error_logs (object_name, error_description) VALUES ('ContactUpdate', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to create contact!' AS response_text;
    END;
    
    UPDATE `contact` SET `name` = name, `alternative` = alternative, `address1` = address1, `address2` = address2, `address3` = address3, `town` = town, `region` = region, `postcode` = postcode, `email1` = email1, `email2` = email2 WHERE `contact_id` = in_contact_id;
                        
    SELECT "Contact updated successfully" as message;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InvoiceCreate` (IN `in_invoice_id` VARCHAR(36), IN `in_user_id` VARCHAR(36), IN `in_created_at` VARCHAR(255), IN `in_due_date` VARCHAR(255), IN `in_contact_1` VARCHAR(255), IN `in_contact_2` VARCHAR(255), IN `in_additional_tax` INT, IN `in_additional_tax_rate` DECIMAL(10,2), IN `in_deduction_as_percent` INT, IN `in_deduction_percent` DECIMAL(10,2), IN `in_deduction_value` VARCHAR(255), IN `in_delivery` INT, IN `in_delivery_rate` DECIMAL(10,2))   BEGIN
		DECLARE exit handler for SQLEXCEPTION BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;

        INSERT INTO error_logs (object_name, error_description) VALUES ('InvoiceCreate', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to create invoice!' AS response_text;
    END;
    
   INSERT INTO `invoice` (`invoice_id`, `user_id`, `status`, `created_at`, `print_date`, `due_date`, `contact_1`, `contact_2`, `additional_tax`, `additional_tax_rate`, `deduction`, `deduction_percent`, `deduction_value`, `delivery`, `delivery_rate`, `deleted`) 
                                VALUES (in_invoice_id, in_user_id, 'pending', in_created_at, NULL, NULL, in_contact_1, in_contact_2, in_additional_tax, in_additional_tax_rate, in_deduction_as_percent, in_deduction_percent, in_deduction_value, in_delivery, in_delivery_rate, NULL);
                                 
    SELECT "Invoice created successfully" as message;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InvoiceDelete` (IN `in_invoice_id` VARCHAR(36), IN `in_user_id` VARCHAR(36))   BEGIN
		DECLARE exit handler for SQLEXCEPTION BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;

        INSERT INTO error_logs (object_name, error_description) VALUES ('InvoiceDelete', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to delete invoice!' AS response_text;
    END;
   	UPDATE invoice SET deleted = NOW() WHERE invoice_id = in_invoice_id AND user_id = in_user_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InvoiceReadAll` (IN `in_user_id` VARCHAR(36), IN `in_limit` INT, IN `in_offset` INT, IN `in_sort_column` VARCHAR(50), IN `in_sort_order` VARCHAR(4))   BEGIN
    DECLARE exit handler for SQLEXCEPTION 
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
        INSERT INTO error_logs (object_name, error_description) 
        VALUES ('InvoiceReadAll', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to get invoices!' AS response_text;
    END;

    SET @sql = CONCAT('
        SELECT 
            i.invoice_id, 
            i.created_at, 
            c.name, 
            c.alternative, 
            c.postcode,
            COALESCE(SUM(isub.unit_price), 0) AS total_unit_price,
            COALESCE(SUM(p.amount), 0) AS total_payment,
            COALESCE(SUM(isub.unit_price), 0) - COALESCE(SUM(p.amount), 0) AS balance,
            COUNT(*) OVER() AS total_records
        FROM invoice i 
        LEFT JOIN contact c ON i.contact_1 = c.contact_id 
        LEFT JOIN subinvoice isub ON i.invoice_id = isub.invoice_id
        LEFT JOIN payment p ON i.invoice_id = p.invoice_id
        WHERE i.user_id = ? AND i.deleted IS NULL
        GROUP BY i.invoice_id, c.contact_id
        ORDER BY ', in_sort_column, ' ', in_sort_order, '
        LIMIT ? OFFSET ?'
    );

    PREPARE stmt FROM @sql;
    EXECUTE stmt USING in_user_id, in_limit, in_offset;
    DEALLOCATE PREPARE stmt;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InvoiceReadById` (IN `in_user_id` VARCHAR(36), IN `in_invoice_id` VARCHAR(36))   BEGIN
		DECLARE exit handler for SQLEXCEPTION BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;

        INSERT INTO error_logs (object_name, error_description) VALUES ('InvoiceReadById', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to get invoices!' AS response_text;
    END;
   	SELECT * FROM invoice WHERE invoice_id = in_invoice_id AND user_id = in_user_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InvoiceSubRead` (IN `invoice_id` INT)   BEGIN
  SELECT * FROM invoice_sub WHERE fk_invoice_id = invoice_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PaymentCreate` (IN `in_payment_id` VARCHAR(36), IN `in_invoice_id` VARCHAR(36), IN `in_amount` DECIMAL(10,2), IN `in_method` INT, IN `in_date` DATETIME, IN `in_details` VARCHAR(255))   BEGIN 
		DECLARE exit handler for SQLEXCEPTION BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;

        INSERT INTO error_logs (object_name, error_description) VALUES ('PaymentCreate', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to add payment!' AS response_text;
    END;
    
    INSERT INTO `payment` (`payment_id`, `invoice_id`, `amount`, `method`, `date`, `details`) 
                   VALUES (in_payment_id, in_invoice_id, in_amount, in_method, in_date, in_details);
                      
    SELECT 'OK' as response_flag, 'Payment added' as response_text;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PaymentDelete` (IN `in_payment_id` VARCHAR(36), IN `in_user_id` VARCHAR(36), IN `in_deleted` DATE)   BEGIN 
		DECLARE exit handler for SQLEXCEPTION BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
        
        INSERT INTO error_logs (object_name, error_description) VALUES ('PaymentDelete', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to delete payment!' AS response_text;
    END;
    UPDATE payment SET deleted = in_deleted WHERE payment_id = in_payment_id;
                                      
    SELECT 'OK' as response_flag, 'Deleted' as response_text;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PaymentReadAll` (IN `in_invoice_id` VARCHAR(36))   BEGIN 
		DECLARE exit handler for SQLEXCEPTION BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;

        INSERT INTO error_logs (object_name, error_description) VALUES ('PaymentReadAll', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to fetch payments!' AS response_text;
    END;
		
		SELECT * FROM payment WHERE invoice_id = in_invoice_id AND deleted IS NULL;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PaymentUpdate` (IN `in_payment_id` VARCHAR(36), IN `in_invoice_id` VARCHAR(36), IN `in_amount` DECIMAL(10,2), IN `in_method` INT, IN `in_date` DATETIME, IN `in_details` VARCHAR(255))   BEGIN 
		DECLARE exit handler for SQLEXCEPTION BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;

        INSERT INTO error_logs (object_name, error_description) VALUES ('PaymentUpdate', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to edit payment!' AS response_text;
    END;
    
    UPDATE `payment` SET `amount` = in_amount, `method` = in_method, `date` = in_date, `details` = in_details 
    WHERE `payment_id` = in_payment_id AND `invoice_id` = in_invoice_id;
                      
    SELECT 'OK' as response_flag, 'Payment edited' as response_text;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RefreshTokenDelete` (IN `in_token` TEXT)   BEGIN
   UPDATE users SET refresh_token = NULL WHERE refresh_token = in_token;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RefreshTokenUpdate` (IN `in_user_id` VARCHAR(36), IN `in_token` TEXT)   BEGIN

UPDATE users SET refresh_token = in_token WHERE user_id = in_user_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RefreshTokenVerify` (IN `in_user_id` VARCHAR(36), IN `in_token` TEXT)   BEGIN
    SELECT refresh_token FROM users WHERE user_id = in_user_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SettingsCreate` (`in_settings_id` VARCHAR(255), `in_settings_user_parent_id` VARCHAR(255), `in_settings_business_name` VARCHAR(255), `in_settings_address_1` VARCHAR(255), `in_settings_address_2` VARCHAR(255), `in_settings_address_3` VARCHAR(255), `in_settings_town` VARCHAR(255), `in_settings_region` VARCHAR(255), `in_settings_postcode` VARCHAR(255), `in_settings_telephone` VARCHAR(255), `in_settings_fax` VARCHAR(255), `in_settings_email` VARCHAR(255), `in_settings_website` VARCHAR(255), `in_settings_tax_number` VARCHAR(255), `in_settings_business_number` VARCHAR(255), `in_settings_tax_name` VARCHAR(255), `in_settings_tax_rate` DECIMAL(5,2), `in_settings_overdue_days` INT, `in_settings_currency_symbol` INT, `in_settings_reply_slip_text` VARCHAR(255), `in_settings_invoice_message` VARCHAR(255))   BEGIN
    DECLARE exit handler for SQLEXCEPTION 
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
        
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error occurred in SettingsCreate';

        INSERT INTO error_logs (object_name, error_description) 
        VALUES ('SettingsCreate', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to register settings!' AS response_text;
    END;
    
    INSERT INTO `settings` (
                            `settings_id`, `settings_user_parent_id`, `settings_business_name`, 
                            `settings_address_1`, `settings_address_2`, `settings_address_3`, 
                            `settings_town`, `settings_region`, `settings_postcode`, 
                            `settings_telephone`, `settings_fax`, `settings_email`, 
                            `settings_website`, `settings_tax_number`, `settings_business_number`, 
                            `settings_tax_name`, `settings_tax_rate`, `settings_overdue_days`, 
                            `settings_currency_symbol`, `settings_reply_slip_text`, `settings_invoice_message`
                            ) 
                    VALUES (
                            in_settings_id, in_settings_user_parent_id, in_settings_business_name, 
                            in_settings_address_1, in_settings_address_2, in_settings_address_3, 
                            in_settings_town, in_settings_region, in_settings_postcode, 
                            in_settings_telephone, in_settings_fax, in_settings_email, 
                            in_settings_website, in_settings_tax_number, in_settings_business_number,
                            in_settings_tax_name, in_settings_tax_rate, in_settings_overdue_days, 
                            in_settings_currency_symbol, in_settings_reply_slip_text, in_settings_invoice_message
                            );

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SettingsReadBy` (IN `in_user_parent_id` VARCHAR(36))   BEGIN 
		DECLARE exit handler for SQLEXCEPTION BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
        
        INSERT INTO error_logs (object_name, error_description) VALUES ('SettingsReadBy', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to read settings!' AS response_text;
    END;
		
		SELECT * FROM settings WHERE settings_user_parent_id = in_user_parent_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SettingsUpdate` (`in_settings_id` VARCHAR(255), `in_settings_user_parent_id` VARCHAR(255), `in_settings_business_name` VARCHAR(255), `in_settings_address_1` VARCHAR(255), `in_settings_address_2` VARCHAR(255), `in_settings_address_3` VARCHAR(255), `in_settings_town` VARCHAR(255), `in_settings_region` VARCHAR(255), `in_settings_postcode` VARCHAR(255), `in_settings_telephone` VARCHAR(255), `in_settings_fax` VARCHAR(255), `in_settings_email` VARCHAR(255), `in_settings_website` VARCHAR(255), `in_settings_tax_number` VARCHAR(255), `in_settings_business_number` VARCHAR(255), `in_settings_tax_name` VARCHAR(255), `in_settings_tax_rate` DECIMAL(3,2), `in_settings_overdue_days` INT, `in_settings_currency_symbol` VARCHAR(5), `in_settings_reply_slip_text` VARCHAR(255), `in_settings_invoice_message` VARCHAR(255))   BEGIN
    DECLARE exit handler for SQLEXCEPTION 
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
        INSERT INTO error_logs (object_name, error_description) 
        VALUES ('SettingsUpdate', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to edit settings!' AS response_text;
    END;

 UPDATE `settings` SET `settings_user_parent_id` = in_settings_user_parent_id, 
                       `settings_business_name` = in_settings_business_name, `settings_address_1` = in_settings_address_1, `settings_address_2` = in_settings_address_2, 
                       `settings_address_3` = in_settings_address_3, `settings_town` = in_settings_town, `settings_region` = in_settings_region, 
                       `settings_postcode` = in_settings_postcode, `settings_telephone` = in_settings_telephone, `settings_fax` = in_settings_fax, 
                       `settings_email` = in_settings_email, `settings_website` = in_settings_website, `settings_tax_number` = in_settings_tax_number, 
                       `settings_business_number` = in_settings_business_number, `settings_tax_name` = in_settings_tax_name, `settings_tax_rate` = in_settings_tax_rate, 
                       `settings_overdue_days` = in_settings_overdue_days, `settings_currency_symbol` = in_settings_currency_symbol, 
                       `settings_reply_slip_text` = in_settings_reply_slip_text,
                       `settings_invoice_message` = in_settings_invoice_message 
                       
                 WHERE `settings_id` = in_settings_id;

    SELECT 'OK' AS response_flag, 'Settings updated successfully!' AS response_text;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SubinvoiceCreate` (IN `in_subinvoice_id` VARCHAR(36), IN `in_invoice_id` VARCHAR(36), IN `in_product` VARCHAR(255), IN `in_description` VARCHAR(255), IN `in_taxed` TINYINT, IN `in_tax_rate` DECIMAL(10,2), IN `in_discount` TINYINT, IN `in_discount_percent` DECIMAL(10,2), IN `in_discount_amount` DECIMAL(10,2), IN `in_qty` DECIMAL(10,2), IN `in_unit_price` DECIMAL(10,2))   BEGIN 
		DECLARE exit handler for SQLEXCEPTION BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;

        INSERT INTO error_logs (object_name, error_description) VALUES ('SubinvoiceCreate', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to add item!' AS response_text;
    END;
    INSERT INTO `subinvoice` (`subinvoice_id`, `invoice_id`, `product`, `description`, `taxed`, `tax_rate`, `discount`, `discount_percent`, `discount_amount`, `qty`, `unit_price`)         
                      VALUES (in_subinvoice_id, in_invoice_id, in_product, in_description, in_taxed, in_tax_rate, in_discount, in_discount_percent, in_discount_amount, in_qty, in_unit_price);
                      SELECT 'OK' as response_flag, 'Added' as response_text;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SubinvoiceDelete` (IN `in_subinvoice_id` VARCHAR(36), IN `in_user_id` VARCHAR(36))   BEGIN 
		DECLARE exit handler for SQLEXCEPTION BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;

        INSERT INTO error_logs (object_name, error_description) VALUES ('SubinvoiceDelete', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to delete item!' AS response_text;
    END;
    DELETE FROM subinvoice WHERE subinvoice_id = in_subinvoice_id;
                                      
    SELECT 'OK' as response_flag, 'Deleted' as response_text;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SubinvoiceReadAll` (IN `in_invoice_id` VARCHAR(36))   BEGIN 
		DECLARE exit handler for SQLEXCEPTION BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;

        INSERT INTO error_logs (object_name, error_description) VALUES ('ArticleReadAll', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to award prize!' AS response_text;
    END;
		
		SELECT * FROM subinvoice WHERE invoice_id = in_invoice_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SubinvoiceUpdate` (IN `in_subinvoice_id` VARCHAR(36), IN `in_invoice_id` VARCHAR(36), IN `in_product` VARCHAR(255), IN `in_description` VARCHAR(255), IN `in_taxed` TINYINT, IN `in_tax_rate` DECIMAL(10,2), IN `in_discount` TINYINT, IN `in_discount_percent` DECIMAL(10,2), IN `in_discount_amount` DECIMAL(10,2), IN `in_qty` DECIMAL(10,2), IN `in_unit_price` DECIMAL(10,2))   BEGIN 
		DECLARE exit handler for SQLEXCEPTION BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
        
        INSERT INTO error_logs (object_name, error_description) VALUES ('SubinvoiceUpdate', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to edit item!' AS response_text;
    END;
    UPDATE `invoice_app`.`subinvoice` SET `product` = in_product, 
                                          `description` = in_description, 
                                          `taxed` = in_taxed, 
                                          `tax_rate` = in_tax_rate, 
                                          `discount` = in_discount, 
                                          `discount_amount` = in_discount_amount, 
                                          `qty` = in_qty, 
                                          `unit_price` = in_unit_price, 
                                          `discount_percent` = in_discount_percent
                                    WHERE `subinvoice_id` = in_subinvoice_id AND `invoice_id` = in_invoice_id;
                                      
    SELECT 'OK' as response_flag, 'Edited' as response_text;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UserByEmail` (IN `in_email` VARCHAR(255))   BEGIN
		DECLARE exit handler for SQLEXCEPTION BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;

        INSERT INTO error_logs (object_name, error_description) VALUES ('UserByEmail', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to select user!' AS response_text;
    END;
  
  SELECT * FROM users WHERE email = in_email;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UserCreate` (IN `p_uuid` VARCHAR(36), IN `p_email` VARCHAR(255), IN `p_password` VARCHAR(255), IN `p_role` ENUM('admin','worker'))   BEGIN
    -- Declare an error handler to catch any SQL exceptions
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        -- Rollback transaction to prevent partial insertions
        ROLLBACK;

        -- Capture error details
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;

        -- Log error in error_logs table
        INSERT INTO error_logs (object_name, error_description) 
        VALUES ('UserCreate', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));

        -- Return an error response
        SELECT 'NOK' AS response_flag, 'Failed to register user!' AS response_text;
    END;

    -- Start transaction
    START TRANSACTION;

      -- Insert user record
      INSERT INTO users (user_id, email, `password`, role) 
      VALUES (p_uuid, p_email, p_password, p_role);

      -- If the user is an admin, call SettingsCreate procedure to insert default settings
      IF p_role = 'admin' THEN
          CALL SettingsCreate(p_uuid, p_uuid, "", "", "", "", "", "", "", "", "", "", "", "", "", "VAT", 17.50, 30, 40, "", "");
      END IF;

    -- Commit the transaction if no errors
    COMMIT;

    -- Return success response
    -- SELECT 'OK' AS response_flag, 'User registered successfully!' AS response_text;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UserLogin` (IN `p_email` VARCHAR(255), IN `p_password` VARCHAR(255), IN `p_role` ENUM('admin','worker'), IN `p_pin` VARCHAR(255))   BEGIN
    DECLARE exit handler for SQLEXCEPTION BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;

        INSERT INTO error_logs (object_name, error_description) VALUES ('UserCreate', CONCAT("ERROR ", @errno, " (", @sqlstate, "): ", @text));
        SELECT 'NOK' AS response_flag, 'Failed to register user!' AS response_text;
    END;
    INSERT INTO users (email, password, role, pin) 
    VALUES (p_email, p_password, p_role, p_pin);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `article`
--

CREATE TABLE `article` (
  `article_id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `taxed` tinyint(1) DEFAULT NULL,
  `rate` decimal(10,2) DEFAULT NULL,
  `unit_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_by` varchar(36) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `dicounted` tinyint(1) DEFAULT NULL,
  `discount_percent` decimal(10,2) DEFAULT NULL,
  `discount_value` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `article`
--

INSERT INTO `article` (`article_id`, `name`, `description`, `taxed`, `rate`, `unit_price`, `created_by`, `deleted`, `created_at`, `dicounted`, `discount_percent`, `discount_value`) VALUES
('1', 'MacBook', 'Pro', 1, '16.00', '1200.00', '550e8400-e29b-41d4-a716-446655440000', '2025-03-02 06:20:01', '2025-03-02 06:11:22', NULL, NULL, NULL),
('123456789', '', '', 1, '16.70', '1200.00', '0', NULL, '2025-03-06 17:54:19', 1, '2.00', '2.00'),
('1234567890', 'Coca-Cola', '', 1, '16.70', '1200.00', '0', NULL, '2025-03-06 17:55:44', 1, '2.00', '2.00'),
('1234567896', 'Beans', 'Black eyed peace', 1, '16.70', '1.30', '550e8400-e29b-41d4-a716-446655440000', NULL, '2025-03-06 18:11:29', 1, '2.00', '2.00'),
('1234567897', 'Patate', 'Sweet', 1, '16.70', '1.20', '2147483647', NULL, '2025-03-06 18:08:01', 1, '2.00', '2.00'),
('1234567898', 'Beans', 'Black eyed peace', 1, '16.70', '1.30', '550e8400-e29b-41d4-a716-446655440000', NULL, '2025-03-06 18:00:38', 1, '2.00', '2.00'),
('2', 'Mambo', 'Lorem Ipsum', 1, '12.00', '123.00', '550e8400-e29b-41d4-a716-446655440000', NULL, '2025-03-02 08:48:06', 12, '1.00', '3.00'),
('3', 'Samsonite Bag', '2 vo 3 pula', 1, '15.00', '78.30', '550e8400-e29b-41d4-a716-446655440000', NULL, '2025-03-02 08:49:11', 1, '0.00', '2.00'),
('4', 'Beans', 'Black eyed peace', 1, '16.70', '1.30', '550e8400-e29b-41d4-a716-446655440000', '2025-03-07 11:03:30', '2025-03-02 09:21:52', 1, '2.00', '2.00');

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `contact_id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `alternative` varchar(255) DEFAULT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `address3` varchar(255) DEFAULT NULL,
  `town` varchar(255) DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  `postcode` varchar(10) DEFAULT NULL,
  `email1` varchar(255) DEFAULT NULL,
  `email2` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` varchar(36) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`contact_id`, `name`, `alternative`, `address1`, `address2`, `address3`, `town`, `region`, `postcode`, `email1`, `email2`, `created_at`, `created_by`, `deleted_at`) VALUES
('1', 'Driton Haxhiu', 'alternative', 'alternative', 'alternative', 'alternative', 'alternative', 'alternative', NULL, 'alternative', 'alternative', NULL, '550e8400-e29b-41d4-a716-446655440000', '2025-03-07 12:27:48'),
('12345aa', 'Driton Haxhiu', 'alternative', 'alternative', 'alternative', 'alternative', 'alternative', 'alternative', NULL, 'alternative', 'alternative', '2025-03-07 10:56:25', '550e8400-e29b-41d4-a716-446655440000', NULL),
('12345aba', 'Driton Haxhiu', 'alternative', 'alternative', 'alternative', 'alternative', 'alternative', 'alternative', NULL, 'alternative', 'alternative', '2025-03-07 10:57:55', '550e8400-e29b-41d4-a716-446655440000', NULL),
('19b211c8-0fdb-46e5-86c7-edca52976998', 'Brikena', 'brikena@yopmail.com', NULL, NULL, NULL, NULL, NULL, NULL, '045895647', NULL, '2025-03-08 10:24:10', '550e8400-e29b-41d4-a716-446655440000', NULL),
('1bda1839-919f-465c-baeb-8edb633c5958', 'local5', '1@1.com', NULL, NULL, NULL, NULL, NULL, NULL, '123123', NULL, '2025-03-08 11:52:49', '550e8400-e29b-41d4-a716-446655440000', NULL),
('24ce5cb9-8763-4d74-8569-e2f1efc97694', 'Local', '1@1.c', NULL, NULL, NULL, NULL, NULL, NULL, '123123', NULL, '2025-03-08 11:44:32', '550e8400-e29b-41d4-a716-446655440000', NULL),
('27e28efe-71da-4d0d-a63e-47c7f3a11562', 'Toska', 'toska@yopmail.com', NULL, NULL, NULL, NULL, NULL, NULL, '044888999', NULL, '2025-03-08 21:49:54', '550e8400-e29b-41d4-a716-446655440000', NULL),
('3', 'Driton Haxhiu', 'alternative', 'alternative', 'alternative', 'alternative', 'alternative', 'alternative', NULL, 'alternative', 'alternative', '2025-02-26 00:02:31', '550e8400-e29b-41d4-a716-446655440000', NULL),
('3a41be70-b40f-4b66-bdc1-10807a329e81', 'Laura', 'laura@yopmail.com', NULL, NULL, NULL, NULL, NULL, NULL, '045369874', NULL, '2025-03-08 11:05:35', '550e8400-e29b-41d4-a716-446655440000', NULL),
('4', 'Brikena Haxhiu', 'alternative', 'alternative', 'alternative', 'alternative', 'alternative', 'alternative', NULL, 'alternative', 'alternative', '2025-02-26 00:04:03', '550e8400-e29b-41d4-a716-446655440000', '2025-02-26 01:04:03'),
('44b55d39-5725-4a9c-9df4-59d6078c0f81', 'Toska', 'Rinor@yopmail.com', NULL, NULL, NULL, NULL, NULL, NULL, 'Haxhiu', NULL, '2025-03-21 00:53:42', '550e8400-e29b-41d4-a716-446655440000', NULL),
('4ac4ace1-730e-4adf-a569-0a9bfc6c9d8d', 'Anduena', 'andu@yopmail.com', NULL, NULL, NULL, NULL, NULL, NULL, '044325652', NULL, '2025-03-08 10:22:26', '550e8400-e29b-41d4-a716-446655440000', NULL),
('5', 'Brikena Haxhiu', 'alternative', 'alternative', 'alternative', 'alternative', 'alternative', 'alternative', NULL, 'alternative', 'alternative', '2025-02-26 00:04:15', '550e8400-e29b-41d4-a716-446655440000', '2025-03-07 12:21:25'),
('543rt5', 'Front', 'front@yopmail.com', NULL, NULL, NULL, NULL, NULL, NULL, 'front@yopmail.com', NULL, '2025-03-08 02:22:03', '550e8400-e29b-41d4-a716-446655440000', NULL),
('562c92bd-cb3a-423e-9737-9dcd1fb0bf59', 'Rinor', 'nori@yopmail.com', NULL, NULL, NULL, NULL, NULL, NULL, 'nori nori', NULL, '2025-03-08 10:21:52', '550e8400-e29b-41d4-a716-446655440000', NULL),
('5b679dd8-9cbc-45e9-97a1-b3db8baebfe9', 'Pumpkin', 'p@p.p', NULL, NULL, NULL, NULL, NULL, NULL, '123123', NULL, '2025-03-08 12:12:53', '550e8400-e29b-41d4-a716-446655440000', NULL),
('5da8de7f-59fd-4cf4-bb78-ea6d5fdeb9dc', 'Local1', '1@w.w', NULL, NULL, NULL, NULL, NULL, NULL, '123123', NULL, '2025-03-08 11:47:39', '550e8400-e29b-41d4-a716-446655440000', NULL),
('6', 'Driton Haxhiu', 'alternative', 'alternative', 'alternative', 'alternative', 'alternative', 'alternative', NULL, 'alternative', 'alternative', '2025-03-01 06:55:54', '1550e8400-e29b-41d4-a716-44665544000', '2025-03-01 08:33:06'),
('604b87a6-8a38-42ae-ab68-ccbab8da9bb6', 'Lula', 'lula@l.c', NULL, NULL, NULL, NULL, NULL, NULL, '123', NULL, '2025-03-21 02:20:02', '550e8400-e29b-41d4-a716-446655440000', NULL),
('6476ca2f-1bd0-41a9-b739-8f631330333d', 'Emirjon Haxhiu', 'emirjoni@yopmail.com', NULL, NULL, NULL, NULL, NULL, NULL, '123 123 123', NULL, '2025-03-13 00:46:40', '550e8400-e29b-41d4-a716-446655440000', NULL),
('7', 'Driton Haxhiu', 'alternative', 'alternative', 'alternative', 'alternative', 'alternative', 'alternative', NULL, 'alternative', 'alternative', '2025-03-01 07:32:48', '1550e8400-e29b-41d4-a716-44665544000', '2025-03-01 08:33:12'),
('7d90890e-b4a5-4398-97af-8f0ec92ed915', 'Article', '1@1.e', NULL, NULL, NULL, NULL, NULL, NULL, '123123', NULL, '2025-03-08 12:00:16', '550e8400-e29b-41d4-a716-446655440000', NULL),
('7e2b3556-952a-4f9a-b4fd-9d1fa94766d0', 'Ulix', 'ulix@yopmail.com', NULL, NULL, NULL, NULL, NULL, NULL, '12345678', NULL, '2025-03-08 10:28:08', '550e8400-e29b-41d4-a716-446655440000', NULL),
('8b4c9bc6-d985-4d48-aedb-8bba07ed7229', 'Ujeman', 'ujeman@yopmail.com', NULL, NULL, NULL, NULL, NULL, NULL, 'Kosova', NULL, '2025-03-12 11:44:22', '550e8400-e29b-41d4-a716-446655440000', NULL),
('8dbd91fa-4cf5-4db1-9406-b6f1fb9f409b', 'Hello', 'hello@yopmail.com', NULL, NULL, NULL, NULL, NULL, NULL, 'Hello', NULL, '2025-03-12 11:46:18', '550e8400-e29b-41d4-a716-446655440000', NULL),
('95f81fd0-4bfc-43ee-bc3f-99102a2380e3', 'Storage', '1@1.d', NULL, NULL, NULL, NULL, NULL, NULL, '123123', NULL, '2025-03-08 11:46:22', '550e8400-e29b-41d4-a716-446655440000', NULL),
('a5d5d889-8877-4d95-b579-ccc02b937895', 'Alkidi', 'kidi@yopmail.com', NULL, NULL, NULL, NULL, NULL, NULL, '123123', NULL, '2025-03-12 18:42:19', '550e8400-e29b-41d4-a716-446655440000', NULL),
('ac9f6db1-8be9-4973-8f0e-1f5c78c16903', 'Ulix', 'lixi@yopmail.com', NULL, NULL, NULL, NULL, NULL, NULL, '123', NULL, '2025-03-21 01:21:16', '550e8400-e29b-41d4-a716-446655440000', NULL),
('de70627a-efb6-431d-8f63-71b8d3ecc4d0', 'Local4', '1@1.g', NULL, NULL, NULL, NULL, NULL, NULL, '123123', NULL, '2025-03-08 11:52:49', '550e8400-e29b-41d4-a716-446655440000', NULL),
('e552b671-d602-4e8f-a6c0-3a3a75092808', 'line', 'l@l.l', NULL, NULL, NULL, NULL, NULL, NULL, '123123', NULL, '2025-03-08 11:20:11', '550e8400-e29b-41d4-a716-446655440000', NULL),
('e5b28e8e-5974-4a2b-9adf-81219cb0ecd4', 'Teuta Avdiu', 'teuta@yopmail.com', NULL, NULL, NULL, NULL, NULL, NULL, '123 3456 789', NULL, '2025-03-13 00:47:31', '550e8400-e29b-41d4-a716-446655440000', NULL),
('e8622edf-837d-4751-bb33-9ceb25af2a6f', 'online', '2@t.com', NULL, NULL, NULL, NULL, NULL, NULL, '123123', NULL, '2025-03-08 11:16:27', '550e8400-e29b-41d4-a716-446655440000', NULL),
('ec59c91c-deff-414f-9ae9-634990c1059e', 'Local2', 'e@e.e', NULL, NULL, NULL, NULL, NULL, NULL, '123123', NULL, '2025-03-08 11:47:39', '550e8400-e29b-41d4-a716-446655440000', NULL),
('f0ce8414-e736-4d27-9f8d-27779f75a398', 'Local3', '2@w.c', NULL, NULL, NULL, NULL, NULL, NULL, '123123', NULL, '2025-03-08 11:47:39', '550e8400-e29b-41d4-a716-446655440000', NULL),
('f1a9c7d6-4196-4f3e-ab2b-83345e3e3298', 'Driton Haxhiu', 'luna33@yopmail.com', NULL, NULL, NULL, NULL, NULL, NULL, '043 528 093', NULL, '2025-03-12 18:47:45', '33a5123456s78901234567824', NULL),
('fc7ba236-e58d-427b-aa38-646500545cbd', 'Driton', 'driton@yopmail.com', NULL, NULL, NULL, NULL, NULL, NULL, 'Kosova', NULL, '2025-03-12 11:44:48', '550e8400-e29b-41d4-a716-446655440000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `currency`
--

CREATE TABLE `currency` (
  `currency_id` int(11) NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_name` varchar(50) NOT NULL,
  `currency_symbol` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `currency`
--

INSERT INTO `currency` (`currency_id`, `currency_code`, `currency_name`, `currency_symbol`) VALUES
(1, 'AED', 'United Arab Emirates Dirham', 'د.إ'),
(2, 'AFN', 'Afghan Afghani', '؋'),
(3, 'ALL', 'Albanian Lek', 'L'),
(4, 'AMD', 'Armenian Dram', '֏'),
(5, 'ANG', 'Netherlands Antillean Guilder', 'ƒ'),
(6, 'AOA', 'Angolan Kwanza', 'Kz'),
(7, 'ARS', 'Argentine Peso', '$'),
(8, 'AUD', 'Australian Dollar', '$'),
(9, 'AWG', 'Aruban Florin', 'ƒ'),
(10, 'AZN', 'Azerbaijani Manat', '₼'),
(11, 'BAM', 'Bosnia and Herzegovina Convertible Mark', 'KM'),
(12, 'BBD', 'Barbadian Dollar', '$'),
(13, 'BDT', 'Bangladeshi Taka', '৳'),
(14, 'BGN', 'Bulgarian Lev', 'лв'),
(15, 'BHD', 'Bahraini Dinar', '.د.ب'),
(16, 'BIF', 'Burundian Franc', 'FBu'),
(17, 'BMD', 'Bermudian Dollar', '$'),
(18, 'BND', 'Brunei Dollar', '$'),
(19, 'BOB', 'Bolivian Boliviano', 'Bs.'),
(20, 'BRL', 'Brazilian Real', 'R$'),
(21, 'BSD', 'Bahamian Dollar', '$'),
(22, 'BTN', 'Bhutanese Ngultrum', 'Nu.'),
(23, 'BWP', 'Botswana Pula', 'P'),
(24, 'BYN', 'Belarusian Ruble', 'Br'),
(25, 'BZD', 'Belize Dollar', '$'),
(26, 'CAD', 'Canadian Dollar', '$'),
(27, 'CDF', 'Congolese Franc', 'FC'),
(28, 'CHF', 'Swiss Franc', 'CHF'),
(29, 'CLP', 'Chilean Peso', '$'),
(30, 'CNY', 'Chinese Yuan', '¥'),
(31, 'COP', 'Colombian Peso', '$'),
(32, 'CRC', 'Costa Rican Colón', '₡'),
(33, 'CUC', 'Cuban Convertible Peso', '$'),
(34, 'CUP', 'Cuban Peso', '$'),
(35, 'CVE', 'Cape Verdean Escudo', '$'),
(36, 'CZK', 'Czech Koruna', 'Kč'),
(37, 'DJF', 'Djiboutian Franc', 'Fdj'),
(38, 'DKK', 'Danish Krone', 'kr'),
(39, 'DOP', 'Dominican Peso', '$'),
(40, 'DZD', 'Algerian Dinar', 'د.ج'),
(41, 'EGP', 'Egyptian Pound', '£'),
(42, 'ERN', 'Eritrean Nakfa', 'Nfk'),
(43, 'ETB', 'Ethiopian Birr', 'Br'),
(44, 'EUR', 'Euro', '€'),
(45, 'FJD', 'Fijian Dollar', '$'),
(46, 'FKP', 'Falkland Islands Pound', '£'),
(47, 'FOK', 'Faroe Islands Krone', 'kr'),
(48, 'GBP', 'British Pound', '£'),
(49, 'GEL', 'Georgian Lari', '₾'),
(50, 'GGP', 'Guernsey Pound', '£'),
(51, 'GHS', 'Ghanaian Cedi', '₵'),
(52, 'GIP', 'Gibraltar Pound', '£'),
(53, 'GMD', 'Gambian Dalasi', 'D'),
(54, 'GNF', 'Guinean Franc', 'FG'),
(55, 'GTQ', 'Guatemalan Quetzal', 'Q'),
(56, 'GYD', 'Guyanese Dollar', '$'),
(57, 'HKD', 'Hong Kong Dollar', '$'),
(58, 'HNL', 'Honduran Lempira', 'L'),
(59, 'HRK', 'Croatian Kuna', 'kn'),
(60, 'HTG', 'Haitian Gourde', 'G'),
(61, 'HUF', 'Hungarian Forint', 'Ft'),
(62, 'IDR', 'Indonesian Rupiah', 'Rp'),
(63, 'ILS', 'Israeli New Shekel', '₪'),
(64, 'IMP', 'Isle of Man Pound', '£'),
(65, 'INR', 'Indian Rupee', '₹'),
(66, 'IQD', 'Iraqi Dinar', 'ع.د'),
(67, 'IRR', 'Iranian Rial', '﷼'),
(68, 'ISK', 'Icelandic Króna', 'kr'),
(69, 'JEP', 'Jersey Pound', '£'),
(70, 'JMD', 'Jamaican Dollar', '$'),
(71, 'JOD', 'Jordanian Dinar', 'د.ا'),
(72, 'JPY', 'Japanese Yen', '¥'),
(73, 'KES', 'Kenyan Shilling', 'KSh'),
(74, 'KGS', 'Kyrgyzstani Som', 'с'),
(75, 'KHR', 'Cambodian Riel', '៛'),
(76, 'KID', 'Kiribati Dollar', '$'),
(77, 'KMF', 'Comorian Franc', 'CF'),
(78, 'KRW', 'South Korean Won', '₩'),
(79, 'KWD', 'Kuwaiti Dinar', 'د.ك'),
(80, 'KYD', 'Cayman Islands Dollar', '$'),
(81, 'KZT', 'Kazakhstani Tenge', '₸'),
(82, 'LAK', 'Lao Kip', '₭'),
(83, 'LBP', 'Lebanese Pound', 'ل.ل'),
(84, 'LKR', 'Sri Lankan Rupee', '₨'),
(85, 'LRD', 'Liberian Dollar', '$'),
(86, 'LSL', 'Lesotho Loti', 'L'),
(87, 'LYD', 'Libyan Dinar', 'ل.د'),
(88, 'MAD', 'Moroccan Dirham', 'د.م.'),
(89, 'MDL', 'Moldovan Leu', 'L'),
(90, 'MGA', 'Malagasy Ariary', 'Ar'),
(91, 'MKD', 'Macedonian Denar', 'ден'),
(92, 'MMK', 'Burmese Kyat', 'K'),
(93, 'MNT', 'Mongolian Tögrög', '₮'),
(94, 'MOP', 'Macanese Pataca', 'P'),
(95, 'MRU', 'Mauritanian Ouguiya', 'UM'),
(96, 'MUR', 'Mauritian Rupee', '₨'),
(97, 'MVR', 'Maldivian Rufiyaa', 'Rf'),
(98, 'MWK', 'Malawian Kwacha', 'MK'),
(99, 'MXN', 'Mexican Peso', '$'),
(100, 'MYR', 'Malaysian Ringgit', 'RM'),
(101, 'MZN', 'Mozambican Metical', 'MT'),
(102, 'NAD', 'Namibian Dollar', '$'),
(103, 'NGN', 'Nigerian Naira', '₦'),
(104, 'NIO', 'Nicaraguan Córdoba', 'C$'),
(105, 'NOK', 'Norwegian Krone', 'kr'),
(106, 'NPR', 'Nepalese Rupee', '₨'),
(107, 'NZD', 'New Zealand Dollar', '$'),
(108, 'OMR', 'Omani Rial', 'ر.ع.'),
(109, 'PAB', 'Panamanian Balboa', 'B/.'),
(110, 'PEN', 'Peruvian Sol', 'S/.'),
(111, 'PGK', 'Papua New Guinean Kina', 'K'),
(112, 'PHP', 'Philippine Peso', '₱'),
(113, 'PKR', 'Pakistani Rupee', '₨'),
(114, 'PLN', 'Polish Złoty', 'zł'),
(115, 'PYG', 'Paraguayan Guaraní', '₲'),
(116, 'QAR', 'Qatari Rial', 'ر.ق'),
(117, 'RON', 'Romanian Leu', 'lei'),
(118, 'RSD', 'Serbian Dinar', 'дин.'),
(119, 'RUB', 'Russian Ruble', '₽'),
(120, 'RWF', 'Rwandan Franc', 'FRw'),
(121, 'SAR', 'Saudi Riyal', '﷼'),
(122, 'SDG', 'Sudanese Pound', 'ج.س.'),
(123, 'SEK', 'Swedish Krona', 'kr'),
(124, 'SGD', 'Singapore Dollar', '$'),
(125, 'SYP', 'Syrian Pound', '£'),
(126, 'THB', 'Thai Baht', '฿'),
(127, 'TRY', 'Turkish Lira', '₺'),
(128, 'UAH', 'Ukrainian Hryvnia', '₴'),
(129, 'UGX', 'Ugandan Shilling', 'USh'),
(130, 'USD', 'United States Dollar', '$'),
(131, 'UYU', 'Uruguayan Peso', '$U'),
(132, 'UZS', 'Uzbekistan Som', 'сум'),
(133, 'VES', 'Venezuelan Bolívar', 'Bs.'),
(134, 'VND', 'Vietnamese đồng', '₫'),
(135, 'ZAR', 'South African Rand', 'R'),
(136, 'ZMW', 'Zambian Kwacha', 'ZK'),
(137, 'ZWL', 'Zimbabwean Dollar', '$');

-- --------------------------------------------------------

--
-- Table structure for table `error_logs`
--

CREATE TABLE `error_logs` (
  `id` int(11) NOT NULL,
  `object_name` varchar(255) DEFAULT NULL,
  `error_description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `invoice_id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `status` enum('pending','paid') DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `print_date` datetime DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  `contact_1` varchar(36) DEFAULT NULL COMMENT 'Client',
  `contact_2` varchar(36) DEFAULT NULL COMMENT 'Delivery',
  `additional_tax` tinyint(1) DEFAULT NULL,
  `additional_tax_rate` decimal(10,2) DEFAULT NULL,
  `deduction` tinyint(1) DEFAULT NULL,
  `deduction_percent` decimal(10,2) DEFAULT NULL,
  `deduction_value` decimal(10,2) DEFAULT NULL,
  `delivery` tinyint(1) DEFAULT NULL,
  `delivery_rate` decimal(10,2) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` (`invoice_id`, `user_id`, `status`, `created_at`, `print_date`, `due_date`, `contact_1`, `contact_2`, `additional_tax`, `additional_tax_rate`, `deduction`, `deduction_percent`, `deduction_value`, `delivery`, `delivery_rate`, `deleted`) VALUES
('1', '550e8400-e29b-41d4-a716-446655440000', 'pending', '2025-02-24 23:26:49', NULL, NULL, '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('2', '550e8400-e29b-41d4-a716-446655440000', 'pending', '2025-02-24 23:27:01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('2228', '550e8400-e29b-41d4-a716-446655440000', 'pending', '2025-02-24 23:26:49', NULL, NULL, '19b211c8-0fdb-46e5-86c7-edca52976998', '19b211c8-0fdb-46e5-86c7-edca52976998', 0, '0.00', 1, '2.00', '0.00', 0, '0.00', '2025-03-09 12:43:19'),
('22289', '550e8400-e29b-41d4-a716-446655440000', 'pending', '2025-02-24 23:26:49', NULL, NULL, '19b211c8-0fdb-46e5-86c7-edca52976998', '19b211c8-0fdb-46e5-86c7-edca52976998', 0, '0.00', 1, '2.00', '0.00', 0, '0.00', NULL),
('550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440000', 'pending', '2025-02-24 23:26:49', NULL, NULL, '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440000', 'pending', '2025-02-24 23:26:49', NULL, NULL, '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440000', 'pending', '2025-02-24 23:26:49', NULL, NULL, '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('550e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440000', 'pending', '2025-02-24 23:26:49', NULL, NULL, '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('550e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440000', 'pending', '2025-02-24 23:26:49', NULL, NULL, '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('550e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440000', 'pending', '2025-02-24 23:26:49', NULL, NULL, '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('550e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440000', 'pending', '2025-02-24 23:26:49', NULL, NULL, '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('550e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440000', 'pending', '2025-02-24 23:26:49', NULL, NULL, '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('550e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440000', 'pending', '2025-02-24 23:26:49', NULL, NULL, '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('550e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440000', 'pending', '2025-02-24 23:26:49', NULL, NULL, '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('550e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440000', 'pending', '2025-02-24 23:26:49', NULL, NULL, '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` varchar(36) NOT NULL,
  `invoice_id` varchar(36) NOT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `method` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `details` text DEFAULT NULL,
  `deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`payment_id`, `invoice_id`, `amount`, `method`, `date`, `details`, `deleted`) VALUES
('1', '1', '200.00', 1, NULL, 'Lorem Ipsum', NULL),
('123', '1', '0.00', 1, '0000-00-00 00:00:00', 'Lorem Ipsum', NULL),
('2', '2', '300.00', 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `settings_id` varchar(36) NOT NULL,
  `settings_user_parent_id` varchar(36) NOT NULL,
  `settings_business_name` varchar(255) DEFAULT NULL,
  `settings_address_1` varchar(255) DEFAULT NULL,
  `settings_address_2` varchar(255) DEFAULT NULL,
  `settings_address_3` varchar(255) DEFAULT NULL,
  `settings_town` varchar(255) DEFAULT NULL,
  `settings_region` varchar(255) DEFAULT NULL,
  `settings_postcode` varchar(10) DEFAULT NULL,
  `settings_telephone` varchar(20) DEFAULT NULL,
  `settings_fax` varchar(20) DEFAULT NULL,
  `settings_email` varchar(100) DEFAULT NULL,
  `settings_website` varchar(100) DEFAULT NULL,
  `settings_tax_number` varchar(20) DEFAULT NULL,
  `settings_business_number` varchar(20) DEFAULT NULL,
  `settings_tax_name` varchar(5) DEFAULT NULL,
  `settings_tax_rate` decimal(5,2) UNSIGNED DEFAULT 17.50,
  `settings_overdue_days` int(11) DEFAULT NULL,
  `settings_currency_symbol` int(11) NOT NULL,
  `settings_reply_slip_text` varchar(255) DEFAULT NULL,
  `settings_invoice_message` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`settings_id`, `settings_user_parent_id`, `settings_business_name`, `settings_address_1`, `settings_address_2`, `settings_address_3`, `settings_town`, `settings_region`, `settings_postcode`, `settings_telephone`, `settings_fax`, `settings_email`, `settings_website`, `settings_tax_number`, `settings_business_number`, `settings_tax_name`, `settings_tax_rate`, `settings_overdue_days`, `settings_currency_symbol`, `settings_reply_slip_text`, `settings_invoice_message`) VALUES
('0', '0', '', '', '', '', '', '', '', '', '', '', '', '', '', 'VAT', '17.50', 30, 40, '', ''),
('20a5123456s78901234567824', '20a5123456s78901234567824', '', '', '', '', '', '', '', '', '', '', '', '', '', 'VAT', '9.99', 30, 40, '', ''),
('21a5123456s78901234567824', '21a5123456s78901234567824', '', '', '', '', '', '', '', '', '', '', '', '', '', 'VAT', '17.50', 30, 40, '', ''),
('22a5123456s78901234567824', '22a5123456s78901234567824', '', '', '', '', '', '', '', '', '', '', '', '', '', 'VAT', '17.50', 30, 40, '', ''),
('23a5123456s78901234567824', '23a5123456s78901234567824', '', '', '', '', '', '', '', '', '', '', '', '', '', 'VAT', '17.50', 30, 40, '', ''),
('24a5123456s78901234567824', '24a5123456s78901234567824', '', '', '', '', '', '', '', '', '', '', '', '', '', 'VAT', '17.50', 30, 40, '', ''),
('25a5123456s78901234567824', '25a5123456s78901234567824', '', '', '', '', '', '', '', '', '', '', '', '', '', 'VAT', '17.50', 30, 40, '', ''),
('26a5123456s78901234567824', '26a5123456s78901234567824', '', 'req.user.user_id, ', '', '', '', '', '', '', '', '', '', '', '', 'VAT', '17.50', 30, 40, '', ''),
('27a5123456s78901234567824', '27a5123456s78901234567824', '', '', '', '', '', '', '', '', '', '', '', '', '', 'VAT', '17.50', 30, 40, '', ''),
('28a5123456s78901234567824', '28a5123456s78901234567824', '', '', '', '', '', '', '', '', '', '', '', '', '', 'VAT', '17.50', 30, 40, '', ''),
('29a5123456s78901234567824', '29a5123456s78901234567824', '', '', '', '', '', '', '', '', '', '', '', '', '', 'VAT', '17.50', 30, 40, '', ''),
('35a5123456s78901234567824', '35a5123456s78901234567824', '', '', '', '', '', '', '', '', '', '', '', '', '', 'VAT', '17.50', 30, 40, '', ''),
('36a5123456s78901234567824', '36a5123456s78901234567824', '', '', '', '', '', '', '', '', '', '', '', '', '', 'VAT', '17.50', 30, 40, '', ''),
('37a5123456s78901234567824', '37a5123456s78901234567824', '', '', '', '', '', '', '', '', '', '', '', '', '', 'VAT', '17.50', 30, 40, '', ''),
('39a5123456s78901234567824', '39a5123456s78901234567824', '', '', '', '', '', '', '', '', '', '', '', '', '', 'VAT', '17.50', 30, 40, '', ''),
('40a5123456s78901234567824', '40a5123456s78901234567824', '', '', '', '', '', '', '', '', '', '', '', '', '', 'VAT', '17.50', 30, 40, '', ''),
('7a5123456s78901234567823', '7a5123456s78901234567823', '', '', '', '', '', '', '', '', '', '', '', '', '', 'VAT', '9.99', 30, 40, '', ''),
('8a5123456s78901234567824', '8a5123456s78901234567824', '', '', '', '', '', '', '', '', '', '', '', '', '', 'VAT', '9.99', 30, 40, '', ''),
('9a5123456s78901234567824', '550e8400-e29b-41d4-a716-446655440000', 'string', 'string', 'string', 'string', 'string', 'string', 'string', 'string', 'string', 'string', 'string', 'string', 'string', 'strin', '17.50', 29, 40, 'string', 'string');

-- --------------------------------------------------------

--
-- Table structure for table `subinvoice`
--

CREATE TABLE `subinvoice` (
  `subinvoice_id` varchar(36) NOT NULL,
  `invoice_id` varchar(36) NOT NULL,
  `product` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `taxed` tinyint(1) DEFAULT NULL,
  `tax_rate` decimal(10,2) DEFAULT NULL,
  `discount` tinyint(1) DEFAULT NULL,
  `discount_amount` decimal(10,2) DEFAULT NULL,
  `qty` decimal(11,0) DEFAULT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  `discount_percent` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `subinvoice`
--

INSERT INTO `subinvoice` (`subinvoice_id`, `invoice_id`, `product`, `description`, `taxed`, `tax_rate`, `discount`, `discount_amount`, `qty`, `unit_price`, `discount_percent`) VALUES
('1', '1', 'Macbook Air', NULL, 1, '12.00', 1, '12.00', '2', '1200.00', '12.00'),
('12234', '1', 'asd', 'asd', 1, '16.00', 1, '0.00', '1', '100.00', '2.00'),
('2', '1', 'iPhone 15 Pro Max', 'Lorem Ipsum', 1, '17.50', 1, '10.00', '1', '1000.00', '12.00'),
('3', '1', 'asd', 'asd', 1, '16.00', 1, '0.00', '1', '100.00', '2.00'),
('aaa', '1', 'asd', 'asd', 1, '16.00', 1, '0.00', '1', '100.00', '2.00'),
('bbb', '1', 'asd', 'asd', 1, '16.00', 1, '0.00', '1', '100.00', '2.00'),
('ccc', '1', 'Macbook', 'Lorem Ipsum', 1, '16.00', NULL, NULL, NULL, '100.00', '2.00'),
('ddd', '1', 'Macbook', 'Lorem ipsum', 0, '16.00', 0, '0.00', '1', '200.00', '0.00');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` varchar(36) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','worker') NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `parent_id` varchar(36) NOT NULL,
  `refresh_token` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `email`, `password`, `role`, `created_at`, `parent_id`, `refresh_token`) VALUES
('1', 'driton@example.com', '$2y$12$.Z4U6/guBZDUdCWH.E.r6OTwqjruoiB8uWM4GbxouLASltLNisfRC', 'admin', '2025-02-24 22:42:05', '1', NULL),
('2', 'driton@yopmail.com', '$2b$10$vxVBrwoxVWNa.t7DAOtmSOe8gn0/RRWqyCHn9WNE5lYvtQ77ImY7e', 'admin', '2025-03-05 21:29:48', '1', NULL),
('3', 'luna@yopmail.com', '$2b$10$sRNgrT1L/rzsDA38csyqmuqBoEdaulEeFka6Lz/JrNPXAiMa/9hKe', 'admin', '2025-03-06 09:52:34', '1', NULL),
('33a5123456s78901234567824', 'luna33@yopmail.com', '$2b$10$nq19YEm4SnPjVTL3nyWawOhbKZ2irVUC5XArAH5R38nsNJNreQJoS', 'admin', '2025-03-10 22:45:40', '', NULL),
('35a5123456s78901234567824', 'luna35@yopmail.com', '$2b$10$fxpQtQZrFWwTHsuGsFTo6Otf1SUeD9YkJDfsWz0BP0yiNnR08TWCe', 'admin', '2025-03-10 22:50:23', '', NULL),
('36a5123456s78901234567824', 'luna36@yopmail.com', '$2b$10$iPIpJRHgwmv/DBesKwhfK.N/LH06ck6vDaiOLrrJ4JNdiayGSd9X2', 'admin', '2025-03-10 22:53:23', '', NULL),
('37a5123456s78901234567824', 'luna37@yopmail.com', '$2b$10$/O6sXrDcBTLZUJriDmnpceQDKnK0Nkk7EpKAx.FwYdHcU6wcXsatq', 'admin', '2025-03-10 22:54:11', '', NULL),
('38a5123456s78901234567824', 'luna38@yopmail.com', '$2b$10$AwgVm4yPvmS5z3b5oQ2cJucl9IVvmNyK7LjM9/hyen8L0KnPSezmW', 'admin', '2025-03-10 22:55:40', '', NULL),
('39a5123456s78901234567824', 'luna39@yopmail.com', '$2b$10$2pDE3x1fCcwHRzbepvUeMuzvVtMJDGnLl5043nHjq1I4PBWTGdXwO', 'admin', '2025-03-10 22:56:34', '', NULL),
('4', 'luna1@yopmail.com', '$2b$10$EgMY7xxcoYA2ZpkpyVklSOBTCeVgF4AUZWJOp4DwLfefHJWkzzDme', 'admin', '2025-03-06 09:55:05', '1', NULL),
('40a5123456s78901234567824', 'luna40@yopmail.com', '$2b$10$YOb87P8cZzDVNq1ua3fPpOX4JCSG849LBFg10.d80sW3Ms2aW4f1q', 'admin', '2025-03-10 22:58:10', '', NULL),
('550e8400-e29b-41d4-a716-446655440000', 'luna2@yopmail.com', '$2b$10$phgVXAq.3aUvnJPGRFm6i.HuPSIhKIXTYcJ21bX1PQG2yXT1L0YeW', 'admin', '2025-03-06 10:10:03', '550e8400-e29b-41d4-a716-446655440000', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNTUwZTg0MDAtZTI5Yi00MWQ0LWE3MTYtNDQ2NjU1NDQwMDAwIiwiZW1haWwiOiJsdW5hMkB5b3BtYWlsLmNvbSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc0MjUyNDM5NCwiZXhwIjoxNzQzMTI5MTk0fQ.cy1cFBnhqEiQL9d7xYUIQNwLanwGkU0q6oH0TVyL7Go');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`article_id`);

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`contact_id`) USING BTREE;

--
-- Indexes for table `currency`
--
ALTER TABLE `currency`
  ADD PRIMARY KEY (`currency_id`),
  ADD UNIQUE KEY `currency_code` (`currency_code`);

--
-- Indexes for table `error_logs`
--
ALTER TABLE `error_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`invoice_id`) USING BTREE,
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`,`invoice_id`) USING BTREE;

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`settings_id`);

--
-- Indexes for table `subinvoice`
--
ALTER TABLE `subinvoice`
  ADD PRIMARY KEY (`subinvoice_id`) USING BTREE,
  ADD KEY `fk_invoice_id` (`invoice_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`) USING BTREE,
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `currency`
--
ALTER TABLE `currency`
  MODIFY `currency_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=138;

--
-- AUTO_INCREMENT for table `error_logs`
--
ALTER TABLE `error_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
