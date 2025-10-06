'use client'
import { DataContext } from "@/app/provider/Providers"
import { useContext, useEffect, useState } from "react"
import BtnControl from "./BtnControl"

const ControlBotonesCliente = () => {

    const { cliente, updateEditarPerfil, editar, updateRutaActual, updateRutaAnterior } = useContext(DataContext)

    const [habilitarBtnSolcitud, setHabilitarBtnSolcitud] = useState(false)

    useEffect(() => {


        const validarCampos = (cliente.regional !== undefined && cliente.regional !== '' && cliente?.regional !== 'default' && cliente?.regional !== 'Seleccionar')
            && (cliente.oficina !== undefined && cliente.oficina !== '' && cliente?.oficina !== 'default' && cliente?.oficina !== 'Seleccionar')
            && (cliente.coomeva !== undefined && cliente.coomeva !== '' && cliente?.coomeva !== 'default' && cliente?.coomeva !== 'Seleccionar' && cliente?.coomeva !== NaN)
            && (cliente.vinculado !== undefined && cliente.vinculado !== '' && cliente?.vinculado !== 'default' && cliente?.vinculado !== 'Seleccionar' && cliente?.vinculado !== NaN)
            && (cliente.estado_coo !== undefined && cliente.estado_coo !== '' && cliente?.estado_coo !== 'default' && cliente?.estado_coo !== 'Seleccionar' && cliente?.estado_coo !== NaN)
            && (cliente.estado_ban !== undefined && cliente.estado_ban !== '' && cliente?.estado_ban !== 'default' && cliente?.estado_ban !== 'Seleccionar' && cliente?.estado_ban !== NaN)
            && (cliente.sector !== undefined && cliente.sector !== '' && cliente?.sector !== 'default' && cliente?.sector !== 'Seleccionar' && cliente?.sector !== NaN)
            && (cliente.tipo_contrato !== undefined && cliente.tipo_contrato !== '' && cliente?.tipo_contrato !== 'default' && cliente?.tipo_contrato !== 'Seleccionar' && cliente?.tipo_contrato !== NaN)
            && (cliente.cliente !== undefined && cliente.cliente !== '')
            && (cliente.antiguedad_coo !== undefined && cliente.antiguedad_coo !== '')
            && (cliente.antiguedad_ban !== undefined && cliente.antiguedad_ban !== '')
            && (cliente.activos !== undefined && cliente.activos !== '')
            && (cliente.ingreso !== undefined && cliente.ingreso !== '')
            && (cliente.ventas_an !== undefined && cliente.ventas_an !== '')
        setHabilitarBtnSolcitud(validarCampos)

    }, [cliente])

    // listas



    // {
    //     tipoPersona: 'PJ',
    //     nuevoCliente: true,
    //     numDocumento: '243243',
    //     regional: '1',
    //     nombreRegional: 'Cali',
    //     cliente: 'lojani',
    //     oficina: '101',
    //     coomeva: 1,
    //     antiguedad_coo: '0',
    //     vinculado: '1',
    //     estado_coo: '23',
    //     estado_ban: '20',
    //     ingreso: '43232432',
    //     activos: '243243243',
    //     sector: '31',
    //     ventas_an: '43243',
    //     tipo_contrato: '3'
    //   }








    let habilitarBotonSolicitud =
        (cliente?.cliente &&

            /* cliente?.ventas_an &&
            cliente?.antiguedad_ban &&
            cliente?.ingreso && */
            cliente?.activos) &&
        (
            cliente?.cliente !== '' &&

            /* cliente?.ventas_an !== '' &&
            cliente?.antiguedad_ban !== '' &&
            cliente?.ingreso !== '' && */
            cliente?.activos !== ''
        ) &&


        // inputs
        (cliente?.regional &&
            cliente?.coomeva &&
            cliente?.estado_coo &&
            cliente?.tipo_contrato &&
            cliente?.sector &&
            cliente?.tipoPersona &&
            cliente?.oficina &&
            cliente?.vinculado &&
            cliente?.estado_ban
        ) &&


        (
            cliente?.regional !== '' && cliente?.regional !== 'default' &&
            cliente?.coomeva !== '' && cliente?.coomeva !== 'default' &&
            cliente?.estado_coo !== '' && cliente?.estado_coo !== 'default' &&
            cliente?.tipo_contrato !== '' && cliente?.tipo_contrato !== 'default' &&
            cliente?.sector !== '' && cliente?.sector !== 'default' &&
            cliente?.tipoPersona !== '' && cliente?.tipoPersona !== 'default' &&
            cliente?.oficina !== ' ' && cliente?.oficina !== 'default' &&
            cliente?.vinculado !== '' && cliente?.vinculado !== 'default' &&
            cliente?.estado_ban !== '' && cliente?.estado_ban !== "default"
        )



    const editarPerfil = () => {
        if (habilitarBotonSolicitud || cliente.editar) {
            updateEditarPerfil(true)
        }
    }


    /**
     * funcion para validar que todos los campos esten digitados o seleccionado
     * evitar continuar si no estan los campos completos
     */
    const validarCamposVaciosPerfil = () => {

        const inputCliente = document.getElementById(`idCliente.cliente`)

        alert(inputCliente.value)

    }


    return (
        <>
            <BtnControl
                name={"Editar"}
                // url={'/radicacion/solicitud'}
                enableButton={(cliente?.editar)}
                editarPerfil={true}
                editarCliente={editarPerfil}
                opcion={'editar'}


            />
            <BtnControl
                name={"Consultar Solicitudes"}
                url={'/radicacion/bandejaSolicitudes'}
                enableButton={true}
                opcion={'navegar'}
                updateRutaActual={updateRutaActual}
                updateRutaAnterior={updateRutaAnterior}
            />
            <BtnControl
                name={"Iniciar Solicitud"}
                url={'/radicacion/solicitud'}
                enableButton={habilitarBtnSolcitud}
                opcion={'navegar'}
                cliente={cliente}
                updateRutaActual={updateRutaActual}
                updateRutaAnterior={updateRutaAnterior}

            />
        </>
    )
}

export default ControlBotonesCliente