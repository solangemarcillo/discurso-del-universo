
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