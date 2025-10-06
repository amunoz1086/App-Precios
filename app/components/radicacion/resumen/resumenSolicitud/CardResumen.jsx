'use client'

import TipoOperacion from "../../solicitud/TipoOperacion";
import TipoProducto from "../../solicitud/TipoProducto";

export default function CardResumen({ listTypeProducts, listTipeOperactions, solicitud }) {

    return (
        <>
            <TipoProducto listTypeProducts={listTypeProducts.DATA} solicitud={solicitud} />
            <TipoOperacion listTipoOperations={listTipeOperactions.DATA} solicitud={solicitud} />
        </>
    )
}