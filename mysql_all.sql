DROP DATABASE IF EXISTS sistema_universitario;
CREATE DATABASE sistema_universitario;
USE sistema_universitario;

-- ========================================
-- LIVRARIA
-- ========================================

CREATE TABLE autores (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(50)
);

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE livros (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    preco DECIMAL(10,2),
    estoque INT,
    id_autor INT,
    id_categoria INT,
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE clientes_livraria (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATE,
    status VARCHAR(20),
    FOREIGN KEY (id_cliente) REFERENCES clientes_livraria(id_cliente)
);

CREATE TABLE itens_pedido (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_livro INT,
    quantidade INT,
    preco_unitario DECIMAL(10,2),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_livro) REFERENCES livros(id_livro)
);

INSERT INTO autores (nome, nacionalidade) VALUES
('Machado de Assis','Brasileiro'),
('George Orwell','Inglês'),
('J.K. Rowling','Britânica'),
('Stephen King','Americano');

INSERT INTO categorias (nome) VALUES
('Romance'),
('Fantasia'),
('Terror'),
('Distopia');

INSERT INTO livros (titulo, preco, estoque, id_autor, id_categoria) VALUES
('Dom Casmurro',29.90,10,1,1),
('1984',39.90,15,2,4),
('Harry Potter',49.90,20,3,2),
('It',59.90,8,4,3);

INSERT INTO clientes_livraria (nome, email) VALUES
('Ana Silva','ana@email.com'),
('Carlos Souza','carlos@email.com');

INSERT INTO pedidos (id_cliente, data_pedido, status) VALUES
(1,'2026-05-01','PAGO'),
(2,'2026-05-02','PENDENTE');

INSERT INTO itens_pedido (id_pedido, id_livro, quantidade, preco_unitario) VALUES
(1,1,2,29.90),
(1,3,1,49.90),
(2,2,1,39.90);

-- CONSULTAS LIVRARIA

SELECT livros.titulo, autores.nome
FROM livros
JOIN autores ON livros.id_autor = autores.id_autor;

SELECT pedidos.id_pedido, clientes_livraria.nome, pedidos.status
FROM pedidos
JOIN clientes_livraria ON pedidos.id_cliente = clientes_livraria.id_cliente;


-- ========================================
-- AGÊNCIA DE VIAGENS
-- ========================================

CREATE TABLE clientes_agencia (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    telefone VARCHAR(20)
);

CREATE TABLE destinos (
    id_destino INT AUTO_INCREMENT PRIMARY KEY,
    cidade VARCHAR(100),
    pais VARCHAR(100)
);

CREATE TABLE hoteis (
    id_hotel INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    estrelas INT,
    preco_diaria DECIMAL(10,2),
    id_destino INT,
    FOREIGN KEY (id_destino) REFERENCES destinos(id_destino)
);

CREATE TABLE voos (
    id_voo INT AUTO_INCREMENT PRIMARY KEY,
    origem VARCHAR(100),
    destino VARCHAR(100),
    data_partida DATE,
    data_chegada DATE,
    preco DECIMAL(10,2)
);

CREATE TABLE pacotes (
    id_pacote INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    preco_total DECIMAL(10,2),
    duracao_dias INT,
    id_destino INT,
    id_hotel INT,
    id_voo INT,
    FOREIGN KEY (id_destino) REFERENCES destinos(id_destino),
    FOREIGN KEY (id_hotel) REFERENCES hoteis(id_hotel),
    FOREIGN KEY (id_voo) REFERENCES voos(id_voo)
);

CREATE TABLE reservas (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_pacote INT,
    data_reserva DATE,
    status VARCHAR(20),
    FOREIGN KEY (id_cliente) REFERENCES clientes_agencia(id_cliente),
    FOREIGN KEY (id_pacote) REFERENCES pacotes(id_pacote)
);

INSERT INTO clientes_agencia (nome, email, telefone) VALUES
('Lucas Martins','lucas@email.com','119999'),
('Juliana Rocha','juliana@email.com','219888');

INSERT INTO destinos (cidade, pais) VALUES
('Paris','França'),
('Roma','Itália');

INSERT INTO hoteis (nome, estrelas, preco_diaria, id_destino) VALUES
('Hotel Lux',5,800,1),
('Roma Palace',4,500,2);

