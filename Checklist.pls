--PL/SQL Checklist


-- 1.USO DE RECORD
DECLARE
   type pessoa_type is record
      (cpf varchar(14),
      cep_pessoa varchar(9),
      nome varchar(30),
      data_nasc date,
      numero_end number,
      complemento varchar(50)
      ); 
      pessoa1 pessoa_type;
BEGIN
     pessoa1.cpf	 := '127.721.222-21';
     pessoa1.cep_pessoa	 := '51020-142';
     pessoa1.nome := 'Jeff';
     pessoa1.data_nasc	 := to_date('03/02/1958','dd/mm/yyyy');
     pessoa1.numero_end	 := '222';
     pessoa1.complemento	 := 'Apto 7';
     INSERT INTO pessoa VALUES pessoa1;
END;


-- 2.USO DE ESTRUTURA DO TIPO TABLE e 6.USO DE %TYPE
Declare
    TYPE type_tabela_pacote_id
    IS TABLE OF pacote.id_pacote%TYPE
    INDEX BY BINARY_INTEGER;
    pac_id_tabela type_tabela_pacote_id;
    C Binary_Integer;
Begin
    C := 1;
    For RecPAC in (Select * from pacote) Loop
        pac_id_tabela(C) := RecPAC.id_pacote;
        C := C + 1;
    End Loop ;
END;


-- 3. BLOCO ANÔNIMO
BEGIN
  DBMS_OUTPUT.put_line (
    TO_CHAR (SYSDATE, 
'YYYY-MM-DD HH24:MI:SS'));
END;


--4. CREATE PROCEDURE
CREATE PROCEDURE uspRetornaIdade
AS
BEGIN
SELECT P.nome, YEAR(GETDATE()) - YEAR(P.data_nasc) 
AS IDADE 
FROM pessoa
END


-- 5. CREATE FUNCTION && 8. IF ELSIF 
&& INSERT_INTO
&& USO DE PAR METROS IN
CREATE OR REPLACE FUNCTION entregador_mais_caro
    (cpf_1_in IN VARCHAR2, cpf_2_in IN VARCHAR2)
  RETURN VARCHAR2
 IS
  salario_1 NUMBER;
  salario_2 NUMBER;
BEGIN
    SELECT salario INTO salario_1
    FROM entregador
    WHERE cpf_entregador = cpf_1_in;
    
    SELECT salario INTO salario_2
    FROM entregador
    WHERE cpf_entregador = cpf_2_in;
    
    IF salario_1 > salario_2 THEN
        return cpf_1_in;
    ELSIF salario_2 <= salario_1 THEN
        return cpf_2_in;
    END IF;
END;


-- 7. %ROWTYPE
DECLARE
     info_pessoa pessoa%ROWTYPE;
BEGIN
     info_pessoa.cpf	 := '127.721.111-21';
     info_pessoa.cep_pessoa	 := '51020-142';
     info_pessoa.nome := 'Cleber';
     info_pessoa.data_nasc	 := to_date('03/02/1958','dd/mm/yyyy');
     info_pessoa.numero_end	 := '222';
     info_pessoa.complemento	 := 'Apto 4';
     INSERT INTO pessoa VALUES info_pessoa;
END;


-- 9. CASE WHEN
SELECT cpf,
CASE cpf
  WHEN '123.456.789-10' THEN 'é um entregador'
  WHEN '456.789.101-11' THEN 'é um entregador'
  ELSE 'Não é entregador'
END
FROM pessoa;


-- 10. EXIT WHEN && 12. FOR LOOP
CREATE OR REPLACE PROCEDURE imprimir_pacotes_com_valor_maior_que
    (valor_limite_in IN NUMBER)
    IS
    CURSOR c_pacote IS
        SELECT cpf_pacote, valor
        FROM pacote
        ORDER BY
            valor DESC;
BEGIN
    FOR r_pacote IN c_pacote
    LOOP
        EXIT WHEN r_pacote.valor < valor_limite_in;
        dbms_output.put_line( r_pacote.cpf_pacote || ': $' ||  r_pacote.valor );
    END LOOP;
END;


