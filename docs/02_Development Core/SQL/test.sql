create DATABASE db;
use db;

create table player(
    id int unsigned not null auto_increment,
    email varchar(11) not null
    phone varchar(10) not null 
    primary key (id)

);


insert into player(email, phone) value ("tiến thiện", "0215454544");
update player where id= 1 set email="helloo"

create table accounts(
    id int unsigned not null auto_increment,
    country_code CHAR(2) CHARACTER SET ascii,
    postal_code CHAR(6) CHARACTER SET ascii,
    uuid CHAR(39) CHARACTER SET ascii, -- more discussion elsewhere
    primary key (id)

)

CREATE TABLE countries (
    code CHAR(2)
);
INSERT INTO countries VALUES ('US'), ('CA'), ('JP');
INSERT INTO countries VALUES ('A'); -- Chỉ 1 ký tự



CREATE USER 'user'@'localhost' IDENTIFIED BY 'some_password';
CREATE USER 'user'@'%' IDENTIFIED BY 'some_password';

GRANT privileges ON database.table TO 'username'@'host';
GRANT SELECT, INSERT, UPDATE ON mydb.* TO 'app_user'@'localhost';
GRANT ALL ON *.* TO 'admin_user'@'localhost' WITH GRANT OPTION;

GRANT SELECT ON dbname.users TO 'reporter'@'192.168.1.50';
GRANT SELECT, LOCK TABLES, RELOAD ON *.* TO 'backup'@'localhost';
GRANT USAGE ON *.* TO 'user'@'host';

SHOW GRANTS FOR 'app_user'@'localhost';
SHOW GRANTS FOR 'webapp'@'192.168.1.10';
FLUSH PRIVILEGES;


-- Xem múi giờ hiện tại
SELECT @@global.time_zone, @@session.time_zone;

-- Chuyển TIMESTAMP sang múi giờ cụ thể
SELECT CONVERT_TZ(NOW(), '+00:00', '+07:00') AS hanoi_time;

-- Lưu timestamp theo UTC, hiển thị theo múi giờ client
-- App PHP/Node.js: gửi múi giờ → server chuyển đổi khi trả về