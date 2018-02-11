-- Procedimiento para consultar la cantidad de cuentas y tarjetas tiene un cliente natural o juridico 
DO
$$
DECLARE
   persona_juridica INTEGER;
   persona_natural INTEGER;
   cantidad_cuentas INTEGER;
   usuario CHARACTER VARYING(20) DEFAULT 'tmerchant'; -- tiene solo una cuenta = lmonserrat y tiene mas de una cuenta = tmerchant
   cuenta_numero CHARACTER VARYING(20);
   tarjeta CHARACTER VARYING(20);
   registro RECORD;
BEGIN
  persona_juridica := (SELECT id_organizacion FROM usuario_cliente WHERE user_name = usuario );
  persona_natural := (SELECT id_persona FROM usuario_cliente WHERE user_name = usuario);
  IF (persona_juridica IS NOT NULL) 
     THEN BEGIN   -- Cuentas como persona juridica
	RAISE NOTICE 'Persona Juridica';
        RAISE NOTICE '================';
        cantidad_cuentas := (SELECT count(*) FROM cuenta WHERE id_cliente = 
                                  (SELECT id FROM cliente WHERE id_ente = 
                                  (SELECT id FROM ente WHERE id = 
                                  (SELECT id FROM empresa WHERE id = persona_juridica))));
        IF cantidad_cuentas >= 1 THEN
           FOR registro IN SELECT numero_Cuenta FROM cuenta WHERE id_cliente = 
                         (SELECT id FROM cliente WHERE id_ente = 
                         (SELECT id FROM ente WHERE id = 
                         (SELECT id FROM empresa WHERE id = persona_juridica)))) LOOP
               cuenta_numero := registro.numero_cuenta;
               tarjeta := (SELECT codigo_tarjeta FROM tarjeta WHERE id = 
                         (SELECT id FROM cliente WHERE id_ente = 
                         (SELECT id FROM ente WHERE id = 
                         (SELECT id FROM empresa WHERE id = 
                         (SELECT id_organizacion FROM usuario_cliente WHERE user_name = usuario)))));
              RAISE NOTICE 'Numero de Cuenta % ',cuenta_numero;
              IF (tarjeta is not null) THEN
                  RAISE NOTICE 'Numero de Tarjeta % ',tarjeta;
              ELSE 
                  RAISE NOTICE '* No tiene Tarjeta asociada *';
              END IF;	
           END LOOP
      END;
     ELSE BEGIN -- No es persona juridica
     END;
  END IF;
  IF (persona_natural IS NOT NULL) 
     THEN BEGIN -- Consultemos si tiene cuentas y/o tarjetas
     END;
     ELSE BEGIN -- No hacer nada
     END;
  END IF;
END
$$




-- Identificar si es natural, juridico

SELECT * FROM security.usuario WHERE username = 'tmerchant';


-- Cuantas cuentas tiene como natural :

SELECT count(*) FROM cuenta WHERE id_cliente = 
                           (SELECT id FROM cliente WHERE id_ente = 
                           (SELECT id FROM ente WHERE id = 
                           (SELECT id FROM persona WHERE id = 
                           (SELECT id_persona FROM usuario_cliente WHERE user_name = 'tmerchant'))));
                           
-- Mostrar las cuentas que tiene como natural :

 SELECT numero_cuenta FROM cuenta WHERE id_cliente = 
                         (SELECT id FROM cliente WHERE id_ente = 
                         (SELECT id FROM ente WHERE id = 
                         (SELECT id FROM persona WHERE id = 
                         (SELECT id_persona FROM usuario_cliente WHERE user_name = 'tmerchant'))));

-- Cuantas tarjetas tiene como natural :

SELECT count(*) FROM tarjeta WHERE id = 
                         (SELECT id FROM cliente WHERE id_ente = 
                         (SELECT id FROM ente WHERE id = 
                         (SELECT id FROM persona WHERE id = 
                         (SELECT id_persona FROM usuario_cliente WHERE user_name = 'tmerchant'))));


-- Mostrar las tarjetas que tiene como natural :
 
SELECT codigo_tarjeta FROM tarjeta WHERE id = 
                         (SELECT id FROM cliente WHERE id_ente = 
                         (SELECT id FROM ente WHERE id = 
                         (SELECT id FROM persona WHERE id = 
                         (SELECT id_persona FROM usuario_cliente WHERE user_name = 'tmerchant'))));

                     
-- Cuantas cuentas tiene como juridico :

SELECT count(*) FROM cuenta WHERE id_cliente = 
                           (SELECT id FROM cliente WHERE id_ente = 
                           (SELECT id FROM ente WHERE id = 
                           (SELECT id FROM empresa WHERE id = 
                           (SELECT id_organizacion FROM usuario_cliente WHERE user_name = 'tmerchant'))));
 
SELECT numero_Cuenta FROM cuenta WHERE id_cliente = 
                         (SELECT id FROM cliente WHERE id_ente = 
                         (SELECT id FROM ente WHERE id = 
                         (SELECT id FROM empresa WHERE id = 
                         (SELECT id_organizacion FROM usuario_cliente WHERE user_name = 'tmerchant'))))

-- Cuantas tarjetas tiene como juridico
  
SELECT count(*) FROM tarjeta WHERE id = 
                         (SELECT id FROM cliente WHERE id_ente = 
                         (SELECT id FROM ente WHERE id = 
                         (SELECT id FROM empresa WHERE id = 
                         (SELECT id_organizacion FROM usuario_cliente WHERE user_name = 'tmerchant'))));

-- Mostrar las tarjetas que tiene como juridico

  SELECT codigo_tarjeta FROM tarjeta WHERE id = 
                         (SELECT id FROM cliente WHERE id_ente = 
                         (SELECT id FROM ente WHERE id = 
                         (SELECT id FROM empresa WHERE id = 
                         (SELECT id_organizacion FROM usuario_cliente WHERE user_name = 'tmerchant'))));