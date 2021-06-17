CREATE TABLE Familiar(
    Nombre varchar (25),
    Apellidos varchar (60),
    Telefono char (10),
    Direccion varchar (70),
    ID_Familia integer PRIMARY KEY 
);

CREATE TABLE Enterrador(
    Nombre varchar (25),
    Apellidos varchar (60),
    Direccion varchar (70),
    Telefono char (10),
    Telef_Movil char(10),
    Antiguedad integer,
    Salario numeric(10,2),
    Dni varchar(10) PRIMARY KEY
);

CREATE TABLE Administrativo(
    Nombre varchar (25),
    Apellidos varchar (60),
    Direccion varchar (70),
    Telefono char (10),
    Telef_Movil char(10),
    Antiguedad integer,
    Salario numeric(10,2),
    Dni varchar(10) PRIMARY KEY
);

CREATE TABLE Sector(
    ID_Sector integer PRIMARY KEY,
    Nombre varchar (30),
    Superficie integer CHECK (Superficie < 1000),
    Capacidad integer
);

CREATE TABLE Jardinero(
    Nombre varchar (25),
    Apellidos varchar (60),
    Direccion varchar (70),
    Telefono char (10),
    Telef_Movil char(10),
    Antiguedad integer,
    Salario numeric(10,2),
    Sector integer NOT NULL DEFAULT 0,
    CONSTRAINT ajena_Sector FOREIGN KEY(Sector)
        REFERENCES Sector(ID_Sector)
        ON DELETE SET DEFAULT
        ON UPDATE CASCADE,
    Dni varchar(10) PRIMARY KEY
);

CREATE TABLE Tumba(
    ID_Tumba integer PRIMARY KEY,
    Tipo varchar (10),
    Sector integer NOT NULL DEFAULT 0,
    CONSTRAINT ajena_Sector FOREIGN KEY(Sector)
        REFERENCES Sector(ID_Sector)
        ON DELETE SET DEFAULT
        ON UPDATE CASCADE
        
);

CREATE TABLE Nicho(
    Altura smallint CHECK (Altura <= 5) ,
    ID_Nicho integer PRIMARY KEY,
    CONSTRAINT ajena_ID_Nicho FOREIGN KEY(ID_Nicho)
        REFERENCES Tumba(ID_TUMBA)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    Inscripcion text
);
    
CREATE TABLE FosaComun(
    ID_Fosa integer PRIMARY KEY,
    CONSTRAINT ajena_ID_Fosa FOREIGN KEY(ID_Fosa)
    REFERENCES Tumba(ID_TUMBA)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    Capacidad integer CHECK (Capacidad <= 200)
);
    
CREATE TABLE Panteon(
    ID_Panteon integer PRIMARY KEY,
    CONSTRAINT ajena_ID_Panteon FOREIGN KEY(ID_Panteon)
        REFERENCES Tumba(ID_TUMBA)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    ID_Familia integer,
    CONSTRAINT ajena_ID_Familia FOREIGN KEY(ID_Familia)
        REFERENCES Familiar(ID_Familia)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    Capacidad smallint Check (Capacidad < 6),
    Inscripcion text
);


CREATE TABLE Factura(
        Cantidad numeric(10,2),
        Fecha Date,
        ID_Familia integer,
        ID_Admin varchar(10),
        CONSTRAINT Clave_Factura PRIMARY KEY(Fecha,ID_Familia,ID_Admin),
        CONSTRAINT ajena_ID_Admin FOREIGN KEY(ID_Admin)
                REFERENCES Administrativo(Dni)
                ON DELETE CASCADE
                ON UPDATE CASCADE,
        CONSTRAINT ajena_ID_Familia FOREIGN KEY(ID_Familia)
                REFERENCES Familiar(ID_Familia)
                ON DELETE CASCADE
                ON UPDATE CASCADE

);

CREATE TABLE Fallecido(
        Nombre varchar (25),
        Apellidos varchar (60),
        FechaNacimiento date,
        FechaMuerte date CHECK (FechaMuerte >= FechaNacimiento),
        Enterrador varchar(10) NOT NULL,
        ID_Familia integer,
        Tumba integer NOT NULL,
        CONSTRAINT ajena_Enterrador FOREIGN KEY(Enterrador)
                REFERENCES Enterrador(Dni)
                ON DELETE SET NULL
                ON UPDATE CASCADE,
        CONSTRAINT ajena_Tumba FOREIGN KEY(Tumba)
                REFERENCES Tumba(ID_Tumba)
                ON DELETE CASCADE
                ON UPDATE CASCADE,
        CONSTRAINT ajena_ID_Familia FOREIGN KEY(ID_Familia)
                REFERENCES Familiar(ID_Familia)
                ON DELETE SET NULL
                ON UPDATE CASCADE,
        Dni varchar(10) PRIMARY KEY
);
    
INSERT INTO Familiar VALUES('SOLANGE','VILLAFUERTE', '0999888899', '4 DE NOVIEMBRE', '1');
INSERT INTO Familiar VALUES('MARIA','MARCILLO', '0888999977', 'SAN PEDRO', '2');
INSERT INTO Familiar VALUES('EDGAR','PANCHANA', '0999663321', 'CALLE 13', '3');

