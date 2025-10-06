'use client'

import { TiArrowBack, TiHome, TiDelete } from "react-icons/ti";
import { usePathname, useRouter } from 'next/navigation'
import { useDatosFuncionProvider } from "@/app/hooks/useDatosFuncionProvider";


const LinkHomeAtras = ({ perfilActivo }) => {

    const { limpiarProviderContext } = useDatosFuncionProvider();
    const pathName = usePathname();
    const pageActual = (pathName.split('/'))[2] || (pathName.split('/'))[1];
    const router = useRouter();


    const navegarAtrar = () => {
        pageActual !== 'bandejaSolicitudes' && perfilActivo !== 'Aprobación' && router.back()
    };


    const navegarHome = () => {
        if (perfilActivo === 'Radicación') {
            router.push('/radicacion')
        };
    };


    const cancelarOperacion = (reset = false) => {
        if (perfilActivo === 'Radicación') {
            limpiarProviderContext(true)
            router.push('/radicacion')
            return
        };

        if (perfilActivo !== 'ADFNC') {
            router.push('/radicacion/bandejaSolicitudes')
        };
    };

    
    return (
        <div className="flex space-x-2">
            <TiHome onClick={navegarHome} disabled={true} className={`${pageActual !== 'bandejaSolicitudes' && perfilActivo !== 'Aprobación' ? 'text-white' : 'text-gray-400'}  w-8 h-6 cursor-pointer`} />
            <TiArrowBack onClick={navegarAtrar} className={`${pageActual !== 'bandejaSolicitudes' && perfilActivo !== 'Aprobación' ? 'text-white' : 'text-gray-400'}  w-8 h-6 cursor-pointer`} />
            <TiDelete onClick={cancelarOperacion} className={`${pageActual !== 'bandejaSolicitudes' && perfilActivo !== 'Aprobación' ? 'text-white ' : 'text-gray-400'}  w-6 h-6 cursor-pointer`} />
        </div>
    )
}

export default LinkHomeAtras;