INSERT INTO voos (origem, destino, data_partida, data_chegada, preco) VALUES
('São Paulo','Paris','2026-06-01','2026-06-02',3500),
('Rio de Janeiro','Roma','2026-06-05','2026-06-06',3200);

INSERT INTO pacotes (nome, preco_total, duracao_dias, id_destino, id_hotel, id_voo) VALUES
('Paris Luxo',6000,7,1,1,1),
('Roma Cultural',4800,6,2,2,2);

INSERT INTO reservas (id_cliente, id_pacote, data_reserva, status) VALUES
(1,1,'2026-05-01','CONFIRMADO'),
(2,2,'2026-05-02','PENDENTE');

-- CONSULTAS AGÊNCIA

SELECT clientes_agencia.nome, destinos.cidade
FROM reservas
JOIN clientes_agencia ON reservas.id_cliente = clientes_agencia.id_cliente
JOIN pacotes ON reservas.id_pacote = pacotes.id_pacote
JOIN destinos ON pacotes.id_destino = destinos.id_destino;



-- ========================================
-- UNIVERSIDADE
-- ========================================

DROP DATABASE IF EXISTS universidade;
CREATE DATABASE universidade;
USE universidade;

CREATE TABLE curso (
    numerocurso INT PRIMARY KEY,
    nomecurso VARCHAR(100),
    numeroaulas INT,
    iniciocurso DATE,
    materiascurso VARCHAR(100)
);

CREATE TABLE aluno (
    numeroaluno INT PRIMARY KEY,
    nomealuno VARCHAR(100),
    numerocurso INT,
    FOREIGN KEY (numerocurso) REFERENCES curso(numerocurso)
);

CREATE TABLE professor (
    numeroprofessor INT PRIMARY KEY,
    nomeprofessor VARCHAR(100),
    materiaprofessor VARCHAR(100)
);

INSERT INTO curso VALUES
(101,'ADS',40,'2024-03-01','Lógica de Programação'),
(102,'ADS',35,'2024-04-01','Lógica de Programação'),
(103,'ADS',30,'2024-05-01','Lógica de Programação'),
(104,'ADS',45,'2024-06-01','Lógica de Programação'),
(105,'ADS',50,'2024-07-01','Lógica de Programação'),
(106,'TI',55,'2024-08-01','Redes'),
(107,'TI',60,'2024-09-01','Banco de Dados'),
(108,'TI',45,'2024-10-01','Gestão'),
(109,'TI',50,'2024-11-01','Segurança'),
(110,'TI',40,'2024-12-01','Engenharia');

INSERT INTO aluno VALUES
(1,'João',101),(2,'Maria',102),(3,'Carlos',103),(4,'Ana',101),
(5,'Pedro',104),(6,'Beatriz',102),(7,'Lucas',103),(8,'Camila',104),
(9,'Felipe',105),(10,'Rafael',101),(11,'Luana',102),(12,'Marcelo',103),
(13,'Bruna',104),(14,'Vinicius',105),(15,'Larissa',101);

INSERT INTO professor VALUES
(1001,'Marcos','Lógica'),
(1002,'Cláudia','Banco de Dados'),
(1003,'Ricardo','Engenharia'),
(1004,'Fernanda','Redes'),
(1005,'Lucas','Gestão'),
(1006,'José','Redes'),
(1007,'Paula','Banco de Dados'),
(1008,'Carla','Gestão'),
(1009,'Julio','Segurança'),
(1010,'Luciana','Engenharia');

CREATE VIEW vw_alunos_cursos AS
SELECT a.numeroaluno, a.nomealuno, c.nomecurso
FROM aluno a
JOIN curso c ON a.numerocurso = c.numerocurso;


-- ========================================
-- LOJINHA
-- ========================================

DROP DATABASE IF EXISTS lojinha;
CREATE DATABASE lojinha;
USE lojinha;

CREATE TABLE Cliente (
    codCliente INT PRIMARY KEY,
    nomeCliente VARCHAR(100),
    enderecoCliente VARCHAR(200),
    telefoneCliente VARCHAR(15)
);

CREATE TABLE Produto (
    codigoProduto INT PRIMARY KEY,
    descricaoProduto VARCHAR(100),
    valorUnitario DECIMAL(10,2),
    quantidadeEstoque INT
);

CREATE TABLE Recibo (
    numNF INT PRIMARY KEY,
    serie VARCHAR(10),
    dataEmissao DATE,
    codCliente INT,
    FOREIGN KEY (codCliente) REFERENCES Cliente(codCliente)
);

