const jwt = require("jsonwebtoken");
const User = require("../models/User");

const generateToken = (id) => {
    return jwt.sign({ id }, process.env.JWT_SECRET, { expiresIn: "1m" });
};

exports.registerUser = async (req, res) => {
    console.log('Entraa?')
    const { name, email, password } = req.body;
    console.log(req.body);
    //Verificar si el ulsuario ya existe
    const userExists = await User.findOne({ email });
    if (userExists) {
        return res.status(400).json({ message: "El usuario ya existe 🥹" });
    }
    try {
        //Crear el Nuevo Usuaio
        const user = await User.create({ name, email, password });
        if (user) {
            return res.status(201).json({
                _id: user._id,
                name: user.name,
                email: user.email,
                token: generateToken(user._id),
            });
        } else {
            return res.status(400).json({ message: "No se pudo crear el usuario 😢" });
        }
    } catch (err) {
        return res.status(500).json({ message: "Error al crear el usuario 😢 Error:" + err });
    }
};

exports.loginUser = async (req, res) => {
    const { email, password } = req.body;
    //verificar si el usuario existe
    const userExists = await User.findOne({ email });
    if (!userExists) {
        return res.status(400).json({ message: "El usuario no existe 😢" });
    }
    //veriiicar si la contraseña es correcta
    const matchPassword = await userExists.matchPassword(password);
    if (!matchPassword) {
        return res.status(400).json({ message: "Contraseña incorrecta 😢" });
    }
    return res.status(200).json({
        _id: userExists._id,
        name: userExists.name,
        email: userExists.email,
        token: generateToken(userExists._id),
    });
};
