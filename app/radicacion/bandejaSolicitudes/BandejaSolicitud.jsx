'use client';

import { useContext, useEffect, useRef, useState } from "react";
import ItemsSolicitudBandeja from "./ItemsSolicitudBandeja";
import { DataContext } from "@/app/provider/Providers";
import { queryListarSolicitudes } from '@/app/lib/solicitudes/queryListarSolicitudes';
import dynamic from 'next/dynamic';
import Loading from "@/app/components/share/Loading";
import { useDatosFuncionProvider } from "@/app/hooks/useDatosFuncionProvider";
import { HiAdjustmentsHorizontal } from "react-icons/hi2";

const DynamicModal = dynamic(() => import('../../components/share/Modals'));

export default function BandejaSolicitud({ searchParams }) {

  const valorConsulta = searchParams?.q || '';
  const [showModal, setShowModal] = useState(false);
  const [messageAlert, setMessageAlert] = useState('');
  const [showLoading, setShowLoading] = useState(false);
  const contextData = useContext(DataContext);
  const { limpiarProviderContext } = useDatosFuncionProvider();
  const [lista, setLista] = useState([]);
  const [originalLista, setOriginalLista] = useState([]);

  const [listAprobacion, setListAprobacion] = useState([]);
  const [listDecision, setListDecision] = useState([]);
  const [listParametrizador, setListParametrizador] = useState([]);
  const [filterDisable, setFilterDisable] = useState(true);


  useEffect(() => {
    listaBandejaSolicitud();
    limpiarProviderContext();
  }, []);


  useEffect(() => {

    const consultarFiltro = async (event) => {

      if (event.detail == true) {


        console.log(event.detail)


        console.log('me ejecute')

        if(!mostrarFiltro)return



        const desdeValor = document.getElementById('desde').value
        const hastaValor = document.getElementById('hasta').value

        if (!desdeValor || !hastaValor) {
          setShowModal(true)
          setMessageAlert("Por favor, selecciona ambas fechas.")
          console.error("Por favor, selecciona ambas fechas.");
          return;
        }

        const desdeFecha = new Date(desdeValor);
        const hastaFecha = new Date(hastaValor);


        const desdeHasta = {
          "dateDesde": desdeFecha.toISOString(),
          "dateHasta": hastaFecha.toISOString()
        };

        setShowLoading(true);

        try {

          const response = await queryListarSolicitudes(JSON.stringify(desdeHasta));
          const resp = JSON.parse(response);

          console.log(resp)

          if (resp.STATUS) {
            let data = JSON.parse(resp.DATA);
            if (data.length > 0) {
              setLista(data);
              setOriginalLista(data);
              console.log(data)
            }
          } else {
            setShowLoading(false);
            setMessageAlert(resp.MESSAGE);
            setShowModal(true);
          };

          setShowLoading(false);

        } catch (error) {

          setShowLoading(false);
          console.log(error);

        }

      }

    };


    window.addEventListener('consultarFiltro', consultarFiltro);

    return () => {
      window.removeEventListener('consultarFiltro', consultarFiltro);

    };
  }, []);





  const listaBandejaSolicitud = async () => {

    setShowLoading(true);

    try {
      const fechaActual = new Date();
      const fechaAtras = new Date(fechaActual);
      fechaAtras.setDate(fechaActual.getDate() - 180);

      const desdeHasta = {
        "dateDesde": fechaAtras.toISOString(),
        "dateHasta": fechaActual.toISOString()
      }

      const response = await queryListarSolicitudes(JSON.stringify(desdeHasta));
      const resp = JSON.parse(response);

      if (resp.STATUS) {
        let data = JSON.parse(resp.DATA);
        if (data.length > 0) {
          setLista(data);
          setOriginalLista(data);
          setFilterDisable(false);
          await generarListas(data);
        }
      } else {
        setShowLoading(false);
        setMessageAlert(resp.MESSAGE);
        setShowModal(true);
      };

      setShowLoading(false);

    } catch (error) {
      setShowLoading(false);
      console.log(error);
    };

  };


  const generarListas = async (data) => {

    const rawAprobacion = new Array();
    const rawDecision = new Array();
    const rawParametrizador = new Array();

    try {

      for (const i of data) {
        rawAprobacion.push(i.codEnte);
        rawDecision.push(i.Aprobacion);
        rawParametrizador.push(i.Parametrizacion);
      };

      const itemAprobacion = [...new Set(rawAprobacion)];

      setListAprobacion(itemAprobacion)
      const itemDecision = [...new Set(rawDecision)];
      const itemParametrizador = [...new Set(rawParametrizador)];

      setListParametrizador(itemParametrizador)

      // setListAprobacion(itemAprobacion.map(aprobacion => <option key={aprobacion} value={aprobacion} >{aprobacion}</option>));
      setListDecision(itemDecision.map(decision => <option key={decision} value={decision} >{decision}</option>));
      // setListParametrizador(itemParametrizador.map(parametrizador => <option key={parametrizador} value={parametrizador} >{parametrizador}</option>));

    } catch (error) {
      console.log(error);
    };
  };


  const filtrardData = (valorConsulta !== '' && valorConsulta !== undefined) ? lista.filter(e => e.NIT_CLIENTE === valorConsulta) : lista;

  useEffect(() => {
    if((valorConsulta !== '' && valorConsulta !== undefined))
    setLista(lista.filter(e => e.NIT_CLIENTE === valorConsulta))
  }, [valorConsulta])
  
  const endModal = () => setShowModal(false);


  const filtroExportacionExcel = () => {
    setMostrarFiltro(true)
  };

  const [mostrarFiltro, setMostrarFiltro] = useState(false);

  const [selectedOptions, setSelectedOptions] = useState([]);
  const [selectedOptions2, setSelectedOptions2] = useState([])
  const [isOpen, setIsOpen] = useState(false);
  const [isOpen2, setIsOpen2] = useState(false);
  const selectRef = useRef(null);
  const selectRef2 = useRef(null);

  useEffect(() => {

    const onFocusMouse = (event) => {
      if (selectRef.current && !selectRef.current.contains(event.target)) {
        setIsOpen(false);
      }
    }
    document.addEventListener('mousedown', onFocusMouse);
    return () => {
      document.removeEventListener('mousedown', onFocusMouse);
    };

  }, [selectRef]);

  useEffect(() => {

    const onFocusMouse = (event) => {
      if (selectRef2.current && !selectRef2.current.contains(event.target)) {
        setIsOpen2(false);
      }
    }
    document.addEventListener('mousedown', onFocusMouse);
    return () => {
      document.removeEventListener('mousedown', onFocusMouse);
    };

  }, [selectRef2]);

 
  const handleOptionClick = (option, estado) => {

    if (estado === 1) {
      const newSelectedOptions = selectedOptions.includes(option)
        ? selectedOptions.filter((item) => item !== option)
        : [...selectedOptions, option];
      setSelectedOptions(newSelectedOptions);

      onChangeInput({ target: { value: document.getElementById('nSolicitud')?.value || '' } }, newSelectedOptions, selectedOptions2);
    } else if (estado === 2) {
      const newSelectedOptions2 = selectedOptions2.includes(option)
        ? selectedOptions2.filter((item) => item !== option)
        : [...selectedOptions2, option];
      setSelectedOptions2(newSelectedOptions2);
      onChangeInput({ target: { value: document.getElementById('nSolicitud')?.value || '' } }, selectedOptions, newSelectedOptions2);
    }
  };




  const onChangeInput = (e, currentSelectedOptions = selectedOptions, currentSelectedOptions2 = selectedOptions2) => {

    const valorBuscar = e.target.value ? e.target.value.toLowerCase() : '';


    const listaFiltrada = originalLista.filter((item) => {
      const cliente = item.CLIENTE ? String(item.CLIENTE).toLowerCase() : '';
      const codSolicitud = item.COD_SOLICITUD ? String(item.COD_SOLICITUD).toLowerCase() : '';
      const decision = item.Aprobacion ? String(item.Aprobacion).toLowerCase() : ''; 

      const textSearchMatches =
        valorBuscar === '' || 
        codSolicitud.includes(valorBuscar) ||
        cliente.includes(valorBuscar) ||
        decision.includes(valorBuscar);

      const enteAprobacionMatches =
        currentSelectedOptions.length === 0 ||
        currentSelectedOptions.map(option => String(option).toLowerCase()).includes(String(item.codEnte || '').toLowerCase());

      const parametrizadorMatches =
        currentSelectedOptions2.length === 0 || 
        currentSelectedOptions2.map(option => String(option).toLowerCase()).includes(String(item.Parametrizacion || '').toLowerCase());

      return textSearchMatches && enteAprobacionMatches && parametrizadorMatches;
    });

    setLista(listaFiltrada);
  };



  const cancelarFiltro = async () => {
    setMostrarFiltro()
    setSelectedOptions([])
    setSelectedOptions2([])
    await listaBandejaSolicitud()

  }

  const convertToCSV = (data) => {
    const headers = Object.keys(data[0]).join(";");
    const rows = data.map((item) => Object.values(item).join(";"));
    return `${headers}\n${rows.join("\n")}`;
  };


  const exportToCSV = ({ data: data }) => {
    const csvContent = convertToCSV(data);
    const BOM = "\uFEFF"; // Marca BOM para UTF-8
    const blob = new Blob([BOM + csvContent], { type: "text/csv;charset=utf-8;" });
    const url = URL.createObjectURL(blob);
    const link = document.createElement("a");
    link.href = url;
    link.setAttribute("download", "datos_exportados.csv");
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  };


  const generarReporte = async (e) => {
   
        exportToCSV({ data: lista })
      
     
  };




  return (
    <>
      <div className="flex justify-end  py-2">
        <div className="flex gap-4  ">
          <div className="flex gap-3 items-center cursor-pointer" onClick={filtroExportacionExcel}>
            <p>Filtro</p>
            <HiAdjustmentsHorizontal />
          </div>
          <div>
            <button 
            onClick={!(lista.length>0)?()=>{}:generarReporte} 
            disabled={!(lista.length>0)}
            className={`${!(lista.length>0)?'bg-gray-500 text-white':'bg-white text-coomeva_color-grisLetras'} shadow-md  py-2 px-4 rounded-md`}
            >Exportar a Excel</button>
          </div>
        </div>
      </div>
      {
        mostrarFiltro ?
          <div className="flex items-center gap-8">
            {/* Fecha Desde: */}
            <div className="flex flex-col gap-2  w-full">
              <label htmlFor="desde" className="">Fecha Desde:</label>
              <input
                type="date"
                name="desde"
                id="desde"
                className="outline-none border border-gray-400  px-2 rounded-md"
              />
            </div>
            {/* Fecha Hasta: */}
            <div className="flex flex-col gap-2  w-full">
              <label htmlFor="hasta" className="">Fecha Hasta:</label>
              <input
                type="date"
                name="hasta"
                id="hasta"
                className="outline-none border border-gray-400  px-2 rounded-md"
              />
            </div>
            {/* Número de Solicitud: */}
            <div className="flex flex-col gap-2  w-full">
              <label htmlFor="nSolicitud" className="">Número de Solicitud:</label>
              <input
                type="number"
                name="nSolicitud"
                id=""
                className="outline-none border border-gray-400  px-2 rounded-md"
                disabled={filterDisable}
                onChange={onChangeInput}
              />
            </div>

            <div className="flex flex-col gap-2 w-64 relative" ref={selectRef}>
              <label htmlFor="" className="">
                Ente de aprobación
              </label>

              <div
                onClick={() => setIsOpen(!isOpen)}
                className="px-2 border w-48 border-gray-300 rounded-md cursor-pointer flex justify-between items-center bg-white"
              >
                <span>
                  {selectedOptions.length > 0
                    ? selectedOptions[selectedOptions.length - 1]
                    : 'Selecciona'}
                </span>
                <svg
                  className={`w-5 h-5 transition-transform ${isOpen ? 'transform rotate-180' : ''
                    }`}
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M19 9l-7 7-7-7"
                  />
                </svg>
              </div>
              {isOpen && (
                <div className="absolute z-10 w-48 mt-1 border border-gray-300 rounded-md bg-white shadow-lg top-full"> {/* Se agregó top-full para un posicionamiento correcto */}
                  {listAprobacion.map((option) => (
                    <div
                      key={option}
                      onClick={() => handleOptionClick(option, 1)}

                      className={`p-2 cursor-pointer ${selectedOptions.includes(option)
                        ? 'bg-blue-500 text-white'
                        : 'hover:bg-gray-100'
                        }`}
                    >
                      {option}
                    </div>
                  ))}
                </div>
              )}
            </div>

            {/* Decisión: */}
            <div className="flex flex-col gap-2  w-full">
              <label htmlFor="decision">Decisión:</label>
              <select
                name="decision"
                id=""
                className="outline-none border border-gray-400  px-2 rounded-md"
                disabled={filterDisable}
                onChange={onChangeInput}
              >
                <option value="">Seleccione</option>
                {listDecision}
              </select>
            </div>
            <div className="flex flex-col Estado Parametrizador: gap-2 relative" ref={selectRef2}>
              <label htmlFor="" className="">
                Estado Parametrizador
              </label>

              <div
                onClick={() => setIsOpen2(!isOpen2)}
                className="px-2 border w-48 border-gray-300 rounded-md cursor-pointer flex justify-between items-center bg-white"
              >
                <span>
                  {selectedOptions2.length > 0
                    ? selectedOptions2[selectedOptions2.length - 1]
                    : 'Selecciona'}
                </span>
                <svg
                  className={`w-5 h-5 transition-transform ${isOpen ? 'transform rotate-180' : ''
                    }`}
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M19 9l-7 7-7-7"
                  />
                </svg>
              </div>
              {isOpen2 && (
                <div className="absolute z-10 w-48 mt-1 border border-gray-300 rounded-md bg-white shadow-lg top-full"> {/* Se agregó top-full para un posicionamiento correcto */}
                  {listParametrizador.map((option) => (
                    <div
                      key={option}
                      onClick={() => handleOptionClick(option, 2)}
                      className={`p-2 cursor-pointer ${selectedOptions2.includes(option)
                        ? 'bg-blue-500 text-white'
                        : 'hover:bg-gray-100'
                        }`}
                    >
                      {option}
                    </div>
                  ))}
                </div>
              )}
            </div>


            <div className="w-full flex justify-center">
              <button
                onClick={cancelarFiltro} className="bg-coomeva_color-rojo text-white px-6 py-1 text-xs  rounded-md">
                Cancelar
              </button>
            </div>
          </div>
          : undefined
      }
      <div className="overflow-y-scroll h-[60vh]">
        {
          showLoading && <Loading />
        }
        {
          (showModal)
          &&
          <DynamicModal titulo={'Notificación'} mostrarModal={endModal} ocultarBtnCancelar={true} textBtnContinuar="Ok" mostrarImagneFondo={true}>
            <p className="w-full text-sm text-center text-[#002e49f3] font-semibold">{messageAlert}</p>
          </DynamicModal>
        }
        {filtrardData.map(solicitud => (<ItemsSolicitudBandeja key={solicitud.COD_SOLICITUD} contextData={contextData} solicitud={solicitud} />))}
      </div>
    </>
  )
};