-- 11. WHILE LOOP
DECLARE @counter int, @maxId int
SELECT @counter =min (pacote_id), maxID = max(pacote_id) FROM pacote
WHILE (@counter IS NOT NULL AND @counter <maxId) 
BEGIN 
SELECT @cep_pacote = cep_pacote FROM pacote WHERE id_pacote = @counter
PRINT CONVERT(VARCHAR, @counter) + ‘O cep de entrega é ‘ + @cep_pacote
SET @counter = @counter + 1
END


-- 14. CURSOR (OPEN, FETCH e CLOSE)
CREATE OR REPLACE PROCEDURE pagar_entregador
    (cpf_entregador_in IN VARCHAR2, cnpj_armazem_in IN VARCHAR2)
    IS
    salario_entregador NUMBER;
    CURSOR c_salario IS
        SELECT salario
        FROM entregador
        WHERE cpf_entregador = cpf_entregador_in;
BEGIN
    OPEN c_salario;
    FETCH c_salario INTO salario_entregador;
    IF c_salario%found THEN
        INSERT INTO paga (cnpj_paga, cpf_paga, data_de_pagamento, valor_paga) 
        VALUES (cnpj_armazem_in, cpf_entregador_in, SYSDATE, salario_entregador);
    END IF;
END;


-- 15. EXCEPTION WHEN
DECLARE 
   c_cpf pessoa.cpf%type := 8; 
   c_nome pessoa.nome%type; 
BEGIN 
   SELECT  nome INTO  c_nome
   FROM pessoa 
   WHERE cpf = c_cpf;  
   DBMS_OUTPUT.PUT_LINE ('Name: '||  c_nome);

EXCEPTION 
   WHEN no_data_found THEN 
      dbms_output.put_line('Nenhuma pessoa encontrada!'); 
   WHEN others THEN 
      dbms_output.put_line('Error!'); 
END;


-- 17. CREATE OR REPLACE PACKAGE
CREATE OR REPLACE PACKAGE entregadorP AS
  FUNCTION get_nome(n_func_cpf VARCHAR2)
    RETURN VARCHAR2;
  FUNCTION get_salario(n_func_cpf VARCHAR2)
    RETURN NUMBER;
END entregadorP;


-- 18. CREATE OR REPLACE PACKAGE BODY
CREATE OR REPLACE PACKAGE BODY entregadorP AS
  FUNCTION get_nome(n_func_cpf VARCHAR2) RETURN VARCHAR2 IS
      v_nome VARCHAR2(30);
  BEGIN
    SELECT nome
    INTO v_nome
    FROM pessoa
    WHERE cpf = n_func_cpf;

    RETURN v_nome;

  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN NULL;
  WHEN TOO_MANY_ROWS THEN
    RETURN NULL;
  END; 

  FUNCTION get_salario(n_func_cpf VARCHAR2) RETURN NUMBER IS
    n_salario NUMBER;
  BEGIN
    SELECT salario
    INTO n_salario
    FROM entregador
    WHERE cpf_entregador = n_func_cpf;

    RETURN n_salario;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RETURN NULL;
      WHEN TOO_MANY_ROWS THEN
        RETURN NULL;
  END;
END entregadorP;


-- 19. CREATE OR REPLACE TRIGGER LINHA
CREATE OR REPLACE TRIGGER pacote_id_seq_trigger
BEFORE INSERT ON pacote
FOR EACH ROW
    WHEN (new.id_pacote IS NULL)
BEGIN
   :new.id_pacote  :=  seq_id_pacote.NEXTVAL;
END;


-- 20. CREATE OR REPLACE TRIGGER COMANDO
CREATE OR REPLACE TRIGGER horario_permitido
BEFORE DELETE 
ON pacote
DECLARE
    deletar_fora_de_horario EXCEPTION;
BEGIN
    IF TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) > 17 OR TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) < 8
    THEN
        RAISE deletar_fora_de_horario;
    END IF;
EXCEPTION
 WHEN deletar_fora_de_horario THEN
    Raise_application_error(-20324,'FORA DO EXPEDIENTE-' || 'Não é possível deletar um pacote fora do horário do expediente.');
END;







