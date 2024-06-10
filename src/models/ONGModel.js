var database = require("../database/config")

function autenticar(Email, Senha) {
    console.log("Model ONG")
    var instrucaoSql = `
        SELECT IdONG, Nome, Email, Telefone, fkTipoONG  FROM ONG WHERE Email = '${Email}' AND Senha = '${Senha}';
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function Buscar_Total_Voluntarios(fkONG) {
    var instrucao = `
    SELECT 
        count(fkVoluntario) AS Total_Voluntarios
    FROM 
        Participacao
    JOIN
        Acao
    ON
        fkONG = IdAcao
    WHERE
        fkONG = '${fkONG}';
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function Buscar_Acoes_Com_Mais_Voluntarios(fkONG) {
    var instrucao = `
    SELECT 
        IdAcao, Nome AS Nome_da_Acao, COUNT(fkVoluntario) AS Numero_Voluntarios
    FROM 
        Acao
    JOIN 
        Participacao ON IdAcao = fkAcao
    WHERE fkONG = ${fkONG}
    GROUP BY 
        IdAcao, Nome
    ORDER BY 
        Numero_Voluntarios DESC
    LIMIT 
        7
    ;
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function Buscar_Categorias_de_Acoes_Com_Mais_Voluntarios(fkONG) {
    var instrucao = `
    SELECT 
        Categoria.Nome AS Categoria_da_Acao,
        COUNT(Participacao.fkVoluntario) AS Numero_de_Voluntarios
    FROM 
        Categoria
    LEFT JOIN 
        Acao ON Categoria.IdCategoria = Acao.fkCategoria AND Acao.fkONG = ${fkONG}
    LEFT JOIN 
        Participacao ON Acao.IdAcao = Participacao.fkAcao
    GROUP BY 
        Categoria.Nome
    ORDER BY 
        Numero_de_Voluntarios DESC;
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function Buscar_Acoes(fkONG) {
    var instrucao = `
    SELECT 
        Nome AS Nome_da_Acao, DataAcao AS Data_da_Acao, IdAcao
    FROM 
        Acao
    WHERE
        fkONG = '${fkONG}';
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function cadastrar(NomeONG, CNPJ, CEP, Senha, Telefone, Email, TipoONG) {
    var instrucao = `
        INSERT INTO ONG (Nome, Email, Telefone, CNPJ, Senha, CEP, fkTipoONG) VALUES ('${NomeONG}', '${Email}', '${Telefone}', '${CNPJ}', '${Senha}', '${CEP}', '${TipoONG}');

    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function cadastrar_Acao(NomeAcao, Categoria, Estado, Cidade, Zona, Endereco, Data, Url, Descricao, fkONG) {
    var instrucao = `
        INSERT INTO Acao (Nome, Descricao, DataAcao, Endereco, URLImagem, fkONG, fkEstado, fkCidade, fkZona, fkCategoria) VALUES ('${NomeAcao}', '${Descricao}', '${Data}', '${Endereco}', '${Url}', '${fkONG}', '${Estado}', '${Cidade}', '${Zona}', '${Categoria}');

    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

module.exports = { 
    cadastrar, 
    autenticar, 
    cadastrar_Acao, 
    Buscar_Total_Voluntarios, 
    Buscar_Acoes, 
    Buscar_Acoes_Com_Mais_Voluntarios, 
    Buscar_Categorias_de_Acoes_Com_Mais_Voluntarios
};
