var database = require("../database/config")

function autenticar(Email, Senha) {
    var instrucaoSql = `
        SELECT IdVoluntario, Nome, Email, fkEstado, fkCidade, fkZona  FROM Voluntario WHERE Email = '${Email}' AND Senha = '${Senha}';
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listar() {
    var instrucao = `
        SELECT * FROM carro;
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function cadastrar(Nome, Email, Telefone, Senha, fkEstado, fkCidade, fkZona) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", Nome, Email, Telefone, Senha, fkEstado, fkCidade, fkZona);
    
    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.
    var instrucaoSql = `
        INSERT INTO Voluntario (Nome, Email, Telefone, Senha, fkEstado, fkCidade, fkZona) VALUES ('${Nome}', '${Email}', '${Telefone}', '${Senha}', '${fkEstado}', '${fkCidade}', '${fkZona}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function Cadastrar_Participacao(IdUsuario, fkAcao) {;
    
    var instrucaoSql = `
        INSERT INTO Participacao (Status, fkVoluntario, fkAcao) VALUES ('Ativo', '${IdUsuario}', '${fkAcao}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


module.exports = {
    listar,
    cadastrar,
    autenticar,
    Cadastrar_Participacao
};
