-- ----------------------------------------------------------------- Criando Database ---------------------------------------------------------------

CREATE DATABASE TerraFirma;

-- --------------------------------------------------------------------------------------------------------------------------------------------------

-- --------------------------------------------------------------- Selecionando Database ------------------------------------------------------------

USE TerraFirma;

-- --------------------------------------------------------------------------------------------------------------------------------------------------

-- ----------------------------------------------------------------- Criando Tabelas ----------------------------------------------------------------

-- Criar tabela Estado
CREATE TABLE Estado (
    IdEstado INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(75) NOT NULL UNIQUE,
    Sigla VARCHAR(2) NOT NULL UNIQUE,
    CHECK ( 
        (Nome = 'Acre' AND Sigla = 'AC') OR
        (Nome = 'Alagoas' AND Sigla = 'AL') OR
        (Nome = 'Amapá' AND Sigla = 'AP') OR
        (Nome = 'Amazonas' AND Sigla = 'AM') OR
        (Nome = 'Bahia' AND Sigla = 'BA') OR
        (Nome = 'Ceará' AND Sigla = 'CE') OR
        (Nome = 'Distrito Federal' AND Sigla = 'DF') OR
        (Nome = 'Espírito Santo' AND Sigla = 'ES') OR
        (Nome = 'Goiás' AND Sigla = 'GO') OR
        (Nome = 'Maranhão' AND Sigla = 'MA') OR
        (Nome = 'Mato Grosso' AND Sigla = 'MT') OR
        (Nome = 'Mato Grosso do Sul' AND Sigla = 'MS') OR
        (Nome = 'Minas Gerais' AND Sigla = 'MG') OR
        (Nome = 'Pará' AND Sigla = 'PA') OR
        (Nome = 'Paraíba' AND Sigla = 'PB') OR
        (Nome = 'Paraná' AND Sigla = 'PR') OR
        (Nome = 'Pernambuco' AND Sigla = 'PE') OR
        (Nome = 'Piauí' AND Sigla = 'PI') OR
        (Nome = 'Rio de Janeiro' AND Sigla = 'RJ') OR
        (Nome = 'Rio Grande do Norte' AND Sigla = 'RN') OR
        (Nome = 'Rio Grande do Sul' AND Sigla = 'RS') OR
        (Nome = 'Rondônia' AND Sigla = 'RO') OR
        (Nome = 'Roraima' AND Sigla = 'RR') OR
        (Nome = 'Santa Catarina' AND Sigla = 'SC') OR
        (Nome = 'São Paulo' AND Sigla = 'SP') OR
        (Nome = 'Sergipe' AND Sigla = 'SE') OR
        (Nome = 'Tocantins' AND Sigla = 'TO')
    )
);

-- Criar tabela Cidade

CREATE TABLE Cidade (
    IdCidade INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(75) NOT NULL UNIQUE,
    CHECK (
        Nome IN (
            'São Paulo', 
            'Rio de Janeiro', 
            'Brasília', 
            'Salvador', 
            'Fortaleza', 
            'Belo Horizonte', 
            'Manaus', 
            'Curitiba', 
            'Recife', 
            'Porto Alegre', 
            'Goiânia', 
            'Belém', 
            'Guarulhos', 
            'Campinas', 
            'São Luís'
        )
    )
);

-- Criar tabela Zona
CREATE TABLE Zona (
    IdZona INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(75) NOT NULL UNIQUE,
    CHECK (
        Nome IN (
            'Centro', 
            'Zona Sul', 
            'Zona Leste', 
            'Zona Oeste', 
            'Zona Norte'
        )
    )
);


-- Criar tabela TipoONG
CREATE TABLE TipoONG (
    IdTipo INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(75) NOT NULL UNIQUE,
    CHECK (
        Nome IN (
            'Ambiental', 
            'Educação', 
            'Saúde', 
            'Direitos Humanos', 
            'Assistência Social', 
            'Cultura', 
            'Desenvolvimento Comunitário', 
            'Defesa Animal', 
            'Desenvolvimento Sustentável', 
            'Habitat', 
            'Desenvolvimento Urbano', 
            'Esportes', 
            'Arte e Cultura', 
            'Outros'
        )
    )
);


