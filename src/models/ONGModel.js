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
        INSERT INTO Endereco (Estado, Cidade, Endereco) VALUES ('${Estado}', '${Cidade}', '${Endereco}');
        INSERT INTO ONG (NomeONG, CNPJ, Senha, Telefone, Email, TipoONG, fkVoluntario) VALUES ('${NomeONG}', '${CNPJ}', '${Senha}', '${Telefone}', '${Email}', '${TipoONG}', '${fkVoluntario}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

module.exports = { cadastrar, listar };
