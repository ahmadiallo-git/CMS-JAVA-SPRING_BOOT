CREATE SCHEMA IF NOT EXISTS securecapita;
SET NAMES 'UTF8MB4';
SET TIME_ZONE = '+00:00';
USE securecapita;

DROP TABLE IF EXISTS TwofactorVerifications;
DROP TABLE IF EXISTS ResetPasswordVerifications;
DROP TABLE IF EXISTS AccountVerifications;
DROP TABLE IF EXISTS UserEvents;
DROP TABLE IF EXISTS Events;
DROP TABLE IF EXISTS UserRoles;
DROP TABLE IF EXISTS Roles;
DROP TABLE IF EXISTS Users;

CREATE TABLE IF NOT EXISTS Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(255) NOT NULL,
    lastname VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(255) DEFAULT NULL,
    title VARCHAR(50),
    bio VARCHAR(255) DEFAULT NULL,
    enabled BOOLEAN DEFAULT FALSE,
    non_locked BOOLEAN DEFAULT TRUE,
    using_mfa TINYINT NOT NULL DEFAULT 0,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    image_url VARCHAR(255) DEFAULT 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
    CONSTRAINT UQ_Users_Email UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS Roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    permission VARCHAR(255) NOT NULL,
    CONSTRAINT UQ_Roles_Name UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS UserRoles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    role_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (role_id) REFERENCES Roles (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT UQ_UserRoles_User_id UNIQUE (user_id)
);

CREATE TABLE IF NOT EXISTS Events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(50) NOT NULL CHECK(type IN ('LOGIN_ATTEMPT', 'LOGIN_ATTEMP_FAILURE', 'LOGIN_ATTEMP_SUCCESS', 'PROFILE_UPDATE', 'PROFILE_PICTURE_UPDATE', 'ROLE_UPDATE', 'ACCOUNT_SETTINGS_UPDATE', 'PASSWORD_UPDATE', 'MFA_UPDATE' )),
    description VARCHAR(255) NOT NULL,
    CONSTRAINT UQ_Events_Type UNIQUE (type )
);

CREATE TABLE IF NOT EXISTS UserEvents (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    event_id INT NOT NULL,
    device VARCHAR(100) DEFAULT NULL,
    ip_address VARCHAR(100) DEFAULT NOT NULL,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (event_id) REFERENCES Events (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS AccountVerifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    url VARCHAR(255) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT UQ_AccountVerifications_User_Id UNIQUE (user_id),
    CONSTRAINT UQ_AccountVerifications_Url UNIQUE (url)
);

CREATE TABLE ResetPasswordVerifications (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    url VARCHAR(255) NOT NULL,
    expiration_date DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT UQ_ResetPasswordVerifications_User_Id UNIQUE (user_id),
    CONSTRAINT UQ_ResetPasswordVerifications_Url UNIQUE (url)
);

CREATE TABLE IF NOT EXISTS TwofactorVerifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    code VARCHAR(10) NOT NULL,
    expiration_date DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT UQ_TwofactorVerifications_User_Id UNIQUE (user_id),
    CONSTRAINT UQ_TwofactorVerifications_code UNIQUE (code)
);