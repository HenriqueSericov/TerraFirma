var database = require("../database/config")

function listar() {
    var instrucao = `
        SELECT * FROM carro;
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

module.exports = { cadastrar, listar };
