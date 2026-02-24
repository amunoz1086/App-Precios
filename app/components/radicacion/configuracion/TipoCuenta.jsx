'use client';

import { resetearPesos } from "@/app/lib/utils";
import { useState, useEffect } from "react";
import { usePerfil } from "@/app/hooks/usePerfil";
import { queryCuentas } from "@/app/lib/services/cobis/fn_queryCuentas";
import Loading from "@/app/components/share/Loading";

export default function TipoCuenta({
  seccion,
  listTipoCuenta,
  idFormulario,
  propiedad,
  subPropiedad,
  habilitarInput,
  headTable,
  //desactivarFormato = false,
  updateConfiguracion,
  configuracion
}) {
  // Datos del Cliente
  const { cliente } = usePerfil();

  // Estado base por fila
  const tableBody = [
    { id: 1, cuenta: "", numCuenta: "", porcentaje: "", codCuenta: "", cuentasDisponibles: [] },
    { id: 2, cuenta: "", numCuenta: "", porcentaje: "", codCuenta: "", cuentasDisponibles: [] },
    { id: 3, cuenta: "", numCuenta: "", porcentaje: "", codCuenta: "", cuentasDisponibles: [] },
  ];

  // Estado inicial (usa configuracion si viene con datos)
  const [loading, setLoading] = useState(false);
  const tipoCuentaContext = configuracion[propiedad][subPropiedad] || [];
  const [filas, setFilas] = useState(
    tipoCuentaContext.length > 0
      ? tipoCuentaContext.map((f, i) => ({
        id: i + 1,
        cuenta: f.cuenta || "",
        numCuenta: f.numCuenta || "",
        porcentaje: f.porcentaje || "",
        codCuenta: f.codCuenta || "",
        cuentasDisponibles: f.cuentasDisponibles || []
      }))
      : [...tableBody]
  );

  useEffect(() => {
    if (tipoCuentaContext.length > 0) {
      setFilas(tipoCuentaContext.map((f, i) => ({
        id: i + 1,
        cuenta: f.cuenta || "",
        numCuenta: f.numCuenta || "",
        porcentaje: f.porcentaje || "",
        codCuenta: f.codCuenta || "",
        cuentasDisponibles: f.cuentasDisponibles || []
      })));
    }
  }, [tipoCuentaContext]);

  // Maneja cambios en los inputs
  const handleInputChange = (e, campo, valor, filaIndex) => {
    let nCuenta = '';

    if (campo !== 'porcentaje') {
      const elementSelect = e.target;
      const optionSelect = elementSelect.options[elementSelect.selectedIndex];
      nCuenta = optionSelect?.dataset?.ncuenta;
    }

    const newList = filas.map((row, index) => {
      if (index === filaIndex) {
        return {
          ...row,
          ...(campo === 'numCuenta' && { codCuenta: nCuenta }),
          [campo]: resetearPesos({ valor }),
        };
      }
      return row;
    });
    
    updateConfiguracion(propiedad, subPropiedad, newList);
    setFilas(newList);
  };

  // Agregar fila nueva
  const onKeyAgregarFilaEnter = (e) => {
    if (e.key === 'Enter') {
      setFilas(prev => [
        ...prev,
        {
          id: prev.length + 1,
          cuenta: "",
          numCuenta: "",
          porcentaje: "",
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
      nuevas[filaIndex].cuenta = value;
      nuevas[filaIndex].cuentasDisponibles = cuentas.data;
      nuevas[filaIndex].numCuenta = ''; // limpia la selección previa
      updateConfiguracion(propiedad, subPropiedad, nuevas);
      setLoading(false);
      return nuevas;
    });
  };

  return (
    <div className="container w-full">
      <fieldset className="border bg-white shadow-md rounded-md w-full">
        <legend className={` bg-coomeva_color-grisPestaña2 ml-8 rounded-t-md`}>
          <h2 className="text-coomeva_color-rojo mt-4 w-60 text-center">
            Tipo de cuenta
          </h2>
        </legend>
        <form id={idFormulario} className="h-[10rem] overflow-y-scroll">
          <table className="table-auto w-[99%] text-sm mx-auto mb-3 text-start">
            <thead className="bg-coomeva_color-grisPestaña2 sticky top-0">
              <tr className="font-roboto text-sm bg-coomeva_color-grisPestaña2 h-[35px]">
                {headTable.map((head, i) => (
                  <th
                    key={`${head}${i}`}
                    className="align-bottom text-start px-2 text-coomeva_color-rojo w-[20%]"
                  >
                    {head}
                  </th>
                ))}
              </tr>
            </thead>
            <tbody>
              {filas.map((fila, i) => (
                <tr
                  key={fila.id}
                  className={`text-[#002E49] ${i % 2 !== 0 ? 'bg-coomeva_color-grisPestaña2' : 'bg-white'
                    } h-[36px] align-bottom`}
                >
                  {/* Tipo de cuenta */}
                  <td>
                    <select
                      id={`${seccion}cuenta${i}`}
                      name={`${seccion}cuenta${i}`}
                      defaultValue={fila.cuenta || 'default'}
                      onChange={(e) => cargarCuentas(e, i)}
                      /* onBlur={(e) =>
                        handleInputChange(e, 'cuenta', e.target.value, i)
                      } */
                      disabled={habilitarInput}
                      className="w-[80%] h-8 font-normal text-sm outline-none bg-white border border-coomeva_color-azulClaro rounded-md px-2 mx-4"
                    >
                      <option value="default">Seleccionar</option>
                      {listTipoCuenta.DATA?.map((op) => (
                        <option value={op.codLista} key={op.codLista}>
                          {op.descripcion}
                        </option>
                      ))}
                    </select>
                  </td>
                  {/* Número de cuenta */}
                  <td>
                    <select
                      id={`${seccion}numCuenta${i}`}
                      name={`${seccion}numCuenta${i}`}
                      defaultValue={fila.numCuenta || 'default'}
                      onChange={(e) =>
                        handleInputChange(e, 'numCuenta', e.target.value, i)
                      }
                      disabled={!fila.cuentasDisponibles.length || habilitarInput}
                      className="w-[90%] h-8 font-normal text-sm outline-none bg-white border border-coomeva_color-azulClaro rounded-md px-2 mx-4"
                    >
                      <option value="default">Seleccionar</option>
                      {fila.cuentasDisponibles.map((op) => (
                        <option key={op.code} value={op.code} data-ncuenta={op.value}>
                          {op.value}
                        </option>
                      ))}
                    </select>
                  </td>
                  {/* Porcentaje */}
                  <td>
                    <input
                      id={`${seccion}porcentaje${i}`}
                      name={`${seccion}porcentaje${i}`}
                      type="text"
                      disabled={habilitarInput}
                      className="bg-white rounded-md border border-coomeva_color-azulOscuro border-opacity-25 w-full text-center outline-none h-8"
                      defaultValue={fila.porcentaje || ''}
                      onChange={(e) =>
                        handleInputChange(e, 'porcentaje', e.target.value, i)
                      }
                      onKeyUp={onKeyAgregarFilaEnter}
                    />
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </form>
      </fieldset>
      {
        loading && <Loading />
      }
    </div>
  );
}