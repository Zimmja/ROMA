CREATE TABLE Spaces (
    id  serial,
    name varchar(30),
    password varchar(30),
    bedrooms int,
    fk_User int
 );