-- Criar tabela Categoria
CREATE TABLE Categoria (
    IdCategoria INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(75) NOT NULL UNIQUE,
    CONSTRAINT chk_ValidCategoria CHECK (
        Nome IN (
            'Alimento', 
            'Serviços', 
            'Educacao', 
            'Animais', 
            'Saude', 
            'Recreacao'
        )
    )
);

-- Criar tabela ONG
CREATE TABLE ONG (
    IdONG INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(75) NOT NULL,
    Email VARCHAR(264) NOT NULL UNIQUE,
    Telefone CHAR(9) NOT NULL UNIQUE,
    CNPJ CHAR(14) NOT NULL UNIQUE,
    Senha VARCHAR(45) NOT NULL,
    CEP CHAR(9) NOT NULL,
    fkTipoONG INT NOT NULL,
    
    CONSTRAINT fkTipoONG FOREIGN KEY (fkTipoONG) REFERENCES TipoONG(IdTipo)
);

-- Criar tabela Voluntario
CREATE TABLE Voluntario (
    IdVoluntario INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(75) NOT NULL,
    Email VARCHAR(264) NOT NULL UNIQUE,
    Telefone CHAR(9) NOT NULL UNIQUE,
    Senha VARCHAR(64) NOT NULL,
	fkEstado INT NOT NULL,
    fkCidade INT NOT NULL,
    fkZona INT NOT NULL,
    
	CONSTRAINT fkCidadeEstado FOREIGN KEY (fkEstado) REFERENCES Estado(IdEstado),
    CONSTRAINT fkCidadeCliente FOREIGN KEY (fkCidade) REFERENCES Cidade(IdCidade),
    CONSTRAINT fkZonaCliente FOREIGN KEY (fkZona) REFERENCES Zona(IdZona)
);

-- Criar tabela Acao
CREATE TABLE Acao (
    IdAcao INT AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    Descricao VARCHAR(225) NOT NULL,
    DataAcao DATE NOT NULL,
    Endereco VARCHAR(80) NOT NULL,
    URLImagem VARCHAR(500) NOT NULL,
    fkONG INT,
	fkEstado INT NOT NULL,
    fkCidade INT NOT NULL,
    fkZona INT NOT NULL,
    fkCategoria INT NOT NULL,
    
    CONSTRAINT pkCompostaAcao PRIMARY KEY(IdAcao, fkONG),
    CONSTRAINT fkONGAcao FOREIGN KEY (fkONG) REFERENCES ONG(IdONG),
	CONSTRAINT fkEstadoAcao FOREIGN KEY (fkEstado) REFERENCES Estado(IdEstado),
	CONSTRAINT fkCidadeAcao FOREIGN KEY (fkCidade) REFERENCES Cidade(IdCidade),
	CONSTRAINT fkZonaAcao FOREIGN KEY (fkZona) REFERENCES Zona(IdZona),
    CONSTRAINT fkCategoriaAcao FOREIGN KEY (fkCategoria) REFERENCES Categoria(IdCategoria)
);

-- Criar tabela Participacao
CREATE TABLE Participacao (
    Status VARCHAR(45),
    fkVoluntario INT,
    fkAcao INT,
    
    CONSTRAINT pkCompostaParticipacao PRIMARY KEY(fkVoluntario, fkAcao),
    FOREIGN KEY (fkVoluntario) REFERENCES Voluntario(IdVoluntario),
    FOREIGN KEY (fkAcao) REFERENCES Acao(IdAcao)
);

-- --------------------------------------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------- Inserindo Dados  ---------------------------------------------------------------

-- Inserts para a tabela Estado
INSERT INTO Estado (Nome, Sigla) VALUES
('Acre', 'AC'),
('Alagoas', 'AL'),
('Amapá', 'AP'),
('Amazonas', 'AM'),
('Bahia', 'BA'),
('Ceará', 'CE'),
('Distrito Federal', 'DF'),
('Espírito Santo', 'ES'),
('Goiás', 'GO'),
('Maranhão', 'MA'),
('Mato Grosso', 'MT'),
('Mato Grosso do Sul', 'MS'),
('Minas Gerais', 'MG'),
('Pará', 'PA'),
('Paraíba', 'PB'),
('Paraná', 'PR'),
('Pernambuco', 'PE'),
('Piauí', 'PI'),
('Rio de Janeiro', 'RJ'),
('Rio Grande do Norte', 'RN'),
('Rio Grande do Sul', 'RS'),
('Rondônia', 'RO'),
('Roraima', 'RR'),
('Santa Catarina', 'SC'),
('São Paulo', 'SP'),
('Sergipe', 'SE'),
('Tocantins', 'TO');

