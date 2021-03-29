DROP TABLE armazena;
DROP TABLE remetente;
DROP TABLE telefone;
DROP TABLE pessoa;
DROP TABLE data_de_armazenamento;
DROP TABLE bonifica;
DROP TABLE pacote;
DROP TABLE paga;
DROP TABLE armazem;
DROP TABLE endereco;
DROP TABLE dependente;
DROP TABLE entregador;
DROP TABLE bonificacao;

DROP SEQUENCE seq_id_pacote;
DROP SEQUENCE seq_id_bonificacao;


CREATE SEQUENCE seq_id_pacote
INCREMENT BY 1 START WITH 1;

CREATE SEQUENCE seq_id_bonificacao
INCREMENT BY 1 START WITH 1;

CREATE TABLE endereco(
  cep VARCHAR2(9) NOT NULL,
  rua VARCHAR2(30) NOT NULL,
  bairro VARCHAR2(30) NOT NULL,
  cidade VARCHAR2(15) NOT NULL,
  estado VARCHAR2(2) NOT NULL,
  CONSTRAINT endereco_pk PRIMARY KEY (cep)
);

CREATE TABLE pessoa(
	cpf VARCHAR2(14) NOT NULL,
	cep_pessoa VARCHAR2(9),
	nome VARCHAR2(30) NOT NULL,
	data_nasc DATE NOT NULL,
	numero_end NUMBER,
	complemento VARCHAR2(50),
	CONSTRAINT pessoa_pk PRIMARY KEY (cpf),
	CONSTRAINT pessoa_cep_fk FOREIGN KEY (cep_pessoa) REFERENCES endereco (cep)
);

CREATE TABLE entregador(
	cpf_entregador VARCHAR2(14) NOT NULL,
  supervisor VARCHAR2(14) NOT NULL,
  salario NUMBER NOT NULL,
  pis VARCHAR2(14) NOT NULL,
	CONSTRAINT entregador_pk PRIMARY KEY (cpf_entregador),
	CONSTRAINT entregador_supervisor_fk FOREIGN KEY(supervisor) REFERENCES entregador(cpf_entregador)
);

CREATE TABLE pacote(
	id_pacote INTEGER NOT NULL,
	cpf_pacote VARCHAR2(14) NOT NULL,
	cep_pacote VARCHAR2(9) NOT NULL,
	valor NUMBER NOT NULL,
	data_de_entrega DATE NOT NULL,
	numero_pacote NUMBER NOT NULL,
	complemento_pacote VARCHAR2(30),
	CONSTRAINT pacote_pk PRIMARY KEY (id_pacote),
	CONSTRAINT pacote_cpf_entregador_fk FOREIGN KEY (cpf_pacote) REFERENCES entregador (cpf_entregador),
    CONSTRAINT pacote_checkValor CHECK (valor > 0)
);

CREATE TABLE armazem(
	cnpj VARCHAR2(19) NOT NULL,
	cep_armazem VARCHAR2(9) NOT NULL,
	capacidade_de_pacotes NUMBER NOT NULL,
	numero_armazem NUMBER NOT NULL,
	complemento_armazem VARCHAR2(30),
	CONSTRAINT armazem_pk PRIMARY KEY (cnpj),
	CONSTRAINT armazem_cep_fk FOREIGN KEY (cep_armazem) REFERENCES endereco (cep)
);

CREATE TABLE remetente(
	cpf_remetente VARCHAR2(14) NOT NULL,
	data_de_cadastro DATE NOT NULL,
	CONSTRAINT remetente_pk PRIMARY KEY (cpf_remetente),
	CONSTRAINT remetente_cpf_p_fk FOREIGN KEY (cpf_remetente) REFERENCES pessoa (cpf)
);

CREATE TABLE armazena(
	cpf_armazena VARCHAR2(14) NOT NULL,
	cnpj_armazena VARCHAR2(19) NOT NULL,
	id_pacote_armazena INTEGER NOT NULL,
	CONSTRAINT armazena_pk PRIMARY KEY (cpf_armazena, cnpj_armazena, id_pacote_armazena),
    CONSTRAINT armazena_cpf_remetente_fk FOREIGN KEY (cpf_armazena) REFERENCES remetente(cpf_remetente),
    CONSTRAINT armazena_cnpj_armazem_fk FOREIGN KEY (cnpj_armazena) REFERENCES armazem(cnpj),
    CONSTRAINT armazena_id_pacote_fk FOREIGN KEY (id_pacote_armazena) REFERENCES pacote(id_pacote)
);

CREATE TABLE data_de_armazenamento(
	id_pacote_armazenamento INTEGER, 
	data_de_armazenamento DATE NOT NULL,
	CONSTRAINT data_de_armazenamento_pk PRIMARY KEY (id_pacote_armazenamento),
  CONSTRAINT data_de_armazenamento_id_pacote_fk FOREIGN KEY (id_pacote_armazenamento) REFERENCES pacote(id_pacote)
);

CREATE TABLE bonificacao(
	id_bonificacao INTEGER,
	valor_bonificacao NUMBER NOT NULL,
	CONSTRAINT bonificacao_pk PRIMARY KEY (id_bonificacao)
);

CREATE TABLE bonifica(
	id_bonificacao_bonifica INTEGER NOT NULL,
	id_pacote_bonifica INTEGER NOT NULL,
	cpf_entregador_bonifica VARCHAR2(14) NOT NULL,
	CONSTRAINT bonifica_pk PRIMARY KEY (id_bonificacao_bonifica, id_pacote_bonifica, cpf_entregador_bonifica),
  CONSTRAINT bonifica_id_bonificacao_fk FOREIGN KEY (id_bonificacao_bonifica) REFERENCES bonificacao(id_bonificacao),
  CONSTRAINT bonifica_id_pacote_fk FOREIGN KEY (id_pacote_bonifica) REFERENCES pacote(id_pacote),
  CONSTRAINT bonifica_cpf_entregador_fk FOREIGN KEY (cpf_entregador_bonifica) REFERENCES entregador(cpf_entregador)
);

CREATE TABLE telefone(
	cpf_telefone VARCHAR2(14) NOT NULL,
	numero_de_telefone VARCHAR2(11) NOT NULL,
	CONSTRAINT telefone_pk PRIMARY KEY (cpf_telefone, numero_de_telefone),
	CONSTRAINT telefone_cpf_fk FOREIGN KEY(cpf_telefone) REFERENCES pessoa(cpf)
);

CREATE TABLE dependente(
	cpf_dependente VARCHAR2(14) NOT NULL,
  numero_dependente NUMBER NOT NULL,
  nome_dependente VARCHAR2(30) NOT NULL,
	CONSTRAINT dependente_pk PRIMARY KEY (cpf_dependente, numero_dependente),
  CONSTRAINT dependente_cpf_fk FOREIGN KEY(cpf_dependente) REFERENCES entregador(cpf_entregador)
);

CREATE TABLE paga(
	cnpj_paga VARCHAR2(19) NOT NULL,
  cpf_paga VARCHAR2(14) NOT NULL,
  data_de_pagamento DATE NOT NULL,
  valor_paga NUMBER NOT NULL,
	CONSTRAINT paga_pk PRIMARY KEY (cnpj_paga, cpf_paga, data_de_pagamento),
  CONSTRAINT paga_cpf_fk FOREIGN KEY(cpf_paga) REFERENCES entregador(cpf_entregador),
  CONSTRAINT paga_cnpj_fk FOREIGN KEY(cnpj_paga) REFERENCES armazem(cnpj)
);
