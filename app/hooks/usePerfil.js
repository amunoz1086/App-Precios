import { limpiarContext } from "../lib/utils"
import { useProvider } from "../provider/Providers"

export const usePerfil = () => {

    const context=useProvider()

    const {cliente,editar,estadoSolicitud,updateDataCliente,pathConvenio,updateDocumentoCliente,inputDocument} =context

    const limpiarProvider = (resetInputDocument) => {
        limpiarContext({context:context,resetDocuemnt:resetInputDocument})
    }

    return {
        cliente,
        editar,
        estadoSolicitud,
        updateDataCliente,
        pathConvenio,
        inputDocument,
        updateDocumentoCliente,
        limpiarProvider
    }
}
