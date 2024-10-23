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


// Actualización de usuario usando el correo electrónico
exports.updateUser = async (req, res) => {
    const { email, name, password } = req.body; // Se toma el email del cuerpo de la solicitud

    try {
        const user = await User.findOne({ email }); // Buscar usuario por email
        if (!user) {
            return res.status(404).json({ message: "Usuario no encontrado 😢" });
        }

        // Verificar si el nuevo email ya está en uso por otro usuario
        if (email && email !== user.email) {
            const emailExists = await User.findOne({ email });
            if (emailExists) {
                return res.status(400).json({ message: "El email ya está en uso por otro usuario 🥹" });
            }
        }

        user.name = name || user.name;
        if (password) {
            user.password = password; // Actualiza la contraseña solo si se pasa en el cuerpo de la solicitud
        }

        const updatedUser = await user.save();

        return res.status(200).json({
            _id: updatedUser._id,
            name: updatedUser.name,
            email: updatedUser.email,
            token: generateToken(updatedUser._id),
        });
    } catch (err) {
        return res.status(500).json({ message: "Error al actualizar el usuario 😢 Error:" + err });
    }
};