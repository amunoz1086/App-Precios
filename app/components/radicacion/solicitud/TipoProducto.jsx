'use client'

export default function TipoProducto({ listTypeProducts, onChangeSave, solicitud, deshabilitar }) {

  return (
    <div className={`p-6  h-64 w-60 border rounded-lg flex flex-col shadow-md bg-white  my-4`}>
      <h1 className="text-base mb-5 text-coomeva_color-rojo">Tipo de producto</h1>
      <div className="space-y-4">
        {
          listTypeProducts?.map(tipo => (
            <div key={tipo.COD_PRODUCTO} className="rounded flex basis-5/6 items-center space-x-2 ">
              <input
                id={tipo.COD_PRODUCTO}
                name={tipo.NOMBRE}
                onClick={onChangeSave}
                disabled={((tipo.COD_PRODUCTO === '02' /* || tipo.COD_PRODUCTO === '01' */) ? true : false) || deshabilitar}
                value={tipo.COD_PRODUCTO}
                type="checkbox"
                defaultChecked={
                  tipo.COD_PRODUCTO === '01' && solicitud?.tipoProducto?.credito ||
                  tipo.COD_PRODUCTO === '03' && solicitud?.tipoProducto?.convenio
                }

                className={`border border-coomeva_color-grisPestaña border-opacity-30 shadow-sm ${tipo.COD_PRODUCTO !== '2'
                  ?
                  tipo.COD_PRODUCTO === '01' && solicitud?.tipoProducto?.credito ? "bg-coomeva_color-azulClaro cursor-default" :
                    tipo.COD_PRODUCTO === '03' && solicitud?.tipoProducto?.convenio ? "bg-coomeva_color-azulClaro cursor-default " : 'cursor-default'
                  : null} appearance-none w-7 h-7  rounded-md `}
              />
              <label className={`text-sm ${tipo.COD_PRODUCTO !== '2' ? "cursor-default" : null} text-coomeva_color-azulOscuro`} htmlFor={tipo.COD_PRODUCTO}>{tipo.NOMBRE}</label>
            </div>
          ))
        }
      </div>
    </div>
  )
}