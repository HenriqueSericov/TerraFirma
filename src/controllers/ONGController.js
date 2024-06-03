var ONGModel = require("../models/ONGModel");

function listar(req, res) {
    ONGModel.listar().then(function(resultado){
        // precisamos informar que o resultado voltará para o front-end como uma resposta em json
        res.status(200).json(resultado);
    }).catch(function(erro){
        res.status(500).json(erro.sqlMessage);
    })
}

function cadastrar(req, res) {
    var NomeONG = req.body.NomeONG;
    var CNPJ = req.body.CNPJ;
    var Estado = req.body.Estado;
    var Cidade = req.body.Cidade;
    var Senha = req.body.Senha;
    var Telefone = req.body.Telefone;
    var Email = req.body.Email;
    var TipoONG = req.body.TipoONG;
    var Endereco = req.body.Endereco;
    var fkVoluntario = req.body.fkVoluntario

    if (NomeONG == undefined) {
        res.status(400).send("Seu nome está undefined!");
    }
    else {

        ONGModel.cadastrar(NomeONG, CNPJ, Estado, Cidade, Senha, Telefone, Email, TipoONG, Endereco, fkVoluntario )
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
    }

module.exports = {
    listar,
    cadastrar
}