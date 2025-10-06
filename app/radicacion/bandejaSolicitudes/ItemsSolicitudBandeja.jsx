'use client';

import { useRouter } from "next/navigation";
import { queryDetalleSolicitud } from '@/app/lib/solicitudes/queryDetalleSolicitud';
import { queryEstadoSolicitud } from '@/app/lib/solicitudes/queryEstadoSolicitud';
import { conversionPesos, resetearPesos } from "@/app/lib/utils";


const ItemsSolicitudBandeja = ({ solicitud, contextData }) => {

  const route = useRouter();
  const desicionRespuesta = {
    "Aprobado": 0,
    "En Proceso": 1,
    "avalado": 2,
    "No Aprobado": 3
  };


  const detallesSolicitud = async (e, estadoSolicitud) => {

    const { updateCodigoSolictud, updateStatusCorreo } = contextData
    let dataSolicitud = {};
    let nSolicitud = {};
    nSolicitud.cod_solicitud = parseInt(e.target.id);

    try {
      let response = await queryDetalleSolicitud(nSolicitud.cod_solicitud);
      let resEstadoAprobacion = await queryEstadoSolicitud(nSolicitud);

      dataSolicitud = JSON.parse(response.DATA);

      dataSolicitud[0].ESTADO_SOLICITUD = desicionRespuesta[estadoSolicitud];

      if (JSON.parse(resEstadoAprobacion).state !== 205) {
        dataSolicitud[0].estadoAprobacion = JSON.parse(resEstadoAprobacion).data[0].estadoAprobacion;
        dataSolicitud[0].estadoParametrizacion = JSON.parse(resEstadoAprobacion).data[0].estadoParametrizacion === null ? 0 : JSON.parse(resEstadoAprobacion).data[0].estadoParametrizacion;
      } else {
        dataSolicitud[0].estadoAprobacion = 0;
        dataSolicitud[0].estadoParametrizacion = 0;
      };

      updateCodigoSolictud(dataSolicitud.COD_SOLICITUD);
      updateStatusCorreo(response?.statusCorreo ? response?.statusCorreo === 'true' ? true : false : false);
      cargarDatosSolictudContext({ solicitudBD: dataSolicitud });

      route.push('/radicacion/resumen');

    } catch (error) {
      console.log(error);
    };
  };


  const cargarDatosSolictudContext = ({ solicitudBD }) => {

    const { updateCodigoSolictud, updateTecnicoOperador,
      updateConfiguracion,
      updateDepositoVista,
      updateServicioFinanciero,
      updateDataRemi,
      updateConvenioRecaudo,
      updateDataSolciitud,
      updateConvenioPago,
      updateDataCliente, updateEstadoSolicitud,
      updateCreditoNuevo,
      updateReciprocidadResumen,
      updateResumenMotor,
      updateClienteFiducia,
      updateCampoAdicionalesModal,
      updateClientModal,
      updateAprobacionParametrizacion,
      updateIdSolictudDb,
      updateDocumentoCliente
    } = contextData

    const {
      SOLICITUD, ID_RADICADOR, TECNICO_OPERADOR, CONVENIO_PAGO, CONVENIO_RECAUDO, CONVENIO_SERVICIO,
      RADICACION, DEPOSITO_VISTA, CONFIGURACION, REMI, KNIME, SERVICIOS_FINANCIEROS,
      CREDITO_NUEVO, RECIPROCIDAD_RESUMEN, ESTADO_SOLICITUD, CLIENTE_FIDUCIA, DOCUMENTO, CLIENTE_MODAL, CAMPO_ADICIONALES_MODAL, estadoAprobacion, estadoParametrizacion

    } = solicitudBD[0]


    ESTADO_SOLICITUD == 3 ? updateAprobacionParametrizacion({

    }) : updateAprobacionParametrizacion({
      estadoAprobacion: estadoAprobacion,
      estadoParametrizacion: estadoParametrizacion,
      idRadicador: ID_RADICADOR
    })



    updateDocumentoCliente(solicitudBD[0]?.NIT_CLIENTE || '')

    updateDataSolciitud(SOLICITUD);
    // convenio Pago
    updateConvenioPago(undefined, CONVENIO_PAGO);
    // convenio Recaudo
    updateConvenioRecaudo(undefined, CONVENIO_RECAUDO);
    // convenio Financiero
    updateServicioFinanciero(undefined, SERVICIOS_FINANCIEROS);
    // depositoVista
    updateDepositoVista(undefined, DEPOSITO_VISTA);
    // configuracion
    // updateCreditoNuevo(CREDITO_NUEVO);


    updateCreditoNuevo( Array.isArray(CREDITO_NUEVO)?CREDITO_NUEVO:[])
    //acutalizar el estado solicitud

    updateEstadoSolicitud(ESTADO_SOLICITUD);
    updateReciprocidadResumen(RECIPROCIDAD_RESUMEN);
    updateDataRemi(REMI || []);
    updateDataCliente(RADICACION);

    const config = DOCUMENTO;

    updateClienteFiducia(undefined, CLIENTE_FIDUCIA, true);
    updateTecnicoOperador(JSON.parse(TECNICO_OPERADOR));
    updateCampoAdicionalesModal(JSON.parse(CAMPO_ADICIONALES_MODAL));
    updateClientModal(CLIENTE_MODAL);
    updateIdSolictudDb(solicitudBD[0]?.COD_SOLICITUD);

    updateConfiguracion("adquirencia", "infoTriburaria", config?.adquirencia?.infoTriburaria || []);
    updateConfiguracion("adquirencia", "infoComercio", config?.adquirencia?.infoComercio || {});
    updateConfiguracion("adquirencia", "tipoVenta", config?.adquirencia?.tipoVenta || {});
    updateConfiguracion("adquirencia", "tipoCuenta1", config?.adquirencia?.tipoCuenta1 || []);


    updateConfiguracion("convenioRecaudo", "recaudoFormato", config?.convenioRecaudo?.recaudoFormato || {});
    updateConfiguracion("convenioRecaudo", "recaudoManuales1", config?.convenioRecaudo?.recaudoManuales1 || []);
    updateConfiguracion("convenioRecaudo", "recaudoSiNo", config?.convenioRecaudo?.recaudoSiNo || '');
    updateConfiguracion("convenioRecaudo", "cuentaRecaudodora", config?.convenioRecaudo?.cuentaRecaudodora || []);
    updateConfiguracion("convenioRecaudo", "modeloPago", config?.convenioRecaudo?.modeloPago || {});
    updateConfiguracion("convenioRecaudo", "recuadoClasePago", config?.convenioRecaudo?.recuadoClasePago || {});
    updateConfiguracion("convenioRecaudo", "recaudoRespaldo", config?.convenioRecaudo?.recaudoRespaldo || {});

    updateConfiguracion("corresponsales", "tipoRecuado", config?.corresponsales?.tipoRecuado || {});
    updateConfiguracion("corresponsales", "BaseWebTicket", config?.corresponsales?.BaseWebTicket || {});
    updateConfiguracion("corresponsales", "tipoCuenta", config?.corresponsales?.tipoCuenta || []);
    updateConfiguracion("corresponsales", "recuadoManual", config?.corresponsales?.recuadoManual || []);
    updateConfiguracion("corresponsales", "cuentaRecaudadoraEan", config?.corresponsales?.cuentaRecaudadoraEan || []);
    updateConfiguracion("corresponsales", "modeloPago", config?.corresponsales?.modeloPago || {});

    updateConfiguracion("convenioPago", "cuentaRecaudadora1", config?.convenioPago?.cuentaRecaudadora1 || []);
    updateConfiguracion("convenioPago", "cuentaRecaudadora2", config?.convenioPago?.cuentaRecaudadora2 || []);
    updateResumenMotor(resultadoResumen(KNIME));
  };

  const resultadoResumen = (dtResult) => {

    const { DATOS_ENTE_ATRIBUCION_FINAL } = dtResult;
    const aprobadores = {
      gerencia: false,
      vprecidencia: false,
      presidencia: false,
      junta: false,
    };

    DATOS_ENTE_ATRIBUCION_FINAL.length > 0 && DATOS_ENTE_ATRIBUCION_FINAL.map(e => {
      const tipoApor = e.tipo_aprobador.toLowerCase()
      aprobadores.presidencia = (tipoApor).includes('presidencia')
      aprobadores.vprecidencia = (tipoApor).includes('vic')
      aprobadores.gerencia = (tipoApor).includes('gerente')
      aprobadores.junta = (tipoApor).includes('junta')

    });

    return {
      entes: aprobadores,
      responseKnime: dtResult
    };
  };

  return (
    <div className="container border border-coomeva_color-grisPestaña2 shadow-md rounded-lg mt-4 w-[100vw]"
    //  style={{ width: '100vw' }}
     >
      <div className="flex items-center overflow-y-auto rounded-lg w-[100%]">

        
        <div className="w-full">
          <span className="bg-coomeva_color-grisPestaña2 py-1"></span>
          
          <table
            className="w-full divide-y divide-gray-300"
            border={1}
          >
            <thead className=" text-coomeva_color-rojo  text-xs bg-coomeva_color-grisPestaña2">
              <tr className="divide-x divide-gray-300" >
                <th className="p-3 w-[5%]">Nº Solicitud</th>
                <th className="p-3 w-[10%]">Fecha</th>
                <th className="p-3 w-[15%] text-start">Oficina</th>
                <th className="p-3 w-[10%] text-start">Regional</th>
                <th className="p-3 w-[10%] text-start">ID Cliente</th>
                <th className="p-3 w-[20%] text-start">Cliente</th>
                <th className="p-3 w-[15%] text-start">Total Cartera</th>
                <th className="p-3 w-[15%] text-start">Total Captación</th>
                <th className="p-3 w-[10%] text-start">Rentabilidad</th>
                <th className="p-3 w-[15%] text-start">Costo Integral</th>
                <th className="p-3 w-[10%] text-start">Ente de Aprobación</th>
                <th className="p-3 w-[10%] text-start">Decisión</th>
                <th className="p-3 w-[10%] text-start">Estado Parametrizador</th>
              </tr>
            </thead>
            <tbody className="p-8 text-[11.5px] text-coomeva_color-azulOscuro font-semibold">
              <tr className="divide-x bg-white divide-gray-300">
                <td className="p-3 w-[5%] text-center">{solicitud.COD_SOLICITUD}</td>
                <td className="p-3 w-[10%] text-center">{solicitud.FECHA_HORA}</td>
                <td className="p-3 w-[15%]">{solicitud.OFICINA}</td>
                <td className="p-3 w-[10%]">{solicitud.REGIONAL}</td>
                <td className="p-3 w-[10%]">{solicitud.NIT_CLIENTE}</td>
                <td className="p-3 w-[20%]">{solicitud.CLIENTE}</td>
                <td className="p-3 w-[15%]">{'$ ' + resetearPesos({ valor: solicitud?.TOTAL_CARTERA || solicitud?.TOTAL_CARTERA || 0 })}</td>
                <td className="p-3 w-[15%]">{'$ ' + resetearPesos({ valor: solicitud?.TOTAL_CAPTACION || solicitud?.TOTAL_CAPTACION || 0 })}</td>
                <td className="p-3 w-[5%]">{conversionPesos({ valor: solicitud.RENTABILIDAD, nDecimales: 2, style: "percent" })}</td>
                <td className="p-3 w-[5%]">{conversionPesos({ valor: solicitud.COSTO_INTEGRAL, nDecimales: 2, style: "percent" })}</td>
                <td className="p-3 w-[15%]">{solicitud.codEnte}</td>
                <td className="p-3 w-[10%]">{solicitud.Aprobacion}</td>
                <td className="p-3 w-[10%] text-center">{solicitud.Parametrizacion}</td>
              </tr>
            </tbody>
          </table>
          <span className="bg-white py-1"></span>
        </div>
        <div className="flex justify-center items-center w-[10%] h-[10%]">
          <button id={solicitud.COD_SOLICITUD} onClick={(e) => { detallesSolicitud(e, solicitud.Aprobacion) }} className=" transition duration-300 ease-in-out bg-white text-center text-sm text-coomeva_color-rojo border rounded-lg border-red-500 hover:bg-coomeva_color-rojo hover:text-white w-[70%] py-6">
            Ingresar
          </button>
        </div>
      </div>
    </div>
  );
};

export default ItemsSolicitudBandeja;