INSERT INTO Enterrador VALUES('MAURICIO','PALMA', 'SAN JUAN', '042789647', '092564123','5', '800','1315729220');
INSERT INTO Enterrador VALUES('JOSE','PARRAGA', 'SARILAND', '052489752', '092533123', '2','800','1385463221');
INSERT INTO Enterrador VALUES('PAUL','MERO', 'URBIRRIOS', '05894735', '099562123', '6','800','1358652110');

INSERT INTO Administrativo VALUES('JOEL','MOYA', 'CALLE 12','05254156','096773215','3','600','1358541223');
INSERT INTO Administrativo VALUES('VICENTE','MACIAS','LA AURORA','05254185','093641236','2','600','1358540023');
INSERT INTO Administrativo VALUES('ESTIVEN','DELGADO','MARINABLUE','05214785','094514665','2','700','1301458225');

INSERT INTO Sector VALUES('1','NORTE','400','20');
INSERT INTO Sector VALUES('2','SUR','700','30');
INSERT INTO Sector VALUES('3','ESTE','500','25');

INSERT INTO Jardinero VALUES('VICTOR','LOPEZ', 'MANTA BEACH', '05214568', '099562135', '1', '500','1','1352145662');
INSERT INTO Jardinero VALUES('JULIO','AROZEMENA', 'SAN JUAN', '05211168', '099502135', '3', '500','2','1352145002');
INSERT INTO Jardinero VALUES('ROGER','DOMINGUEZ', 'PORTAL DEL SOL', '056669652', '097778541', '4', '500','3','1302122662');

INSERT INTO Tumba VALUES('1','NICHO', '1');
INSERT INTO Tumba VALUES('2','FOSACOMUN', '2');
INSERT INTO Tumba VALUES('3','PANTEON', '3');

INSERT INTO Nicho VALUES('3','1','ALADINO TIPAN');
INSERT INTO FosaComun VALUES('2','100');
INSERT INTO Panteon VALUES('3','3', '5', 'PEDRO SOLORZANO');

INSERT INTO Factura VALUES('625.25','2020-06-03', '1', '1358541223');
INSERT INTO Factura VALUES('200.95','2019-08-04', '2', '1358540023');
INSERT INTO Factura VALUES('1521.25','2018-06-05', '3', '1301458225');

INSERT INTO Fallecido VALUES('ALADINO','TIPAN', '1965-04-02', '2020-06-01','1315729220', '1', '1', '1352478995');
INSERT INTO Fallecido VALUES('ANTONIO','TORRES', '1985-03-20', '2019-08-02','1385463221', '2', '2','1315447885');
INSERT INTO Fallecido VALUES('PEDRO', 'SOLORZANO', '1987-05-06', '2020-06-03','1358652110', '3', '3', '1575412112');

/*Consulta sobre que enterrador enterró a Alejandro y la fecha de muerte*/
select 
concat(Fallecido.Nombre,' ', Fallecido.Apellidos) as Fallecido,
concat(Enterrador.Nombre,' ', enterrador.Apellidos) as Nombre_Enterrador,
Enterrador.Dni as DNI_Enterrador,
fallecido.fechamuerte as Fecha_Muerte
From Fallecido INNER JOIN Enterrador
ON Fallecido.Enterrador = Enterrador.Dni 
WHERE Fallecido.Nombre = 'ALADINO';

/*Consulta sobre salario de más de 700 entre los enterradores con sus datos*/
select 
concat(Nombre,' ', Apellidos) as Enterrador, Dni, Telefono, Telef_Movil as Telefono_Movil, 
concat (antiguedad, ' años')as Antiguedad, Salario
FROM Enterrador
WHERE Salario > 700;

/*Consulta sobre facturas de cada familia*/
select
concat (Familiar.Nombre,' ',Familiar.Apellidos)as familiar,
Factura.Cantidad, Factura.Fecha,
concat (administrativo.Nombre,' ',administrativo.Apellidos) as Administrador,
administrativo.Dni
from factura
INNER JOIN Familiar on factura.id_familia = familiar.id_familia
INNER JOIN Administrativo on Administrativo.Dni = factura.id_Admin;

/*Consulta sobre la tumba, el tipo de tumba, y el fallecido de cada tumba, tambien el jardinero encargado del sector*/
select
tumba.id_Tumba, tumba.Tipo, 
concat(fallecido.nombre,' ', fallecido.apellidos) as Nombre_Fallecido, 
sector.nombre as Sector, sector.capacidad, concat(sector.superficie, 'm2') as Superficie,
concat (jardinero.nombre,' ',jardinero.apellidos) as Jardinero_Encargado
from Tumba
INNER JOIN Fallecido on Fallecido.tumba = tumba.ID_tumba
INNER JOIN Sector on Sector.ID_sector = tumba.sector
INNER JOIN Jardinero on Jardinero.sector = sector.ID_Sector