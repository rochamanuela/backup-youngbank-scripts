create database youngbank;
use youngbank;

/* CRIACAO DAS TABELAS */
CREATE TABLE cliente (
	codigo int auto_increment primary key not null,
	nome_razaosocial varchar(100) not null,
	nomesocial_fantasia varchar(100) null,
	foto_logo varchar(100) null,
	datanascimento_abertura date null,
	usuario char(10) not null,
	senha int not null,
	codigoEndereco int not null
);

CREATE TABLE endereco (
  codigo INT auto_increment PRIMARY KEY,
  logadouro varchar(100) not null,
  bairro varchar(100) not null,
  cidade varchar(50) not null,
  uf char(2),
  cep char(10)
);

CREATE TABLE contato (
  codigo INT auto_increment PRIMARY KEY,
  codigoCliente INT,
  numero varchar(15) not null,
  ramal varchar(10) null,
  email varchar(50) null,
  observacao varchar(50)
);

CREATE TABLE cliente_pf (
  codigoCliente int primary key,
  cpf varchar(15) null,
  rg varchar(15) null,
  constraint UK_CPF unique(cpf)
);

create table cliente_pj (
  codigoCliente int primary key,
  cnpj varchar(15) null,
  inscricaoEstadual varchar(30) null,
  inscricaoMunicial varchar(30) null,
  constraint UK_CNPJ unique(cnpj)
);

create table clienteConta (
  codigo int auto_increment PRIMARY KEY,
  codigoCliente int,
  codigoConta int
);

create table conta (
  codigo int auto_increment primary key,
  agencia varchar(10) not null,
  numero varchar(25) not null,
  tipo varchar(20) not null,
  limite decimal(10,2) null,
  ativo bit not null,
  constraint CK_CONTA_TIPO check(tipo = 'corrente' OR tipo = 'investimento')
);

create table cartao (
  codigo int auto_increment primary key,
  codigoConta int,
  numero varchar(30) not null,
  cvv char(3) not null,
  validade date not null,
  bandeira varchar(30) not null,
  situacao varchar(30) not null,
  constraint UK_CARTAO_NUMERO unique(numero)
);

create table emprestimo (
  codigo int auto_increment primary key,
  codigoConta int,
  dataSolicitacao date not null,
  valorSolicitado decimal(10,2) null,
  juros float not null,
  aprovado bit not null,
  numeroParcela int not null,
  dataAprovacao date null,
  observacao varchar(200) null
);

create table investimento (
  codigo int auto_increment primary key,
  codigoConta int,
  tipo varchar(20) not null,
  aporte decimal not null,
  taxaAdm float not null,
  prazo varchar(20) not null,
  grauRisco char(5) null,
  rentabilidade decimal not null,
  finalizado bit not null
);

create table movimentacao (
  codigo int auto_increment primary key,
  codigoCartao int,
  contaDestino int,
  dataHora datetime not null,
  operacao varchar(20),
  valor decimal not null
);

create table emprestimoParcela (
  codigo int auto_increment primary key,
  codigoEmprestimo int,
  numero int not null,
  dataVencimento date not null,
  valorParcela decimal(10,2) not null,
  dataPagamento date null,
  valorPago decimal(10,2) null
);
/* FIM DA CRIACAO DAS TABELAS */

/* DEFINICAO CHAVES ESTRANGEIRAS */
ALTER TABLE cliente
add constraint fk_endereco_cliente
foreign key (codigoEndereco) references endereco(codigo);

ALTER TABLE cartao
add constraint fk_cartao_conta
foreign key (codigoConta) references conta(codigo);

ALTER TABLE cliente_pf
add constraint fk_clientePF_cliente
foreign key (codigoCliente) references cliente(codigo);

ALTER TABLE cliente_pj
add constraint fk_clientePJ_cliente
foreign key (codigoCliente) references cliente(codigo);

ALTER TABLE clienteconta
add constraint fk_conta_cliente
foreign key (codigoCliente) references cliente(codigo);

ALTER TABLE clienteconta
add constraint fk_cliente_conta
foreign key (codigoConta) references conta(codigo);

ALTER TABLE emprestimo
add constraint fk_emprestimo_conta
foreign key (codigoConta) references conta(codigo);

ALTER TABLE emprestimoparcela
add constraint fk_emprestimo_parcela
foreign key (codigoEmprestimo) references emprestimo(codigo);

ALTER TABLE investimento
add constraint fk_conta_investimento
foreign key (codigoConta) references conta(codigo);

