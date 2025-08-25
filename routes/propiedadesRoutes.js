import express from "express"
import { body } from 'express-validator'
import { admin, crear, guardar, agregarImagen, almacenarImagen, editar, guardarCambios, eliminar, cambiarEstado, mostrarPropiedad, enviarMensaje, verMensajes } from '../controllers/propiedadController.js'
import protegerRuta from "../middleware/protegerRuta.js"
import upload from '../middleware/subirImagen.js'
import identificarUsuario from "../middleware/identificarUsuario.js"


const router = express.Router()

router.get('/mis-propiedades', protegerRuta, admin)
router.get('/propiedades/crear', protegerRuta, crear)
router.post('/propiedades/crear', 
    protegerRuta,
    body('titulo').notEmpty().withMessage('El titulo del Anuncio es Obligatorio'),
    body('descripcion')
        .notEmpty().withMessage('La descripcion no puede ir vacía')
        .isLength({ max: 300}).withMessage('La descripción es muy larga'),
    body('categoria').isNumeric().withMessage('Selecciona una Categoría'),
    body('precio').isNumeric().withMessage('Selecciona un rango de Precios'),
    body('habitaciones').isNumeric().withMessage('Selecciona una cantidad de Habitaciones'),
    body('estacionamiento').isNumeric().withMessage('Selecciona una cantidad estacionamientos'),
    body('wc').isNumeric().withMessage('Selecciona una cantidad de Baños'),
    body('lat').isNumeric().withMessage('Ubica la Propiedad en el Mapa'),
    guardar
)

router.get('/propiedades/agregar-imagen/:id', 
    protegerRuta,
    agregarImagen
)

router.post('/propiedades/agregar-imagen/:id',
    protegerRuta,
    upload.single('imagen'), 
    almacenarImagen
)

router.get('/propiedades/editar/:id', 
    protegerRuta,
    editar
)

router.post('/propiedades/editar/:id', 
    protegerRuta,
    body('titulo').notEmpty().withMessage('El titulo del Anuncio es Obligatorio'),
    body('descripcion')
        .notEmpty().withMessage('La descripcion no puede ir vacía')
        .isLength({ max: 300}).withMessage('La descripción es muy larga'),
    body('categoria').isNumeric().withMessage('Selecciona una Categoría'),
    body('precio').isNumeric().withMessage('Selecciona un rango de Precios'),
    body('habitaciones').isNumeric().withMessage('Selecciona una cantidad de Habitaciones'),
    body('estacionamiento').isNumeric().withMessage('Selecciona una cantidad estacionamientos'),
    body('wc').isNumeric().withMessage('Selecciona una cantidad de Baños'),
    body('lat').isNumeric().withMessage('Ubica la Propiedad en el Mapa'),
    guardarCambios
)

router.post('/propiedades/eliminar/:id',
    protegerRuta,
    eliminar    
) 

router.put('/propiedades/:id',
    protegerRuta,
    cambiarEstado
)

//Area Pública

router.get('/propiedad/:id',
    identificarUsuario,
    mostrarPropiedad

)

//Almacenar los mensajes

router.post('/propiedad/:id',
    identificarUsuario,
    body('mensaje').isLength({min: 10}).withMessage('El Mensaje no puede ir vacio o es muy corto'),
    enviarMensaje

)

router.get('/mensajes/:id',
    protegerRuta,
    verMensajes
)


export default router