

export const rolUsuario = { 'radicador': false, 'aprobador': true, 'parametrizador': true }

/**opciones pestañas */
export const Tabs = [
    {
        name: 'Crédito Nuevo',
        href: '/radicacion/convenioServicios/creditoNuevo',
        tab: 'credito'
    },
    {
        name: 'Convenio de Pago',
        href: '/radicacion/convenioServicios',
        tab: 'convenioPago'
    },
    {
        name: 'Convenio de Recaudo',
        href: '/radicacion/convenioServicios/convenioRecaudo',
        tab: 'convenioRecaudo'
    },
    {
        name: 'Servicios Financieros',
        href: '/radicacion/convenioServicios/servicioFinanciero',
        tab: 'servicioFinanciero'
    }
]



export const listCoberturaFNG = [
    {
        id: 1,
        value: 0,
        descripcion: '0%'
    },
    {
        id: 2,
        value: 10,
        descripcion: '10%'
    },
    {
        id: 3,
        value:20,
        descripcion: '20%'
    },{
        id: 4,
        value:30,
        descripcion: '30%'
    },{
        id: 5,
        value:40,
        descripcion: '40%'
    },{
        id: 6,
        value:50,
        descripcion: '50%'
    },{
        id: 7,
        value:60,
        descripcion: '60%'
    },{
        id: 8,
        value:70,
        descripcion: '70%'
    },{
        id: 9,
        value:80,
        descripcion: '80%'
    },{
        id: 10,
        value:90,
        descripcion: '90%'
    },{
        id: 11,
        value:100,
        descripcion: '100%'
    },
]

export const listEntidadRedescueto = [
    {
        id: 1,
        value:'Bancoldex',
        descripcion: 'Bancoldex'
    },
    {
        id: 2,
        value:'Findeter',
        descripcion: 'Findeter'
    },
    {
        id: 3,
        value:'Finagro',
        descripcion: 'Finagro'
    },
]

export const validarNumeroDocumento = (e) => {

    const numero = /^\d+$/.test(e.target.value)
    if (!numero) {
        document.getElementById(e.target.id).value = (e.target.value).slice(0, -1)
    }
}

export const transformarCantidadPesos = ({ cantidad, decimales = 1, signo, campo }) => {

    const valor = parseFloat(cantidad);

    if (!isNaN(valor)) {
        if (valor == 0) {
            return ''
        }
        if (signo === 'COP') {
            const factor = 10 ** decimales;
            cantidad = Math.round(cantidad * factor) / factor;
            const valFormateado = new Intl.NumberFormat('es-CO', {
                style: 'currency',
                currency: 'COP',
                minimumFractionDigits: decimales,
                maximumFractionDigits: decimales,
            }).format(cantidad);

            return valFormateado

        } else if (signo === '%') {
            return valor + '%';
        }
    };

    return cantidad == 0 ? '' : cantidad
};


export const dataFormularioOrdenada = ({ formularioRef, seccion }) => {

    const formValues = {};
    const objectoOrdenado = {};

    formularioRef.forEach((value, key) => {
        const fila = key.match(/\d+/g); // Obtenemos el último carácter que identifica la fila del registro 
        const nuevaLlave = key.replace(`${seccion}`, '').replace('hidden', '').replace(/\d+/g, '');  //quitar oficina y hidden de la llave del objecto

        formValues[nuevaLlave] = value;

        if (!objectoOrdenado[fila]) {
            objectoOrdenado[fila] = {};
        }

        objectoOrdenado[fila][nuevaLlave] = value === "Seleccionar" ? '' : value;
    });

    return Object.values(objectoOrdenado);
};


export const transformaValorPesos = (valor, numDecimales, signo) => {

    if (signo !== '%') {
        const valorNumerico = parseFloat(valor.replace(',0', '').replace(/[^\d]/g, ''));

        if (!isNaN(valorNumerico)) {
            const valorConDecimales = Number.parseFloat(valorNumerico.toFixed(numDecimales));
            const valorFormateado = new Intl.NumberFormat('es-CO', {
                style: 'currency',
                currency: 'COP',
                minimumFractionDigits: numDecimales,
                maximumFractionDigits: numDecimales,
            }).format(valorConDecimales);

            return valorFormateado
        }
    }

    return valor !== '' ? valor + ',00%' : ''
};


export const transformarValorPuntoDecimal = ({ valor, cantidadDecimales, quitarPunto }) => {

    if (valor !== null && valor !== undefined) {
        valor = quitarPunto && valor !== '' ? valor.toString().split('.') : valor
        if (valor !== '') {
            valor = valor?.toString().split(',')
            valor = valor !== '' ? valor[0]?.split(/\D+/).join("") : valor
            return `${valor.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".")}${cantidadDecimales}`;
        }

        return valor
    }

    return ''
};


export const formatearValor = ({ valor = '' }) => {

    valor = valor.toString();
    valor = valor.split(',')
    valor = valor[0].split(/\D+/).join("")

    return valor
};


