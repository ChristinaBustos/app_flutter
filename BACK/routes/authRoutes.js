const express = require("express");
const authController = require("../controllers/authController");
const router = express.Router();

//Ruta para rgistrar un usuario
router.post("/register", authController.registerUser);
//Ruta para logear un usuario
router.post("/login", authController.loginUser);
//ruta para actualizar un usuario
router.put("/update",authController.updateUser);

module.exports = router;
