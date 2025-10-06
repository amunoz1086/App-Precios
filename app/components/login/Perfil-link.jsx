'use client'

import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { crearCookiPerfilTemporal, getSession } from '@/app/lib/auth/auth';
import { useDatosFuncionProvider } from '@/app/hooks/useDatosFuncionProvider';


export default function PerfilLink({ roles }) {

  const { limpiarProviderContext } = useDatosFuncionProvider();
  const router = useRouter();

  const fnSubName = () => {
    try {
      let subTitulo;

      if (roles?.length > 0) {
        switch (roles[0]) {
          case 'Administración': {
            subTitulo = 'Usuarios';
            break;
          }
          case 'ADFNC': {
            subTitulo = 'Parámetros';
            break;
          }
          default:
            break;
        }
        return subTitulo;
      };

    } catch (error) {
      console.log(error);
    };
  };

  const [rolPerfil] = useState([
    {
      id: 1,
      name: "Radicación",
      subName: "Radicación",
      rol: 'Radicación',
      redirect: "/radicacion",
      img: {
        url: "radicacion",
        alt: "",
        opacity: 0,
      },
      disabled: !(roles?.some(e => e === 'Radicación'))
    },
    {
      id: 2,
      name: "Aprobación",
      subName: "Aprobación",
      rol: 'Aprobación',
      redirect: "/radicacion/bandejaSolicitudes",
      img: {
        url: "aprobacion",
        alt: "",
        opacity: 0,
      },
      disabled: !(roles?.some(e => e === 'Aprobación'))
    },
    {
      id: 3,
      name: "Parametrización",
      subName: "Parametrización",
      rol: 'Parametrización',
      redirect: "/radicacion/bandejaSolicitudes",
      img: {
        url: "parametrizacion",
        alt: "",
        opacity: 0,
      },
      disabled: !(roles?.some(e => e === 'Parametrización'))
    },
    {
      id: 4,
      name: "Administrador",
      subName: (fnSubName()),
      rol: `${roles?.length > 0 ? roles[0] : ''}`,
      redirect: "/login/administracion",
      img: {
        url: "administracion",
        alt: "",
        opacity: 0,
      },
      disabled: !(roles?.some(e => e === 'Administración' || e === 'ADFNC'))
    },
    {
      id: 5,
      name: "Consulta",
      subName: "Consulta",
      rol: 'Consulta',
      redirect: "/radicacion/bandejaSolicitudes",
      img: {
        url: "parametrizacion",
        alt: "",
        opacity: 0,
      },
      disabled: !(roles?.some(e => e === 'Consulta'))
    },
  ]);


  useEffect(() => {
    limpiarProviderContext(true);
  }, []);


  const crearCookie = async (rol, link) => {
    crearCookiPerfilTemporal({ rol: rol });
    const rols = await getSession();

    if (rols) {
      router.push(link)
    };

  };


  return <>
    {rolPerfil.map((perfil) => (
      <button onClick={() => { crearCookie(perfil.rol, perfil.redirect) }} key={perfil.id} className='' disabled={perfil.disabled}>
        <section
          className={`relative w-full h-[6.5rem] flex flex-col justify-end rounded-md bg-cover bg-center ${perfil.img.url} p-3 after:absolute after:top-0 after:left-0 after:w-full after:h-full after:bg-black/15 after:rounded-xl ${perfil.disabled ? "cursor-not-allowed opacity-50" : "cursor-pointer"
            }`}
        >
          <div className="text-white z-50 text-start">
            <h1 className="text-2xl">{perfil.name}</h1>
            <h2 className="text-xl font-light">{perfil.subName}</h2>
          </div>
        </section>
      </button>
    )
    )}
  </>
};