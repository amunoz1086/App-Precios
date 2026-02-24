'use client'

import { useState } from "react";
import { usePerfil } from "@/app/hooks/usePerfil";
import { queryCuentas } from "@/app/lib/services/cobis/fn_queryCuentas";
import Loading from "@/app/components/share/Loading";

const headTable = ["Tipo de Cuenta", "Número Cuenta Recaudadora", "EAN"];
const bodyTable = [
    { id: 1, tipoCuenta: "", numCuenta: "", eanr: '', codCuenta: "", cuentasDisponibles: [] },
    { id: 2, tipoCuenta: "", numCuenta: "", eanr: '', codCuenta: "", cuentasDisponibles: [] },
    { id: 3, tipoCuenta: "", numCuenta: "", eanr: '', codCuenta: "", cuentasDisponibles: [] },
];


export default function CuentaRecaudadoraEanRecaudo({
    listTipoCuenta,
    habilitarInput,
    updateConfiguracion,
    configuracion
}) {

    // Datos del Cliente
    const { cliente } = usePerfil();
    const [loading, setLoading] = useState(false);

    const infoContext = configuracion['convenioRecaudo']['cuentaRecaudodora'];
    const [filas, setFilas] = useState(
        infoContext.length > 0
            ? infoContext.map(f => ({ ...f, cuentasDisponibles: f.cuentasDisponibles || [] }))
            : [...bodyTable]);

    const handleInputChange = (e, campo, valor, filaIndex) => {
        let nCuenta = '';

        if (campo !== 'eanr') {
            const elementSelect = e.target;
            const optionSelect = elementSelect.options[elementSelect.selectedIndex];
            nCuenta = optionSelect?.dataset?.ncuenta;
        }

        const newList = filas.map((row, index) => {
            if (index === filaIndex) {
                return {
                    ...row,
                    ...(campo === 'numCuenta' && { codCuenta: nCuenta }),
                    [campo]: valor,
                };
            }
            return row;
        });

        updateConfiguracion('convenioRecaudo', 'cuentaRecaudodora', newList)
        setFilas(newList);
    };

    const onKeyAgregarFilaEnter = (e) => {
        if (e.key === 'Enter') {
            setFilas(prev => [
                ...prev,
                {
                    id: prev.length + 1,
                    tipoCuenta: "",
                    numCuenta: '',
                    eanr: '',
                    cuentasDisponibles: []
                },
            ]);
        }
    };

    // Carga de cuentas según tipo seleccionado (por fila)
    const cargarCuentas = async (e, filaIndex) => {
        setLoading(true);
        const value = e.target.value;
        const tipoCuenta = +value === 1 ? 'AHO' : 'CTE';

        const dataBuscarCuentas = {
            identification: cliente.numDocumento,
            identificationType: cliente.tipoPersona || cliente.customerType === 'PJ' ? 'NIT' : 'CC',
            acountType: tipoCuenta,
        };

        const cuentas = JSON.parse(await queryCuentas(JSON.stringify(dataBuscarCuentas)));

        setFilas(prev => {
            const nuevas = [...prev];
            nuevas[filaIndex].tipoCuenta = value;
            nuevas[filaIndex].cuentasDisponibles = cuentas.data;
            nuevas[filaIndex].numCuenta = ''; // limpia la selección previa
            updateConfiguracion('convenioRecaudo', 'cuentaRecaudodora', nuevas);
            setLoading(false);
            return nuevas;
        });
    };


    return (
        <div className='w-full mt-4'>
            <div className="container w-full">
                <fieldset className="border bg-white shadow-md rounded-md w-full">
                    <legend className={`bg-coomeva_color-grisPestaña2 ml-8 rounded-t-md`}>
                        <h2 className="text-transparent mt-4 w-60 text-center">Agregar Reciprocidad Pactada</h2>
                    </legend>
                    <form id={'frmCuentaEan'} className="h-[10rem] overflow-y-scroll">
                        <table className={`table-auto w-[99%] text-sm mx-auto mb-3 text-start `}>
                            <thead className="bg-coomeva_color-grisPestaña2 sticky top-0">
                                <tr className={`font-roboto text-sm bg-coomeva_color-grisPestaña2 h-[35px]`}>
                                    {headTable.map((head, i) => (
                                        <th
                                            key={`${head}${i}`}
                                            className="align-bottom text-start px-2 text-coomeva_color-rojo decoration-inherit w-[20%]"
                                        >
                                            {head}
                                        </th>
                                    ))}
                                </tr>
                            </thead>
                            <tbody>
                                {
                                    filas?.map((fila, i) => (
                                        <tr
                                            key={fila.id}
                                            className={`text-[#002E49] ${i % 2 !== 0 ? 'bg-coomeva_color-grisPestaña2' : 'bg-white'} h-[36px] align-bottom`}
                                        >
                                            <td>
                                                <select
                                                    id={`tipoCuenta${i}`}
                                                    name={`tipoCuenta${i}`}
                                                    defaultValue={infoContext[i]?.tipoCuenta || ''}
                                                    disabled={habilitarInput}
                                                    /* onBlur={(e) => { handleInputChange(e, 'tipoCuenta', e.target.value, i) }} */
                                                    onKeyUp={onKeyAgregarFilaEnter}
                                                    onChange={(e) => cargarCuentas(e, i)}
                                                    className='w-[80%] h-8 font-normal text-sm outline-none bg-white border border-coomeva_color-azulClaro border-spacing-1 rounded-md px-2 mx-4' >
                                                    <option value={"default"} >Seleccionar</option>
                                                    {listTipoCuenta.DATA?.map((op, i) => (
                                                        <option value={op.codLista} key={op.codLista}>{op.descripcion}</option>
                                                    ))}
                                                </select>
                                            </td>
                                            <td>
                                                <select
                                                    id={`numCuenta${i}`}
                                                    name={`numCuenta${i}`}
                                                    defaultValue={infoContext[i]?.numCuenta || 'default'}
                                                    disabled={habilitarInput}
                                                    onBlur={(e) => { handleInputChange(e, 'numCuenta', e.target.value, i) }}
                                                    onKeyUp={onKeyAgregarFilaEnter}
                                                    className='w-[90%] h-8 font-normal  text-sm outline-none bg-white border border-coomeva_color-azulClaro border-spacing-1 rounded-md  px-2 mx-4'
                                                >
                                                    <option value={"default"} >Seleccionar</option>
                                                    {fila.cuentasDisponibles.map((op) => (
                                                        <option key={op.code} value={op.code} data-ncuenta={op.value}>
                                                            {op.value}
                                                        </option>
                                                    ))}
                                                </select>
                                            </td>
                                            <td>
                                                <input
                                                    id={`eanr${i}`}
                                                    name={`eanr${i}`}
                                                    type="text"
                                                    defaultValue={infoContext[i]?.eanr || ''}
                                                    className={` bg-white  rounded-md border border-coomeva_color-azulOscuro border-opacity-25 w-full  text-center outline-none h-8`}
                                                    onBlur={(e) => { handleInputChange(e, 'eanr', e.target.value, i) }}
                                                    onKeyUp={onKeyAgregarFilaEnter}
                                                    disabled={habilitarInput}
                                                    autoComplete="off"
                                                />
                                            </td>
                                        </tr>
                                    ))
                                }
                            </tbody>
                        </table>
                    </form>
                </fieldset>
                {
                    loading && <Loading />
                }
            </div>
        </div >
    )
}