/** insertarParmetroUrl pasar parametro por la  url **/
export const insertarParametroUrl = ({ searchParams, nombreParametro, valorParametro, replace, pathName, affectRow = 0, nombreParamsRow = 'n' }) => {
    const params = new URLSearchParams(searchParams);
    params.set(`${nombreParametro}`, `${valorParametro}`);
    params.set(`${nombreParamsRow}`, affectRow);
    replace(`${pathName}?${params.toString()}`)
};


/** transformaDataGuardarDB funciona para transfroma los formData 
 * en array de array para guardar en la bases de datos INSERT,UPDATE **/

export const transformaDataGuardarDB = ({ formData, paramEfecty }) => {
    const ordenarData = {};
    formData.forEach((value, key) => {
        if (!ordenarData[key]) {
            ordenarData[key] = [];
        }
        ordenarData[key].push(paramEfecty ? value : formatearValor({ valor: value }));
    });

    return JSON.stringify(Object.values(ordenarData));
};


export const transformDataGuardarDBNombre = ({ formData, campoCondicion }) => {

    let ordenarData = {}
    let con = 0; // Variable para identificar la primera iteración

    formData.forEach((value, key) => {
        if (!ordenarData[key]) {
            con = 0
            ordenarData[key] = [];
        }

        con === campoCondicion ? ordenarData[key].push(value) : ordenarData[key].push(formatearValor({ valor: value }));
        con++
    });

    return Object.values(ordenarData)
};


/** Validar que solo se ingrese numero **/
export const validarNumeroInputText = (e) => {

    const numero = /^\d+$/.test(e.target.value)

    if (!numero && e.target.value !== '') {
        document.getElementById(e.target.id).value = e.target.value.length > 1 ? (e.target.value).slice(0, -1) : ''
    }
};


/*** Conversores de pesos colombiana - reset **/
export const conversionPesos = ({ valor, nDecimales = 0, style = "currency" }) => {

    const objetPropidad = (style !== 'currency')
        ? {
            style: style,
            minimumFractionDigits: nDecimales,
        }
        : {
            style: style,
            currency: "COP",
            minimumFractionDigits: nDecimales,
        }

    return Number(style !== 'currency' ? (valor / 100) : valor).toLocaleString("es-CO", objetPropidad)
};

export const separarMiles = ({ valor }) => {

    const objetPropidad = {
        style: 'decimal',
        minimumFractionDigits: 0,
        maximumFractionDigits: 0,

    };

    return Number(valor).toLocaleString("es-CO", objetPropidad)
};


export const resetearPesos = ({ valor }) => {

    return valor.toLocaleString("es-CO", {
        minimumFractionDigits: 0,
        maximumFractionDigits: 0,
    })
};


export const limpiarContext = ({ context, resetDocuemnt }) => {

    const { updateEvaluar,
        updateEditarPerfil,
        updateCodigoSolictud,
        updateTecnicoOperador,
        updateConfiguracion,
        updateDepositoVista,
        updateServicioFinanciero,
        updateDataRemi,
        updateConvenioRecaudo,
        updateDataSolciitud,
        updateConvenioPago,
        updateDataCliente,
        updateEstadoSolicitud,
        updateCreditoNuevo,
      
        updateReciprocidadResumen,
        updateResumenMotor,
        updateClienteFiducia,
        updateCampoAdicionalesModal,
        updateHistorialPath,
        updateClientModal, updateStatusCorreo,
        updateIsDocumentos, updateIdSolictudDb,
        updateAprobacionParametrizacion,
        habilitarBotoAprobarSolicitud, updateDocumentoCliente,
        updateObservacion
    } = context


    updateHistorialPath(true)

    resetDocuemnt && updateDocumentoCliente('')


    updateDataCliente({ editar: false })
    // updateEditarPerfil(false)

    updateDataSolciitud({});

    // convenio Pago
    updateConvenioPago(undefined, {
        convenioPagoNominaTipo: {},
        convenioPagoTerceros: [],
        convenioPagoNominaNegociada: [],
    });
    // convenio Recaudo
    updateConvenioRecaudo(undefined, {
        recaudoOficina: [],
        recaudoPSE: [],
        recaudoCorresponsales: [],
        adquirencia: [],
        gastosPse: [],
        gastoasOficina: [],
        redes: {
            credibanVp: '0',
            redebanVp: '0',
            credibancoVnp: '0',
            redebanVnp: '0',
            redebanMicropagos: '0',
            credibancoVendig: '0',
            credibancoTrMasivo: '0',
            total: '0'
        }
    });
    // convenio Financiero
    updateServicioFinanciero(undefined, {
        solicitud: [],
        tipoConvenio: "",
    });
    // depositoVista
    updateDepositoVista(undefined, {
        tipoCuenta: "",
        planRemuracion: {
            planRem: "",
            monto: "",
            tasa: "",
        },
        cuentasPlan: [],
    });
    // configuracion
    // TODO CARGAR DATA DE LA SOLICITUD
    updateCreditoNuevo([]);

    // alert('llamaste navegar')
    //acutalizar el estado solicitud
    updateEstadoSolicitud("");

    updateReciprocidadResumen({
        ahorro: {},
        corriente: {},
        resultadoResumenMotor: {},
    });

    updateDataRemi([]);

    // updateDataCliente({});

    updateClienteFiducia();

    updateTecnicoOperador({});

    updateCampoAdicionalesModal({});

    updateClientModal({});

    updateConfiguracion("adquirencia", "infoTriburaria", []);
    updateConfiguracion("adquirencia", "infoComercio", {});
    updateConfiguracion("adquirencia", "tipoVenta", {});
    updateConfiguracion("adquirencia", "tipoCuenta1", []);
 

    updateConfiguracion("convenioRecaudo", "recaudoFormato", {});
    updateConfiguracion("convenioRecaudo", "recaudoManuales1", []);
    updateConfiguracion("convenioRecaudo", "recaudoSiNo", "");
    updateConfiguracion("convenioRecaudo", "cuentaRecaudodora", []);
    updateConfiguracion("convenioRecaudo", "modeloPago", {});
    updateConfiguracion("convenioRecaudo", "recuadoClasePago", {});
    updateConfiguracion("convenioRecaudo", "recaudoRespaldo", {});

    updateConfiguracion("corresponsales", "tipoRecuado", {});
    updateConfiguracion("corresponsales", "BaseWebTicket", {});
    // updateConfiguracion("corresponsales", "tipoCuenta", []);
    updateConfiguracion("corresponsales", "recuadoManual", []);
    updateConfiguracion("corresponsales", "cuentaRecaudadoraEan", []);
    updateConfiguracion("corresponsales", "modeloPago", {});

    updateConfiguracion("convenioPago", "cuentaRecaudadora1", []);
    updateConfiguracion("convenioPago", "cuentaRecaudadora2", []);
    updateEditarPerfil(false);
    updateResumenMotor({});
    updateCodigoSolictud('')
    updateStatusCorreo(false)
    updateIsDocumentos({
        cedula: false,
        rut: false,
        certificado: false,
        formato: false,
        contrato: false
    })
    updateIdSolictudDb('')
    updateAprobacionParametrizacion({})
    updateEvaluar(false)
    habilitarBotoAprobarSolicitud(false)

    updateObservacion('')


};



