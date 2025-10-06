import { cookies, headers } from "next/headers";
import { redirect } from "next/navigation";

import Usuarios from "@/app/components/administracion/usuarios/Usuarios";

export default async function usuarios() {

    const headersList = headers()

    const referer = headersList.get('referer')

    // if(referer == null) {redirect('/login/administracion')}

    const rolActivo = cookies().get('rol')?.value;
    // if (rolActivo !== 'Administración') return redirect('/login/perfil');

    return <section className='flex flex-wrap'>
        <div className='w-full  p-2'>
            <Usuarios />
        </div>
    </section>
};