import { limpiarContext } from "../lib/utils";
import { useProvider } from "../provider/Providers";

export const useDatosFuncionProvider = () => {

  const context = useProvider()

  const {
    updateEvaluar,
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
    habilitarBotoAprobarSolicitud,
  } = context

  const limpiarProviderContext = (resetDocument = false) => limpiarContext({ context, resetDocument })

  return {
    updateEvaluar,
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
    habilitarBotoAprobarSolicitud,
    limpiarProviderContext,
  }
}