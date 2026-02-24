'use client'

import { DataContext } from "@/app/provider/Providers";
import { useContext, useEffect, useState } from "react";
import BtnControl from "./BtnControl";

const ControlBotonesCliente = () => {

    const { cliente, updateEditarPerfil, editar, updateRutaActual, updateRutaAnterior } = useContext(DataContext);
    const [habilitarBtnSolcitud, setHabilitarBtnSolcitud] = useState(false);

    const isValidSelect = (value) =>
        value !== undefined &&
        value !== null &&
        value !== '' &&
        value !== 'default' &&
        value !== '0' &&
        value !== 'Seleccionar';

    const isValidNumber = (value) =>
        value !== undefined &&
        value !== '' &&
        !Number.isNaN(value);

    const isValidText = (value) =>
        typeof value === 'string' && value.trim() !== '';

    useEffect(() => {
        const validarCampos =
            isValidSelect(cliente.regional) &&
            isValidSelect(cliente.oficina) &&
            //isValidSelect(cliente.coomeva) &&
            isValidSelect(cliente.vinculado) &&
            isValidSelect(cliente.estado_coo) &&
            isValidSelect(cliente.estado_ban) &&
            isValidSelect(cliente.sector) &&
            isValidSelect(cliente.tipo_contrato) &&
            isValidSelect(cliente.customerType) &&
            isValidText(cliente.cliente) &&
            isValidNumber(cliente.antiguedad_coo) &&
            isValidNumber(cliente.antiguedad_ban) &&
            isValidNumber(cliente.activos) &&
            isValidNumber(cliente.ingreso) &&
            isValidNumber(cliente.ventas_an);

        setHabilitarBtnSolcitud(validarCampos)
    }, [cliente]);


    const editarPerfil = () => {
        if (habilitarBtnSolcitud || cliente?.editar) {
            updateEditarPerfil(true)
        }
    };


    return (
        <>
            <BtnControl
                name={"Editar"}
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
};

export default ControlBotonesCliente;