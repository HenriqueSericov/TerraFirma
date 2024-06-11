var ONGModel = require("../models/ONGModel");

function autenticar(req, res) {
    var Email = req.body.emailServer;
    var Senha = req.body.senhaServer;

    if (Email == undefined) {
        res.status(400).send("Seu Email está undefined!");
    } else if (Senha == undefined) {
        res.status(400).send("Sua Senha está indefinida!");
    } else {

        ONGModel.autenticar(Email, Senha)
            .then(
                function (resultadoAutenticar) {
                    console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`); // transforma JSON em String

                    if (resultadoAutenticar.length == 1) {
                        console.log(resultadoAutenticar);

                        res.json({
                            IdONG: resultadoAutenticar[0].IdONG,
                            Email: resultadoAutenticar[0].Email,
                            Nome: resultadoAutenticar[0].Nome,
                            Senha: resultadoAutenticar[0].Senha,
                            Telefone: resultadoAutenticar[0].Telefone,
                            CNPJ: resultadoAutenticar[0].CNPJ,
                            CEP: resultadoAutenticar[0].CEP,
                            fkTipoONG: resultadoAutenticar[0].fkTipoONG
                        });
                    } else if (resultadoAutenticar.length == 0) {
                        res.status(403).send("Email e/ou Senha inválido(s)");
                    } else {
                        res.status(403).send("Mais de um usuário com o mesmo login e Senha!");
                    }
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}
function Buscar_Total_Voluntarios(req, res) {
    var fkONG = req.body.fkONG;
    if (fkONG == undefined) {
        res.status(400).send("Seu fkONG está undefined!");
    }
    ONGModel.Buscar_Total_Voluntarios(fkONG).then(function(resultado){
        res.status(200).json(resultado);
    }).catch(function(erro){
        res.status(500).json(erro.sqlMessage);
    })
}

function Buscar_Acoes_Com_Mais_Voluntarios(req, res) {
    var fkONG = req.body.fkONG;
    if (fkONG == undefined) {
        res.status(400).send("Seu fkONG está undefined!");
    }
    ONGModel.Buscar_Acoes_Com_Mais_Voluntarios(fkONG).then(function(resultado){
        res.status(200).json(resultado);
    }).catch(function(erro){
        res.status(500).json(erro.sqlMessage);
    })
}

function Buscar_Categorias_de_Acoes_Com_Mais_Voluntarios(req, res) {
    var fkONG = req.body.fkONG;
    if (fkONG == undefined) {
        res.status(400).send("Seu fkONG está undefined!");
    }
    ONGModel.Buscar_Categorias_de_Acoes_Com_Mais_Voluntarios(fkONG).then(function(resultado){
        res.status(200).json(resultado);
    }).catch(function(erro){
        res.status(500).json(erro.sqlMessage);
    })
}

function Buscar_Acoes(req, res) {
    var fkONG = req.body.fkONG;
    if (fkONG == undefined) {
        res.status(400).send("Seu fkONG está undefined!");
    }
    ONGModel.Buscar_Acoes(fkONG).then(function(resultado){
        res.status(200).json(resultado);
    }).catch(function(erro){
        res.status(500).json(erro.sqlMessage);
    })
}

function Buscar_Todas_Acoes_Por_Categoria(req,res) {
    var Categoria_Buscada = req.body.Categoria;
    if (Categoria_Buscada == undefined) {
        res.status(400).send("Seu Categoria_Buscada está undefined!");
    }
    ONGModel.Buscar_Todas_Acoes_Por_Categoria(Categoria_Buscada).then(function(resultado){
        res.status(200).json(resultado);
    }).catch(function(erro){
        res.status(500).json(erro.sqlMessage);
    })
}

function Buscar_Inscricoes(req,res) {
    var fkVoluntario = req.body.fk_Voluntario;
    if (fkVoluntario == undefined) {
        res.status(400).send("Seu fkVoluntario está undefined!");
    }
    ONGModel.Buscar_Inscricoes(fkVoluntario).then(function(resultado){
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

    function cadastrar_Acao(req, res) {
        var NomeAcao = req.body.NomeAcao;
        var Categoria = req.body.Categoria;
        var Estado = req.body.Estado;
        var Cidade = req.body.Cidade;
        var Zona = req.body.Zona;
        var Endereco = req.body.Endereco;
        var Data = req.body.Data;
        var Url = req.body.Url;
        var Descricao = req.body.Descricao;
        var fkONG = req.body.fkONG;
    
        if (NomeAcao == undefined) {
            res.status(400).send("Seu NomeAcao está undefined!");
        }else if(Categoria == undefined){
            res.status(400).send("Sua Categoria está undefined!");        
        }else if(Estado == undefined){
            res.status(400).send("Seu Estado está undefined!");        
        }else if(Cidade == undefined){
            res.status(400).send("Sua Cidade está undefined!");        
        }else if(Zona == undefined){
            res.status(400).send("Sua Zona está undefined!");        
        }else if(Endereco == undefined){
            res.status(400).send("Seu Endereco está undefined!");        
        }else if(Data == undefined){
            res.status(400).send("Sua Data está undefined!");        
        }else if(Url == undefined){
            res.status(400).send("Seu Url está undefined!");        
        }else if(Descricao == undefined){
            res.status(400).send("Sua Descricao está undefined!");        
        }else if(fkONG == undefined){
            res.status(400).send("Seu fkONG está undefined!");        
        }
        
        else {
    
            ONGModel.cadastrar_Acao(NomeAcao, Categoria, Estado, Cidade, Zona, Endereco, Data, Url, Descricao, fkONG)
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
    cadastrar,
    autenticar,
    cadastrar_Acao,
    Buscar_Total_Voluntarios,
    Buscar_Acoes,
    Buscar_Acoes_Com_Mais_Voluntarios,
    Buscar_Categorias_de_Acoes_Com_Mais_Voluntarios,
    Buscar_Todas_Acoes_Por_Categoria,
    Buscar_Inscricoes
}