ALTER TABLE movimentacao
add constraint fk_movimentacao_cartao
foreign key (codigoCartao) references cartao(codigo);

ALTER TABLE contato
add constraint fk_contato_cliente
foreign key (codigoCliente) references cliente(codigo);

/* FIM DEFINICAO CHAVES ESTRANGEIRAS */

-- ajustes
alter table endereco change logadouro logradouro varchar(100);

-- inserção no banco de dados

insert into endereco (logradouro, bairro, cidade, uf, cep)
values ('Avenida São João, 156', 'Vila Joana', 'Jundiaí', 'SP', '13216000'),
	   ('Rua Paracatu, 698', 'Parque Imperial', 'São Paulo', 'SP', '04302021'),
	   ('Avenida Cristiano Olsen, 10', 'Jardim Sumaré', 'Araçatuba', 'SP', '16015244'),
	   ('Rua Serra de Bragança, 74', 'Vila Gomes Cardim', 'São Paulo', 'SP', '03318000'),
	   ('Rua Barao de Vitoria, 65', 'Casa Grande', 'Diadema', 'SP', '09961660'),
	   ('Rua Pereira Estefano, 100', 'Vila da Saúde', 'São Paulo', 'SP', '04144070'),
	   ('Alameda do Carmo, 15', 'Barão Geraldo', 'Campinas', 'SP', '13084008');

insert into cliente (nome_razaosocial, nomesocial_fantasia, foto_logo, datanascimento_abertura, usuario, senha, codigoEndereco)
values  ('Alice Barbalho Vilalobos', 'Alice Vilalobos', '\fotos\2.jpg', '1992-05-17', 'alice', 987, 1),
		('Sheila Tuna Espírito Santo', NULL, '\fotos\4.jpg', '1980-03-05', 'sheila', 123, 2),
		('Abigail Barateiro Cangueiro', NULL, '\fotos\6.jpg', '1987-05-30', 'abigail', 147, 3),
		('Regina e Julia Entregas Expressas ME', NULL, '\fotos\8.jpg', '2018-03-11', 'express', 987, 4),
		('João Barbalho Vilalobos', NULL, '\fotos\10.jpg', '1990-06-15', 'joao', 357, 5),
		('Juan e Valentina Alimentos ME', NULL, '\fotos\12.jpg','2015-11-12', 'avenida', 258, 6),
		('Derek Bicudo Lagos', NULL, '\fotos\14.jpg', '2002-03-12', 'derek', 258, 7),
		('Marcelo Frois Caminha', 'Ana Maria', '\fotos\16.jpg', '2001-11-23', 'ana', 654, 6),
		('Gabriel e Marcelo Corretores Associados Ltda', 'Imobiliária Cidade', '\fotos\18.jpg', '2017-09-26', 'cidade', 474, 1),
		('Jaime Câmara Valério', NULL, '\fotos\20.jpg', '1998-07-20', 'jaime', 369, 3);

-- ajustes feitos pois a coluna data estava errada antes
update cliente set datanascimento_abertura = '1992-05-17' where codigo = 21;
update cliente set datanascimento_abertura = '1980-03-05' where codigo = 22;
update cliente set datanascimento_abertura = '1987-05-30' where codigo = 23;
update cliente set datanascimento_abertura = '2018-03-11' where codigo = 24;
update cliente set datanascimento_abertura = '1990-06-15' where codigo = 25;
update cliente set datanascimento_abertura = '2015-11-12' where codigo = 26;
update cliente set datanascimento_abertura = '2002-03-12' where codigo = 27;
update cliente set datanascimento_abertura = '2001-11-23' where codigo = 28;
update cliente set datanascimento_abertura = '2017-09-26' where codigo = 29;
update cliente set datanascimento_abertura = '1998-07-20' where codigo = 30;
        
select * from endereco;
select * from cliente;
select * from cliente_pf;
select * from cliente_pj;
select * from contato;

