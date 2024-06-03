var express = require("express");
var router = express.Router();

var ONGController = require("../controllers/ONGController");

router.post("/cadastrar", function (req, res) {
    // função a ser chamada quando acessar /carros/cadastrar
    ONGController.cadastrar(req, res);
});

router.get("/listar", function (req, res) {
    // função a ser chamada quando acessar /carros/listar
    ONGController.listar(req, res);
});

module.exports = router;