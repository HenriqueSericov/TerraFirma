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
    var CEP = req.body.CEP;
    var Senha = req.body.Senha;
    var Telefone = req.body.Telefone;
    var Email = req.body.Email;
    var TipoONG = req.body.TipoONG;

    if (NomeONG == undefined) {
        res.status(400).send("Seu nome está undefined!");
    }else if(CNPJ == undefined){
        res.status(400).send("Seu CNPJ está undefined!");        
    }else if(CEP == undefined){
        res.status(400).send("Seu CEP está undefined!");        
    }else if(Senha == undefined){
        res.status(400).send("Seu Senha está undefined!");        
    }else if(Telefone == undefined){
        res.status(400).send("Seu Telefone está undefined!");        
    }else if(Email == undefined){
        res.status(400).send("Seu Email está undefined!");        
    }else if(TipoONG == undefined){
        res.status(400).send("Seu TipoONG está undefined!");        
    }
    else {

        ONGModel.cadastrar(NomeONG, CNPJ, CEP, Senha, Telefone, Email, TipoONG)
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