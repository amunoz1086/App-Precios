import { cookies } from "next/headers";
import { redirect } from "next/navigation";
import Navbar from "../components/headers/Navbar";
import SubtituloNavbarAdmin from "../components/headers/SubtituloNavbarAdmin";

export default function Layout({ children }) {

    const rolActivo = cookies().get('rol')?.value;
    if (rolActivo !== 'Administración' && rolActivo !== 'ADFNC') return redirect('/login/perfil');

    return (
        <div className="px-8">
            <Navbar />
            <SubtituloNavbarAdmin />
            {children}
        </div>
    );
};