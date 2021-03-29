INSERT INTO endereco (cep, rua, bairro, cidade, estado) VALUES ('51020-210', 'Rua Padre Carapuceiro', 'Boa Viagem', 'Recife', 'PE');
INSERT INTO endereco (cep, rua, bairro, cidade, estado) VALUES ('51234-210', 'Rua Agamenon Magalhães', 'Cidade universitária', 'Recife', 'PE');
INSERT INTO endereco (cep, rua, bairro, cidade, estado) VALUES ('12314-325', 'Paulista', 'Jardim Paulista', 'São Paulo', 'SP');
INSERT INTO endereco (cep, rua, bairro, cidade, estado) VALUES ('23124-142', 'Abobora', 'Um bairro', 'oa cidade', 'PR');
INSERT INTO endereco (cep, rua, bairro, cidade, estado) VALUES ('23122-232', 'Tampa', 'Rolha', 'estrada', 'RJ');
INSERT INTO endereco (cep, rua, bairro, cidade, estado) VALUES ('51020-142', 'Abobora', 'Um bairro', 'oa cidade', 'PR');
INSERT INTO endereco (cep, rua, bairro, cidade, estado) VALUES ('51020-232', 'Tampa', 'Rolha', 'estrada', 'RJ');


INSERT INTO pessoa (cpf, cep_pessoa, nome, data_nasc, numero_end, complemento) VALUES ('123.456.789-10', '51020-210', 'Matheus', to_date('01/10/1996', 'dd/mm/yy'), 342, 'casa 9');
INSERT INTO pessoa (cpf, cep_pessoa, nome, data_nasc, numero_end, complemento) VALUES ('456.789.101-11', '51234-210', 'Felipe', to_date('05/08/1998', 'dd/mm/yy'), 654, 'apartamento 601');
INSERT INTO pessoa (cpf, cep_pessoa, nome, data_nasc, numero_end, complemento) VALUES ('789.101.112-13', '12314-325', 'Ricardo', to_date('08/04/1993', 'dd/mm/yy'), 901, 'apartamento 304');
INSERT INTO pessoa (cpf, cep_pessoa, nome, data_nasc, numero_end, complemento) VALUES ('012.345.678-91', '23124-142', 'Lucas', to_date('17/11/1999', 'dd/mm/yy'), 772, 'apartamento 202');
INSERT INTO pessoa (cpf, cep_pessoa, nome, data_nasc, numero_end, complemento) VALUES ('345.678.910-11', '23124-142', 'João', to_date('26/02/1997', 'dd/mm/yy'), 237, 'apartamento 1001');

INSERT INTO entregador (cpf_entregador, supervisor, salario, pis) VALUES ('123.456.789-10', '123.456.789-10', 10000, '222.22222.22-2');
INSERT INTO entregador (cpf_entregador, supervisor, salario, pis) VALUES ('456.789.101-11', '123.456.789-10', 3000, '333.22222.22-2');

INSERT INTO pacote (id_pacote, cpf_pacote, cep_pacote, valor, data_de_entrega, numero_pacote, complemento_pacote) VALUES (1, '123.456.789-10', '66666-66', 1250.00, to_date('30/04/2021', 'dd/mm/yy'), 746, 'apartamento 403');
INSERT INTO pacote (id_pacote, cpf_pacote, cep_pacote, valor, data_de_entrega, numero_pacote, complemento_pacote) VALUES (2, '123.456.789-10', '77777-77', 12000.00, to_date('07/05/2021', 'dd/mm/yy'), 990, 'apartamento 1402');
INSERT INTO pacote (id_pacote, cpf_pacote, cep_pacote, valor, data_de_entrega, numero_pacote, complemento_pacote) VALUES (3, '123.456.789-10', '88888-88', 750.00, to_date('10/10/2021', 'dd/mm/yy'), 1021, 'casa 1');
INSERT INTO pacote (id_pacote, cpf_pacote, cep_pacote, valor, data_de_entrega, numero_pacote, complemento_pacote) VALUES (4, '456.789.101-11', '99999-99', 17750.00, to_date('01/04/2021', 'dd/mm/yy'), 877, 'apartamento 103');
INSERT INTO pacote (id_pacote, cpf_pacote, cep_pacote, valor, data_de_entrega, numero_pacote, complemento_pacote) VALUES (5, '456.789.101-11', '10101-01', 147.00, to_date('28/07/2021', 'dd/mm/yy'), 241, 'apartamento 805');

