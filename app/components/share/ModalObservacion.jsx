import React from 'react'

export const ModalObservacion = ({ w = 35, iconoAlert = false, ocultarBtnContinuar = false, habilitarBotomContinuar = true, children, mostrarModal, cerrarModal, titulo, textBtnContinuar = 'Aceptar', ocultarBtnCancelar = false, mostrarImagneFondo = false }) => {
    return (
        <div className={"fixed bg-cover  z-[9999] inset-0  flex justify-center bg-[#88838342] items-center transition-all "}   >
            <div className={`bg-white py-14 px-5 w-[${w}%] rounded-md flex flex-col justify-center items-center gap-5`}>
                <div className="relative mx-auto flex mb-2 ">
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
                <div className="flex  gap-6">
                    {
                        ocultarBtnCancelar ? undefined : <button onClick={cerrarModal} className="py-2 px-8 bg-[#979797ff] rounded-lg mx-auto text-white text-xs">No</button>
                    }
                    {
                        ocultarBtnContinuar ? undefined : <button id="modal" onClick={habilitarBotomContinuar ? mostrarModal : () => { }} className={`py-2 px-8 ${habilitarBotomContinuar ? 'bg-coomeva_color-rojo' : 'bg-[#979797ff]'} rounded-lg mx-auto text-white text-xs`}>{textBtnContinuar}</button>
                    }
                </div>
            </div>
        </div>
    )
}