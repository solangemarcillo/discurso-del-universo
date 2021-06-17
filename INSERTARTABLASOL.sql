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
    