-- 01. Consulte todos os clientes (nome) e seus respectivos endereços (logradouro, cidade e uf)
select nome_razaoSocial, logradouro, cidade, uf from cliente left join endereco on cliente.codigoEndereco = endereco.codigo;

-- 02. Consulte o cartão numero 4444695847251436 (numero e bandeira) e suas movimentações (data, operação e valor)
select c.numero, c.bandeira, m.dataHora, m.operacao, m.valor
from cartao c join movimentacao m on c.codigo = m.codigoCartao
where c.numero = '4444695847251436';

-- 03. Consulte o emprestimo de codigo 2 (data solicitação, valor solicitado e numero de parcelas) e suas parcelas em aberto (não pagas) (número, valor e data de vencimento)
select 
	e.dataSolicitacao, 
	e.valorSolicitado, 
	e.numeroParcela, 
	p.numero, 
	p.valorParcela, 
	p.dataVencimento
from emprestimo e 
join emprestimoparcela p on e.codigo = p.codigoEmprestimo
where e.codigo = 2 and p.valorPago = null;

-- 04. Consulte os clientes (nome) e seus respectivos endereços (logradouro, cidade e uf) que moram na cidade de São Paulo
select 
	c.nome_razaosocial, 
	e.logradouro, 
	e.cidade,
    e.uf
from cliente c 
join endereco e on e.codigo = c.codigoEndereco
where e.cidade = 'São Paulo';

-- 05. Consulte os clientes (nome) e seus respectivos contatos (numero e email) dos cliente que tem e-mail do gmail
select nome_razaoSocial, numero, email from cliente left join contato on cliente.codigo = contato.codigoCliente
where email like '%gmail%';

-- 06. Consulte as contas (agencia, numero e tipo) que possuem investimentos de longo prazo (tipo, aporte e prazo)
select
	c.agencia,
    c.numero,
    c.tipo as tipoConta,
    i.tipo as tipoInvestimento,
    i.aporte,
    i.prazo
from conta c
join investimento i on c.codigo = i.codigoConta
where i.prazo = 'longo';

-- 07. Consulte quem é cliente (nome) que possui o telefone (11) 98052-6863
select nome_razaoSocial, numero from cliente left join contato on cliente.codigo = contato.codigoCliente where numero = '(11) 98052-6863';

-- 08. Quais contas (agencia, numero e tipo) tiveram seus emprestimos negados (data solicitação, valor solicitado e se foi aprovado ou não)
select
	c.agencia,
    c.numero,
    c.tipo as tipoConta,
    e.dataSolicitacao,
    e.valorSolicitado,
    e.aprovado
from conta c
join emprestimo e on c.codigo = e.codigoConta
where e.aprovado = 0;

-- 09. Quais foram os cartões (numero e bandeira) que realizaram movimentações no dia 01/02/2023 (data, operação e valor)
select
	c.numero as numeroCartao,
    c.bandeira,
    m.dataHora as dataMovimento,
    m.operacao,
    m.valor
from cartao c
join movimentacao m on c.codigo = m.codigoCartao
where dataHora = '2023-02-01';

-- 10. Consulte os clientes PJ (nome e CNPJ) e suas respectivas cidades e telefone de contato
select
	c.nome_razaosocial,
    j.cnpj,
    e.cidade,
    t.numero
from cliente c
inner join cliente_pj j on j.codigoCliente = c.codigo
inner join endereco e on c.codigoEndereco = e.codigo
inner join contato t on t.codigoCliente = c.codigo;

-- 11. Consulte as contas (agencia e numero) seus cartões (numero e bandeira) e suas respectivas movimentações (operacao e valor)
select
	c.agencia,
    c.numero,
    a.numero as numeroCartao,
    a.bandeira,
    m.operacao,
    m.valor
from conta c
inner join cartao a on a.codigoConta = c.codigo
inner join movimentacao m on m.codigoCartao = a.codigo;

-- 12. Consulte as contas (agencia e numero) seus emprestimos (codigos, datas de solicitação e valores solicitados) e suas respectivas parcelas (numero, vencimento e valor pago)
select
	c.agencia,
    c.numero,
    e.codigo,
    e.dataSolicitacao,
    e.valorSolicitado,
    p.numero as numeroParcelas,
    p.dataVencimento,
    p.valorPago
from conta c
inner join emprestimo e on e.codigoConta = c.codigo
inner join emprestimoparcela p on p.codigoEmprestimo = e.codigo;

-- 13. Consulte todos clientes pessoa física (nome e cpf) e suas respectivas contas (agencia, numero)
select
	c.nome_razaosocial as nome,
    f.cpf,
    a.agencia,
    a.numero
from cliente c
inner join cliente_pf on f.codigoCliente = c.codigo
inner join conta a on a.codigo = 

-- 14. Consulte as transferências (com valores) realizadas pela cliente Abigail Barateiro Cangueiro

-- 15. Consulte as operações de crédito e debito (com valores) realizadas pela cliente Alice Barbalho Vilalobos

-- 16. Consulte quais clientes (nomes) realizaram movimentações em 01/02/2023

-- 17. Consulte os clientes (nome) que possuem emprestimos aprovados apresentando os valores solicitados e os valores totais que serão pagos (com juros)
