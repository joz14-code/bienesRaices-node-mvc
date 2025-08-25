import { check, validationResult } from 'express-validator'
import bcrypt from 'bcrypt'
import Usuario from '../models/Usuario.js'
import { generarJWT, generarId } from '../helpers/tokens.js'
import{ emailRegistro, emailOlvidePassword } from '../helpers/emails.js'
 
const formularioLogin = (req, res) => {
    res.render('auth/login', {
        //autenticado: true
        pagina: 'Iniciar Sesión',
        csrfToken: req.csrfToken()

    })
}

const autenticar = async (req, res) => {
    // Validación
    await check('email').isEmail().withMessage('El Email es Obligatorio').run(req)    
    await check('password').notEmpty().withMessage('El Password es obligatorio').run(req)

    let resultado = validationResult(req)

    //Verificar que el resultado esté vacio
    if(!resultado.isEmpty()) {
        //errores
        return res.render('auth/login', {
            pagina: 'Iniciar Sesión',
            csrfToken : req.csrfToken(),
            errores: resultado.array()
            
        })
    }

    const { email, password } = req.body
    
    //Comprobar si el usuario existe 
    const usuario = await Usuario.findOne({ where: { email }})
    if(!usuario) {
        return res.render('auth/login', {
            pagina: 'Iniciar Sesión',
            csrfToken : req.csrfToken(),
            errores: [{msg: 'El Usuario no existe'}]
            
        })
    }

    //Comprobar si el usuario está confirmado
    if(!usuario.confirmado) {        
        return res.render('auth/login', {
            pagina: 'Iniciar Sesión',
            csrfToken : req.csrfToken(),
            errores: [{msg: 'Tu cuenta no ha sido confirmada'}]
            
        })

    }

    //Revisar el password
    if(!usuario.verificarPassword(password)) {
        return res.render('auth/login', {
            pagina: 'Iniciar Sesión',
            csrfToken : req.csrfToken(),
            errores: [{msg: 'El Password es Incorrecto'}]
            
        })

    }   

    //Autenticar al usuario
    const token = generarJWT({id: usuario.id, nombre: usuario.nombre })

    console.log(token)

    //Almacenar en un cookie 
    return res.cookie('_token', token, {
        httpOnly: true,
        //secure: true

        
    }).redirect('/mis-propiedades')

}

const cerrarSesion = (req, res) =>{
    return res.clearCookie('_token').status(200).redirect('/auth/login')

}

const formularioRegistro = (req, res) => {    
    res.render('auth/registro', {
        pagina: 'Crear Cuenta',
        csrfToken : req.csrfToken()      

    })
}

const registrar = async (req, res) => {
    
    //validación
    await check('nombre').notEmpty().withMessage('El nombre es obligatorio').run(req)
    await check('email').isEmail().withMessage('Eso no parece un email').run(req)    
    await check('password').isLength({ min: 6 }).withMessage('El Password debe ser de al menos 6 caracteres').run(req)
    await check('repetir_password').notEmpty().withMessage('Repetir Password es obligatorio').equals(req.body.password).withMessage('Los Passwords no son iguales').run(req)

    let resultado = validationResult(req)
   
    //Verificar que el resultado esté vacio
    if(!resultado.isEmpty()){
        //errores
        return res.render('auth/registro', {
            pagina: 'Crear Cuenta',
            csrfToken : req.csrfToken(),
            errores: resultado.array(), 
            usuario: {
                nombre: req.body.nombre,
                email: req.body.email
            }
        })
    }
    
    //extraer los datos
    const { nombre, email, password } = req.body

    //verificar que el usuario no está duplicado 
    const existeUsuario = await Usuario.findOne({ where : { email }})

    if(existeUsuario) {
        //errores
        return res.render('auth/registro', {
            pagina: 'Crear Cuenta',
            csrfToken : req.csrfToken(),
            errores: [{msg: 'El usuario ya está registrado'}], 
            usuario: {
                nombre: req.body.nombre,
                email: req.body.email
            }
        })
    }
    
    //Almacenar un usuario 
    const usuario = await Usuario.create({
        nombre,
        email,
        password,
        token: generarId()

    })

    //Envia email de confirmación
    emailRegistro({
        nombre: usuario.nombre,
        email: usuario.email,
        token: usuario.token
    })

    //Mostrar mensaje de confirmación
    res.render('templates/mensaje',{
        pagina: 'Cuenta Creada Correctamente',
        mensaje: 'Hemos Enviado un Email de Confirmación, presiona en el enlace'

    })    
}

