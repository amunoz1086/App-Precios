'use client'

import dynamic from 'next/dynamic';
import { useRouter } from 'next/navigation'
import { useState, useEffect } from 'react';
import { obtenerCookieRol } from "@/app/lib/auth/auth";


const DynamicModal = dynamic(() => import('../share/Modals'));

const opciones = [
    // {
    //     btnCod: "btn1",
    //     value: "Usuarios",
    //     label: "Usuarios y roles en la plataforma",
    //     url: "/administracion/usuarios",
    //     className: "text-white rounded-md bg-red-600 cursor-pointer w-36 py-1 my-2 mr-4",
    //     rol: "ADFNC"
    // },
    {
        btnCod: "btn2",
        value: "Productos",
        label: "Líneas de captación y crédito",
        url: "",
        className: "bg-zinc-300  text-white rounded-md cursor-pointer w-36 py-1 my-2 mr-4 cursor-not-allowed",
        rol: "ADFNC"
    },
    {
        btnCod: "btn3",
        value: "Ahorro",
        label: "Tasas y planes para cuentas de ahorro",
        url: "",
        className: "bg-zinc-300  text-white rounded-md cursor-pointer w-36 py-1 my-2 mr-4 cursor-not-allowed",
        rol: "ADFNC"
    },
    {
        btnCod: "btn4",
        value: "CDT",
        label: "Configuración y condiciones para ahorro a término",
        url: "",
        className: "bg-zinc-300  text-white rounded-md cursor-pointer w-36 py-1 my-2 mr-4 cursor-not-allowed",
        rol: "ADFNC"
    },
    {
        btnCod: "btn5",
        value: "Convenio Recaudo",
        label: "Configuración y condiciones para convenio de recaudo",
        url: "/administracion/convenioRecaudo",
        className: "text-white rounded-md w-36 bg-red-600 cursor-pointer w-36 py-1 my-2 mr-4",
        rol: "ADFNC"
    },
    {
        btnCod: "btn6",
        value: "Convenio Pago",
        label: "Configuración y condiciones para convenio de pago",
        url: "/administracion/convenioPago",
        className: "text-white rounded-md w-36 bg-red-600 cursor-pointer w-36 py-1 my-2 mr-4",
        rol: "ADFNC"
    },
    {
        btnCod: "btn7",
        value: "Serv. Financieros",
        label: "Configuración y condiciones para servicios financieros",
        url: "/administracion/servicioFinanciero",
        className: "text-white rounded-md bg-red-600 cursor-pointer w-36  px-2 whitespace-normal text-sm my-2 mr-4 ",
        rol: "ADFNC"
    },
    {
        btnCod: "btn8",
        value: "Deposito a la Vista",
        label: "Configuración y condiciones para servicios financieros",
        url: "/administracion/depositoVista",
        className: "text-white rounded-md bg-red-600 cursor-pointer w-36  px-2 whitespace-normal text-sm my-2 mr-4 ",
        rol: "ADFNC"
    },
    {
        btnCod: "btn9",
        value: "Config. IBR",
        label: "Configurar las tasas de IBR",
        url: "/administracion/modalidad_IBR",
        className: "btn-admin",
        rol: "Administración"
    },
    {
        btnCod: "btn10",
        value: "Crédito",
        label: "Configurar condiciones de crédito",
        url: "/administracion/credito",
        className: "btn-admin",
        rol: "ADFNC"
    }
];


const opciones2 = [
    {
        btnCod: "btn1",
        value: "Usuarios",
        label: "Usuarios y roles en la plataforma",
        url: "/administracion/usuarios",
        className: "text-white rounded-md bg-red-600 cursor-pointer w-36 py-1 my-2 mr-4",
        rol: "Administración",
        opciones: {
            auditoria: {
                btnCod: "btn01",
                value: "Auditoría",
                label: "Auditoría de usuarios",
                url: "/administracion/auditoria",
                className: "text-white rounded-md  cursor-pointer ",
                rol: "Administración",
            },
            usuarios: {
                btnCod: "btn02",
                value: "Gestión de Usuarios",
                label: "Gestión de usuarios y roles",
                url: "/administracion/usuarios",
                className: "text-white rounded-md  cursor-pointer  ",
                rol: "Administración",
            },
        },
    },
];



