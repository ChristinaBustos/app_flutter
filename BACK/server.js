require("dotenv").config();
const express = require("express");
const morgan = require("morgan");
const cors = require("cors");
const mongoose = require("mongoose");
const authRouter = require("./routes/authRoutes");

const app = express();
app.use(morgan("dev"));
app.use(cors());
app.use(express.json());

app.use("/api/auth", authRouter);

mongoose
    .connect(process.env.MONGO_URI)
    .then(() => {
        console.log("Conectado a la Base de De Datos 🤠");
    })
    .catch((err) => {
        console.log("Error al Conectar a la Base de Datos 😢, Error: " + err);
    });

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log("El Servidor se esta corriendo en el puerto: " + PORT);
});