-- Inserts para a tabela Cidade
INSERT INTO Cidade (Nome) VALUES
('São Paulo'),
('Rio de Janeiro'),
('Brasília'),
('Salvador'),
('Fortaleza'),
('Belo Horizonte'),
('Manaus'),
('Curitiba'),
('Recife'),
('Porto Alegre'),
('Goiânia'),
('Belém'),
('Guarulhos'),
('Campinas'),
('São Luís');

-- Inserts para a tabela Zona
INSERT INTO Zona (Nome) VALUES
('Centro'),
('Zona Sul'),
('Zona Leste'),
('Zona Oeste'),
('Zona Norte');

-- Inserts para a tabela TipoONG
INSERT INTO TipoONG (Nome) VALUES
('Ambiental'),
('Educação'),
('Saúde'),
('Direitos Humanos'),
('Assistência Social'),
('Cultura'),
('Desenvolvimento Comunitário'),
('Defesa Animal'),
('Desenvolvimento Sustentável'),
('Habitat'),
('Desenvolvimento Urbano'),
('Esportes'),
('Arte e Cultura'),
('Outros');

-- Inserts para a tabela Categoria
INSERT INTO Categoria (Nome) VALUES
('Alimento'),          
('Serviços'),
('Educação'),
('Animais'),
('Saude'),
('Recreação');

-- Insert para a tabela ONG
INSERT INTO ONG (Nome, Email, Telefone, CNPJ, Senha, CEP, fkTipoONG) VALUES 
('União SPTech', 'UniaoSPTech@outlook.com', '123123123', '12345678901234', '12345678@', '04109-060', 7);

-- Inserts para a tabela Voluntario
INSERT INTO Voluntario (Nome, Email, Telefone, Senha, fkEstado, fkCidade, fkZona) 
VALUES 
('Henrique Sericov', 'email1@example.com', '123456789', 'senha1', 1, 1, 1),
('Juliana Murakami', 'email2@example.com', '987654321', 'senha2', 1, 1, 1),
('Mariana Dias', 'email3@example.com', '456123789', 'senha3', 1, 1, 1),
('João Carlos', 'email4@example.com', '789456123', 'senha4', 1, 1, 1),
('Gabriela Silva', 'email5@example.com', '321654987', 'senha5', 1, 1, 1),
('Roberto Sampaio', 'email6@example.com', '654987321', 'senha6', 1, 1, 1),
('Gabriel Almeida', 'email7@example.com', '159357852', 'senha7', 1, 1, 1),
('Bruno Milici', 'email8@example.com', '852963741', 'senha8', 1, 1, 1),
('Guilherme Gavassa', 'email9@example.com', '369852147', 'senha9', 1, 1, 1),
('Erik Azevedo', 'email10@example.com', '741852963', 'senha10', 1, 1, 1);

