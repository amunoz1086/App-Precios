import { queryListarTipoConvenio, queryListarTipoOperacion, queryListarTipoProducto } from "@/app/lib/admin/querys/listas"
import Cards from "./Cards"


export default async function FormSolicitud({rolActivo}) {

    const listTypeProducts = await queryListarTipoProducto()

    const listTipeOperactions = await queryListarTipoOperacion()

    const listTypeConvenios = await queryListarTipoConvenio()


    return (
        <div >
           <Cards
           listTypeProducts={JSON.parse(listTypeProducts)}

           listTipeOperactions={JSON.parse(listTipeOperactions)}
           
           listTypeConvenios={JSON.parse(listTypeConvenios)}

           rolActivo={rolActivo}
           
           />
        </div>
    )
}
