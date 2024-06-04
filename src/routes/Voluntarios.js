var express = require("express");
var router = express.Router();

var VoluntarioController = require("../controllers/VoluntarioController");

router.post("/cadastrar", function (req, res) {
    // função a ser chamada quando acessar /carros/cadastrar
    VoluntarioController.cadastrar(req, res);
});

router.get("/listar", function (req, res) {
    // função a ser chamada quando acessar /carros/listar
    VoluntarioController.listar(req, res);
});

module.exports = router;