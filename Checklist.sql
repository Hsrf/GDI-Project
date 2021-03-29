--SQL Checklist


-- 2. ALTER TABLE
ALTER TABLE ENDERECO
MODIFY (CIDADE VARCHAR2(20));

--6. CREATE INDEX
CREATE INDEX entregador_salario
ON entregador (cpf_entregador, salario);

-- 8. UPDATE
UPDATE pessoa
SET nome='Hugo Falcao', complemento='apto 101'
WHERE  cpf = '123.456.789-10';

-- 9. DELETE
DELETE FROM paga WHERE cpf_paga='456.789.101-11';

-- 10. SELECT FROM WHERE && 11. BETWEEN
SELECT * FROM pessoa
WHERE numero_end BETWEEN 100 AND 500

-- 12. IN
SELECT *
FROM pessoa
WHERE nome IN ('Felipe', 'Lucas', 'Ricardo', 'Hugo Falcao');

-- 13. LIKE && 19. COUNT
SELECT COUNT(cpf)
FROM pessoa
WHERE nome LIKE 'L%';


-- 15. INNER JOIN
SELECT *
FROM data_de_armazenamento
INNER JOIN bonifica
ON data_de_armazenamento.id_pacote_armazenamento = bonifica.id_pacote_bonifica;


-- 16. MAX
SELECT MAX(valor_bonificacao) FROM bonificacao;

-- 17. MIN
SELECT MIN(valor_bonificacao) FROM bonificacao;

-- 18. AVG
SELECT AVG(valor_bonificacao) FROM bonificacao;

-- 20. FULL OUTER JOIN && 25. ORDER BY
SELECT * FROM endereco
FULL OUTER JOIN pessoa ON endereco.cep = pessoa.cep_pessoa
ORDER BY pessoa.nome

-- 21. SUBCONSULTA COM OPERADOR RELACIONAL
SELECT cpf
FROM pessoa
WHERE cpf =
    (SELECT cpf_entregador
     FROM entregador
     WHERE salario > 4000 );

--22. SUBCONSULTA COM IN && 23. SUBCONSULTA COM ANY
SELECT nome
FROM pessoa
WHERE cep_pessoa = ANY
  (SELECT cep
  FROM endereco
  WHERE estado IN ('PE', 'SP'));
SELECT nome
FROM pessoa
WHERE cep_pessoa IN
  (SELECT cep
  FROM endereco
  WHERE estado IN ('PE', 'SP'));


-- 24. SUBCONSULTA COM ALL
SELECT * 
FROM pessoa
WHERE nome != ALL(SELECT nome FROM pessoa WHERE nome = 'Felipe');

-- 26. GROUP BY && HAVING
SELECT COUNT(numero_pacote), cpf_pacote
FROM pacote
GROUP BY cpf_pacote
HAVING COUNT(numero_pacote) > 2

-- 28. UNION
SELECT cpf_armazena, id_pacote_armazena 
FROM armazena 
WHERE cnpj_armazena = '123.456.789/1111-23'
UNION SELECT cpf_armazena, id_pacote_armazena 
FROM armazena
WHERE cnpj_armazena = '123.456.789/2222-34'

-- 29. CREATE VIEW
CREATE VIEW dependentes_de_Felipe AS
SELECT nome_dependente, numero_dependente
FROM dependente
WHERE cpf_dependente = (
SELECT cpf 
FROM pessoa
WHERE nome = 'Felipe')

-- 30. GRANT e REVOKE
GRANT SELECT, INSERT, UPDATE, DELETE ON alunos TO jpgj;
REVOKE SELECT, INSERT, UPDATE, DELETE ON alunos TO jpgj;