insert into contato (codigoCliente, numero, ramal, email, observacao)
values  (21, '(15)3754-8198', 'Ramal 12', 'alicebv@yahoo.com','Comercial'),
		(21, '(13)98872-3866', NULL, NULL, 'Pessoal'),
		(22, '(11)3836-8266', NULL, 'sheila.santo@uol.com', NULL),
		(23, '(11)2605-8626', NULL, 'abigail.vilalobos@gmail.com', NULL),
		(24, '(18)99771-7848', NULL, 'express@gmail.com', NULL),
		(25, '(16)99184-1137', NULL, 'jao@gmail.com', NULL	),
		(26, '(11)96905-6363', NULL, 'avenida@hotmail.com', 'Horário comercial'),
		(27, '(19)2389-8133', 'Ramal 10', 'derek.bc@empresa.com', NULL),
		(27, '(11)98052-6863', NULL, 'derek.bc@gmail.com', 'Trabalho'),
		(28, '(14)2355-4677', 'Ramal 2', 'marcelofrois@gmail.com', 'Comercial'),
		(28, '(18)99890-3946', NULL, 'marcelofrois@uol.com', 'Trabalho'),
		(29, '(11)3456-2642', NULL, 'cidade@gmail.com', 'Escritório'),
		(29, '(17)97222-1107', NULL, NULL, 'Corretor'),
		(29, '(18)99874-9845', NULL, NULL, 'Pessoal'),
		(30, '(19)2533-3554', NULL, 'jaimecamara@hotmail.com', NULL);

insert into cliente_pf (codigoCliente, cpf, rg)
values  (21, '33474720040', '135769735'),
		(22, '25964866018', '159052075'),
		(23, '56069215028', '129752927'),
		(25, '91039176062', '358350293'),
		(27, '41396396012', '383172391'),
		(28, '41396396013', '383172392'),
		(30, '41396396014', '383172393');

insert into cliente_pj (codigoCliente, cnpj, inscricaoEstadual, inscricaoMunicial)
values  (24, '41100430000162', '652348.265.32', '804.332.566.351'),
		(26, '92532245000188', '258463.147.96', '568.016.087.935'),
		(29, '78802521000150', '458698.123.89', NULL);

insert into conta (agencia, numero, tipo, limite, ativo)
values  ('01470', '1234568', 'corrente', '3000.00', 1),
		('02582', '6549872', 'corrente', '4000.00', 1),
		('03695', '4567893', 'investimento', '0.00', 0),
		('02582', '2583697', 'corrente', '5000.00', 1),
		('02582', '1472580', 'investimento', '0.00', 1),
		('01470', '2648591', 'investimento', '0.00' ,1),
		('01470', '1548789', 'corrente', '3500.00', 1),
		('02582', '2315487', 'corrente', '4000.00', 0);

select * from conta;

insert into cartao (codigoConta, numero, cvv, validade, bandeira, situacao)
values  (1, '2233475802364659', '321', '2025-03-01', 'Visa', 'ativo'),
		(2, '3333457811659329', '654', '2028-05-01', 'MasterCard', 'bloqueado'),
		(3, '2828453678963265', '987', '2022-01-01', 'Elo', 'vencido'),
		(4, '4444695847251436', '369', '2026-06-01', 'American Express', 'ativo'),
		(5, '6969625134286178', '258', '2023-01-01', 'Visa', 'vencido'),
		(6, '2356458965213497', '147', '2025-07-01', 'Elo', 'ativo'),
		(7, '7777653298456325', '983', '2026-06-01', 'MasterCard', 'ativo'),
		(8, '1326456952148569', '984', '2025-03-01', 'Visa', 'ativo'),
		(1, '2654684768766648', '456', '2025-04-01', 'MasterCard', 'ativo'),
		(2, '2165468743513635', '756', '2025-04-01', 'Visa', 'ativo');

