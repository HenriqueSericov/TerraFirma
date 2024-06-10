var express = require("express");
var router = express.Router();

var ONGController = require("../controllers/ONGController");

router.post("/cadastrar", function (req, res) {
    // função a ser chamada quando acessar /carros/cadastrar
    ONGController.cadastrar(req, res);
});

router.post("/cadastrar_Acao", function (req, res) {
    // função a ser chamada quando acessar /carros/cadastrar
    ONGController.cadastrar_Acao(req, res);
});

router.post("/Buscar_Total_Voluntarios", function (req, res) {
    // função a ser chamada quando acessar /carros/listar
    ONGController.Buscar_Total_Voluntarios(req, res);
});

router.post("/Buscar_Acoes", function (req, res) {
    // função a ser chamada quando acessar /carros/listar
    ONGController.Buscar_Acoes(req, res);
});

router.post("/Buscar_Acoes_Com_Mais_Voluntarios", function (req, res) {
    ONGController.Buscar_Acoes_Com_Mais_Voluntarios(req, res);
});

router.post("/Buscar_Categorias_de_Acoes_Com_Mais_Voluntarios", function (req, res) {
    ONGController.Buscar_Categorias_de_Acoes_Com_Mais_Voluntarios(req, res);
});
router.post("/autenticar", function (req, res) {
    ONGController.autenticar(req, res);
});

module.exports = router;