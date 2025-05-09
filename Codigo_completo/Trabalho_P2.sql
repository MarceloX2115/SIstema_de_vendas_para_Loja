-- 1) Criação das tabelas 
CREATE TABLE clientes (
    cliente_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    data_cadastro DATE DEFAULT CURRENT_DATE,
    status VARCHAR(10) CHECK (status IN ('Ativo', 'Inativo', 'Bloqueado')) DEFAULT 'Ativo',
    cpf VARCHAR(14) UNIQUE NOT NULL,
    endereco TEXT
);
select * from clientes;

CREATE TABLE formas_pagamento (
    forma_pagamento_id SERIAL PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL UNIQUE,
    parcelas_maximas INT CHECK (parcelas_maximas > 0) DEFAULT 1,
    ativo BOOLEAN DEFAULT TRUE
);
select * from clientes;

CREATE TABLE produtos (
    produto_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco NUMERIC(10,2) CHECK (preco > 0) NOT NULL,
    codigo_barras VARCHAR(20) UNIQUE,
    categoria VARCHAR(50),
    data_cadastro DATE DEFAULT CURRENT_DATE
);
select * from produtos;

CREATE TABLE estoque (
    estoque_id SERIAL PRIMARY KEY,
    produto_id INT NOT NULL,
    quantidade INT CHECK (quantidade >= 0) DEFAULT 0,
    localizacao VARCHAR(50),
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (produto_id) REFERENCES produtos(produto_id) ON DELETE CASCADE
);
select * from estoque;

CREATE TABLE pedidos (
    pedido_id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) CHECK (status IN ('Pendente', 'Processando', 'Enviado', 'Entregue', 'Cancelado')) DEFAULT 'Pendente',
    forma_pagamento_id INT,
    valor_total NUMERIC(12,2) CHECK (valor_total >= 0),
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
    FOREIGN KEY (forma_pagamento_id) REFERENCES formas_pagamento(forma_pagamento_id)
);
select * from pedidos;

CREATE TABLE itens_pedido (
    item_id SERIAL PRIMARY KEY,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT CHECK (quantidade > 0) NOT NULL,
    preco_unitario NUMERIC(10,2) CHECK (preco_unitario > 0) NOT NULL,
    desconto NUMERIC(10,2) CHECK (desconto >= 0) DEFAULT 0,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produtos(produto_id),
    UNIQUE (pedido_id, produto_id)
);
select * from itens_pedido;

-- Adicionando coluna após criação de tabela
ALTER TABLE clientes ADD COLUMN data_nascimento DATE;

-- Adicionando uma restrição após a criação da tabela
ALTER TABLE produtos ADD CONSTRAINT check_categoria 
CHECK (categoria IN ('Eletrônicos', 'Roupas', 'Alimentos', 'Livros', 'Brinquedos', 'Outros'));

-- 2) inserindo dados

INSERT INTO formas_pagamento (descricao, parcelas_maximas) VALUES
('Dinheiro', 1),
('Cartão de Crédito', 12),
('Cartão de Débito', 1),
('PIX', 1),
('Boleto Bancário', 1),
('Transferência Bancária', 1),
('Cartão Loja', 6);

-- Inserindo clientes
INSERT INTO clientes (nome, email, telefone, cpf, endereco, data_nascimento) VALUES
('João Silva', 'joao@email.com', '(11) 9999-8888', '123.456.789-01', 'Rua A, 100 - São Paulo', '1985-05-15'),
('Maria Souza', 'maria@email.com', '(11) 9777-6666', '987.654.321-09', 'Av. B, 200 - Rio de Janeiro', '1990-08-20'),
('Carlos Oliveira', 'carlos@email.com', '(21) 9555-4444', '456.789.123-45', 'Rua C, 300 - Belo Horizonte', '1978-11-30'),
('Ana Santos', 'ana@email.com', '(31) 9333-2222', '789.123.456-78', 'Av. D, 400 - Curitiba', '1995-03-25'),
('Pedro Costa', 'pedro@email.com', '(41) 9111-0000', '321.654.987-32', 'Rua E, 500 - Porto Alegre', '1982-07-10'),
('Lucia Ferreira', 'lucia@email.com', '(51) 9888-7777', '654.987.321-65', 'Av. F, 600 - Recife', '1992-09-05'),
('Marcos Rocha', 'marcos@email.com', '(81) 9666-5555', '147.258.369-14', 'Rua G, 700 - Salvador', '1988-12-15'),
('Juliana Lima', 'juliana@email.com', '(71) 9444-3333', '258.369.147-25', 'Av. H, 800 - Fortaleza', '1993-04-18'),
('Fernando Alves', 'fernando@email.com', '(85) 9222-1111', '369.147.258-36', 'Rua I, 900 - Brasília', '1975-06-22'),
('Patricia Gomes', 'patricia@email.com', '(61) 9000-9999', '159.357.486-15', 'Av. J, 1000 - Manaus', '1980-10-08'),
('Cliente Inativo', 'inativo@email.com', '(11) 9999-9999', '999.999.999-99', 'Rua K, 1100 - São Paulo', '1970-01-01');

