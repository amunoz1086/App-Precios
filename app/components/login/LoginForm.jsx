'use client'

import { TbUserExclamation } from "react-icons/tb";
import { FaEyeSlash, FaEye } from "react-icons/fa";
import Link from "next/link";
import { useFormState, useFormStatus } from 'react-dom';
import { adminLogin, eliminarSession } from "@/app/lib/auth/auth";
import { useEffect, useState } from "react";
import Loading from "../share/Loading";
import { useRouter } from 'next/navigation';
import dynamic from "next/dynamic";

const DynamicModal = dynamic(() => import('../share/Modals'))


export default function LoginForm() {

    const [errorMessage, dispatch] = useFormState(adminLogin, undefined);
    const [showModal, setShowModal] = useState(false);
    const router = useRouter();


    useEffect(() => {
        errorMessage?.sessionActiva && setShowModal(!showModal)
        errorMessage?.path && router.push(errorMessage?.path)
    }, [errorMessage]);


    useEffect(() => {
        let uaNavi = ua();
        try {
            if (uaNavi === undefined) {
                document.getElementById('FaEyeSlash').classList.remove('invisible');
            } else {
                if (uaNavi.brands[0].brand !== "Microsoft Edge") {
                    document.getElementById('FaEyeSlash').classList.remove('invisible');
                };
            };
        } catch (error) {
            console.log(error);
        };
    });


    const ua = () => {
        return navigator.userAgentData;
    };


    const viewPass = () => {
        document.getElementById('FaEye').classList.remove('invisible');
        document.getElementById('FaEyeSlash').classList.add('invisible');
        document.getElementById('password').type = 'text';
    };


    const hidePass = () => {
        document.getElementById('FaEyeSlash').classList.remove('invisible');
        document.getElementById('FaEye').classList.add('invisible');
        document.getElementById('password').type = 'password';
    };


    const cerrarSessionIniciarSession = async () => {
        const respCerrar = await eliminarSession(errorMessage.token);
        if (respCerrar) {
            const form = document.getElementById("frmLogin");
            const frmData = new FormData(form);
            await adminLogin(false, frmData);
            setShowModal(false);
        };
    };


    const endModal = () => {
        setShowModal(false);
    };


    return (
        <form action={dispatch} id="frmLogin" >
            <div className="flex flex-col w-full justify-end">
                <div className="relative block mb-5 border-b-gray-300 border-b">
                    <input
                        id="foco_user"
                        name="foco_user"
                        type="text"
                        className="py-2 focus:outline-none bg-transparent text-lg w-full block peer z-0"
                        required
                        autoComplete="off"
                        autoFocus
                    />
                    <label
                        className={`absolute bottom-0 py-2 left-0 transition-all pointer-events-none text-gray-500 peer-valid:-translate-y-6 peer-valid:text-sm peer-focus:-translate-y-6 peer-focus:text-sm`}
                        htmlFor="foco_user"
                        id="labelUsuario"
                    >
                        Usuario
                    </label>
                </div>
                <div className="relative block border-b-gray-300 border-b">
                    <span id="FaEyeSlash" className="absolute inset-y-0 right-0 flex items-center pr-2 z-0 invisible">
                        <FaEyeSlash
                            className="text-2xl cursor-pointer"
                            // style={{ cursor: 'pointer' }}
                            onClick={viewPass}
                        />
                    </span>
                    <span id="FaEye" className="absolute inset-y-0 right-0 flex items-center pr-2 z-0 invisible">
                        <FaEye
                            className="text-2xl cursor-pointer"
                            // style={{ cursor: 'pointer' }}
                            onClick={hidePass}
                        />
                    </span>
                    <input
                        id="password"
                        name="foco_pass"
                        type="password"
                        className=" py-2 focus:outline-none text-lg bg-transparent w-full block peer"
                        required
                        autoComplete="off"
                        onChange={hidePass}
                    />
                    <label
                        className="absolute bottom-0 py-2 left-0 transition-all pointer-events-none text-gray-500 peer-valid:-translate-y-6 peer-valid:text-sm peer-focus:-translate-y-6 peer-focus:text-sm"
                        htmlFor="password"
                        id="labelContraseña"
                    >
                        Contraseña
                    </label>
                </div>
                <div className="text-end">
                    <Link
                        target="__blank"
                        href="https://secure.coomeva.com.co/autogestiondeclavesgecc/public/forgottenpassword"
                        className="pt-2 no-underline text-gray-400 mb-2 text-sm"
                    >
                        ¿Olvidaste tu contraseña?
                    </Link>
                </div>
            </div>
            <div
                className="flex h-8 items-end space-x-1"
                aria-live="polite"
                aria-atomic="true"
            >
                {!errorMessage?.status && errorMessage?.status === false && (
                    <>
                        <TbUserExclamation className="h-5 w-5 text-red-500" />
                        <p className="text-sm text-red-500">{errorMessage?.message}</p>
                    </>
                )}
            </div>
            <div className="w-full flex mt-6">
                <LoginButtom />
            </div>
            <br />
            <br />
            <h4 className="mt-20 w-full text-center">v1.0.30C</h4>
            {
                (showModal)
                &&
                <DynamicModal titulo={'Notificación'} mostrarModal={cerrarSessionIniciarSession} cerrarModal={endModal} textBtnContinuar="Continuar" mostrarImagneFondo={true}>
                    <p className="w-full text-sm text-center text-[#002e49f3] font-semibold">{errorMessage?.message + '. Si continúas, se cerrará la sesión actual y se iniciará una nueva. ¿Deseas continuar?"'}</p>
                </DynamicModal>
            }
        </form>
    )
};


function LoginButtom() {
    const { pending } = useFormStatus();
    return (
        <>
            {
                pending && <Loading />
            }
            <button
                id="login"
                aria-disabled={pending}
                className={`py-2 px-16 ${pending ? 'bg-coomeva_color-grisPestaña' : 'bg-green-700'}  hover:bg-green-900 transition duration-700 ease-out rounded-xl mx-auto text-white text-sm`}
            >
                Continuar
            </button>
        </>
    )
};
