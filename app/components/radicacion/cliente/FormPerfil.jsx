'use client'

import ListaSelect from "../../share/ListaSelect";
import InputClientPerfil from "./InputClientPerfil";
import { conversionPesos, formatearValor, validarNumeroInputText } from "@/app/lib/utils";
import { usePerfil } from "@/app/hooks/usePerfil";
import { useEffect, useRef, useState } from "react";
import { fnHomologarOficinas } from "@/app/lib/services/homologaciones/actions";
import Loading from "@/app/components/share/Loading";
import dynamic from 'next/dynamic';

const DynamicModal = dynamic(() => import('@/app/components/share/Modals'));

export default function FormPerfil({
    rolActivo,
    regionals,
    oficinas,
    vinculo,
    tipoContrato,
    listTipoClient,
    sectors,
    estadoBanco,
    listEstadoCoomeva,
    asociadoCoomeva,
    estadoCliente
}) {

    const [mostrarModal, setMostrarModal] = useState(false);
    const [messageModal, setMessageModal] = useState('');
    const [loading, setLoading] = useState(false);

    const { cliente, updateDataCliente, editar, estadoSolicitud } = usePerfil();
    const [antigueda, setAntigueda] = useState(false);
    const [listaOficinas, setListaOficinas] = useState(oficinas);
    const habilitarInput = (rolActivo !== '' && rolActivo !== 'Radicación') || (rolActivo !== '' && rolActivo === 'Radicación') && (estadoSolicitud !== '' && estadoSolicitud !== 3);

    const inputRef = useRef(null);


    useEffect(() => {
        if (inputRef.current) {
            (cliente?.nuevoCliente == true || editar == true) && inputRef.current.focus(); // Asigna el enfoque cuando el componente se monta
        }
    }, [cliente?.nuevoCliente, editar]);

    useEffect(() => {
        setAntigueda(false)
    }, [cliente])

    const onChangeAsociado = (e) => {
        const nombreCampo = e.target.id.split('.')[1];
        const value = parseInt(e.target.value);

        updateDataCliente(prev => ({
            ...prev,
            [nombreCampo]: value,
            antiguedad_coo: value !== 1 ? '0' : prev.antiguedad_coo || ''
        }));

        setAntigueda(value !== 1);
    };


    const onChangeAsingarValor = async (e) => {

        const { id, value } = e.target;
        const nombreCampo = (id).split('.')[1];

        let oficinaTaylor;

        if (nombreCampo === 'oficina') {
            oficinaTaylor = await homologarOficina(value);
        };

        updateDataCliente(prev => ({
            ...prev,
            [nombreCampo]:
                nombreCampo === 'activos' ||
                    nombreCampo === 'ingreso' ||
                    nombreCampo === 'ventas_an'
                    ? formatearValor({ valor: value })
                    : value,
            ...(nombreCampo === 'oficina' && { oficinaTaylor })
        }));

    };


    const homologarOficina = async (oficinaCobis) => {
        setLoading(true);
        try {
            const oficinaHomologada = JSON.parse(await fnHomologarOficinas(JSON.stringify({ oficina: oficinaCobis })));
            if (+oficinaHomologada.status === 500) {
                throw (oficinaHomologada);
            };
            return oficinaHomologada.data.data.Record.OFICINA_TAYLOR;

        } catch (err) {
            console.log(err);
            setMessageModal(`No fue posible homologar la oficina n° ${err.oficinaError}, errorCode: ${err.errorCode}`);
            setMostrarModal(!mostrarModal);
        } finally {
            setLoading(false);
        };
    };


    const cerrarModal = () => {
        setMostrarModal(!mostrarModal);
    };

    return (
        <form id='frmPerfil' className='flex justify-around w-full'
            key={cliente?.cliente || 'empty'}
        >
            <div className='w-full'>
                <InputClientPerfil
                    descripcion={"Cliente"}
                    id={"idCliente"}
                    name={'cliente'}
                    bgFila={1}
                    value={cliente?.cliente || ''}
                    inhabilitarInput={(cliente?.cliente && cliente?.nuevoCliente !== true && editar !== true) || habilitarInput}
                    nuevoCliente={cliente?.nuevoCliente || cliente?.cliente}
                    onChangeInput={onChangeAsingarValor}
                    inputRef={inputRef}
                />
                <ListaSelect
                    descripcion={"Regional"}
                    classTitle={"text-coomeva_color-rojo ml-4 text-sm w-[25%] font-bold"}
                    id={"code"}
                    valor={'value'}
                    name={'regional'}
                    color={1}
                    lista={regionals}
                    onchangeSelect={onChangeAsingarValor}
                    defaultValue={cliente?.regional}
                    inhabilitarSelect={(cliente?.regional && cliente.nuevoCliente !== true && editar !== true) || habilitarInput}
                    mostrarLista={cliente?.regional || cliente?.nuevoCliente}
                />
                <ListaSelect
                    descripcion={"Coomeva"}
                    classTitle={"text-coomeva_color-rojo ml-4  w-[25%]  text-sm font-bold"}
                    id={"code"}
                    valor={"value"}
                    name={'coomeva'}
                    lista={asociadoCoomeva}
                    onchangeSelect={onChangeAsociado}
                    inhabilitarSelect={(cliente?.coomeva && cliente.nuevoCliente !== true && editar !== true) || habilitarInput}
                    defaultValue={cliente?.coomeva}
                    mostrarLista={cliente?.coomeva || cliente?.nuevoCliente || editar === true}
                />
                <InputClientPerfil
                    descripcion={"Antigüedad Coomeva (meses)"}
                    id={"idAntiguedad_coo"}
                    name={"antiguedad_coo"}
                    value={cliente?.antiguedad_coo || ''}
                    inhabilitarInput={(cliente?.antiguedad_coo && cliente?.nuevoCliente !== true && editar !== true || antigueda == true) || habilitarInput}
                    onChangeInput={onChangeAsingarValor}
                    nuevoCliente={cliente?.nuevoCliente || cliente?.cliente}
                />
                <ListaSelect
                    descripcion={"Estado Coomeva"}
                    classTitle={"text-coomeva_color-rojo ml-4  w-[25%] text-sm font-bold"}
                    id={"COD_ESTADO_ASO"}
                    valor={"ESTADO_ASO"}
                    name={'estado_coo'}
                    lista={listEstadoCoomeva}
                    onchangeSelect={onChangeAsingarValor}
                    inhabilitarSelect={(cliente?.estado_coo && cliente.nuevoCliente !== true && editar !== true) || habilitarInput}
                    defaultValue={cliente?.estado_coo}
                    mostrarLista={cliente?.estado_coo || cliente?.nuevoCliente || editar === true}
                />
                <ListaSelect
                    descripcion={"Tipo Contrato"}
                    classTitle={"text-coomeva_color-rojo ml-4  w-[25%] text-sm font-bold"}
                    id={"COD_TIP_CONTRATO"}
                    valor={'TIPO_CONTRATO'}
                    name={'tipo_contrato'}
                    color={1}
                    lista={tipoContrato}
                    onchangeSelect={onChangeAsingarValor}
                    inhabilitarSelect={(cliente?.tipo_contrato && cliente.nuevoCliente !== true && editar !== true) || habilitarInput}
                    defaultValue={cliente?.tipo_contrato}
                    mostrarLista={cliente?.nuevoCliente || cliente?.tipo_contrato}
                />
                <InputClientPerfil
                    descripcion={"Ventas anuales"}
                    classTitle={"text-coomeva_color-rojo ml-4  w-[25%] text-sm font-bold"}
                    id={"idventas_an"}
                    name={"ventas_an"}
                    bgFila={1}
                    value={cliente?.ventas_an ? cliente?.ventas_an !== '' ? conversionPesos({ valor: formatearValor({ valor: cliente?.ventas_an }) }) : '' : ''}
                    inhabilitarInput={(cliente?.ventas_an && cliente.nuevoCliente !== true && editar !== true) || habilitarInput}
                    onChangeInput={onChangeAsingarValor}
                    onChangeValidacion={(e) => { validarNumeroInputText(e) }}
                    nuevoCliente={cliente?.nuevoCliente || cliente?.cliente}
                    activarFocus={true}
                    valContext={cliente?.ventas_an}
                />
                <ListaSelect
                    descripcion={"Sector"}
                    classTitle={"text-coomeva_color-rojo ml-4  w-[25%] text-sm font-bold"}
                    id={"code"}
                    valor={'value'}
                    name={'sector'}
                    color={1}
                    lista={sectors}
                    onchangeSelect={onChangeAsingarValor}
                    inhabilitarSelect={(cliente?.sector && cliente.nuevoCliente !== true && editar !== true) || habilitarInput}
                    defaultValue={cliente?.sector}
                    mostrarLista={cliente?.nuevoCliente || cliente?.sector}
                />
            </div>
            <div className='w-full'>
                <ListaSelect
                    descripcion={"Tipo Cliente"}
                    classTitle={"text-coomeva_color-rojo ml-4 text-sm font-bold"}
                    id={"TIPOCLI"}
                    valor={"TIPOCLI"}
                    name={'tipoPersona'}
                    lista={listTipoClient}
                    onchangeSelect={onChangeAsingarValor}
                    inhabilitarSelect={(cliente?.customerType) || habilitarInput}
                    defaultValue={cliente?.customerType ? cliente?.customerType === 'PJ' ? 'PJ' : cliente?.customerType : '' || cliente?.nuevoCliente}
                    mostrarLista={cliente?.customerType}
                />
                <ListaSelect
                    descripcion={"Oficina"}
                    classTitle={"text-coomeva_color-rojo ml-4 text-sm font-bold"}
                    id={"code"}
                    valor={"value"}
                    color={1}
                    name={'oficina'}
                    lista={listaOficinas}
                    onchangeSelect={onChangeAsingarValor}
                    inhabilitarSelect={(cliente?.oficina && cliente.nuevoCliente !== true && editar !== true) || habilitarInput}
                    defaultValue={cliente?.oficina}
                    mostrarLista={cliente?.nuevoCliente || cliente?.oficina}
                />
                <ListaSelect
                    descripcion={"Vinculado"}
                    classTitle={"text-coomeva_color-rojo ml-4 text-sm font-bold"}
                    id={"codLista"}
                    valor={"descripcion"}
                    name={'vinculado'}
                    lista={vinculo}
                    onchangeSelect={onChangeAsingarValor}
                    inhabilitarSelect={((cliente?.vinculado == 1 || cliente?.vinculado == 0) && cliente.nuevoCliente !== true && editar !== true) || habilitarInput}
                    defaultValue={cliente?.vinculado + ''}
                    mostrarLista={((cliente?.vinculado == 1 || cliente?.vinculado == 0) || cliente?.nuevoCliente || editar === true)}
                />
                <InputClientPerfil
                    descripcion={"Antigüedad banco"}
                    id={"idAntiguedad_ban"}
                    name={"antiguedad_ban"}
                    value={cliente?.antiguedad_ban || ''}
                    inhabilitarInput={(cliente?.antiguedad_ban && cliente.nuevoCliente !== true && editar !== true) || habilitarInput}
                    nuevoCliente={cliente?.nuevoCliente || cliente?.cliente}
                    onChangeInput={onChangeAsingarValor}
                    onChangeValidacion={(e) => { validarNumeroInputText(e) }}
                />
                <ListaSelect
                    descripcion={"Estado Banco"}
                    classTitle={"text-coomeva_color-rojo ml-4 text-sm font-bold"}
                    id={"COD_ESTADO_BCO"}
                    valor={"ESTADO_BCO"}
                    name={'estado_ban'}
                    lista={estadoBanco}
                    onchangeSelect={onChangeAsingarValor}
                    inhabilitarSelect={(cliente?.estado_ban && cliente.nuevoCliente !== true && editar !== true) || habilitarInput}
                    defaultValue={cliente?.estado_ban}
                    mostrarLista={cliente?.estado_ban || cliente?.nuevoCliente || editar === true}
                />
                <InputClientPerfil
                    descripcion={"Ingreso Mensual"}
                    id={"idIngreso"}
                    name={"ingreso"}
                    value={cliente?.ingreso ? cliente?.ingreso !== '' ? conversionPesos({ valor: formatearValor({ valor: cliente?.ingreso }) }) : '' : ''}
                    inhabilitarInput={(cliente?.ingreso && cliente.nuevoCliente !== true && editar !== true) || habilitarInput}
                    nuevoCliente={cliente?.nuevoCliente || cliente?.cliente}
                    onChangeInput={onChangeAsingarValor}
                    onChangeValidacion={(e) => { validarNumeroInputText(e) }}
                    activarFocus={true}
                    valContext={cliente?.ingreso}
                />
                <InputClientPerfil
                    descripcion={"Activos"}
                    id={"idActivos"}
                    name={"activos"}
                    bgFila={1}
                    value={cliente?.activos ? cliente?.activos !== '' ? conversionPesos({ valor: formatearValor({ valor: cliente?.activos }) }) : '' : ''}
                    inhabilitarInput={(cliente?.activos && cliente.nuevoCliente !== true && editar !== true) || habilitarInput}
                    nuevoCliente={cliente?.nuevoCliente || cliente?.cliente}
                    onChangeInput={onChangeAsingarValor}
                    onChangeValidacion={(e) => { validarNumeroInputText(e) }}
                    activarFocus={true}
                    valContext={cliente?.activos}
                />
                <InputClientPerfil
                    descripcion={"Score"}
                    id={"score"}
                    value={''}
                    inhabilitarInput={false}
                    activarFocus={true}
                    onChangeInput={() => { }}
                />
            </div>
            {
                (mostrarModal)
                &&
                <DynamicModal titulo={'Notificación'} textBtnContinuar="Ok" ocultarBtnCancelar={true} mostrarImagneFondo={true} mostrarModal={cerrarModal}>
                    <p className="w-full text-sm text-center text-[#002e49f3] font-semibold">{messageModal}</p>
                </DynamicModal>
            }
            {
                loading && <Loading />
            }
        </form>
    )
}