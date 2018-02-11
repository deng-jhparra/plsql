DO
$$
DECLARE
   empresa INTEGER;
   cantidad_cuentas INTEGER;
   usuario CHARACTER VARYING(20) DEFAULT 'fjrodriguez'; -- tiene solo una cuenta = lmonserrat y tiene mas de una cuenta = tmerchant
   cuenta_numero CHARACTER VARYING(20);
   tarjeta CHARACTER VARYING(20);
   registro RECORD;
BEGIN
  empresa := (SELECT id_organizacion FROM usuario_cliente WHERE user_name = usuario );
  IF (empresa is null) THEN
     BEGIN
       RAISE NOTICE 'Persona Natural';
       RAISE NOTICE '===============';
       cantidad_cuentas := (SELECT count(*) FROM cuenta WHERE id_cliente = 
                           (SELECT id FROM cliente WHERE id_ente = 
                           (SELECT id FROM ente WHERE id = 
                           (SELECT id FROM persona WHERE id = 
                           (SELECT id_persona FROM usuario_cliente WHERE user_name = usuario)))));
       IF cantidad_cuentas >= 1 THEN
          FOR registro IN SELECT numero_Cuenta FROM cuenta WHERE id_cliente = 
                         (SELECT id FROM cliente WHERE id_ente = 
                         (SELECT id FROM ente WHERE id = 
                         (SELECT id FROM persona WHERE id = 
                         (SELECT id_persona FROM usuario_cliente WHERE user_name = usuario)))) LOOP
              cuenta_numero := registro.numero_cuenta;
              tarjeta := (SELECT codigo_tarjeta FROM tarjeta WHERE id = 
                         (SELECT id FROM cliente WHERE id_ente = 
                         (SELECT id FROM ente WHERE id = 
                         (SELECT id FROM persona WHERE id = 
                         (SELECT id_persona FROM usuario_cliente WHERE user_name = usuario)))));
              RAISE NOTICE 'Numero de Cuenta % ',cuenta_numero;
              IF (tarjeta is not null) THEN
                  RAISE NOTICE 'Numero de Tarjeta % ',tarjeta;
              ELSE 
                  RAISE NOTICE '* No tiene Tarjeta asociada *';
              END IF;
          END LOOP;
       END IF;
     END; --BEGIN
  ELSE
     BEGIN
       RAISE NOTICE 'Persona Juridica';
       RAISE NOTICE '================';
       cantidad_cuentas := (SELECT count(*) FROM cuenta WHERE id_cliente = 
                           (SELECT id FROM cliente WHERE id_ente = 
                           (SELECT id FROM ente WHERE id = 
                           (SELECT id FROM empresa WHERE id = 
                           (SELECT id_organizacion FROM usuario_cliente WHERE user_name = usuario)))));
       IF cantidad_cuentas >= 1 THEN
          FOR registro IN SELECT numero_Cuenta FROM cuenta WHERE id_cliente = 
                         (SELECT id FROM cliente WHERE id_ente = 
                         (SELECT id FROM ente WHERE id = 
                         (SELECT id FROM empresa WHERE id = 
                         (SELECT id_organizacion FROM usuario_cliente WHERE user_name = usuario)))) LOOP
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
          END LOOP;
       END IF;
     END; --BEGIN
  END IF;
END$$
