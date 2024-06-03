var database = require("../database/config")

function listar() {
    var instrucao = `
        SELECT * FROM carro;
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function cadastrar(NomeONG, CNPJ, Estado, Cidade, Senha, Telefone, Email, TipoONG, Endereco, fkVoluntario ) {
    var instrucao = `
        INSERT INTO Endereco (Estado, Cidade, Rua) VALUES ('${Estado}', '${Cidade}', '${Endereco}');

    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

module.exports = { cadastrar, listar };
