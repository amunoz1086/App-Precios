'use client'

import { useState, useEffect } from "react";
import Loading from "../../share/Loading";
import { fnQueryListarUsuarios } from "@/app/lib/admin/usuarios/queryListarUsuarios";
import { queryListarAccion } from "@/app/lib/admin/querys/listas";
import { fnQueryAuditoria } from "@/app/lib/admin/auditoria/queryAuditoria";
import ModalMenu from "@/app/components/share/Mdl";


export const FiltroAuditoria = () => {

    const [listConversionExcel, setListConversionExcel] = useState([]);
    const [showLoading, setShowLoading] = useState(false);
    const [datosFiltro, setDatosFiltro] = useState({
        "usuario": '',
        "accion": '',
        "desde": '',
        "hasta": ''
    });
    const [loadListUsuarios, setLoadListUsuarios] = useState([]);
    const [loadListAccion, setLoadListAccion] = useState([]);

    /* estado inicial modal  */
    const [showModal, setShowModal] = useState(false);
    const [messageAlert, setMessageAlert] = useState('');
    const [valueBtnOne, setValueBtnOne] = useState('');
    const [valueBtnSecond, setValueBtnSecond] = useState('');
    const [visibBtnOne, setVisibBtnOne] = useState('');
    const [visibBtnSecond, setVisibBtnSecond] = useState('');
    const [fnBtnOne, setFnBtnOne] = useState();
    const [fnBtnSecond, setFnBtnSecond] = useState();


    useEffect(() => {
        loadListarUsuarios();
        loadListarAccion();
        document.getElementById('btnGuardar').classList.add('invisible');
    }, []);


    const callModal = (showModal, messageModal, valueBtnModalOne, valueBtnModalSecond, visibBtnOneModal, visibBtnSecondModal, codeBtnOne, codeBtnSecond) => {
        setShowModal(showModal);
        setMessageAlert(messageModal);
        setValueBtnOne(valueBtnModalOne);
        setValueBtnSecond(valueBtnModalSecond);
        setVisibBtnOne(visibBtnOneModal);
        setVisibBtnSecond(visibBtnSecondModal);
        setFnBtnOne(codeBtnOne);
        setFnBtnSecond(codeBtnSecond);
    };


    const cancelar = () => {
        setShowModal(false);
    };


    const loadListarUsuarios = async () => {
        try {
            const listarUsuarios = JSON.parse(await fnQueryListarUsuarios());
            const dataResult = listarUsuarios.data;
            setLoadListUsuarios(dataResult.map(user => <option key={user.USUARIO} value={user.USUARIO} >{user.NOMBRE}</option>));
        } catch (error) {
            console.log(error);
        };
    };


    const loadListarAccion = async () => {
        try {
            const listarAccion = JSON.parse(await queryListarAccion());
            const dataResult = listarAccion.DATA;
            setLoadListAccion(dataResult.map(accion => <option key={accion.codLista} value={accion.codLista} >{accion.descripcion}</option>));
        } catch (error) {
            console.log(error);
        };
    };


    const onChangeInput = (e) => {
        const { name, value } = e.target
        setDatosFiltro({
            ...datosFiltro,
            [name]: value
        })
    };


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
        setShowLoading(true)
        try {
            if (datosFiltro.usuario === "") {
                setShowLoading(false);
                callModal(true, `Debe seleccionar al menos un valor para el  filtro  Usuario`, '', 'Ok', 'none', '', null, () => cancelar);
                return;
            };

            if (datosFiltro.accion === "") {
                setShowLoading(false);
                callModal(true, `Debe seleccionar al menos un valor para el  filtro  Acción`, '', 'Ok', 'none', '', null, () => cancelar);
                return;
            };

            if (datosFiltro.desde === "" || datosFiltro.hasta === "") {
                setShowLoading(false);
                callModal(true, `Debe indicar la fecha desde y hasta para poder contnuar`, '', 'Ok', 'none', '', null, () => cancelar);
                return;
            };

            const resApi = JSON.parse(await fnQueryAuditoria(JSON.stringify(datosFiltro)))
            if (resApi.status === 200) {
                const totalDadta = resApi.data.length

                if (totalDadta === 0) {
                    setShowLoading(false);
                    callModal(true, `Sin resultados con los filtros aplicados. Modifíquelos e intente otra vez`, '', 'Ok', 'none', '', null, () => cancelar);
                    return;
                }

                exportToCSV({ data: resApi.data })
                //exportToCSV({ data: resApi.data })
                setShowLoading(false)
            } else {
                throw Error(resApi.status);
            }

        } catch (error) {
            console.log(error)
            callModal(true, `${error}`, '', 'Ok', 'none', '', null, () => cancelar);
            setShowLoading(false)
        }
    };


    return (
        <>
            <div className="flex gap-8 w-full my-8">
                <div className="flex gap-3 items-center w-full">
                    <label htmlFor="usuario">Usuario: </label>
                    <select
                        name="usuario"
                        id=""
                        className="outline-none border border-gray-400 w-full py-2 px-2 rounded-md"
                        onChange={onChangeInput}
                    >
                        <option value="">Seleccione</option>
                        <option value="A">Todos</option>
                        {loadListUsuarios}
                    </select>
                </div>
                <div className="flex gap-3 items-center w-full">
                    <label htmlFor="accion">Acción: </label>
                    <select
                        name="accion"
                        id=""
                        className="outline-none border border-gray-400 w-full py-2 px-2 rounded-md"
                        onChange={onChangeInput}
                    >
                        <option value="">Seleccione</option>
                        {loadListAccion}
                    </select>
                </div>
                <div className="flex gap-3 items-center w-full">
                    <label htmlFor="desde" className="w-[20%]">Fecha Desde: </label>
                    <input
                        type="date"
                        name="desde"
                        id=""
                        className="outline-none border border-gray-400 w-[70%] py-2 px-2 rounded-md"
                        onChange={onChangeInput}
                    />
                </div>
            </div>
            <div className="flex gap-8 w-full">
                <div className="flex gap-2 items-center ">
                    <label htmlFor="hasta" className="">Fecha Hasta: </label>
                    <input
                        type="date"
                        name="hasta"
                        id=""
                        className="outline-none border border-gray-400 w-[30rem] px-2  py-2  rounded-md"
                        onChange={onChangeInput}
                    />
                </div>
                <div className="flex gap-3 items-center ">
                    <button onClick={generarReporte} className="bg-coomeva_color-rojo  py-2 w-52 rounded-md text-white">Exportar a Excel</button>
                </div>
            </div>
            {
                showLoading && <Loading />
            }
            {showModal ? (
                <ModalMenu
                    clickBtnOne={fnBtnOne}
                    clickBtnSecond={fnBtnSecond}
                    viewBtnOne={visibBtnOne}
                    viewBtnSecond={visibBtnSecond}
                    modalMenssage={messageAlert}
                    valBtnOne={valueBtnOne}
                    valBtnSecond={valueBtnSecond}
                />
            ) : null}
        </>
    )
};