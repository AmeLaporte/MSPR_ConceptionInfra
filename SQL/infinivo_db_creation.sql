SET NAMES 'utf8mb4';
SET CHARACTER SET utf8mb4;

create database infinivo;
use infinivo;

create table if not exists client(
    client_id INT NOT NULL AUTO_INCREMENT,
    societe VARCHAR(32),
    nom VARCHAR(32) NOT NULL,
    prenom VARCHAR(32) NOT NULL,
    adresse VARCHAR(50) NOT NULL,
    code_postal CHAR(5) NOT NULL,
    ville VARCHAR(32) NOT NULL,
    telephone CHAR(10) NOT NULL,
    mail VARCHAR(50) NOT NULL,
    CONSTRAINT PK_CLIENT PRIMARY KEY(client_id)
);

create table if not exists logiciel(
    logiciel_id INT NOT NULL AUTO_INCREMENT,
    descriptif VARCHAR(255) NOT NULL,
    nom VARCHAR(32) NOT NULL,
    prix_unitaire INT NOT NULL,
    CONSTRAINT PK_LOGICIEL PRIMARY KEY(logiciel_id)
);

create table if not exists licence(
    licence_id INT NOT NULL AUTO_INCREMENT,
    logiciel_id INT NOT NULL,
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    status_lic VARCHAR(3) NOT NULL,
    CONSTRAINT PK_LICENCE PRIMARY KEY(licence_id),
    CONSTRAINT FK_LICENCE_LOGICIEL FOREIGN KEY(logiciel_id) REFERENCES logiciel(logiciel_id)
);

create table if not exists commande(
    commande_id INT NOT NULL AUTO_INCREMENT,
    client_id INT NOT NULL,
    date_commande DATE NOT NULL,
    logiciel_id INT NOT NULL,
    licence_id INT NOT NULL,
    remise INT,
    numero_facture INT NOT NULL,
    prix INT NOT NULL,
    status_com VARCHAR(32) NOT NULL,
    CONSTRAINT PK_COMMANDE PRIMARY KEY(commande_id),
    CONSTRAINT FK_COMMANDE_CLIENT FOREIGN KEY(client_id) REFERENCES client(client_id),
    CONSTRAINT FK_COMMANDE_LOGICIEL FOREIGN KEY(logiciel_id) REFERENCES logiciel(logiciel_id),
    CONSTRAINT FK_COMMANDE_LICENCE FOREIGN KEY(licence_id) REFERENCES licence(licence_id)
);