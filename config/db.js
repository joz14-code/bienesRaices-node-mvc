import Sequelize from "sequelize";
import dotenv from 'dotenv';
dotenv.config({path: '.env'})

const db = new Sequelize(process.env.BD_NOMBRE, process.env.BD_USER, process.env.BD_PASS,{
    host: process.env.BD_HOST,
    port: 3306,
    dialect: 'mysql',
    define: {
        timestamps: true
    },

    pool:{
        max: 5, //maximo de conexiones
        min: 0, //minimo de conexiones
        acquire: 30000, //tiempo antes de marcar un error 
        idle: 10000 //tiempo que debe de transcurrir para finalizar una conexion a la base de datos para liberar memoria
    },
    
    OperatorAliases: false

});

export default db;