-- Atualizando status do cliente inativo
UPDATE clientes SET status = 'Inativo' WHERE cliente_id = 11;

-- Inserindo produtos
INSERT INTO produtos (nome, descricao, preco, codigo_barras, categoria) VALUES
('Smartphone X', 'Smartphone última geração', 2999.99, '7891234567890', 'Eletrônicos'),
('Notebook Pro', 'Notebook com 16GB RAM e SSD 512GB', 4599.90, '7891234567891', 'Eletrônicos'),
('Camiseta Básica', 'Camiseta de algodão branca', 49.90, '7891234567892', 'Roupas'),
('Calça Jeans', 'Calça jeans azul masculina', 129.90, '7891234567893', 'Roupas'),
('Arroz 5kg', 'Arroz integral tipo 1', 22.50, '7891234567894', 'Alimentos'),
('Feijão 1kg', 'Feijão carioca', 8.90, '7891234567895', 'Alimentos'),
('Livro SQL', 'Livro sobre banco de dados SQL', 89.90, '7891234567896', 'Livros'),
('Boneca', 'Boneca de pano artesanal', 59.90, '7891234567897', 'Brinquedos'),
('Fone Bluetooth', 'Fone de ouvido sem fio', 199.90, '7891234567898', 'Eletrônicos'),
('Mochila', 'Mochila escolar resistente', 119.90, '7891234567899', 'Outros'),
('Caneta', 'Caneta esferográfica azul', 2.50, '7891234567800', 'Outros');

-- Inserindo estoque
INSERT INTO estoque (produto_id, quantidade, localizacao) VALUES
(1, 50, 'Prateleira A1'),
(2, 30, 'Prateleira A2'),
(3, 100, 'Prateleira B1'),
(4, 80, 'Prateleira B2'),
(5, 200, 'Prateleira C1'),
(6, 150, 'Prateleira C2'),
(7, 40, 'Prateleira D1'),
(8, 60, 'Prateleira D2'),
(9, 70, 'Prateleira E1'),
(10, 90, 'Prateleira E2'),
(11, 500, 'Caixa 01');

-- Inserindo pedidos
INSERT INTO pedidos (cliente_id, data_pedido, status, forma_pagamento_id, valor_total) VALUES
(1, '2023-01-15 10:30:00', 'Entregue', 2, 3049.89),
(2, '2023-01-16 14:45:00', 'Enviado', 3, 4699.80),
(3, '2023-01-17 09:15:00', 'Processando', 4, 179.80),
(4, '2023-01-18 16:20:00', 'Pendente', 5, 31.40),
(5, '2023-01-19 11:30:00', 'Entregue', 1, 129.90),
(6, '2023-01-20 13:25:00', 'Cancelado', 2, 2999.99),
(7, '2023-01-21 15:10:00', 'Enviado', 3, 199.90),
(8, '2023-01-22 10:00:00', 'Entregue', 4, 89.90),
(9, '2023-01-23 14:30:00', 'Processando', 5, 242.40),
(10, '2023-01-24 09:45:00', 'Pendente', 1, 59.90);

-- Inserindo itens de pedido
INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario, desconto) VALUES
(1, 1, 1, 2999.99, 0),
(1, 10, 1, 119.90, 70.00),
(2, 2, 1, 4599.90, 0),
(2, 9, 1, 199.90, 100.00),
(3, 3, 2, 49.90, 0),
(3, 4, 1, 129.90, 50.00),
(4, 5, 1, 22.50, 0),
(4, 6, 1, 8.90, 0),
(5, 4, 1, 129.90, 0),
(6, 1, 1, 2999.99, 0),
(7, 9, 1, 199.90, 0),
(8, 7, 1, 89.90, 0),
(9, 5, 10, 22.50, 2.10),
(9, 6, 2, 8.90, 0),
(10, 8, 1, 59.90, 0);

-- 3) Fazendo manipulações

-- Atualizando produtos com aumento de 10% da categoria Eletrônicos
UPDATE produtos 
SET preco = preco * 1.10 
WHERE categoria = 'Eletrônicos';

-- Atualizar status de pedidos antigos para 'Entregue'
UPDATE pedidos 
SET status = 'Entregue' 
WHERE status = 'Pendente' AND data_pedido < '2023-01-20';

-- Aplicar desconto de 15% em produtos da categoria Roupas
UPDATE produtos
SET preco = preco * 0.85
WHERE categoria = 'Roupas';

-- Excluir cliente que nunca fez pedido
DELETE FROM clientes 
WHERE cliente_id NOT IN (SELECT DISTINCT cliente_id FROM pedidos) AND status = 'Inativo';

-- Excluir produtos sem estoque e sem vendas
DELETE FROM produtos
WHERE produto_id NOT IN (SELECT DISTINCT produto_id FROM itens_pedido)
AND produto_id NOT IN (SELECT DISTINCT produto_id FROM estoque WHERE quantidade > 0);

