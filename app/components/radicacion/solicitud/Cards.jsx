'use client'


import { useSolicitud } from "@/app/hooks/useSolicitud"
import BtnControl from "../cliente/BtnControl"
import TipoConvenioServicio from "./TipoConvenioServicio"
import TipoOperacion from "./TipoOperacion"
import TipoProducto from "./TipoProducto"


export default function Cards({ listTypeProducts, listTipeOperactions, listTypeConvenios,rolActivo }) {

    const {context,convenio,enableButton,habilitarInput,onChangeSave,frmForm,solicitud}= useSolicitud(rolActivo)
 

    return (
        <>
            <form ref={frmForm} className="w-full flex flex-row" >
                <div className=' w-3/12 h-auto px-2 py-1  '>
                    <TipoProducto
                        onChangeSave={onChangeSave}
                        listTypeProducts={listTypeProducts.DATA}
                        solicitud={solicitud}
                        deshabilitar={habilitarInput}
                    />
                </div>

                <div className='w-3/12  px-2 py-1'>
                    <TipoOperacion
                        onChangeSave={onChangeSave}
                        listTipoOperations={listTipeOperactions.DATA}
                        solicitud={solicitud}
                        deshabilitarInput={habilitarInput}
                    />
                </div>
                <div className=' w-4/12  px-2 py-1'>
                    <TipoConvenioServicio
                        onChangeSave={onChangeSave}
                        listTypeConvenio={listTypeConvenios.DATA}
                        solicitud={solicitud}
                        convenio={convenio}
                        deshabilitarInput={habilitarInput}
                    />

                </div>
            </form>
            <section className='w-full flex flex-row justify-end'>
                <BtnControl
                    name={'Configurar'}
                    url={
                        convenio.tipoProducto?.credito
                            ? '/radicacion/convenioServicios/creditoNuevo'
                            : convenio.tipoConvenio['convenioPago']
                                ? '/radicacion/convenioServicios'
                                : convenio.tipoConvenio['convenioRecaudo']
                                    ? '/radicacion/convenioServicios/convenioRecaudo'
                                    : '/radicacion/convenioServicios/servicioFinanciero'

                    }
                    enableButton={enableButton}
                    data={convenio}
                    nameFuctionContext={'updateDataSolciitud'}
                    context={context}
                    opcion={'navegarActualizarContext'}
                />
            </section>
        </>
    )
}
