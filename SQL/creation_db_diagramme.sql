SET NAMES 'utf8mb4';
SET CHARACTER SET utf8mb4;

create database db_diagramme;
use db_diagramme;

create table if not exists client(
    client_id INT NOT NULL,
    nom VARCHAR(45) NOT NULL,
    prenom VARCHAR(45) NOT NULL,
    telephone CHAR(45) NOT NULL,
    mail VARCHAR(45) NOT NULL,
    CONSTRAINT PK_CLIENT PRIMARY KEY(client_id)
);

create table if not exists logiciel(
    logiciel_id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(32) NOT NULL,
    cle_licence VARCHAR(255) NOT NULL,
    CONSTRAINT PK_LOGICIEL PRIMARY KEY(logiciel_id)
);


create table if not exists commande(
    commande_id INT NOT NULL AUTO_INCREMENT,
    client_id INT NOT NULL,
    date_commande DATE,
    logiciel_id INT NOT NULL,
    CONSTRAINT PK_COMMANDE PRIMARY KEY(commande_id),
    CONSTRAINT FK_COMMANDE_CLIENT FOREIGN KEY(client_id) REFERENCES client(client_id),
    CONSTRAINT FK_COMMANDE_LOGICIEL FOREIGN KEY(logiciel_id) REFERENCES logiciel(logiciel_id),
);