insert into movimentacao (codigoCartao, contaDestino, dataHora, operacao, valor)
values  (1, NULL, '2023-02-05 07:30:00', 'debito', 1000.00),
		(9, NULL, '2023-02-05 08:15:20', 'credito', 2500.00),
		(4, NULL, '2023-02-05 14:05:10', 'credito', 3450.00),
		(10, 2,   '2023-02-05 16:45:26', 'transferencia', 1100.00),
		(4, NULL, '2023-02-05 18:50:00', 'debito', 950.00),
		(1, NULL, '2023-02-05 20:00:30', 'credito', 546.00),
		(4, 7,    '2023-02-05 22:13:47', 'transferencia', 5000.00),
		(4, NULL, '2023-02-05 07:45:10', 'credito', 3600.00),
		(6, NULL, '2023-02-05 09:14:44', 'debito', 2800.00),
		(7, 1,    '2023-02-05 11:30:12', 'transferencia', 750.00),
		(7, NULL, '2023-02-05 13:13:00', 'credito', 500.00),
		(6, NULL, '2023-02-05 15:30:07', 'debito', 9000.00),
		(7, NULL, '2023-02-05 16:25:00', 'credito', 2350.00),
		(8, NULL, '2023-02-05 21:05:55', 'debito', 6400.00),
		(8, 4,    '2023-02-05 21:48:36', 'transferencia', 2100.00),
		(8, NULL, '2023-02-05 07:15:00', 'debito', 600.00),
		(1, NULL, '2023-02-05 07:36:15', 'debito', 1750.00),
		(1, NULL, '2023-02-05 08:05:55', 'credito', 900.00),
		(8, NULL, '2023-02-05 08:30:00', 'debito', 4000.00),
		(10, 4,   '2023-02-05 10:00:00', 'transferencia', 5500.00),
		(9, NULL, '2023-02-05 12:15:00', 'credito', 360.00),
		(8, 6,    '2023-02-05 14:20:45', 'transferencia', 600.00),
		(7, NULL, '2023-02-05 14:50:40', 'debito', 3800.00),
		(6, NULL, '2023-02-05 14:29:30', 'credito', 2000.00),
		(1, 6,    '2023-02-05 15:00:20', 'transferencia', 850.00),
		(6, NULL, '2023-02-05 16:05:00', 'debito', 660.00),
		(5, NULL, '2023-02-05 18:35:15', 'debito', 780.00),
		(8, NULL, '2023-02-05 07:15:00', 'debito', 600.00),
		(1, NULL, '2023-02-05 07:36:15', 'debito', 1750.00),
		(1, NULL, '2023-02-05 08:05:55', 'credito', 900.00),
		(8, NULL, '2023-02-05 08:30:00', 'debito', 4000.00),
		(9, 1,    '2023-02-05 10:00:00', 'transferencia', 5500.00),
		(7, NULL, '2023-02-05 12:15:00', 'credito', 360.00),
		(8, 2,    '2023-02-05 14:20:45', 'transferencia', 600.00),
		(7, NULL, '2023-02-05 14:50:40', 'debito', 3800.00),
		(6, NULL, '2023-02-05 14:29:30', 'credito', 2000.00),
		(8, NULL, '2023-02-05 08:15:00', 'debito', 370.00),
		(1, NULL, '2023-02-05 08:36:15', 'debito', 1750.00),
		(1, NULL, '2023-02-05 09:05:55', 'credito', 2900.00),
		(8, NULL, '2023-02-05 09:30:00', 'debito', 450.00),
		(10, 4,   '2023-02-05 09:00:00', 'transferencia', 5800.00),
		(10, NULL,'2023-02-05 09:15:00', 'credito', 2360.00),
		(8, 6,    '2023-02-05 10:20:45', 'transferencia', 1600.00),
		(7, NULL, '2023-02-05 10:25:40', 'debito', 330.00),
		(6, NULL, '2023-02-05 10:29:30', 'credito', 2900.00),
		(8, NULL, '2023-02-05 16:15:00', 'debito', 3500.00),
		(1, NULL, '2023-02-05 16:36:15', 'debito', 1050.00),
		(1, NULL, '2023-02-05 18:05:55', 'credito', 7400.00),
		(8, NULL, '2023-02-05 19:30:00', 'debito', 6000.00),
		(8, 4,    '2023-02-05 20:00:00', 'transferencia', 1280.00),
		(6, NULL, '2023-02-05 22:15:00', 'credito', 690.00),
		(8, 2,    '2023-02-05 22:20:45', 'transferencia', 1450.00),
		(7, NULL, '2023-02-05 23:50:40', 'debito', 26800.00),
		(6, NULL, '2023-02-05 23:55:30', 'credito', 900.00);

insert into emprestimo (codigoConta, dataSolicitacao, valorSolicitado, juros, aprovado, numeroParcela, dataAprovacao, observacao)
values  (1, '2022-10-10', 10000.00, 0.05, 1, 10, '2022-10-16', NULL),
		(2, '2022-11-15', 15000.00, 0.05, 1, 12, '2022-11-17', 'Consignado'),
		(2, '2022-12-05', 25000.00, 0.065, 0, 0, NULL, 'Recusado'),
		(3, '2022-12-10', 12000.00, 0.05, 0, 0,  NULL, 'Recusado'),
		(5, '2023-01-10', 15000.00, 0.1, 1, 24, '2023-01-13', 'Consignado');