-- Atualizar localização no estoque para produtos eletrônicos
UPDATE estoque
SET localizacao = 'Setor Eletrônicos - ' || localizacao
WHERE produto_id IN (SELECT produto_id FROM produtos WHERE categoria = 'Eletrônicos');

-- 4) Fazendo consultas

-- 1. Listar todos os clientes ativos
SELECT * FROM clientes WHERE status = 'Ativo';

-- 2. Produtos com preço acima de R$ 100,00
SELECT nome, preco FROM produtos WHERE preco > 100 ORDER BY preco DESC;

-- 3. Pedidos realizados em janeiro de 2023 com status 'Entregue' ou 'Enviado'
SELECT p.pedido_id, c.nome AS cliente, p.data_pedido, p.status
FROM pedidos p
JOIN clientes c ON p.cliente_id = c.cliente_id
WHERE p.data_pedido BETWEEN '2023-01-01' AND '2023-01-31'
AND p.status IN ('Entregue', 'Enviado');

-- 4. Total de vendas por forma de pagamento
SELECT fp.descricao, COUNT(p.pedido_id) AS total_pedidos, SUM(p.valor_total) AS total_vendido
FROM formas_pagamento fp
LEFT JOIN pedidos p ON fp.forma_pagamento_id = p.forma_pagamento_id
GROUP BY fp.descricao
ORDER BY total_vendido DESC;

-- 5. Produtos mais vendidos (quantidade)
SELECT pr.nome, SUM(ip.quantidade) AS total_vendido
FROM itens_pedido ip
JOIN produtos pr ON ip.produto_id = pr.produto_id
GROUP BY pr.nome
ORDER BY total_vendido DESC
LIMIT 5;

-- 6. Clientes que gastaram mais de R$ 500,00
SELECT c.nome, SUM(p.valor_total) AS total_gasto
FROM clientes c
JOIN pedidos p ON c.cliente_id = p.cliente_id
GROUP BY c.nome
HAVING SUM(p.valor_total) > 500
ORDER BY total_gasto DESC;

-- 7. Produtos com estoque baixo (menos de 50 unidades)
SELECT p.nome, e.quantidade, p.categoria
FROM produtos p
JOIN estoque e ON p.produto_id = e.produto_id
WHERE e.quantidade < 50
ORDER BY e.quantidade;

-- 8. Média de valor dos pedidos por status
SELECT status,ROUND(AVG(valor_total), 2) AS media_valor  -- Arredonda para 2 casas decimais
FROM pedidos
GROUP BY status;

-- 9. Busca de produtos por termo (LIKE)
SELECT nome, preco FROM produtos 
WHERE nome LIKE '%Smart%' OR descricao LIKE '%Smart%';

-- 10. Relação de itens de um pedido específico
SELECT p.nome AS produto, ip.quantidade, ip.preco_unitario, ip.desconto, 
       (ip.preco_unitario * ip.quantidade - ip.desconto) AS subtotal
FROM itens_pedido ip
JOIN produtos p ON ip.produto_id = p.produto_id
WHERE ip.pedido_id = 1;

-- 11) Consulta com JOIN múltiplo: Pedidos com detalhes completos
SELECT 
    pd.pedido_id,
    c.nome AS cliente,
    pd.data_pedido,
    pd.status,
    fp.descricao AS forma_pagamento,
    pd.valor_total,
    STRING_AGG(pr.nome || ' (' || ip.quantidade || ' un)', ', ') AS produtos
FROM 
    pedidos pd
JOIN 
    clientes c ON pd.cliente_id = c.cliente_id
LEFT JOIN 
    formas_pagamento fp ON pd.forma_pagamento_id = fp.forma_pagamento_id
JOIN 
    itens_pedido ip ON pd.pedido_id = ip.pedido_id
JOIN 
    produtos pr ON ip.produto_id = pr.produto_id
GROUP BY 
    pd.pedido_id, c.nome, pd.data_pedido, pd.status, fp.descricao, pd.valor_total
ORDER BY 
    pd.data_pedido DESC;

-- 12) Consulta com subquery: Clientes que compraram produtos eletrônicos
SELECT DISTINCT c.nome, c.email
FROM clientes c
JOIN pedidos p ON c.cliente_id = p.cliente_id
JOIN itens_pedido ip ON p.pedido_id = ip.pedido_id
WHERE ip.produto_id IN (
    SELECT produto_id FROM produtos WHERE categoria = 'Eletrônicos'
);

-- 13) Consulta com HAVING: Categorias com vendas superiores a R$ 300
SELECT 
    p.categoria, 
    SUM(ip.preco_unitario * ip.quantidade - ip.desconto) AS total_vendido
FROM 
    itens_pedido ip
JOIN 
    produtos p ON ip.produto_id = p.produto_id
GROUP BY 
    p.categoria
HAVING 
    SUM(ip.preco_unitario * ip.quantidade - ip.desconto) > 300
ORDER BY 
    total_vendido DESC;

