// DELIMITER //
// 'CREATE TRIGGER stock_account AFTER INSERT ON gas
//       FOR EACH ROW
//         BEGIN
//           INSERT INTO stocks(stock, item, type, created_at, updated_at) VALUES (0, NEW.id, 2, NEW.created_at, NEW.updated_at);
//       END//
// '

// DELIMITER //
// 'CREATE TRIGGER stock_update AFTER INSERT ON gas
//       FOR EACH ROW
//         BEGIN
//           INSERT INTO stocks(stock, item, type, created_at, updated_at) VALUES (0, NEW.id, 2, NEW.created_at, NEW.updated_at);
//       END//
// '

// DELIMITER //
// 'CREATE TRIGGER stock_report AFTER INSERT ON stocks
//       FOR EACH ROW
//         BEGIN
//           INSERT INTO stock_reports(stock, item, type, created_at, updated_at) VALUES (0, NEW.id, 2, NEW.created_at, NEW.updated_at);
//       END//
// '

CREATE TRIGGER stock_report AFTER UPDATE ON stocks FOR EACH ROW BEGIN DECLARE deinc varchar(10); DECLARE amount INT; IF OLD.stock < NEW.stock THEN SET deinc = 'IN'; SET amount = NEW.stock - OLD.stock; ELSE SET deinc = 'OUT'; SET amount = OLD.stock - NEW.stock; END IF; INSERT INTO stock_reports(stock, item, type, choices, created_at, updated_at) VALUES (amount, OLD.item, OLD.type, deinc, NEW.updated_at, NEW.updated_at); END

<!-- DELIMITER //
 CREATE PROCEDURE create_stock_report(IN supplier INT, IN stock INT, IN choice VARCHAR(10), IN created_at DATETIME, IN updated_at DATETIME)
         BEGIN
           INSERT INTO stock_reports(supplier, stock, choices, created_at, updated_at) VALUES (supplier, stock, choice, created_at, updated_at);
 END// -->

<!-- DELIMITER //
 CREATE PROCEDURE create_stock_account(IN id INT)
         BEGIN
           INSERT INTO stocks(stock, item, type, created_at, updated_at) VALUES (0, NEW.id, 2, NEW.created_at, NEW.updated_at);
 END// -->
