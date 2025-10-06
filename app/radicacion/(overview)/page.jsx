import EncabezadoMenuPrincipal from "@/app/components/headers/EncabezadoMenuPrincipal";
import Captacion from "@/app/components/radicacion/cliente/Captacion";
import Cartera from "@/app/components/radicacion/cliente/Cartera";
import Cupo from "@/app/components/radicacion/cliente/Cupo";
import PerfilCliente from "@/app/components/radicacion/cliente/PerfilCliente";
import TipoConvenio from "@/app/components/radicacion/cliente/TipoConvenio";
import ControlBotonesCliente from "@/app/components/radicacion/cliente/ControlBotonesCliente";
import { Suspense } from "react";
import { PerfilCLienteSkeleton } from "@/app/components/skeletons";
import { redirect } from "next/navigation";
import { cookies, headers } from "next/headers";



export default async function Radicacion() {

    const headersList = headers()

    const referer = headersList.get('referer')

    if (referer == null) { redirect('/login/perfil') }


    const rolActivo = cookies().get('rol')?.value

    if (rolActivo !== 'Radicación') return redirect('/login/perfil')

    if ((rolActivo) === undefined || (rolActivo) === '') redirect('/login/perfil')


    return <section className=" w-full  sm:inline  md:w-[95%]  lg:w-[100%]">

        <EncabezadoMenuPrincipal
            urlImage={'cabecera3'}
            title={'MENÚ'}
            subtitle={'Principal'}
            paragraph={'Digita el ID del cliente para consultarlo. Puedes ingresar la información en caso de clientes nuevos o actualizarla en clientes actuales. Adicionalmente, puedes iniciar una solicitud de precio preferencial.'}
            enableInput={{ "input1": true }}
            enableListDoc={true}
            btnConsultar={true}
            btnNuevo={true}
            iconSearch={true}
            perfilActivo={rolActivo}
        />

        <main className="flex-grow">
            <section className='w-full px-2 py-1'>
                <Suspense fallback={<PerfilCLienteSkeleton />}>
                    <PerfilCliente
                        rolActivo={rolActivo}
                    />
                </Suspense>
            </section>
            <section className=' w-full flex flex-row'>
                <div className=' w-3/5 px-2 py-1'>
                    <Cartera />
                </div>
                <div className=' w-2/5 px-2 py-1'>
                    <Cupo />
                </div>
            </section>
            <section className=' w-full flex flex-row'>
                <div className=' w-[65%] px-2 py-1'>
                    <Captacion />
                </div>
                <div className='w-[35%] px-2 py-2'>
                    <TipoConvenio
                        textDefault={''}
                        dimensionTextArea={{
                            columna: 48,
                            fila: 4
                        }}
                        titulo={"Tipo de convenio"}
                        desabilitar={true}
                        id={"tconvenioCaptacion"}
                        ancho={"auto"}
                    />
                </div>
            </section>
            <section className=' w-full my-4 flex flex-row justify-end pr-2 mt-8'>
                <ControlBotonesCliente />
            </section>
        </main>
    </section>
}