'use client'

export default function Modals({ w = 25, iconoAlert = true, ocultarBtnContinuar = false, habilitarBotomContinuar = true, children, mostrarModal, cerrarModal, titulo, textBtnContinuar = 'Aceptar', ocultarBtnCancelar = false, mostrarImagneFondo = false }) {

    let fondoImagen = mostrarImagneFondo ? "fondoModal" : ""
    return (

        // <div style={{backgroundImage:img,backgroundSize:"cover"}} className="fixed z-40 inset-0 bg-black bg-opacity-30 backdrop-blur-sm flex justify-center items-center">
        <div className={"fixed bg-cover  z-[9999] inset-0  flex justify-center items-center transition-all " + fondoImagen}   >
            <div className={`bg-[#f4f6f7d1] py-14 px-5 w-[${w}%] rounded-md flex flex-col justify-center items-center gap-5`}>
                <div className="relative mx-auto flex mb-2 ">
                    <img
                        src="/logos/logoverde.svg"
                        width={200}
                        height={200}
                        className="mx-auto w-12 h-14 absolute left-0 top-0"
                        alt="icono modal mensaje"
                    // priority
                    />
                    <h6 className=" text-center mt-9 ml-6 text-coomeva_color-azulOscuro font-bold">
                        {titulo}
                    </h6>
                </div>
                {
                    iconoAlert ?
                        <div className="flex items-end h-[30%]">
                            <img className="w-10 h-10" width={50} height={50} src='/modal/icono.svg' alt="icono advertencia mensaje modal"></img>
                        </div> : undefined
                }

                {children}

                <hr className="w-full border-coomeva_color-grisPestaña2" />
                <div className="flex justify-between w-full">
                    {
                        ocultarBtnContinuar ? undefined : <button id="modal" onClick={habilitarBotomContinuar ? mostrarModal : () => { }} className={`py-2 px-8 ${habilitarBotomContinuar ? 'bg-coomeva_color-verdeLetras' : 'bg-[#979797ff]'} rounded-lg mx-auto text-white text-xs`}>{textBtnContinuar}</button>
                    }
                    {
                        ocultarBtnCancelar ? undefined : <button onClick={cerrarModal} className="py-2 px-8 bg-[#979797ff] rounded-lg mx-auto text-white text-xs">Cancelar</button>
                    }
                </div>
            </div>
        </div>
    )
}