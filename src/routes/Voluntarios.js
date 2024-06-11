var express = require("express");
var router = express.Router();

var VoluntarioController = require("../controllers/VoluntarioController");

router.post("/cadastrar", function (req, res) {
    VoluntarioController.cadastrar(req, res);
})

router.post("/Cadastrar_Participacao", function (req, res) {
    VoluntarioController.Cadastrar_Participacao(req, res);
})

router.get("/listar", function (req, res) {
    // função a ser chamada quando acessar /carros/listar
    VoluntarioController.listar(req, res);
});

router.post("/autenticar", function (req, res) {
    VoluntarioController.autenticar(req, res);
});

module.exports = router;