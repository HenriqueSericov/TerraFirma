var VoluntarioModel = require("../models/VoluntarioModel");

function listar(req, res) {
    VoluntarioModel.listar().then(function(resultado){
        // precisamos informar que o resultado voltará para o front-end como uma resposta em json
        res.status(200).json(resultado);
    }).catch(function(erro){
        res.status(500).json(erro.sqlMessage);
    })
}

function cadastrar(req, res) {
    var Nome = req.body.Nome;
    var Email = req.body.Email;
    var Telefone = req.body.Telefone;
    var Senha = req.body.Senha;
    var fkEstado = req.body.fkEstado;
    var fkCidade = req.body.fkCidade;
    var fkZona = req.body.fkZona;

    if (Nome == undefined) {
        res.status(400).send("Seu nome está undefined!");
    }else if(Email == undefined){
        res.status(400).send("Seu Email está undefined!");        
    }else if(Telefone == undefined){
        res.status(400).send("Seu Telefone está undefined!");        
    }else if(Senha == undefined){
        res.status(400).send("Seu Senha está undefined!");        
    }else if(fkEstado == undefined){
        res.status(400).send("Seu fkEstado está undefined!");        
    }else if(fkCidade == undefined){
        res.status(400).send("Seu fkCidade está undefined!");        
    }else if(fkZona == undefined){
        res.status(400).send("Seu fkZona está undefined!");        
    }
    else {

        VoluntarioModel.cadastrar(Nome, Email, Telefone, Senha, fkEstado, fkCidade, fkZona)
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