CREATE TABLE Compra (
    numNF INT,
    codigoProduto INT,
    quantidadeComprada INT,
    valorTotal DECIMAL(10,2),
    PRIMARY KEY (numNF, codigoProduto),
    FOREIGN KEY (numNF) REFERENCES Recibo(numNF),
    FOREIGN KEY (codigoProduto) REFERENCES Produto(codigoProduto)
);

INSERT INTO Cliente VALUES
(1,'Luffy','Going Merry','1111'),
(2,'Zoro','Going Merry','2222'),
(3,'Nami','Going Merry','3333'),
(4,'Sanji','Going Merry','4444'),
(5,'Chopper','Going Merry','5555'),
(6,'Robin','Going Merry','6666'),
(7,'Franky','Going Merry','7777'),
(8,'Brook','Going Merry','8888'),
(9,'Jinbe','Going Merry','9999'),
(10,'Yamato','Going Merry','0000');

INSERT INTO Produto VALUES
(101,'Produto A',10,50),(102,'Produto B',20,30),
(103,'Produto C',15,20),(104,'Produto D',25,10),
(105,'Produto E',30,5),(106,'Produto F',35,15),
(107,'Produto G',40,12),(108,'Produto H',45,10),
(109,'Produto I',50,8),(110,'Produto J',55,5);

INSERT INTO Recibo VALUES
(1,'A001','2024-10-18',1),(2,'A002','2024-10-19',2),
(3,'A003','2024-10-20',3),(4,'A004','2024-10-21',4),
(5,'A005','2024-10-22',5),(6,'A006','2024-10-23',6),
(7,'A007','2024-10-24',7),(8,'A008','2024-10-25',8),
(9,'A009','2024-10-26',9),(10,'A010','2024-10-27',10);

INSERT INTO Compra VALUES
(1,101,2,20),(1,102,3,60),(2,103,5,75),(3,104,1,25),(4,105,4,120),
(6,106,2,70),(7,107,3,120),(8,108,1,45),(9,109,4,200),(10,110,5,275);

CREATE VIEW vw_clientes_compras AS
SELECT cl.nomeCliente, rc.numNF, co.quantidadeComprada, pr.descricaoProduto
FROM Cliente cl
JOIN Recibo rc ON cl.codCliente = rc.codCliente
JOIN Compra co ON rc.numNF = co.numNF
JOIN Produto pr ON co.codigoProduto = pr.codigoProduto;


-- ========================================
-- PROJETO (FORNECEDORES)
-- ========================================

DROP DATABASE IF EXISTS projeto;
CREATE DATABASE projeto;
USE projeto;

CREATE TABLE Fornecedor (
    codFornecedor INT PRIMARY KEY,
    nomeFornecedor VARCHAR(100),
    enderecoFornecedor VARCHAR(200),
    emailFornecedor VARCHAR(100)
);

CREATE TABLE Produto (
    codProduto INT PRIMARY KEY,
    descricaoProduto VARCHAR(100)
);

CREATE TABLE Compra (
    numCompra INT PRIMARY KEY,
    dtCompra DATE,
    codFornecedor INT,
    codProduto INT,
    FOREIGN KEY (codFornecedor) REFERENCES Fornecedor(codFornecedor),
    FOREIGN KEY (codProduto) REFERENCES Produto(codProduto)
);

INSERT INTO Fornecedor VALUES
(1,'Assai','Rua A','a@email'),
(2,'Shibata','Rua B','b@email'),
(3,'Pão de Açúcar','Rua C','c@email'),
(4,'Atacadão','Rua D','d@email'),
(5,'Davo','Rua E','e@email');

INSERT INTO Produto VALUES
(101,'Higiene'),(102,'Perecível'),(103,'Não Perecível'),
(104,'Limpeza'),(105,'Alimento');

INSERT INTO Compra VALUES
(1,'2024-10-01',1,101),(2,'2024-10-02',1,102),
(3,'2024-10-03',2,103),(4,'2024-10-04',3,101),
(5,'2024-10-05',2,102);

CREATE VIEW vw_fornecedores_compras AS
SELECT f.nomeFornecedor, p.descricaoProduto, c.dtCompra
FROM Fornecedor f
JOIN Compra c ON f.codFornecedor = c.codFornecedor
JOIN Produto p ON c.codProduto = p.codProduto;
SELECT pacotes.nome, pacotes.preco_total
FROM pacotes;
