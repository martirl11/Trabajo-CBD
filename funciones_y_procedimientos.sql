create or replace NONEDITIONABLE FUNCTION root_cbd_2.QUE_CATEGORIA(categorias IN VARCHAR2) RETURN VARCHAR2 IS 

    CURSOR nombres_categorias IS
    SELECT REGEXP_SUBSTR(categorias, '[^,]+', 1, LEVEL) AS elemento
    FROM DUAL
    CONNECT BY LEVEL <= REGEXP_COUNT(categorias, ',') + 1;
    categoria VARCHAR(15454);
    categorias_id vARCHAR2(3565);
    resultado VARCHAR2(24545);
BEGIN
    OPEN nombres_categorias;
    LOOP
    FETCH nombres_categorias INTO categoria;
    EXIT WHEN nombres_categorias%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(to_char(LENGTH(categoria))||categoria);   
    
        IF LENGTH(categoria)>0 then
          BEGIN
          SELECT idcategoria INTO categorias_id FROM cinema_categoria@merchandising
                WHERE UPPER(nombre) LIKE '%' || UPPER(categoria) || '%';
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              categorias_id:='';
          END;  
                DBMS_OUTPUT.PUT_LINE(categorias_id);   
          if resultado IS NULL THEN
            resultado:=categorias_id||',';
          END IF;
          IF (categorias_id IS NOT NULL OR length(categorias_id)>0) and 
             INSTR(resultado, categorias_id||',' )=0 and resultado is not null THEN
                    resultado:= resultado||categorias_id||','; 
          END IF;
        END IF;
          
         
    
    END LOOP;
    CLOSE nombres_categorias;
    DBMS_OUTPUT.PUT_LINE(resultado); 
    RETURN resultado;
END QUE_CATEGORIA;
/

create or replace NONEDITIONABLE FUNCTION root_cbd_2.QUE_ITEM(itemId in number) RETURN VARCHAR2
IS
  resultado VARCHAR2(100);
  tipo_elemento varchar2(200);
BEGIN
  tipo_elemento:='';
  begin
  SELECT c.ITEM_PTR_ID INTO resultado FROM chic_ropa c WHERE c.ITEM_PTR_ID = itemId;
  exception
  WHEN NO_DATA_FOUND THEN
              tipo_elemento:='';
  end;
  IF resultado IS NULL THEN
    begin
      SELECT c.ITEM_PTR_ID INTO resultado FROM chic_taza c WHERE c.ITEM_PTR_ID = itemId;
    exception
      WHEN NO_DATA_FOUND THEN
                  tipo_elemento:='';
    end;
  else
    tipo_elemento:='ropa';
    RETURN tipo_elemento;
  END IF;

  IF resultado IS NULL THEN
    begin
      SELECT c.ITEM_PTR_ID INTO resultado FROM chic_accesorio c WHERE c.ITEM_PTR_ID = itemId;
    exception
      WHEN NO_DATA_FOUND THEN
                  tipo_elemento:='';
    end;
  else
    tipo_elemento:='taza';  
    RETURN tipo_elemento;
  END IF;
  
  IF resultado IS NULL THEN
    begin
      SELECT c.ITEM_PTR_ID INTO resultado FROM chic_poster c WHERE c.ITEM_PTR_ID = itemId;
    exception
      WHEN NO_DATA_FOUND THEN
                  tipo_elemento:='';
    end;
  else
    tipo_elemento:='accesorio'; 
    RETURN tipo_elemento;
  END IF;

  IF resultado IS NOT NULL THEN
    tipo_elemento:='poster';
    RETURN tipo_elemento;
  END IF;

  RETURN tipo_elemento;
 
END QUE_ITEM;

/

create or replace NONEDITIONABLE FUNCTION root_cbd_2.QUE_PELICULA(peliculas IN VARCHAR2) RETURN VARCHAR2 IS

    CURSOR nombres_peliculas IS
    SELECT REGEXP_SUBSTR(peliculas, '[^,]+', 1, LEVEL) AS elemento
    FROM DUAL
    CONNECT BY LEVEL <= REGEXP_COUNT(peliculas, ',') + 1;
    pelicula VARCHAR(15454);
    peliculas_id vARCHAR2(3565);
    resultado VARCHAR2(24545);
BEGIN
    OPEN nombres_peliculas;
    LOOP
    FETCH nombres_peliculas INTO pelicula;
    EXIT WHEN nombres_peliculas%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(to_char(LENGTH(pelicula))||pelicula);   
    
        IF LENGTH(pelicula)>0 then
          BEGIN
          SELECT idpelicula INTO peliculas_id FROM cinema_pelicula@merchandising
                WHERE UPPER(titulo) LIKE '%' || UPPER(pelicula) || '%';
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              peliculas_id:='';
          END;  
                DBMS_OUTPUT.PUT_LINE(peliculas_id);  
          if resultado IS NULL THEN
            resultado:=peliculas_id||',';
          END IF;
          IF (peliculas_id IS NOT NULL OR length(peliculas_id)>0) and 
             INSTR(resultado, peliculas_id||',' )=0 and resultado is not null THEN
                    resultado:= resultado||peliculas_id||','; 
          END IF;
        END IF;
         
    
    END LOOP;
    CLOSE nombres_peliculas;
    DBMS_OUTPUT.PUT_LINE(resultado); 
    -- Si no se encontró ninguna película, devolver 0
    RETURN resultado;
END;

/