//Función que comprueba una cuenta
const confirmar = async (req, res) => {
   
    const { token } = req.params;   

    //Verificar si el token es válido
    const usuario = await Usuario.findOne({ where: {token}})
    
    if(!usuario){
        return res.render('auth/confirmarCuenta',{
            pagina: 'Error al confirmar tu cuenta',
            mensaje: 'Hubo un error al confirmar tu cuenta, inténtalo de nuevo',
            error: true
        })

    }

    // Confirmar la cuenta
    
    usuario.token = null;
    usuario.confirmado = true;
    await usuario.save();

    return res.render('auth/confirmarCuenta',{
        pagina: 'Cuenta Confirmada',
        mensaje: 'La cuenta se confirmó Correctamente'        
    })

    console.log(usuario) 
}


const formularioOlvidePassword = (req, res) => {
    res.render('auth/olvide-password', {
        pagina: 'Recupera tu acceso a Bienes Raices',
        csrfToken : req.csrfToken()
    })
}

const resetPassword = async (req, res) =>{
    //validación    
    await check('email').isEmail().withMessage('Eso no parece un email').run(req)    
    
    let resultado = validationResult(req)
   
    //Verificar que el resultado esté vacio
    if(!resultado.isEmpty()){
        //errores
        return res.render('auth/olvide-password', {
            pagina: 'Recupera tu acceso a Bienes Raices',
            csrfToken : req.csrfToken(),
            errores: resultado.array()
        })
    }

    //Buscar el usuario

    const { email } = req.body
    const usuario = await Usuario.findOne ({ where : {email}})

    if (!usuario){
        return res.render('auth/olvide-password', {
            pagina: 'Recupera tu acceso a Bienes Raices',
            csrfToken : req.csrfToken(),
            errores: [{msg: 'El Email no pertenece a ningún usuario'}]
        })
    }

    //Generar un token y enviar el email
    usuario.token = generarId();
    await usuario.save();

    //enviar un email
    emailOlvidePassword({
        email: usuario.email,
        nombre: usuario.nombre,
        token: usuario.token
    })

    //Renderizar un mensaje
     res.render('templates/mensaje',{
        pagina: 'Reestablece tu password',
        mensaje: 'Hemos Enviado un Email con las instrucciones'

    })     
}

const comprobarToken = async (req, res) => {
    const { token } = req.params;

    const usuario = await Usuario.findOne({where: {token}})

    if(!usuario) {
        return res.render('auth/confirmarCuenta',{
            pagina: 'Reestablece tu password',
            mensaje: 'Hubo un error al validar tu información, intenta de nuevo',
            error: true        
        })

    }
    
    //Mostrar formulario para modificar el password
    res.render('auth/reset-password',{
        pagina: 'Reestablece tu password',
        csrfToken: req.csrfToken()
    })
}

const nuevoPassword = async(req, res) => {

   //validar el password
   await check('password').isLength({ min: 6 }).withMessage('El Password debe ser de al menos 6 caracteres').run(req)

   let resultado = validationResult(req)
   
    //Verificar que el resultado esté vacio
    if(!resultado.isEmpty()){
        //errores
        return res.render('auth/reset-password', {
            pagina: 'Reestablece tu Password',
            csrfToken : req.csrfToken(),
            errores: resultado.array(), 
            
        })
    }
   
   const { token } = req.params
   const { password } = req.body

   //Identificar quien hace el cambio

   const usuario = await Usuario.findOne({where: {token}})
   console.log(usuario)

   //Hashear el nuevo Password
    const salt = await bcrypt.genSalt(10)
    usuario.password = await bcrypt.hash(usuario.password, salt);
    usuario.token = null;

    await usuario.save();

    res.render('auth/confirmarCuenta', {
        pagina: 'Password Reestablecido',
        mensaje: 'El Password se guardó correctamente'
    })

    
}

export {
    formularioLogin,
    autenticar,
    cerrarSesion,
    formularioRegistro,
    registrar,
    confirmar,
    formularioOlvidePassword,
    resetPassword,
    comprobarToken,
    nuevoPassword   
}