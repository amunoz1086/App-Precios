'use client'

import { useRouter, usePathname } from 'next/navigation';
import { useState } from "react";
import dynamic from 'next/dynamic';

const DynamicModal = dynamic(() => import('@/app/components/share/Modals'));

export default function BtnControl({ name, context, arial_label, url, handleTabClick, cliente, resetResultados,
  setEvaluar, enableButton, opcion, data, nameFuctionContext, validarCampos, descicion, frmId, frmId2, paddingX,
  functionEvaluarSolcitud, solicitarAprobacion, finalizarParametrizacion, editarCliente, functionContinuar,
  enviarParametrizar, updateRutaActual, updateRutaAnterior }) {

  const [mostrarModal, setMostrarModal] = useState(false);
  const [messageModal, setMessageModal] = useState('');

  const router = useRouter();
  const pathName = usePathname();

  const opcionesFunciones = {
    'navegar': (url) => {
      if (name == 'Ver detalle' && (pathName.split('/'))[2] != 'configuracion') {
        resetResultados()
      };
      if (name === "Iniciar Solicitud") {
        if (cliente?.hasOwnProperty('oficinaTaylor') && (cliente?.oficinaTaylor > 0)) {
          if (!enableButton) {
            return;
          }
          router.push(url);
        } else {
          if (!enableButton) {
            return;
          }
          setMessageModal(`Atención: la oficina no ha sido homologada. ¿Desea continuar?`);
          setMostrarModal(!mostrarModal);
        };
      } else if (name === "Documentos") {
        if (!enableButton) {
          return;
        }
        router.push(url);
      } else {
        router.push(url)
      };
    },
    'navegarActualizarContext': () => {
      if (enableButton && (!validarCampos)) {
        nameFuctionContext && updateContext()
        router.push(url)
      }
    },
    'adicionarCuentaResumen': (url) => enableButton ? validarCamposObligaroriosNavegar(url) : undefined,
    'evaluar': async () => enableButton ? await functionEvaluarSolcitud() : undefined,
    'solictarAprobacion': async () => { enableButton && await solicitarAprobacion({ message: '¿Seguro que desea enviar la operación?', functionContinuar: functionContinuar }) },
    'finalizarParametrizacion': async () => enableButton && await finalizarParametrizacion({ message: '¿Seguro que desea finalizar la operación?', functionContinuar: functionContinuar }),
    'negar': async () => enableButton ? await finalizarParametrizacion({ message: '¿Seguro que desea negar la operación?', functionContinuar: functionContinuar, observacion: true }) : undefined,
    'aprobar': async () => enableButton ? await finalizarParametrizacion({ message: '¿Seguro que desea aprobar la operación?', functionContinuar: functionContinuar }) : undefined,
    'documentos': () => enableButton,
    'verDetalle': () => { },
    'editar': () => editarCliente(),
    'enviarParametrizar': async () => enableButton ? await enviarParametrizar() : undefined,
    'ajustar': async () => enableButton ? await finalizarParametrizacion({ message: '¿Deseas ajustar los parametros de la solicitud?', functionContinuar: functionContinuar }) : undefined,
  };

  const onClickRouter = () => opcionesFunciones[opcion](url);
  const updateContext = () => context[nameFuctionContext](data);

  const validarCamposObligaroriosNavegar = (url) => {
    const formId = document.getElementById(frmId);
    const formId2 = document.getElementById(frmId2);

    if ((!formId.checkValidity()) || (!formId2.checkValidity())) {
      formId.reportValidity()
      formId2.reportValidity()
      return
    };
    router.push(url);
  };

  const cerrarModal = () => {
    setMostrarModal(!mostrarModal);
  };

  const btnContinuarModal = () => {
    router.push(url);
    setMostrarModal(!mostrarModal);
  };

  return (
    <>
      <button
        aria-label={arial_label}
        className={enableButton ? `bg-coomeva_color-rojo text-white w-48 text-xs ${paddingX ? 'px-10' : 'px-6'}  py-3 mt-2 mx-2  rounded-md` : 'bg-[#58585A] text-white font-medium cursor-default w-48 mx-2 py-3 text-xs px-6 mt-2 rounded-md'}
        onClick={onClickRouter}
      >
        {name}
      </button>
      {
        (mostrarModal)
        &&
        <DynamicModal titulo={'Notificación'} cerrarModal={cerrarModal} mostrarImagneFondo={true} mostrarModal={() => { btnContinuarModal() }}>
          <p className="w-full text-sm text-center text-[#002e49f3] font-semibold">{messageModal}</p>
        </DynamicModal>
      }
    </>
  )
}