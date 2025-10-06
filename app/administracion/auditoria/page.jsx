import { FiltroAuditoria } from "@/app/components/administracion/auditoria/FiltroAuditoria";


export default async function auditoria() {

  return <section className='flex flex-wrap'>
    <div className='w-full  py-20 px-6  shadow-md'>
      <h5 className="text-center text-xl"><strong>Informe de Log de Eventos</strong></h5>
      <FiltroAuditoria />
    </div>
  </section>
};