insert into emprestimoparcela (codigoEmprestimo, numero, dataVencimento, valorParcela, dataPagamento, valorPago)
values  (1, 1, '2022-11-15', 1050.00, '2022-11-14', 1050.00),
		(1, 2, '2022-12-15', 1050.00, '2022-12-15', 1050.00),
		(1, 3, '2023-01-15', 1050.00, '2023-01-16', 1050.00),
		(1, 4, '2023-02-15', 1050.00, '2023-02-15', 1050.00),
		(1, 5, '2023-03-15', 1050.00, '2023-03-14', 1050.00),
		(1, 6, '2023-04-15', 1050.00, NULL, NULL),
		(1, 7, '2023-05-15', 1050.00, NULL, NULL),
		(1, 8, '2023-06-15', 1050.00, NULL, NULL),
		(1, 9, '2023-07-15', 1050.00, NULL, NULL),
		(1, 10, '2023-08-15', 1050.00, NULL, NULL),
		(2, 1, '2022-12-10', 1312.50, '2022-12-10', 1312.50),
		(2, 2, '2023-01-10', 1312.50, '2023-01-12', 1312.50),
		(2, 3, '2023-02-10', 1312.50, '2023-02-11', 1312.50),
		(2, 4, '2023-03-10', 1312.50, '2023-03-09', 1312.50),
		(2, 5, '2023-04-10', 1312.50, NULL, NULL),
		(2, 6, '2023-05-10', 1312.50, NULL, NULL),
		(2, 7, '2023-06-10', 1312.50, NULL, NULL),
		(2, 8, '2023-07-10', 1312.50, NULL, NULL),
		(2, 9, '2023-08-10', 1312.50, NULL, NULL),
		(2, 10, '2023-09-10', 1312.50, NULL, NULL),
		(2, 11, '2023-10-10', 1312.50, NULL, NULL),
		(2, 12, '2023-11-10', 1312.50, NULL, NULL),
		(5, 1, '2023-02-10', 687.50, '2023-02-10', 687.50),
		(5, 2, '2023-03-10', 687.50, '2023-03-08', 687.50),
		(5, 3, '2023-04-10', 687.50, NULL, NULL),
		(5, 4, '2023-05-10', 687.50, NULL, NULL),
		(5, 5, '2023-06-10', 687.50, NULL, NULL),
		(5, 6, '2023-07-10', 687.50, NULL, NULL),
		(5, 7, '2023-08-10', 687.50, NULL, NULL),
		(5, 8, '2023-09-10', 687.50, NULL, NULL),
		(5, 9, '2023-10-10', 687.50, NULL, NULL),
		(5, 10, '2023-11-10', 687.50, NULL, NULL),
		(5, 11, '2023-12-10', 687.50, NULL, NULL),
		(5, 12, '2024-01-10', 687.50, NULL, NULL),
		(5, 13, '2024-02-10', 687.50, NULL, NULL),
		(5, 14, '2024-03-10', 687.50, NULL, NULL),
		(5, 15, '2024-04-10', 687.50, NULL, NULL),
		(5, 16, '2024-05-10', 687.50, NULL, NULL),
		(5, 17, '2024-06-10', 687.50, NULL, NULL),
		(5, 18, '2024-07-10', 687.50, NULL, NULL),
		(5, 19, '2024-08-10', 687.50, NULL, NULL),
		(5, 20, '2024-09-10', 687.50, NULL, NULL),
		(5, 21, '2024-10-10', 687.50, NULL, NULL),
		(5, 22, '2024-11-10', 687.50, NULL, NULL),
		(5, 23, '2024-12-10', 687.50, NULL, NULL),
		(5, 24, '2025-01-10', 687.50, NULL, NULL);

insert into investimento (codigoConta, tipo, aporte, taxaAdm, prazo, grauRisco, rentabilidade, finalizado)
values 	(1, 'CDB', 10000.00, 0.04, 'medio', 'AA', 1250.00, 1),
		(1, 'acoes', 125000.00, 0.05, 'medio', 'BBB', 0, 0),
		(2, 'acoes', 150000.00, 0.05, 'longo', 'BBB', 0, 0),
		(3, 'CDB', 20000.00, 0.04, 'curto', 'AA', 1500.00, 0),
		(4, 'fundos', 200000.00, 0.05, 'longo', 'BB', 0, 0),
		(3, 'CDB', 15000.00, 0.04, 'medio', 'AA', 1600.00, 0),
		(5, 'TTD', 12000.00, 0.04, 'medio', 'AA-', 1500.00, 0),
		(1, 'acoes', 100000.00, 0.05, 'medio', 'BB', 0, 0);

insert into clienteconta (codigoCliente, codigoConta)
values  (21,1),
		(22,2),
		(22,3),
		(23,4),
		(24,5),
		(21,3),
		(25,7),
		(26,8),
		(27,6),
		(28,4),
		(29,6),
		(30,5);