INSERT INTO armazem (cnpj, cep_armazem, capacidade_de_pacotes, numero_armazem, complemento_armazem) VALUES ('123.456.789/0000-12', '51020-142', 2500, 1002, 'armazém 1');
INSERT INTO armazem (cnpj, cep_armazem, capacidade_de_pacotes, numero_armazem, complemento_armazem) VALUES ('123.456.789/1111-23', '51020-232', 1200, 1002, 'armazém 2');

INSERT INTO remetente (cpf_remetente, data_de_cadastro) VALUES ('789.101.112-13', to_date('30/04/2021', 'dd/mm/yy'));
INSERT INTO remetente (cpf_remetente, data_de_cadastro) VALUES ('012.345.678-91', to_date('23/01/2021', 'dd/mm/yy'));
INSERT INTO remetente (cpf_remetente, data_de_cadastro) VALUES ('345.678.910-11', to_date('17/02/2021', 'dd/mm/yy'));

INSERT INTO armazena (cpf_armazena, cnpj_armazena, id_pacote_armazena) VALUES ('789.101.112-13', '123.456.789/0000-12',1);
INSERT INTO armazena (cpf_armazena, cnpj_armazena, id_pacote_armazena) VALUES ('012.345.678-91', '123.456.789/1111-23',2);

INSERT INTO data_de_armazenamento (id_pacote_armazenamento, data_de_armazenamento) VALUES (1, to_date('02/01/2021', 'dd/mm/yy'));
INSERT INTO data_de_armazenamento (id_pacote_armazenamento, data_de_armazenamento) VALUES (2, to_date('24/09/2020', 'dd/mm/yy'));

INSERT INTO bonificacao (id_bonificacao, valor_bonificacao) VALUES (1, 0.20);
INSERT INTO bonificacao (id_bonificacao, valor_bonificacao) VALUES (2, 0.25);

INSERT INTO bonifica (id_bonificacao_bonifica, id_pacote_bonifica, cpf_entregador_bonifica) VALUES (1, 1, '123.456.789-10');
INSERT INTO bonifica (id_bonificacao_bonifica, id_pacote_bonifica, cpf_entregador_bonifica) VALUES (2, 2, '456.789.101-11');

INSERT INTO telefone (cpf_telefone, numero_de_telefone) VALUES ('123.456.789-10', '81999990234');
INSERT INTO telefone (cpf_telefone, numero_de_telefone) VALUES ('456.789.101-11', '81999234698');
INSERT INTO telefone (cpf_telefone, numero_de_telefone) VALUES ('789.101.112-13', '81923434698');
INSERT INTO telefone (cpf_telefone, numero_de_telefone) VALUES ('012.345.678-91', '81922344698');

INSERT INTO dependente (cpf_dependente, numero_dependente, nome_dependente) VALUES ('123.456.789-10',1,'Jorge da silva');
INSERT INTO dependente (cpf_dependente, numero_dependente, nome_dependente) VALUES ('456.789.101-11',2,'Emanuel de oliveira');

INSERT INTO paga (cnpj_paga, cpf_paga, data_de_pagamento, valor_paga) VALUES ('123.456.789/0000-12', '123.456.789-10', to_date('20/02/2000', 'dd/mm/yy'), 10000);
INSERT INTO paga (cnpj_paga, cpf_paga, data_de_pagamento, valor_paga) VALUES ('123.456.789/0000-12', '456.789.101-11', to_date('25/05/1999', 'dd/mm/yy'), 3000);
