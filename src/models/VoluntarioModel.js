var database = require("../database/config")

function listar() {
    var instrucao = `
        SELECT * FROM carro;
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function cadastrar(Nome, Email, Telefone, Senha, fkEstado, fkCidade, fkZona) {
    var instrucao = `
        INSERT INTO Voluntario (Nome, Email, Telefone, Senha, fkEstado, fkCidade, fkZona) VALUES ('${Nome}', '${Email}', '${Telefone}', '${Senha}', '${fkEstado}', '${fkCidade}', '${fkZona}');

    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

module.exports = { cadastrar, listar };
