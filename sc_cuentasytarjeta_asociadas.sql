﻿-- Identificar si es natural, juridico

SELECT * FROM security.usuario WHERE username = 'pgsgroup';



-- Cuantas cuentas tiene como natural :

SELECT count(*) FROM cuenta WHERE id_cliente = 
                           (SELECT id FROM cliente WHERE id_ente = 
                           (SELECT id FROM ente WHERE id = 
                           (SELECT id FROM persona WHERE id = 
                           (SELECT id_persona FROM usuario_cliente WHERE user_name = 'pgsgroup'))));
                           
-- Mostrar las cuentas que tiene como natural :

 SELECT numero_cuenta FROM cuenta WHERE id_cliente = 
                         (SELECT id FROM cliente WHERE id_ente = 
                         (SELECT id FROM ente WHERE id = 
                         (SELECT id FROM persona WHERE id = 
                         (SELECT id_persona FROM usuario_cliente WHERE user_name = 'pgsgroup'))));

-- Cuantas tarjetas tiene como natural :

SELECT count(*) FROM tarjeta WHERE id = 
                         (SELECT id FROM cliente WHERE id_ente = 
                         (SELECT id FROM ente WHERE id = 
                         (SELECT id FROM persona WHERE id = 
                         (SELECT id_persona FROM usuario_cliente WHERE user_name = 'pgsgroup'))));


-- Mostrar las tarjetas que tiene como natural :
 
SELECT codigo_tarjeta FROM tarjeta WHERE id = 
                         (SELECT id FROM cliente WHERE id_ente = 
                         (SELECT id FROM ente WHERE id = 
                         (SELECT id FROM persona WHERE id = 
                         (SELECT id_persona FROM usuario_cliente WHERE user_name = 'pgsgroup'))));

                     
-- Cuantas cuentas tiene como juridico :

SELECT count(*) FROM cuenta WHERE id_cliente = 
                           (SELECT id FROM cliente WHERE id_ente = 
                           (SELECT id FROM ente WHERE id = 
                           (SELECT id FROM empresa WHERE id = 
                           (SELECT id_organizacion FROM usuario_cliente WHERE user_name = 'pgsgroup'))));
 
SELECT numero_Cuenta FROM cuenta WHERE id_cliente = 
                         (SELECT id FROM cliente WHERE id_ente = 
                         (SELECT id FROM ente WHERE id = 
                         (SELECT id FROM empresa WHERE id = 
                         (SELECT id_organizacion FROM usuario_cliente WHERE user_name = 'pgsgroup'))))

-- Cuantas tarjetas tiene como juridico
  
SELECT count(*) FROM tarjeta WHERE id = 
                         (SELECT id FROM cliente WHERE id_ente = 
                         (SELECT id FROM ente WHERE id = 
                         (SELECT id FROM empresa WHERE id = 
                         (SELECT id_organizacion FROM usuario_cliente WHERE user_name = 'pgsgroup'))));

-- Mostrar las tarjetas que tiene como juridico

  SELECT codigo_tarjeta FROM tarjeta WHERE id = 
                         (SELECT id FROM cliente WHERE id_ente = 
                         (SELECT id FROM ente WHERE id = 
                         (SELECT id FROM empresa WHERE id = 
                         (SELECT id_organizacion FROM usuario_cliente WHERE user_name = 'pgsgroup'))));