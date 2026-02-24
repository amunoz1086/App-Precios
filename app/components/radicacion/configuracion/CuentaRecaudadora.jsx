'use client'

import EstructuraTabla from "../../share/EstructuraTabla";
import { useState } from "react";
import { usePerfil } from "@/app/hooks/usePerfil";
import { dataFormularioOrdenada } from "@/app/lib/utils";
import { queryCuentas } from "@/app/lib/services/cobis/fn_queryCuentas";
import Loading from "@/app/components/share/Loading";


const bodyTable = [
  { id: 1, tipoCuenta: '', numCuenta: '' }
];


export default function CuentaRecaudadora({
  headTable,
  listTipoCuenta,
  seccion,
  idFormulario,
  propieadd,
  subPropiedad,
  habilitarInput,
  updateConfiguracion,
  configuracion
}) {

  // Datos del Cliente
  const { cliente } = usePerfil();
  const [loading, setLoading] = useState(false);

  const infoContext = configuracion[propieadd][subPropiedad];
  const [filas, setFilas] = useState([]);

  const onBlurInputUpdateContext = (e) => {
    const elementSelect = e.target;
    const optionSelect = elementSelect.options[elementSelect.selectedIndex];
    const nCuenta = optionSelect.dataset.ncuenta;

    const currenForm = document.getElementById(idFormulario);

    if (currenForm) {
      const formData = new FormData(currenForm);
      const data = dataFormularioOrdenada({ formularioRef: formData, seccion: seccion });

      if (nCuenta !== undefined) {
        data[0].codCuenta = nCuenta;
      };

      updateConfiguracion(propieadd, subPropiedad, data);
    };
  };

  // Carga de cuentas según tipo seleccionado
  const cargarCuentas = async (e) => {
    setLoading(true);
    const value = e.target.value;
    const tipoCuenta = +value === 1 ? 'AHO' : 'CTE';

    const dataBuscarCuentas = {
      identification: cliente.numDocumento,
      identificationType: cliente.tipoPersona || cliente.customerType === 'PJ' ? 'NIT' : 'CC',
      acountType: tipoCuenta,
    };

    const cuentas = JSON.parse(await queryCuentas(JSON.stringify(dataBuscarCuentas)));
    setFilas(cuentas.data);
    setLoading(false);
  };

  return (
    <EstructuraTabla titulo={'tipo cuenta'} hidden={true}>
      <form id={idFormulario}>
        <table className={`table-auto  w-[99%] text-sm  mx-auto mb-3 text-start `}>
          <thead className="bg-coomeva_color-grisPestaña2">
            <tr className={`font-roboto text-sm  bg-coomeva_color-grisPestaña2 h-[35px]`}>
              {headTable.map((head, i) => (
                <th className={`align-bottom text-start px-2 text-coomeva_color-rojo  decoration-inherit  w-[50%]`} key={head} >{head}</th>
              ))}
            </tr>
          </thead>
          <tbody>
            {
              bodyTable?.map((servicio, i) => (
                <tr className={`text-[#002E49] ${i % 2 !== 0 ? 'bg-coomeva_color-grisPestaña2' : 'bg-white'} h-[36px] align-bottom`} key={servicio.id}>
                  <td>
                    <select
                      id={`${seccion}tipoCuenta${i}`}
                      name={`${seccion}tipoCuenta${i}`}
                      defaultValue={infoContext[i]?.tipoCuenta}
                      disabled={habilitarInput}
                      onChange={(e) => cargarCuentas(e, i)}
                      className='w-[80%] h-8 font-normal  text-sm outline-none bg-white border border-coomeva_color-azulClaro border-spacing-1 rounded-md  px-2 mx-4'>
                      <option defaultValue={"default"} >Seleccionar</option>
                      {listTipoCuenta.DATA?.map((op, i) => (
                        <option value={op.codLista} key={op.codLista}>{op.descripcion}</option>
                      ))}
                    </select>
                  </td>
                  <td>
                    <select
                      id={`${seccion}numeroCuenta${i}`}
                      name={`${seccion}numeroCuenta${i}`}
                      defaultValue={infoContext[i]?.numeroCuenta || 'default'}
                      onBlur={onBlurInputUpdateContext}
                      disabled={habilitarInput}
                      className='w-[90%] h-8 font-normal  text-sm outline-none bg-white border border-coomeva_color-azulClaro border-spacing-1 rounded-md  px-2 mx-4'>
                      <option defaultValue={"default"} >Seleccionar</option>
                      {filas.map((op, i) => (
                        <option id={op.code} value={op.code} key={op.code} data-ncuenta={op.value}>{op.value}</option>
                      ))}
                    </select>
                  </td>
                </tr>
              ))
            }
          </tbody>
        </table>
      </form>
      {
        loading && <Loading />
      }
    </EstructuraTabla>
  )
}