-- Drop database TerraFirma;
-- Inserts para a tabela Acao
INSERT INTO Acao (Nome, Descricao, DataAcao, Endereco, URLImagem, fkONG, fkEstado, fkCidade, fkZona, fkCategoria) 
VALUES
-- Ações da categoria alimento
('Sopão do Povo', 'Distribua sopão para pessoas em situação de rua e vulnerabilidade social.', '2024-06-15', 'Rua das Flores, 123', 'https://plus.unsplash.com/premium_photo-1673809798703-6082a015f931?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8U29wYW98ZW58MHx8MHx8fDA%3D', 1, 25, 1, 1, 1),
('Doando Comida!', 'Ajude a alimentar famílias necessitadas da nossa comunidade doando alimentos não perecíveis. Sua doação fará a diferença.', '2024-06-09', 'Avenida Central, 456', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGhtX4AWMCckBSh0nvI6BATvl5kAReQisKpg&s', 1, 25, 1, 1, 1),
('Cesta Básica Solidária', 'Doe cestas básicas para famílias em situação de vulnerabilidade alimentar.', '2024-06-20', 'Praça da Liberdade, 789', 'https://plus.unsplash.com/premium_photo-1661775322183-bf9d38cff431?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDh8fHxlbnwwfHx8fHw%3D', 1, 25, 1, 1, 1),
('Banquete Solidário', 'Organize um banquete solidário para moradores de rua e pessoas em situação de risco.', '2024-06-25', 'Rua Nova, 321', 'https://images.unsplash.com/photo-1593034509785-5b17ba49f683?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGlxdWUlMjBuaXF1ZXxlbnwwfHwwfHx8MA%3D%3D', 1, 25, 1, 1, 1),

-- Ações da Categoria Serviços
('Doando Carinho', 'Espalhe amor e compaixão para idosos em lares de acolhimento.', '2024-06-16', 'Rua da Paz, 654', 'https://images.unsplash.com/photo-1454875392665-2ac2c85e8d3e?q=80&w=1586&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 1, 25, 1, 1, 2),
('Limpando a Cidade', 'Contribua para tornar nossas ruas mais limpas e seguras, removendo resíduos e revitalizando espaços públicos.', '2024-06-10', 'Avenida Verde, 987', 'https://plus.unsplash.com/premium_photo-1663040117567-ab8441cb7b04?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8TGltcGFuZG8lMjBhJTIwY2lkYWRlfGVufDB8fDB8fHww', 1, 25, 1, 1, 2),
('Consertos Solidários', 'Ofereça pequenos consertos e reparos em moradias de pessoas carentes.', '2024-06-21', 'Rua das Acácias, 543', 'https://images.unsplash.com/photo-1530240852689-f7a9c6d9f6c7?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE0fHx8ZW58MHx8fHx8', 1, 25, 1, 1, 2),
('Pintura Comunitária', 'Ajude a pintar e revitalizar espaços comunitários em bairros carentes.', '2024-06-26', 'Avenida das Nações, 852', 'https://images.unsplash.com/photo-1525909002-1b05e0c869d8?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGludGFuZG8lMjBjYXNhfGVufDB8fDB8fHww', 1, 25, 1, 1, 2),

-- Ações da Categoria Educação
('Educação para todos', 'Apoie o acesso à educação de qualidade para crianças carentes e faça a diferença em suas vidas.', '2024-06-11', 'Rua da Esperança, 159', 'https://images.unsplash.com/photo-1529390079861-591de354faf5?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 1, 25, 1, 1, 3),
('Educação é vida', 'Promova a educação como ferramenta para transformação social.', '2024-06-17', 'Avenida dos Estudantes, 753', 'https://images.unsplash.com/photo-1532012197267-da84d127e765?q=80&w=1587&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 1, 25, 1, 1, 3),
('Aula de Reforço', 'Ofereça aulas de reforço escolar para crianças e adolescentes da comunidade.', '2024-06-22', 'Praça do Conhecimento, 951', 'https://images.unsplash.com/photo-1581726690015-c9861fa5057f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDR8fHxlbnwwfHx8fHw%3D', 1, 25, 1, 1, 3),
('Biblioteca Comunitária', 'Ajude a montar e organizar uma biblioteca comunitária para crianças e jovens.', '2024-06-27', 'Rua das Letras, 357', 'https://images.unsplash.com/photo-1509021436665-8f07dbf5bf1d?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 1, 25, 1, 1, 3),

-- Ações da Categoria Animais
('Salvando Gatos', 'Participe para salvar gatos abandonados e proporcionar-lhes um lar amoroso e seguro.', '2024-06-12', 'Rua dos Felinos, 468', 'https://images.unsplash.com/photo-1536589961747-e239b2abbec2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fHNhbHZhbmRvJTIwZ2F0b3N8ZW58MHx8MHx8fDA%3D', 1, 25, 1, 1, 4),
('Salvando Dogs', 'Ajude-nos a resgatar e encontrar lares amorosos para cães abandonados.', '2024-06-18', 'Avenida dos Cães, 159', 'https://images.unsplash.com/photo-1675701917466-9a2f2db9d310?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8ZG9ncyUyMHNhdmluZ3xlbnwwfHwwfHx8MA%3D%3D', 1, 25, 1, 1, 4),
('Campanha de Adoção', 'Promova a adoção responsável de cães e gatos abandonados em nossa comunidade.', '2024-06-23', 'Rua dos Bichinhos, 17', 'https://images.unsplash.com/photo-1560807707-8cc77767d783?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 1, 25, 1, 1, 4),
('Lar Temporário', 'Ofereça um lar temporário para animais resgatados até encontrarem uma adoção permanente.', '2024-06-28', 'Avenida dos Pets, 18', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 1, 25, 1, 1, 4),

-- Ações da Categoria Saude
('Campanha de Vacina', 'Ajude a proteger nossa comunidade contra doenças evitáveis participando da campanha de vacinação.', '2024-06-13', 'Rua da Saúde, 5', 'https://images.unsplash.com/photo-1605377347958-e8bd4c00ba1d?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzwFhzQ2FtcGFuaGElMjBkZSUyMHZhY2luYXxlbnwwfHwwfHx8MA%3D%3D', 1, 25, 1, 1, 5),
('Saúde na Praça', 'Participe de um evento de saúde ao ar livre, oferecendo exames básicos e orientações de saúde.', '2024-06-24', 'Praça do Bem-Estar, 19', 'https://images.unsplash.com/photo-1623261887327-c1d2d2ad0137?q=80&w=1664&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 1, 25, 1, 1, 5),
('Doação de Sangue', 'Incentive a doação de sangue para salvar vidas, participe da nossa campanha.', '2024-06-29', 'Avenida da Solidariedade, 20', 'https://images.unsplash.com/photo-1550831107-1553da8c8464?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 1, 25, 1, 1, 5),
('Mutirão de Saúde', 'Participe do mutirão de saúde e ajude a realizar exames preventivos na comunidade.', '2024-06-30', 'Rua dos Cuidados, 21', 'https://images.unsplash.com/photo-1526256262350-7da7584cf5eb?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 1, 25, 1, 1, 5),

-- Ações da Categoria Recreação
('Videogame na Favela', 'Traga alegria e diversão para as crianças da favela com nosso evento "Videogame na Favela".', '2024-06-14', 'Rua do Lazer, 6', 'https://images.unsplash.com/photo-1535223289827-42f1e9919769?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fEdhbWVyfGVufDB8fDB8fHww', 1, 25, 1, 1, 6),
('Cinema na Comunidade', 'Leve a magia do cinema para crianças e famílias da comunidade, com sessões ao ar livre.', '2024-07-01', 'Rua do Filme, 22', 'https://plus.unsplash.com/premium_photo-1675237624894-72210a956d17?q=80&w=1587&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 1, 25, 1, 1, 6),
('Brincadeiras ao Ar Livre', 'Promova um dia de brincadeiras e atividades ao ar livre para as crianças da comunidade.', '2024-07-02', 'Parque das Crianças, 23', 'https://images.unsplash.com/photo-1611153390516-995f4a8c0f2e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8Sm9nb3MlMjBhbyUyMGFyJTIwbGl2cmV8ZW58MHx8MHx8fDA%3D', 1, 25, 1, 1, 6),
('Festa Junina Solidária', 'Organize uma festa junina solidária, trazendo alegria e diversão para a comunidade.', '2024-07-03', 'Rua das Festas, 24', 'https://images.unsplash.com/photo-1526505262320-81542978f63b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fGZlc3RhJTIwaW5mYW50aWx8ZW58MHx8MHx8fDA%3D', 1, 25, 1, 1, 6);

-- Inserts para a tabela Participacao
INSERT INTO Participacao (Status, fkVoluntario, fkAcao) 
VALUES 
('Confirmado', 1, 1),
('Confirmado', 2, 1),
('Pendente', 7, 1),
('Confirmado', 1, 2),
('Pendente', 9, 2),
('Confirmado', 10, 2),
('Confirmado', 1, 3),
('Pendente', 2, 3),
('Pendente', 4, 3),
('Confirmado', 5, 3),
('Pendente', 6, 3),
('Confirmado', 7, 3),
('Pendente', 8, 3),
('Confirmado', 1, 4),
('Pendente', 4, 4),
('Confirmado', 9, 4),
('Pendente', 10, 4),
('Confirmado', 1, 5),
('Pendente', 4, 5),
('Confirmado', 5, 5),
('Confirmado', 9, 5),
('Pendente', 10, 5),
('Confirmado', 1, 6),
('Pendente', 2, 6),
('Confirmado', 7, 6),
('Pendente', 8, 6),
('Confirmado', 1, 7),
('Confirmado', 9, 7),
('Pendente', 10, 7),
('Pendente', 2, 8),
('Pendente', 6, 8),
('Confirmado', 7, 8),
('Confirmado', 9, 8),
('Confirmado', 1, 9),
('Pendente', 2, 9),
('Confirmado', 3, 9),
('Pendente', 4, 9),
('Confirmado', 5, 9),
('Pendente', 6, 9),
('Confirmado', 7, 9),
('Pendente', 8, 9),
('Confirmado', 9, 9),
('Pendente', 10, 9),
('Confirmado', 1, 10),
('Pendente', 2, 10),
('Confirmado', 3, 10),
('Pendente', 2, 11),
('Confirmado', 3, 11),
('Pendente', 4, 11),
('Confirmado', 9, 11),
('Pendente', 10, 11),
('Confirmado', 1, 12),
('Confirmado', 7, 12),
('Pendente', 8, 12),
('Confirmado', 9, 12),
('Pendente', 10, 12),
('Confirmado', 7, 13),
('Pendente', 8, 13),
('Confirmado', 1, 14),
('Confirmado', 3, 14),
('Pendente', 4, 14),
('Confirmado', 5, 14),
('Pendente', 6, 14),
('Confirmado', 7, 14),
('Pendente', 8, 14),
('Confirmado', 9, 14),
('Confirmado', 3, 15),
('Pendente', 4, 15),
('Pendente', 2, 16),
('Confirmado', 5, 16),
('Pendente', 6, 16),
('Confirmado', 7, 16),
('Pendente', 8, 16),
('Pendente', 10, 16),
('Confirmado', 1, 17),
('Confirmado', 9, 17),
('Pendente', 10, 17),
('Confirmado', 1, 18),
('Confirmado', 5, 18),
('Pendente', 6, 18),
('Confirmado', 7, 18),
('Pendente', 8, 18),
('Pendente', 6, 19),
('Confirmado', 7, 19),
('Pendente', 8, 19),
('Confirmado', 9, 19),
('Pendente', 2, 20),
('Pendente', 6, 20),
('Confirmado', 7, 20),
('Confirmado', 7, 21),
('Pendente', 8, 21),
('Confirmado', 9, 21),
('Pendente', 10, 21),
('Pendente', 4, 22),
('Confirmado', 5, 22),
('Pendente', 6, 22),
('Confirmado', 7, 22),
('Pendente', 8, 22),
('Confirmado', 9, 22),
('Pendente', 10, 22),
('Confirmado', 5, 23),
('Pendente', 10, 23),
('Confirmado', 1, 24),
('Confirmado', 3, 24),
('Confirmado', 7, 24),
('Confirmado', 9, 24),
('Confirmado', 10, 24);

-- --------------------------------------------------------------------------------------------------------------------------------------------------

-- --------------------------------------------------------- Descrevendo Estrutura das Tabelas ------------------------------------------------------

-- Descrevendo estrutura da tabela Estado
Describe Estado;

-- Descrevendo estrutura da tabela Cidade
Describe Cidade;

-- Descrevendo estrutura da tabela Zona
Describe Zona;

-- Descrevendo estrutura da tabela TipoONG
Describe TipoONG;

-- Descrevendo estrutura da tabela Categoria
Describe Categoria;

-- Descrevendo estrutura da tabela ONG
Describe ONG;

-- Descrevendo estrutura da tabela Voluntario
Describe Voluntario;

-- Descrevendo estrutura da tabela Acao
Describe Acao;

-- Descrevendo estrutura da tabela Participacao
Describe Participacao;

-- --------------------------------------------------------------------------------------------------------------------------------------------------

-- -------------------------------------------------------------------- Selects ---------------------------------------------------------------------

-- Selecionar todos os registros da tabela Estado
SELECT * FROM Estado;

-- Selecionar todos os registros da tabela Cidade
SELECT * FROM Cidade ORDER BY IdCidade;

-- Selecionar todos os registros da tabela Zona
SELECT * FROM Zona;

-- Selecionar todos os registros da tabela TipoONG
SELECT * FROM TipoONG ORDER BY IdTipo;

-- Selecionar todos os registros da tabela Categoria
SELECT * FROM Categoria;

-- Selecionar todos os registros da tabela ONG
SELECT * FROM ONG;

-- Selecionar todos os registros da tabela Voluntario
SELECT * FROM Voluntario;

-- Selecionar todos os registros da tabela Acao
SELECT * FROM Acao;

-- Selecionar todos os registros da tabela Participacao
SELECT * FROM Participacao;

-- --------------------------------------------------------------------------------------------------------------------------------------------------