CREATE OR REPLACE PROCEDURE root_cbd_2.POBLAR_MERCHAN is 
BEGIN
    INSERT INTO chic_item (nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES ('Camiseta Toy Story', 001, 'Camiseta con Woody y Buzz', 15.99, 'Toy Story', 'Animation','static/img/item/ropa.jpg');
    INSERT INTO chic_item (nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES ('Sudadera Toy Story', 002, 'Sudadera con el logo de Toy Story', 29.99, 'Toy', 'Animation','static/img/item/ropa.jpg');
    INSERT INTO chic_item (nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES ('Camisa GoldenEye', 003, 'Camisa con logo de 007', 24.99, 'GoldenEye', 'Action','static/img/item/ropa.jpg');
    INSERT INTO chic_item (nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES ('Camiseta Four Rooms', 004, 'Camiseta con diseño de hotel', 12.99, 'Rooms', 'Comedy','static/img/item/ropa.jpg');
    INSERT INTO chic_item (nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES ('Chaqueta Get Shorty', 005, 'Chaqueta de cuero con logo de Chili Palmer', 89.99, 'Shorty', 'Action','static/img/item/ropa.jpg');
    INSERT INTO chic_item (nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES ('Pantalón Copycat', 006, 'Pantalón de vestir con franjas laterales', 49.99, 'Copycat', 'Thriller','static/img/item/ropa.jpg');
    INSERT INTO chic_item (nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES ('Camisa Shanghai Triad', 007, 'Camisa de seda con estampado floral', 39.99, 'Shanghai', 'Drama','static/img/item/ropa.jpg');
    INSERT INTO chic_item (nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES ('Camiseta Twelve Monkeys', 008, 'Camiseta con logo de la película', 14.99, 'Monkeys', 'Science Fiction','static/img/item/ropa.jpg');
    INSERT INTO chic_item (nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES ('Sudadera Babe', 009, 'Sudadera con diseño de cerdito', 29.99, 'Babe', 'Family','static/img/item/ropa.jpg');
    INSERT INTO chic_item (nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES ('Camiseta Dead Man Walking', 010, 'Camiseta con foto de Sean Penn', 15.99, 'Walking', 'Drama','static/img/item/ropa.jpg');
    INSERT INTO chic_item (nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES ('Camiseta Seven (Se7en)', 012, 'Camiseta con los pecados capitales', 17.99, 'Seven', 'Thriller','static/img/item/ropa.jpg');
    INSERT INTO chic_item (nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES ('Jersey Usual Suspects, The', 013, 'Jersey con diseño de cartel de la película', 34.99, 'Suspects', 'Thriller','static/img/item/ropa.jpg');
    INSERT INTO chic_item (nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES ('Falda Mighty Aphrodite', 014, 'Falda larga con estampado griego', 49.99, 'Aphrodite', 'Comedy','static/img/item/ropa.jpg');
    INSERT INTO chic_item (nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES ('Camisa Il Postino', 015, 'Camisa de lino con cuello mao', 29.99, 'Postino', 'Drama','static/img/item/ropa.jpg');
    INSERT INTO chic_item (nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES ('Camiseta Mr. Hollands Opus', 016, 'Camiseta con diseño de partitura musical', 14.99, 'Holland', 'Drama','static/img/item/ropa.jpg');
    INSERT INTO chic_item (nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES ('Sudadera French Twist', 017, 'Sudadera con logo de la película', 29.99, 'Twist', 'Comedy','static/img/item/ropa.jpg');
    INSERT INTO chic_item (nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES ('Chaqueta From Dusk Till Dawn', 018, 'Chaqueta de cuero con diseño de serpiente', 99.99, 'Dusk', 'Action','static/img/item/ropa.jpg');
    INSERT INTO chic_item (nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES ('Camiseta White Balloon, The', 019, 'Camiseta con diseño de globo', 15.99, 'Balloon', 'Drama','static/img/item/ropa.jpg');
    INSERT INTO chic_item (nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES ('Jersey Antonias Line', 020, 'Jersey con diseño de campo de flores', 39.99, 'Antonia', 'Drama','static/img/item/ropa.jpg');
    INSERT INTO chic_item (nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES ('Falda Angels and Insects', 021, 'Falda con estampado de insectos', 44.99, 'Angels and Insects', 'Drama','static/img/item/ropa.jpg');
    INSERT INTO chic_item (nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES ( 'Abrigo Richard III', 011, 'Abrigo largo con detalles dorados', 119.99, 'Richard', 'Drama','static/img/item/ropa.jpg');


    INSERT INTO chic_ropa (ITEM_PTR_ID, talla, marca, color, tiporopa)
    VALUES (001,'S,M,L,XL', 'Disney', 'Blanco', 'Camiseta');
    INSERT INTO chic_ropa (ITEM_PTR_ID, talla, marca, color, tiporopa)
    VALUES (002,'S,M,L,XL', 'Disney', 'Gris', 'Sudadera');
    INSERT INTO chic_ropa (ITEM_PTR_ID, talla, marca, color, tiporopa)
    VALUES(003,'S,M,L,XL', 'James Bond', 'Azul', 'Camisa');
    INSERT INTO chic_ropa (ITEM_PTR_ID, talla, marca, color, tiporopa)
    VALUES(004,'S,M,L,XL', 'Miramax', 'Negro', 'Camiseta');
    INSERT INTO chic_ropa (ITEM_PTR_ID, talla, marca, color, tiporopa)
    VALUES(005, 'S,M,L,XL', 'MGM', 'Negro', 'Chaqueta');
    INSERT INTO chic_ropa (ITEM_PTR_ID, talla, marca, color, tiporopa)
    VALUES(006, '30,32,34,36', 'Universal', 'Negro', 'Pantalón');
    INSERT INTO chic_ropa (ITEM_PTR_ID, talla, marca, color, tiporopa)
    VALUES(007, 'S,M,L,XL', 'Sony', 'Rojo', 'Camisa');
    INSERT INTO chic_ropa (ITEM_PTR_ID, talla, marca, color, tiporopa)
    VALUES(008, 'S,M,L,XL', 'Universal', 'Negro', 'Camiseta');
    INSERT INTO chic_ropa (ITEM_PTR_ID, talla, marca, color, tiporopa)
    VALUES(009, 'S,M,L,XL', 'Universal', 'Rosa', 'Sudadera');
    INSERT INTO chic_ropa (ITEM_PTR_ID, talla, marca, color, tiporopa)
    VALUES(010, 'S,M,L,XL', 'Polygram', 'Blanco', 'Camiseta');
    INSERT INTO chic_ropa (ITEM_PTR_ID, talla, marca, color, tiporopa)
    VALUES(011, 'S,M,L,XL', 'Paramount', 'Verde', 'Abrigo');
    INSERT INTO chic_ropa (ITEM_PTR_ID, talla, marca, color, tiporopa)
    VALUES(012, 'S,M,L,XL', 'New Line', 'Negro', 'Camiseta');
    INSERT INTO chic_ropa (ITEM_PTR_ID, talla, marca, color, tiporopa)
    VALUES(013, 'S,M,L,XL', 'MGM', 'Azul', 'Jersey');
    INSERT INTO chic_ropa (ITEM_PTR_ID, talla, marca, color, tiporopa)
    VALUES(014, 'S,M,L,XL', 'Miramax', 'Azul', 'Falda');
    INSERT INTO chic_ropa (ITEM_PTR_ID, talla, marca, color, tiporopa)
    VALUES(015, 'S,M,L,XL', 'Columbia', 'Blanco', 'Camisa');
    INSERT INTO chic_ropa (ITEM_PTR_ID, talla, marca, color, tiporopa)
    VALUES(016, 'S,M,L,XL', 'Polygram', 'Negro', 'Camiseta');
    INSERT INTO chic_ropa (ITEM_PTR_ID, talla, marca, color, tiporopa)
    VALUES(017, 'S,M,L,XL', 'Miramax', 'Gris', 'Sudadera');
    INSERT INTO chic_ropa (ITEM_PTR_ID, talla, marca, color, tiporopa)
    VALUES(018, 'S,M,L,XL', 'Dimension', 'Negro', 'Chaqueta');
    INSERT INTO chic_ropa (ITEM_PTR_ID, talla, marca, color, tiporopa)
    VALUES(019, 'S,M,L,XL', 'Sony', 'Blanco', 'Camiseta');
    INSERT INTO chic_ropa (ITEM_PTR_ID, talla, marca, color, tiporopa)
    VALUES(020, 'S,M,L,XL', 'First Look', 'Verde', 'Jersey');
    INSERT INTO chic_ropa (ITEM_PTR_ID, talla, marca, color, tiporopa)
    VALUES(021, 'S,M,L,XL', 'Samuel Goldwyn', 'Negro', 'Falda');


   --TAZA

    INSERT INTO chic_item(nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES('Taza Toy Story', 080, 'Taza de merchan de la película Toy Story', 15.99, 'Toy', 'Animation','static/img/item/taza.jpg');
    INSERT INTO chic_item(nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES('Taza GoldenEye', 022, 'Taza de merchan de la película GoldenEye', 18.99, 'GoldenEye', 'Action','static/img/item/taza.jpg');
    INSERT INTO chic_item(nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES('Taza Four Rooms', 023, 'Taza de merchan de la película Four Rooms', 12.99, 'Four', 'Comedy','static/img/item/taza.jpg');
    INSERT INTO chic_item(nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES('Taza Get Shorty', 024, 'Taza de merchan de la película Get Shorty', 16.99, 'Shorty', 'Action','static/img/item/taza.jpg');
    INSERT INTO chic_item(nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES('Taza Copycat', 025, 'Taza de merchan de la película Copycat', 14.99, 'Copycat', 'Thriller','static/img/item/taza.jpg');
    INSERT INTO chic_item(nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES('Taza Shanghai Triad', 026, 'Taza de merchan de la película Shanghai Triad', 19.99, 'Shanghai', 'Drama','static/img/item/taza.jpg');
    INSERT INTO chic_item(nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES('Taza Twelve Monkeys', 027, 'Taza de merchan de la película Twelve Monkeys', 17.99, 'Monkeys', 'Sci-Fi','static/img/item/taza.jpg');
    INSERT INTO chic_item(nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES('Taza Babe', 028, 'Taza de merchan de la película Babe', 15.99, 'Babe', 'Family','static/img/item/taza.jpg');
    INSERT INTO chic_item(nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES('Taza Dead Man Walking', 029, 'Taza de merchan de la película Dead Man Walking', 18.99, 'Dead', 'Drama','static/img/item/taza.jpg');
    INSERT INTO chic_item(nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES('Taza Richard III', 030, 'Taza de merchan de la película Richard III', 12.99, 'Richard', 'Drama','static/img/item/taza.jpg');
    INSERT INTO chic_item(nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES('Taza Seven', 031, 'Taza de merchan de la película Seven', 16.99, 'Seven', 'Thriller','static/img/item/taza.jpg');
    INSERT INTO chic_item(nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES('Taza Usual Suspects', 032, 'Taza de merchan de la película Usual Suspects', 14.99, 'Suspects', 'Thriller','static/img/item/taza.jpg');
    INSERT INTO chic_item(nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES('Taza Mighty Aphrodite', 033, 'Taza de merchan de la película Mighty Aphrodite', 19.99, 'Mighty', 'Comedy','static/img/item/taza.jpg');
    INSERT INTO chic_item(nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES('Taza Postino, Il', 034, 'Taza de merchan de la película Postino, Il', 15.99, 'Postino', 'Drama','static/img/item/taza.jpg');
    INSERT INTO chic_item(nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES('Taza Mr. Hollands Opus', 035, 'Taza de merchan de la película Mr. Hollands Opus', 18.99, 'Holland', 'Drama','static/img/item/taza.jpg');
    INSERT INTO chic_item(nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES('Taza French Twist', 036, 'Taza de merchan de la película French Twist', 12.99, 'French', 'Comedy','static/img/item/taza.jpg');
    INSERT INTO chic_item(nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES('Taza From Dusk Till Dawn', 037, 'Taza de merchan de la película From Dusk Till Dawn', 16.99, 'Dusk', 'Horror','static/img/item/taza.jpg');
    INSERT INTO chic_item(nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES('Taza White Balloon, The', 038, 'Taza de merchan de la película White Balloon, The', 14.99, 'Balloon', 'Drama','static/img/item/taza.jpg');
    INSERT INTO chic_item(nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES('Taza Antonias Line', 039, 'Taza de merchan de la película Antonias Line', 19.99, 'Antonia', 'Drama','static/img/item/taza.jpg');
    INSERT INTO chic_item(nombre, id, descripcion, precio, pelicula, categoria, imagen)
    VALUES('Taza Angels and Insects', 040, 'Taza de merchan de la película Angels and Insects', 15.99, 'Angels and Insects', 'Drama','static/img/item/taza.jpg');


    INSERT INTO chic_taza( ITEM_PTR_ID, color, capacidad, material, artista)
    VALUES
    (080, 'Blanco', '350ml', 'Cerámica', 'Pixar');
    INSERT INTO chic_taza( ITEM_PTR_ID, color, capacidad, material, artista)
    VALUES(022, 'Negro', '400ml', 'Cerámica', 'EON Productions');
    INSERT INTO chic_taza( ITEM_PTR_ID, color, capacidad, material, artista)
    VALUES(023, 'Rojo', '300ml', 'Cerámica', 'Miramax Films');
    INSERT INTO chic_taza( ITEM_PTR_ID, color, capacidad, material, artista)
    VALUES(024, 'Verde', '350ml', 'Cerámica', 'Jersey Films');
    INSERT INTO chic_taza( ITEM_PTR_ID, color, capacidad, material, artista)
    VALUES(025, 'Azul', '300ml', 'Cerámica', 'Regency Enterprises');
    INSERT INTO chic_taza( ITEM_PTR_ID, color, capacidad, material, artista)
    VALUES(026, 'Blanco', '400ml', 'Cerámica', 'Shanghai Film Studio');
    INSERT INTO chic_taza( ITEM_PTR_ID, color, capacidad, material, artista)
    VALUES(027, 'Negro', '350ml', 'Cerámica', 'Universal Pictures');
    INSERT INTO chic_taza( ITEM_PTR_ID, color, capacidad, material, artista)
    VALUES(028, 'Rosa', '300ml', 'Cerámica', 'Kennedy Miller Productions');
    INSERT INTO chic_taza( ITEM_PTR_ID, color, capacidad, material, artista)
    VALUES(029, 'Negro', '400ml', 'Cerámica', 'PolyGram Filmed Entertainment');
    INSERT INTO chic_taza( ITEM_PTR_ID, color, capacidad, material, artista)
    VALUES(030, 'Gris', '300ml', 'Cerámica', 'Mayfair Entertainment International');
    INSERT INTO chic_taza( ITEM_PTR_ID, color, capacidad, material, artista)
    VALUES(031, 'Negro', '350ml', 'Cerámica', 'New Line Cinema');
    INSERT INTO chic_taza( ITEM_PTR_ID, color, capacidad, material, artista)
    VALUES(032, 'Blanco', '300ml', 'Cerámica', 'PolyGram Filmed Entertainment');
    INSERT INTO chic_taza( ITEM_PTR_ID, color, capacidad, material, artista)
    VALUES(033, 'Rosa', '400ml', 'Cerámica', 'Miramax Films');
    INSERT INTO chic_taza( ITEM_PTR_ID, color, capacidad, material, artista)
    VALUES(034, 'Rosa', '400ml', 'Cerámica', 'Miramax Films');
    INSERT INTO chic_taza( ITEM_PTR_ID, color, capacidad, material, artista)
    VALUES(035, 'Azul', '350ml', 'Cerámica', 'PolyGram Filmed Entertainment');
    INSERT INTO chic_taza( ITEM_PTR_ID, color, capacidad, material, artista)
    VALUES(036, 'Rojo', '300ml', 'Cerámica', 'Les Films Alain Sarde');
    INSERT INTO chic_taza( ITEM_PTR_ID, color, capacidad, material, artista)
    VALUES(037, 'Negro', '350ml', 'Cerámica', 'Miramax Films');
    INSERT INTO chic_taza( ITEM_PTR_ID, color, capacidad, material, artista)
    VALUES(038, 'Blanco', '300ml', 'Cerámica', 'Cineplex-Odeon Films');
    INSERT INTO chic_taza( ITEM_PTR_ID, color, capacidad, material, artista)
    VALUES(039, 'Rojo', '400ml', 'Cerámica', 'First Floor Features');
    INSERT INTO chic_taza( ITEM_PTR_ID, color, capacidad, material, artista)
    VALUES(040, 'Verde', '350ml', 'Cerámica', 'Samuelson Productions');


    --POSTER

    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen) VALUES
    (081, 'Poster de Toy Story', 'Poster oficial de la película Toy Story de 1995', 10.99, 'Toy', 'Animation,Comedy,Family','static/img/item/poster.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen) VALUES(041, 'Poster de GoldenEye', 'Poster oficial de la película GoldenEye de 1995', 12.99, 'GoldenEye', 'Action,Adventure,Thriller','static/img/item/poster.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen) VALUES(042, 'Poster de Four Rooms', 'Poster oficial de la película Four Rooms de 1995', 9.99, 'Four', 'Comedy','static/img/item/poster.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen) VALUES(043, 'Poster de Get Shorty', 'Poster oficial de la película Get Shorty de 1995', 11.99, 'Get', 'Comedy,Crime,Thriller','static/img/item/poster.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen) VALUES(044, 'Poster de Copycat', 'Poster oficial de la película Copycat de 1995', 10.99, 'Copycat', 'Crime,Drama,Mystery','static/img/item/poster.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen) VALUES(045, 'Poster de Shanghai Triad', 'Poster oficial de la película Shanghai Triad de 1995', 12.99, 'Shanghai', 'Crime,Drama','static/img/item/poster.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen) VALUES(046, 'Poster de Twelve Monkeys', 'Poster oficial de la película Twelve Monkeys de 1995', 11.99, 'Twelve', 'Mystery,Sci-Fi,Thriller','static/img/item/poster.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen) VALUES(047, 'Poster de Babe', 'Poster oficial de la película Babe de 1995', 10.99, 'Babe', 'Comedy,Drama,Family','static/img/item/poster.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen) VALUES(048, 'Poster de Dead Man Walking', 'Poster oficial de la película Dead Man Walking de 1995', 11.99, 'Dead', 'Crime,Drama','static/img/item/poster.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen) VALUES(049, 'Poster de Richard III', 'Poster oficial de la película Richard III de 1995', 9.99, 'Richard', 'Drama,War','static/img/item/poster.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen) VALUES(050, 'Poster de Seven', 'Poster oficial de la película Seven de 1995', 12.99, 'Seven', 'Crime,Drama,Mystery','static/img/item/poster.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen) VALUES(051, 'Poster de The Usual Suspects', 'Poster oficial de la película The Usual Suspects de 1995', 12.99, 'Usual', 'Crime,Mystery,Thriller','static/img/item/poster.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen) VALUES(052, 'Poster de Mighty Aphrodite', 'Poster oficial de la película Mighty Aphrodite de 1995', 11.99, 'Mighty', 'Comedy,Fantasy,Romance','static/img/item/poster.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen) VALUES(053, 'Poster de Il Postino', 'Poster oficial de la película Il Postino de 1994', 9.99, 'Postino', 'Biography,Comedy,Drama','static/img/item/poster.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen) VALUES(054, 'Poster de Mr. Hollands Opus', 'Poster oficial de la película Mr. Hollands Opus de 1995', 12.99, 'Holland', 'Drama, Music','static/img/item/poster.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen) VALUES(055, 'Poster de French Twist', 'Poster oficial de la película French Twist de 1995', 10.99, 'French', 'Comedy,Drama,Romance','static/img/item/poster.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen) VALUES(056, 'Poster de From Dusk Till Dawn', 'Poster oficial de la película From Dusk Till Dawn de 1996', 12.99, 'Dusk', 'Action,Crime,Horror','static/img/item/poster.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen) VALUES(057, 'Poster de The White Balloon', 'Poster oficial de la película The White Balloon de 1995', 10.99, 'White', 'Drama','static/img/item/poster.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen) VALUES(058, 'Poster de Antonias Line', 'Poster oficial de la película Antonias Line de 1995', 11.99, 'Antonia', 'Comedy,Drama','static/img/item/poster.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen) VALUES(059, 'Poster de Angels and Insects', 'Poster oficial de la película Angels and Insects de 1995', 12.99, 'Angels and Insects', 'Drama,Romance','static/img/item/poster.jpg');

    INSERT INTO chic_poster (ITEM_PTR_ID, tipo, tamano, artista) VALUES
    (081, 'Impreso', '40x60 cm', 'Pixar');
    INSERT INTO chic_poster (ITEM_PTR_ID, tipo, tamano, artista) VALUES(041, 'Impreso', '50x70 cm', 'Martin Campbell');
    INSERT INTO chic_poster (ITEM_PTR_ID, tipo, tamano, artista) VALUES(042, 'Impreso', '30x45 cm', 'Quentin Tarantino');
    INSERT INTO chic_poster (ITEM_PTR_ID, tipo, tamano, artista) VALUES(043, 'Impreso', '50x70 cm', 'Barry Sonnenfeld');
    INSERT INTO chic_poster (ITEM_PTR_ID, tipo, tamano, artista) VALUES(044, 'Impreso', '40x60 cm', 'Jon Amiel');
    INSERT INTO chic_poster (ITEM_PTR_ID, tipo, tamano, artista) VALUES(045, 'Impreso', '50x70 cm', 'Zhang Yimou');
    INSERT INTO chic_poster (ITEM_PTR_ID, tipo, tamano, artista) VALUES(046, 'Impreso', '50x70 cm', 'Terry Gilliam');
    INSERT INTO chic_poster (ITEM_PTR_ID, tipo, tamano, artista) VALUES(047, 'Impreso', '40x60 cm', 'Chris Noonan');
    INSERT INTO chic_poster (ITEM_PTR_ID, tipo, tamano, artista) VALUES(048, 'Impreso', '50x70 cm', 'Tim Robbins');
    INSERT INTO chic_poster (ITEM_PTR_ID, tipo, tamano, artista) VALUES(049, 'Impreso', '30x45 cm', 'Richard Loncraine');
    INSERT INTO chic_poster (ITEM_PTR_ID, tipo, tamano, artista) VALUES(050, 'Impreso', '50x70 cm', 'David Fincher');
    INSERT INTO chic_poster (ITEM_PTR_ID, tipo, tamano, artista) VALUES(051, 'Impreso', '50x70 cm', 'Bryan Singer');
    INSERT INTO chic_poster (ITEM_PTR_ID, tipo, tamano, artista) VALUES(052, 'Impreso', '50x70 cm', 'Woody Allen');
    INSERT INTO chic_poster (ITEM_PTR_ID, tipo, tamano, artista) VALUES(053, 'Impreso', '30x45 cm', 'Michael Radford');
    INSERT INTO chic_poster (ITEM_PTR_ID, tipo, tamano, artista) VALUES(054, 'Impreso', '50x70 cm', 'Stephen Herek');
    INSERT INTO chic_poster (ITEM_PTR_ID, tipo, tamano, artista) VALUES(055, 'Impreso', '40x60 cm', 'Josiane Balasko');
    INSERT INTO chic_poster (ITEM_PTR_ID, tipo, tamano, artista) VALUES(056, 'Impreso', '50x70 cm', 'Robert Rodriguez');
    INSERT INTO chic_poster (ITEM_PTR_ID, tipo, tamano, artista) VALUES(057, 'Impreso', '40x60 cm', 'Jafar Panahi');
    INSERT INTO chic_poster (ITEM_PTR_ID, tipo, tamano, artista) VALUES(058, 'Impreso', '50x70 cm', 'Marleen Gorris');
    INSERT INTO chic_poster (ITEM_PTR_ID, tipo, tamano, artista) VALUES(059, 'Impreso', '50x70 cm', 'Philip Haas');

    --ACCESORIOS

    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen)
    VALUES(060, 'Llavero de Toy Story', 'Llavero de la película de animación Toy Story', 5, 'Toy Story', 'Animation','static/img/item/accesorio.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen)
    VALUES(061, 'Pendiente de GoldenEye', 'Pendiente inspirado en la película de James Bond GoldenEye', 12, 'GoldenEye', 'Action','static/img/item/accesorio.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen)
    VALUES(062, 'Pulsera de Four Rooms', 'Pulsera con colgantes de la película Four Rooms', 8, 'Four Rooms', 'Comedy','static/img/item/accesorio.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen)
    VALUES(063, 'Gafas de Get Shorty', 'Gafas de sol de la película Get Shorty', 20, 'Get Shorty', 'Comedy,Crime','static/img/item/accesorio.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen)
    VALUES(064, 'Sombrero de Copycat', 'Sombrero inspirado en la película Copycat', 15, 'Copycat', 'Thriller','static/img/item/accesorio.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen)
    VALUES(065, 'Gorra de Shanghai Triad', 'Gorra con el logo de la película Shanghai Triad', 10, 'Shanghai Triad', 'Drama','static/img/item/accesorio.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen)
    VALUES(066, 'Llavero de Twelve Monkeys', 'Llavero de la película Twelve Monkeys', 5, 'Twelve Monkeys', 'Sci-Fi','static/img/item/accesorio.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen)
    VALUES(067, 'Pendiente de Babe', 'Pendiente con el personaje Babe de la película del mismo nombre', 8, 'Babe', 'Family','static/img/item/accesorio.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen)
    VALUES(068, 'Pulsera de Dead Man Walking', 'Pulsera con charms de la película Dead Man Walking', 12, 'Dead Man Walking', 'Drama','static/img/item/accesorio.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen)
    VALUES(069, 'Gafas de Richard III', 'Gafas de sol con montura dorada inspiradas en la película Richard III', 18, 'Richard III', 'Drama,History','static/img/item/accesorio.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen)
    VALUES(070, 'Sombrero de Seven', 'Sombrero de detective inspirado en la película Seven', 20, 'Seven', 'Crime,Mystery','static/img/item/accesorio.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen)
    VALUES(071, 'Gorra de The Usual Suspects', 'Gorra con el logo de la película The Usual Suspects', 10, 'The Usual Suspects', 'Crime,Mystery','static/img/item/accesorio.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen)
    VALUES(072, 'Llavero de Mighty Aphrodite', 'Llavero de la película Mighty Aphrodite', 5, 'Mighty Aphrodite', 'Comedy,Romance','static/img/item/accesorio.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen)
    VALUES(073, 'Pendiente de Il Postino', 'Pendiente con la imagen del personaje principal de la película Il Postino', 8, 'Il Postino', 'Drama,Romance','static/img/item/accesorio.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen)
    VALUES(074, 'Pulsera de Mr. Hollands Opus', 'Pulsera con charms de la película Mr. Hollands Opus', 12, 'Mr. Hollands Opus', 'Drama, Music','static/img/item/accesorio.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen)
    VALUES(075, 'Gafas de French Twist', 'Gafas de sol con montura rosa inspiradas en la película French Twist', 18, 'French Twist', 'Comedy,Romance','static/img/item/accesorio.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen)
    VALUES(076, 'Sombrero de From Dusk Till Dawn', 'Sombrero inspirado en la película From Dusk Till Dawn', 15, 'From Dusk Till Dawn', 'Action,Horror','static/img/item/accesorio.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen)
    VALUES(077, 'Gorra de The White Balloon', 'Gorra con el logo de la película The White Balloon', 10, 'The White Balloon', 'Drama','static/img/item/accesorio.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen)
    VALUES(078, 'Llavero de Antonias Line', 'Llavero de la película Antonias Line', 5, 'Antonias Line', 'Drama','static/img/item/accesorio.jpg');
    INSERT INTO chic_item (id, nombre, descripcion, precio, pelicula, categoria,imagen)
    VALUES(079, 'Pendiente de Angels and Insects', 'Pendiente con la imagen de una mariposa inspirado en la película Angels and Insects', 8, 'Angels and Insects', 'Drama,Romance','static/img/item/accesorio.jpg');

    INSERT INTO chic_accesorio (ITEM_PTR_ID, color, material, tamano, artista)
    VALUES(060, 'Amarillo', 'Plástico', '7x5 cm', 'Pixar');
    INSERT INTO chic_accesorio (ITEM_PTR_ID, color, material, tamano, artista)
    VALUES(061, 'Plateado', 'Metal', '2 cm', 'Pierce Brosnan');
    INSERT INTO chic_accesorio (ITEM_PTR_ID, color, material, tamano, artista)
    VALUES(062, 'Negro', 'Metal', '20 cm', 'Quentin Tarantino');
    INSERT INTO chic_accesorio (ITEM_PTR_ID, color, material, tamano, artista)
    VALUES(063, 'Negro', 'Plástico', '15 cm', 'John Travolta');
    INSERT INTO chic_accesorio (ITEM_PTR_ID, color, material, tamano, artista)
    VALUES(064, 'Marrón', 'Tela', '55 cm', 'Sigourney Weaver');
    INSERT INTO chic_accesorio (ITEM_PTR_ID, color, material, tamano, artista)
    VALUES(065, 'Rojo', 'Algodón', 'Talla única', 'Gong Li');
    INSERT INTO chic_accesorio (ITEM_PTR_ID, color, material, tamano, artista)
    VALUES(066, 'Verde', 'Plástico', '7x5 cm', 'Bruce Willis');
    INSERT INTO chic_accesorio (ITEM_PTR_ID, color, material, tamano, artista)
    VALUES(067, 'Rosa', 'Plástico', '2 cm', 'James Cromwell');
    INSERT INTO chic_accesorio (ITEM_PTR_ID, color, material, tamano, artista)
    VALUES(068, 'Negro', 'Metal', '20 cm', 'Susan Sarandon');
    INSERT INTO chic_accesorio (ITEM_PTR_ID, color, material, tamano, artista)
    VALUES(069, 'Dorado', 'Metal', '15 cm', 'Ian McKellen');
    INSERT INTO chic_accesorio (ITEM_PTR_ID, color, material, tamano, artista)
    VALUES(070, 'Negro', 'Tela', '55 cm', 'Brad Pitt');
    INSERT INTO chic_accesorio (ITEM_PTR_ID, color, material, tamano, artista)
    VALUES(071, 'Negro', 'Algodón', 'Talla única', 'Kevin Spacey');
    INSERT INTO chic_accesorio (ITEM_PTR_ID, color, material, tamano, artista)
    VALUES(072,'Rojo', 'Plástico', '7x5 cm', 'Woody Allen');
    INSERT INTO chic_accesorio (ITEM_PTR_ID, color, material, tamano, artista)
    VALUES(073, 'Azul', 'Plástico', '2 cm', 'Massimo Troisi');
    INSERT INTO chic_accesorio (ITEM_PTR_ID, color, material, tamano, artista)
    VALUES(074, 'Plateado', 'Metal', '20 cm', 'Richard Dreyfuss');
    INSERT INTO chic_accesorio (ITEM_PTR_ID, color, material, tamano, artista)
    VALUES(075, 'Rosa', 'Metal', '15 cm', 'Victoria Abril');
    INSERT INTO chic_accesorio (ITEM_PTR_ID, color, material, tamano, artista)
    VALUES(076, 'Negro', 'Tela', '55 cm', 'George Clooney');
    INSERT INTO chic_accesorio (ITEM_PTR_ID, color, material, tamano, artista)
    VALUES(077, 'Blanco', 'Algodón', 'Talla única', 'Majid Majidi');
    INSERT INTO chic_accesorio (ITEM_PTR_ID, color, material, tamano, artista)
    VALUES(078, 'Verde', 'Plástico', '7x5 cm', 'Marleen Gorris');
    INSERT INTO chic_accesorio (ITEM_PTR_ID, color, material, tamano, artista)
    VALUES(079, 'Plateado', 'Metal', '2 cm', 'Mark Rylance');

END ;
/

create or replace  FUNCTION root_cbd.QUE_MERCHAN_PELICULA(idPeli IN number) RETURN VARCHAR2 IS 

    TYPE cursor_merchan IS REF CURSOR;
    ids_merchan cursor_merchan;
    p_titulo VARCHAR(15454);
    merchan_id vARCHAR2(3565);
    resultado VARCHAR2(24545);
    parte VARCHAR2(255);
BEGIN
   
  select p.titulo into p_titulo from cinema_pelicula p where p.idpelicula=idPeli;
  FOR i IN 1..LENGTH(p_titulo) LOOP
    IF instr(p_titulo,' ')=0 then
      IF LENGTH(p_titulo)>0 then
        OPEN ids_merchan FOR  SELECT c.id FROM chic_item@merchandising c
                WHERE UPPER(c.pelicula) LIKE '%' || UPPER(p_titulo) || '%';
         LOOP
         FETCH ids_merchan INTO merchan_id;
         EXIT WHEN ids_merchan%NOTFOUND;
            if resultado IS NULL THEN
            DBMS_OUTPUT.PUT_LINE('1');
              resultado:=merchan_id||',';
            END IF;
            IF (merchan_id IS NOT NULL OR length(merchan_id)>0) and 
               INSTR(resultado, merchan_id||',' )=0 and resultado is not null THEN
                      resultado:= resultado||merchan_id||','; 
            END IF;
        END LOOP;
        CLOSE ids_merchan;
      --i := 0;
      END IF;
    END IF; 
    IF SUBSTR(p_titulo, i, 1) = ' ' THEN
      -- Realizar alguna acción con la palabra encontrada, como imprimirla en pantalla
      dbms_output.put_line(p_titulo||' '||to_char(i));
      DBMS_OUTPUT.PUT_LINE(SUBSTR(p_titulo, 1, i-1));
      IF LENGTH(p_titulo)>0 then
        parte:=SUBSTR(p_titulo, 1, i-2);
        OPEN ids_merchan FOR  SELECT c.id FROM chic_item@merchandising c
                WHERE UPPER(c.pelicula) LIKE '%' || UPPER(parte) || '%';
         LOOP
         FETCH ids_merchan INTO merchan_id;
         EXIT WHEN ids_merchan%NOTFOUND;
            if resultado IS NULL THEN
            DBMS_OUTPUT.PUT_LINE('1');
              resultado:=merchan_id||',';
            END IF;
            IF (merchan_id IS NOT NULL OR length(merchan_id)>0) and 
               INSTR(resultado, merchan_id||',' )=0 and resultado is not null THEN
                      resultado:= resultado||merchan_id||','; 
            END IF;
        END LOOP;
        CLOSE ids_merchan;
    
      END IF;
      p_titulo := SUBSTR(p_titulo, i+1);
    
    end if;
    
  END LOOP;       
        DBMS_OUTPUT.PUT_LINE(resultado); 
    RETURN resultado;
END;
/




create or replace  FUNCTION root_cbd.QUE_MERCHAN_CATEGORIA(idCateg IN number) RETURN VARCHAR2 IS 

    TYPE cursor_merchan IS REF CURSOR;
    ids_merchan cursor_merchan;
    p_titulo VARCHAR(15454);
    merchan_id vARCHAR2(3565);
    resultado VARCHAR2(24545);
    parte VARCHAR2(255);
BEGIN
   
  select p.nombre into p_titulo from cinema_categoria p where p.idCategoria=idcateg;
  dbms_output.put_line(p_titulo);
  FOR i IN 1..LENGTH(p_titulo) 
  LOOP
    IF instr(p_titulo,' ')=0 then
      IF LENGTH(p_titulo)>0 then
        OPEN ids_merchan FOR  SELECT c.id FROM chic_item@merchandising c
                WHERE UPPER(c.categoria) LIKE '%' || UPPER(p_titulo) || '%';
         LOOP
         FETCH ids_merchan INTO merchan_id;
         EXIT WHEN ids_merchan%NOTFOUND;
            if resultado IS NULL THEN
            DBMS_OUTPUT.PUT_LINE('1');
              resultado:=merchan_id||',';
            END IF;
            IF (merchan_id IS NOT NULL OR length(merchan_id)>0) and 
               INSTR(resultado, merchan_id||',' )=0 and resultado is not null THEN
                      resultado:= resultado||merchan_id||','; 
            END IF;
        END LOOP;
        CLOSE ids_merchan;
      --i := 0;
      END IF;
    END IF;
    IF SUBSTR(p_titulo, i, 1) = ' ' THEN
      -- Realizar alguna acción con la palabra encontrada, como imprimirla en pantalla
      dbms_output.put_line(p_titulo||' '||to_char(i));
      DBMS_OUTPUT.PUT_LINE(SUBSTR(p_titulo, 1, i-1));
      IF LENGTH(p_titulo)>0 then
        parte:=SUBSTR(p_titulo, 1, i-1);
        OPEN ids_merchan FOR  SELECT c.id FROM chic_item@merchandising c
                WHERE UPPER(c.categoria) LIKE '%' || UPPER(parte) || '%';
         LOOP
         FETCH ids_merchan INTO merchan_id;
         EXIT WHEN ids_merchan%NOTFOUND;
            if resultado IS NULL THEN
            DBMS_OUTPUT.PUT_LINE('1');
              resultado:=merchan_id||',';
            END IF;
            IF (merchan_id IS NOT NULL OR length(merchan_id)>0) and 
               INSTR(resultado, merchan_id||',' )=0 and resultado is not null THEN
                      resultado:= resultado||merchan_id||','; 
            END IF;
        END LOOP;
        CLOSE ids_merchan;
    
      END IF;
      p_titulo := SUBSTR(p_titulo, i+1);
    
    end if;
    
  END LOOP;       
        DBMS_OUTPUT.PUT_LINE(resultado); 
    RETURN resultado;
END;