export default function AdminLinks() {

    const [listRol, setListRol] = useState();
    const [listBtn, setListBtn] = useState([]);


    useEffect(() => {
        rolAdmin();
        btnAdmin();
    }, [listRol]);


    const rolAdmin = async () => {
        try {
            const dataRes = await obtenerCookieRol();
            setListRol(JSON.parse(dataRes));
        } catch (error) {
            console.log(error);
        };
    };


    const btnAdmin = () => {
        setListBtn(opciones.filter(opcion => opcion.rol.includes(listRol)));
    };


    const [showModal] = useState(false);
    const [messageAlert] = useState('');
    const router = useRouter();


    const navegar = async (link) => {
        if (link !== '') {
            router.push(link)
        };
    };

    const [expandedButton, setExpandedButton] = useState(null);

    const endModal = async () => {
        // try {
        //    await logout();
        //    limpiarProviderContext()
        //     router.push('/login')
        //     setShowModal(false);
        // } catch (error) {
        //     console.log(error)
        // }
    };

    // Función para manejar el clic en el botón principal
    const handleMainButtonClick = (btnCod) => {
        setExpandedButton(expandedButton === btnCod ? null : btnCod);
    };

    // Función para manejar el clic en los botones internos
    const handleInnerButtonClick = (url) => {

        router.push(url)
        setExpandedButton(null); // Contraer el botón después de hacer clic
    };


    return <>
        <div className="">
            <div className="w-full flex mb-4 ">
                <h2 className="mx-auto py-13 font-semibold text-center text-sm">Seleccione la Opción a Configurar</h2>
            </div>
            <div className=" mx-auto ">

                {opciones2.map((opcion) => (
                    <div key={opcion.btnCod} className="mb-2">
                        {/* Botón principal */}

                        {
                            listRol !== 'ADFNC' ?
                                < button
                                    onClick={() => handleMainButtonClick(opcion.btnCod)}
                                    className={`peq:max-md:flex peq:max-md:flex-col-reverse w-full h-14 justify-center '
                                    } text-white rounded-md`}
                                >
                                    <div className='flex items-center space-x-6 '>
                                        <p className={`w-[140px] ${opcion.url === '' ? 'bg-coomeva_color-grisPestaña' : 'bg-coomeva_color-rojo '} text-xs rounded-md text-center py-2 text-white`} >{opcion.value}</p>
                                        <p className='text-sm  text-gray-800'>{opcion.label}</p>
                                    </div>
                                </button>
                                : null
                        }

                        {expandedButton === opcion.btnCod && opcion.opciones && (
                            <div className="mt-2 space-y-2 flex flex-col  ml-6">
                                <button
                                    onClick={() => handleInnerButtonClick(opcion.opciones.auditoria.url)}
                                    className={`peq:max-md:flex peq:max-md:flex-col-reverse w-48 text-xs h-8 bg-coomeva_color-grisPestaña justify-center ${opcion.opciones.auditoria.className}`}
                                >
                                    {opcion.opciones.auditoria.value}
                                </button>
                                <button
                                    onClick={() => handleInnerButtonClick(opcion.opciones.usuarios.url)}
                                    className={`peq:max-md:flex peq:max-md:flex-col-reverse w-48 h-8 text-xs bg-coomeva_color-grisPestaña justify-center ${opcion.opciones.usuarios.className}`}
                                >
                                    {opcion.opciones.usuarios.value}
                                </button>
                            </div>
                        )}
                    </div>
                ))}

                {listBtn?.map((opcion, i) => {
                    return (
                        <button
                            key={opcion.btnCod}
                            onClick={() => { navegar(opcion.url) }}
                            className={`peq:max-md:flex peq:max-md:flex-col-reverse w-full h-14 justify-center`}
                        >
                            <div className='flex items-center space-x-6 '>
                                <p className={`w-[140px] ${opcion.url === '' ? 'bg-coomeva_color-grisPestaña' : 'bg-coomeva_color-rojo '} text-xs rounded-md text-center py-2 text-white`} >{opcion.value}</p>
                                <p className='text-sm'>{opcion.label}</p>
                            </div>
                        </button>
                    );
                })}
            </div>
        </div >
        {
            (showModal)
            &&
            <DynamicModal titulo={'Notificación'} mostrarModal={endModal} ocultarBtnCancelar={true} textBtnContinuar="Ok" mostrarImagneFondo={true}>
                <p className="w-full text-sm text-center text-[#002e49f3] font-semibold">{messageAlert}</p>
            </DynamicModal>
        }
    </>
};