export const validarNavegacionAtras = ({ evaluar, updateHistorialPath }) => {

    evaluar && updateHistorialPath(false)

}

export const infoTabs = {
    'convenioPago': {
        urlImage: 'cabecera1',
        title: 'CONVENIOS',
        subtitle: 'y servicos',
        enableInput: { "input3": true, "input1": true, "input2": true },
        convenioNegociar: "Pago",
        tipoConv: 'Nuevo'
    },
    'convenioRecaudo': {
        urlImage: 'cabecera1',
        title: 'CONVENIOS',
        subtitle: 'y servicos',
        enableInput: { "input3": true, "input1": true, "input2": true },
        convenioNegociar: "Recaudo",
        tipoConv: 'Nuevo'
    }, 'servicioFinanciero': {
        urlImage: 'cabecera1',
        title: 'CONVENIOS',
        subtitle: 'y servicos',
        enableInput: { "input3": true, "input1": true, "input2": true },
        convenioNegociar: "Servicio Financiero",
        tipoConv: 'Nuevo'
    }, 'credito': {
        urlImage: 'cabecera1',
        title: 'Créditos, Convenios',
        subtitle: 'y servicos',
        enableInput: { "input3": true, "input1": true, "input2": true },
        convenioNegociar: "Crédito",
        tipoConv: 'Nuevo'
    }
}


export const validarNumeros = (e) => {

    const numero = /^\d+$/.test(e.target.value)

    if (!numero && e.target.value !== '') {
        document.getElementById(e.target?.id).value = e.target.value.length > 1 ? (e.target.value).slice(0, -1) : ''
        return
    }

}

export const validarTexto = (e) => {

    const soloLetras = /^[a-zA-Z ]*$/.test(e.target.value);

    if (!soloLetras && e.target.value !== '') {
        document.getElementById(e.target.id).value =
            e.target.value.length > 1 ? e.target.value.slice(0, -1) : '';
        return;
    }
};

export const sumarDiasFechaIncial= (fecha, dias) =>{


 const partes = fecha.split("/");

    const dia = parseInt(partes[0], 10);

    const mes = parseInt(partes[1], 10) - 1; 

    const anio = partes[2].length === 2 ? parseInt(partes[2], 10) + 2000 : parseInt(partes[2], 10); 

    const fechaInicial = new Date(anio, mes, dia);

    fechaInicial.setDate(fechaInicial.getDate() + dias);

    const diaResultante = String(fechaInicial.getDate()).padStart(2, '0');

    const mesResultante = String(fechaInicial.getMonth() + 1).padStart(2, '0');
    
    const anioResultante = String(fechaInicial.getFullYear());

    return `${diaResultante}/${mesResultante}/${anioResultante}`;
}







