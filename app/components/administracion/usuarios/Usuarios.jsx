'use client';

import React, { useEffect, useState } from "react";
/* components */
import ModalMenu from "@/app/components/share/Mdl";
/* function */
import { fnQueryListarCargos } from "@/app/lib/admin/usuarios/queryListarCargo";
import { fnQueryListarOficinas } from "@/app/lib/admin/usuarios/queryListarOficinas";
import { fnQueryListarRegional } from "@/app/lib/admin/usuarios/queryListarRegional";
import { fnQueryListarCanal } from "@/app/lib/admin/usuarios/queryListarCanal";
import { fnQueryListarPerfil } from "@/app/lib/admin/usuarios/queryListarPerfil";
import { fnQueryListarTipoAprobador } from "@/app/lib/admin/usuarios/queryListarTipoAprobador";
import { fnQueryListarUsuarios } from "@/app/lib/admin/usuarios/queryListarUsuarios";
import { fnQueryUsuarios } from "@/app/lib/admin/usuarios/queryUsuario";
import { fnQueryUpdateUsuarios } from "@/app/lib/admin/usuarios/queryUpdateUsuario";
import { fnQueryInsertUsusario } from "@/app/lib/admin/usuarios/queryInsertUsuario";
import { fnDeleteUsuarios } from "@/app/lib/admin/usuarios/queryDeleteUsuario";
import { val_fn_profile } from "@/app/lib/auth/fn_profile";
import Loading from "../../share/Loading";
import { queryListarEstado } from "@/app/lib/admin/querys/listas";
import { ModalObservacion } from '../../share/ModalObservacion';

const Usuarios = () => {

    /* estado inicial de datos */
    const [usuario, setUsuario] = useState("");
    const [mensajeObservacion, setMensajeObservacion] = useState('');
    const [observaciotextArea, setObservaciotextArea] = useState('');
    const [opcionEliminarEstado, setOpcionEliminarEstado] = useState(0);
    const [estado, setEstado] = useState();

    /* estado inicial de las listas */
    const [listItemsOficina, setListItemsOficina] = useState([]);
    const [listItemsCargo, setListItemsCargo] = useState([]);
    const [listItemsRegional, setListItemsRegional] = useState([]);
    const [listItemsCanal, setListItemsCanal] = useState([]);
    const [listItemsPerfil, setListItemsPerfil] = useState([]);
    const [listItemsAprobador, setListItemsAprobador] = useState([]);
    const [listItemEstado, setListItemEstado] = useState([])
    const [listConversionExcel, setlistConversionExcel] = useState([])
    const [estadoSeleccionado, setEstadoSeleccionado] = useState('')

    /* estado inicial botones */
    const [btnConsultar, setBtnConsultar] = useState('Consultar');
    const [btnEditar, setBtnEditar] = useState('Editar');
    const [btnEliminar] = useState('Eliminar');
    const [btnNuevo, setBtnNuevo] = useState('Nuevo');
    const [btnExportarExcel, setBtnExportarExcel] = useState('Exportar a Excel')

    /* estado inicial modal  */
    const [showModal, setShowModal] = useState(false);
    const [messageAlert, setMessageAlert] = useState('');
    const [valueBtnOne, setValueBtnOne] = useState('');
    const [valueBtnSecond, setValueBtnSecond] = useState('');
    const [visibBtnOne, setVisibBtnOne] = useState('');
    const [visibBtnSecond, setVisibBtnSecond] = useState('');
    const [fnBtnOne, setFnBtnOne] = useState();
    const [fnBtnSecond, setFnBtnSecond] = useState();
    const [mostrarModalObservacion, setMostrarModalObservacion] = useState(false)

    /* datos cache */
    const [dataOficinas, setDataOficinas] = useState({});

    /* Loading */
    const [showLoading, setShowLoading] = useState(false);

    /* funciones */
    const handleChange = (e) => {
        setUsuario({
            ...usuario,
            [e.target.name]: e.target.value,
        });
    };


    const enterId = (e) => {
        if (e.key === "Enter") {
            e.preventDefault();
            consultar();
        }
    };


    const enterUsusario = (e) => {
        if (e.key === "Enter") {
            e.preventDefault();
            const focusIdUsuario = document.getElementById('cargo');
            focusIdUsuario.focus();
        }
    };


    const focusInputUser = () => {
        const focusIdUsuario = document.getElementById('userId');
        focusIdUsuario.focus();
        focusIdUsuario.value = '';
    };


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


    const endModal = (showModal) => {
        setShowModal(showModal);
    };


    const setRequiredElmenteForm = () => {
        document.frmDataUser.idUsuario.setAttribute('required', true);
        document.frmDataUser.nombre.setAttribute('required', true);
        document.frmDataUser.correo.setAttribute('required', true);
        document.frmDataUser.cargo.setAttribute('required', true);
        document.frmDataUser.oficina.setAttribute('required', true);
        document.frmDataUser.regional.setAttribute('required', true);
        document.frmDataUser.canal.setAttribute('required', true);
        document.frmDataUser.perfiles.setAttribute('required', true);
        document.frmDataUser.estado.setAttribute('required', true);
    };


    const removeRequiredElmenteForm = () => {
        document.frmDataUser.idUsuario.removeAttribute('required');
        document.frmDataUser.nombre.removeAttribute('required');
        document.frmDataUser.correo.removeAttribute('required');
        document.frmDataUser.cargo.removeAttribute('required');
        document.frmDataUser.oficina.removeAttribute('required');
        document.frmDataUser.regional.removeAttribute('required');
        document.frmDataUser.canal.removeAttribute('required');
        document.frmDataUser.perfiles.removeAttribute('required');
        document.frmDataUser.aprobador.removeAttribute('required');
        document.frmDataUser.estado.removeAttribute('required');
    };


    const setHiddenElmenteForm = () => {
        document.frmDataUser.idUsuario.setAttribute('hidden', true);
        document.frmDataUser.nombre.setAttribute('hidden', true);
        document.frmDataUser.correo.setAttribute('hidden', true);
        document.frmDataUser.cargo.setAttribute('hidden', true);
        document.frmDataUser.oficina.setAttribute('hidden', true);
        document.frmDataUser.regional.setAttribute('hidden', true);
        document.frmDataUser.canal.setAttribute('hidden', true);
        document.frmDataUser.perfiles.setAttribute('hidden', true);
        document.frmDataUser.aprobador.setAttribute('hidden', true);
        document.frmDataUser.setAttribute('hidden', true);
    };


    const removeHiddenElmenteForm = () => {
        document.frmDataUser.idUsuario.removeAttribute('hidden');
        document.frmDataUser.nombre.removeAttribute('hidden');
        document.frmDataUser.correo.removeAttribute('hidden');
        document.frmDataUser.cargo.removeAttribute('hidden');
        document.frmDataUser.oficina.removeAttribute('hidden');
        document.frmDataUser.regional.removeAttribute('hidden');
        document.frmDataUser.canal.removeAttribute('hidden');
        document.frmDataUser.perfiles.removeAttribute('hidden');
        document.frmDataUser.removeAttribute('hidden');
    };


    const setDisabledElmenteForm = () => {
        document.frmDataUser.idUsuario.setAttribute('disabled', true);
        document.frmDataUser.nombre.setAttribute('disabled', true);
        document.frmDataUser.correo.setAttribute('disabled', true);
        document.frmDataUser.cargo.setAttribute('disabled', true);
        document.frmDataUser.oficina.setAttribute('disabled', true);
        document.frmDataUser.regional.setAttribute('disabled', true);
        document.frmDataUser.canal.setAttribute('disabled', true);
        document.frmDataUser.perfiles.setAttribute('disabled', true);
        document.frmDataUser.aprobador.setAttribute('disabled', true);
        document.frmDataUser.estado.setAttribute('disabled', true);
    };


    const removeDisabledElmenteForm = (removeStatus) => {
        removeStatus ? document.frmDataUser.idUsuario.removeAttribute('disabled') : document.frmDataUser.idUsuario.setAttribute('disabled', true);
        removeStatus ? document.frmDataUser.nombre.removeAttribute('disabled') : document.frmDataUser.nombre.setAttribute('disabled', true);
        removeStatus ? document.frmDataUser.correo.removeAttribute('disabled') : document.frmDataUser.correo.setAttribute('disabled', true);
        document.frmDataUser.cargo.removeAttribute('disabled');
        document.frmDataUser.oficina.removeAttribute('disabled');
        document.frmDataUser.regional.removeAttribute('disabled');
        document.frmDataUser.canal.removeAttribute('disabled');
        document.frmDataUser.perfiles.removeAttribute('disabled');
        document.frmDataUser.estado.removeAttribute('disabled');
        //estado
    };


    const statusEditar = (editStatus) => {
        let btnEditStatus = document.getElementById('btnEditar')
        if (editStatus) {
            btnEditStatus.removeAttribute('disabled');
            btnEditStatus.classList.replace('disabled_btn-user', 'btn-user');
        } else {
            btnEditStatus.setAttribute('disabled', true);
            btnEditStatus.classList.replace('btn-user', 'disabled_btn-user');
        }
    };


    const statusEliminar = (elitStatus) => {
        let btnElitStatus = document.getElementById('btnEliminar')
        if (elitStatus) {
            btnElitStatus.removeAttribute('disabled');
            btnElitStatus.classList.replace('disabled_btn-user', 'btn-user');
        } else {
            btnElitStatus.setAttribute('disabled', true);
            btnElitStatus.classList.replace('btn-user', 'disabled_btn-user');
        };
    };


    const statusCancelar = (editCancelar) => {
        let btnCancelarStatus = document.getElementById('btnCancelar')
        if (editCancelar) {
            btnCancelarStatus.removeAttribute('disabled');
            btnCancelarStatus.classList.replace('disabled_btn-user', 'btn-user');
        } else {
            btnCancelarStatus.setAttribute('disabled', true);
            btnCancelarStatus.classList.replace('btn-user', 'disabled_btn-user');
        }
    };


    const statusPerfil = (e, numPerfiles) => {
        if (e.target?.value === '3') {
            document.getElementById('thAprobador').removeAttribute('hidden');
            document.getElementById('tdAprobador').removeAttribute('hidden');
            document.frmDataUser.aprobador.removeAttribute('hidden');
            document.frmDataUser.aprobador.removeAttribute('disabled');
            document.frmDataUser.aprobador.setAttribute('required', true);
        } else {
            document.frmDataUser.aprobador.setAttribute('hidden', true);
            document.frmDataUser.aprobador.setAttribute('disabled', true);
            document.frmDataUser.aprobador.removeAttribute('required');
            document.getElementById('thAprobador').setAttribute('hidden', true);
            document.getElementById('tdAprobador').setAttribute('hidden', true);
        };
        for (let i = 0; i < numPerfiles; i++) {
            document.frmDataUser.perfiles.options[i].style.color = 'black';
        };
    };


    const refrescar = () => {
        setBtnConsultar('Consultar');
        setBtnEditar('Editar');
        setBtnNuevo('Nuevo');
        setUsuario('');
        document.frmUsuario.reset();
        document.frmDataUser.reset();
        setDisabledElmenteForm();
        setHiddenElmenteForm();
        removeRequiredElmenteForm();
        document.getElementById('thAprobador').setAttribute('hidden', true);
        document.getElementById('tdAprobador').setAttribute('hidden', true);
        document.frmDataList.removeAttribute('hidden');
        statusEditar(false);
        statusEliminar(false);
        statusCancelar(false);

        if (setShowModal) {
            endModal(false)
        };

        loadListUsuarios();
        focusInputUser();
    };


    /* botones */
    const consultar = async (e) => { /* btn Consultar */
        if (!usuario) {
            callModal(true, 'Ingrese el usuario a consultar', 'Ok', '', '', 'none', () => cancelar, null);
        } else {
            try {
                refrescar();
                statusCancelar(true);
                fnQuery();
                setObservaciotextArea('');
            } catch (error) {
                console.log(error);
            };
        };
    };


    const fnQuery = async () => {
        try {
            let dtResult = await fnQueryUsuarios(usuario);
            renderUsuario(JSON.parse(dtResult));
        } catch (error) {
            console.log(error);
        };
    };


    const renderUsuario = (dtResult) => {
        if (dtResult.STATUS) {
            removeHiddenElmenteForm();
            document.frmDataList.setAttribute('hidden', true);
            document.frmDataUser.idUsuario.value = dtResult.ID_USUARIO;
            document.frmDataUser.nombre.value = dtResult.NOMBRE;
            document.frmDataUser.correo.value = dtResult.CORREO;
            document.frmDataUser.cargo.value = dtResult.COD_CARGO
            document.frmDataUser.oficina.value = dtResult.COD_OFICINA;
            document.frmDataUser.regional.value = dtResult.COD_REGIONAL;
            document.frmDataUser.canal.value = dtResult.COD_CANAL;
            document.frmDataUser.estado.value = dtResult.ESTADO;
            setEstado(dtResult.ESTADO);

            if (dtResult.PERFIL.length > 1) {
                document.frmDataUser.perfiles.multiple = true;
                document.frmDataUser.perfiles.value = dtResult.PERFIL;
                for (const element of dtResult.PERFIL) {
                    document.frmDataUser.perfiles.value = element;
                    document.frmDataUser.perfiles.options[document.frmDataUser.perfiles.selectedIndex].style.color = 'firebrick'
                }
            } else {
                document.frmDataUser.perfiles.multiple = false;
                statusPerfil(document.frmDataUser.perfiles.length);
                document.frmDataUser.perfiles.value = dtResult.PERFIL;
            }

            if (dtResult.ENTE !== 0) {
                document.getElementById('thAprobador').removeAttribute('hidden');
                document.getElementById('tdAprobador').removeAttribute('hidden');

                document.frmDataUser.aprobador.removeAttribute('hidden');
                document.frmDataUser.aprobador.value = dtResult.ENTE;
            };

            statusEditar(true);
            statusEliminar(true);
            setlistConversionExcel([dtResult])

        } else {
            callModal(true, `Usuario: '${usuario.id}', no encontrado`, 'Ok', '', '', 'none', () => refrescar);
        };
    };


    const usuarioEditar = () => { /* btn Editar */
        let btnEdit = document.getElementById('btnEditar').value;
        if (btnEdit === 'Editar') {
            setBtnEditar('Guardar');
            statusCancelar(true);
            removeDisabledElmenteForm(false);
            document.frmDataUser.perfiles.multiple = true;
            if (document.frmDataUser.aprobador.value !== 'DEFAULT') {
                document.frmDataUser.aprobador.removeAttribute('disabled');
            };
            document.frmDataUser.cargo.focus();
        } else {
            const valObservacion = document.getElementById('iObservacion').value;
            const valEstado = parseInt(document.getElementById('estado').value);

            if (valEstado === estado) {
                callModal(true, `Se almacenaran los cambios, ¿Desea continuar? `, 'Continuar', 'Cancelar', '', '', () => Guardar, () => cancelar);
            } else if (valObservacion === "") {
                callModal(true, `Has cambiado el estado del usuario, pero falta una observación. Agrégala para guardar los cambios`, 'Ok', '', '', 'none', () => cancelar);
            } else {
                callModal(true, `Se almacenaran los cambios, ¿Desea continuar? `, 'Continuar', 'Cancelar', '', '', () => Guardar, () => cancelar);
            }
        };
    };


    const usuarioEliminar = async () => {

        setOpcionEliminarEstado(1);
        setMensajeObservacion('eliminar');
        setMostrarModalObservacion(true);

    };


    const eliminar = async () => {

        setShowLoading(true);
        const valObservacion = document.getElementById('iObservacion').value;

        if (valObservacion === "") {
            console.log(valObservacion)
            callModal(true, `Para eliminar al usuario, debes agregar una observación`, 'Ok', '', '', 'none', () => cancelar);
            setShowLoading(false)
            return
        }

        try {

            let dataDelete = {
                "idUsuario": document.getElementById('idUsuario').value,
                "observacion": document.getElementById('iObservacion').value
            };

            const responseEliminar = JSON.parse(await fnDeleteUsuarios(JSON.stringify(dataDelete)));

            if (responseEliminar === 200) {
                setShowLoading(false);
                callModal(true, `Usuario eliminado`, 'Ok', '', '', 'none', () => refrescar);
                document.frmDataList.removeAttribute('hidden');
            } else {
                setShowLoading(false);
                callModal(true, `No fue posible eliminar el usuario, intentelo nuevamente `, '', 'Ok', 'none', '', null, () => cancelar);
            };

        } catch (e) {
            console.log(e);
        } finally {
            setShowLoading(false)
        };

    };


    const Guardar = async () => {
        setShowModal(false);
        let frmDataEdit = new FormData(document.frmDataUser);
        frmDataEdit.set('usuario', document.getElementById('idUsuario').value);
        try {

            let dataPerfil = Object.values(frmDataEdit.getAll('perfiles'));
            let validateDataPerfil = fnValidateDataPerfil(dataPerfil);
            if (validateDataPerfil) {
                fnQueryUpdate(frmDataEdit);
            };

        } catch (e) {
            console.error(e);
        }
    };


    const fnQueryUpdate = async (frmDataUpdate) => {
        try {
            let dataResult = await fnQueryUpdateUsuarios(frmDataUpdate);
            if (dataResult.state) {
                callModal(true, `${dataResult.message} `, 'Ok', '', '', 'none', () => refrescar);
                document.frmDataList.removeAttribute('hidden');
            } else {
                callModal(true, `${dataResult.message} `, '', 'Ok', 'none', '', null, () => cancelar);
            };
        } catch (error) {
            console.log(error);
        };
    };


    const usuarioNuevo = async () => {
        let btnNuev = document.getElementById('btnUserNuevo').value;
        if (btnNuev === 'Nuevo') {
            refrescar();
            statusCancelar(true);
            setBtnNuevo('Guardar');
            removeHiddenElmenteForm();
            removeDisabledElmenteForm(true);
            setRequiredElmenteForm();
            setObservaciotextArea('');
            document.frmDataList.setAttribute('hidden', true);
            document.frmDataUser.perfiles.multiple = true;
            document.frmDataUser.idUsuario.focus();
        } else {
            let frmDataInsert = document.getElementById('frmDataUser');
            if (frmDataInsert.checkValidity()) {

                const valObservacion = document.getElementById('iObservacion').value;
                const valEstado = parseInt(document.getElementById('estado').value);

                if (valEstado === estado) {
                    callModal(true, `Se insertará un nuevo usuario. ¿Desea continuar?`, 'Continuar', 'Cancelar', '', '', () => Adicionar, () => cancelar);
                } else if (valObservacion === "") {
                    callModal(true, `Falta una observación para el estado. Agrégala para guardar los cambios`, 'Ok', '', '', 'none', () => cancelar);
                } else {
                    callModal(true, `Se insertará un nuevo usuario. ¿Desea continuar?`, 'Continuar', 'Cancelar', '', '', () => Adicionar, () => cancelar);
                }

            } else {
                callModal(true, 'Algunos campos están vacíos o no cumplen las condiciones. Verifíquelos e intente nuevamente', '', 'Ok', 'none', '', null, () => cancelar);
            };
        };
    };


    const Adicionar = async () => {
        setShowModal(false);
        let frmDataInsert = new FormData(document.frmDataUser);

        try {
            let dataPerfil = Object.values(frmDataInsert.getAll('perfiles'));
            let validateDataPerfil = fnValidateDataPerfil(dataPerfil);
            if (validateDataPerfil) {
                fnQueryInsert(frmDataInsert);
            };
        } catch (e) {
            console.error(e);
        }
    };


    const fnQueryInsert = async (frmDataInsert) => {
        try {
            let dtResult = await fnQueryInsertUsusario(frmDataInsert);
            if (dtResult.state) {
                callModal(true, `${dtResult.message} `, 'Ok', '', '', 'none', () => refrescar, null);
                document.frmDataList.removeAttribute('hidden');
            } else {
                callModal(true, `${dtResult.message} `, '', 'Ok', 'none', '', null, () => cancelar);
            };
        } catch (error) {
            console.log(error);
        }
    };


    const fnValidateDataPerfil = (dataPerfil) => {
        let dataAutorización;
        if (dataPerfil.length > 2) {
            callModal(true, `Solo se permiten dos perfiles por usuario`, '', 'Ok', 'none', '', null, () => cancelar);
            return false;
        } else if (dataPerfil.length === 1) {
            return true;
        } else {
            if (parseInt(dataPerfil[0]) === 2 && parseInt(dataPerfil[1]) === 4) {
                dataAutorización = true;
            } else {
                dataAutorización = false;
            };
        }
        if (!dataAutorización) {
            callModal(true, `Solo se permiten los perfiles: Radicación + Parametrizacion, para un perfil dual`, '', 'Ok', 'none', '', null, () => cancelar);
            return false;
        } else {
            return true;
        };
    };


    const cancelar = () => {
        setShowModal(false);
        focusInputUser();
    };


    /* Load listas desplegables */
    useEffect(() => {

        loadListCargo();
        loadListOficina();
        loadListRegional();
        loadListCanal();
        loadListPerfil();
        loadListAprobador();
        loadListEstado()
        loadListUsuarios();
        statusEditar(false);
        statusEliminar(false);
        statusCancelar(false);
        document.getElementById('btnGuardar').classList.add('invisible');

    }, []);


    const loadListCargo = async () => {
        try {
            let dataResult = await fnQueryListarCargos();
            setListItemsCargo(dataResult.cargos.map(cargos => <option key={cargos.COD_CARGO} value={cargos.COD_CARGO} >{cargos.CARGO}</option>));
        } catch (error) {
            console.log(error);
        };
    };


    const loadListOficina = async () => {
        try {
            let dataResult = await fnQueryListarOficinas();
            setDataOficinas(dataResult.oficinas);
            setListItemsOficina(dataResult.oficinas.map(offices => <option key={offices.COD_OFICINA} value={offices.COD_OFICINA} >{offices.OFICINA}</option>));
        } catch (error) {
            console.log(error);
        };
    };


    const loadListRegional = async () => {
        let dataResult = await fnQueryListarRegional();
        setListItemsRegional(dataResult.regional.map(regional => <option key={regional.COD_REGIONAL_RAD} value={regional.COD_REGIONAL_RAD} >{regional.REGIONAL_RAD}</option>));
    };


    const loadListCanal = async () => {
        let dataResult = await fnQueryListarCanal();
        setListItemsCanal(dataResult.canal.map(canal => <option key={canal.COD_CANAL_RAD} value={canal.COD_CANAL_RAD} >{canal.CANAL_RAD}</option>));
    };


    const loadListPerfil = async () => {
        let dataResult = await fnQueryListarPerfil();
        setListItemsPerfil(dataResult.perfil.map(perfil => <option key={perfil.COD_PERFIL} value={perfil.COD_PERFIL} >{perfil.DESCRIPCION}</option>));
    };


    const loadListAprobador = async () => {
        let dataResult = await fnQueryListarTipoAprobador();
        setListItemsAprobador(dataResult.aprobador.map(aprobador => <option key={aprobador.cod_aprobador} value={aprobador.cod_aprobador} >{aprobador.tipo_aprobador}</option>));
    };


    const loadListEstado = async () => {
        let dataResult = JSON.parse(await queryListarEstado())
        setListItemEstado(dataResult.DATA.map(estado => <option key={estado.codLista} value={estado.codLista} >{estado.descripcion}</option>));
    };


    const filtrarOficinas = (codRegional) => {
        let listadoOfinasfiltro = dataOficinas.filter((oficina) => codRegional.includes(oficina.REGIONAL));
        setListItemsOficina(listadoOfinasfiltro.map(offices => <option key={offices.COD_OFICINA} id={offices.COD_OFICINA} data-regional={offices.REGIONAL} value={offices.COD_OFICINA}>{offices.OFICINA}</option>));
    };


    const loadListUsuarios = async () => {
        try {
            setShowLoading(true);
            let dataResult = JSON.parse(await fnQueryListarUsuarios());

            if (dataResult.status === 200) {
                fnListData(dataResult.data)
            } else {
                setShowLoading(false)
                callModal(true, 'No fue posible cargar el listado de usuarios, recargue la pagina', 'Ok', '', '', 'none', () => cancelar, null);
            };

        } catch (error) {
            setShowLoading(false)
            console.log('loadListUsuarios:', error);
        };

    };


    const fnListData = (dataList) => {
        let contRow = 0;
        const tbody = document.getElementById('dataList');
        const valChidrens = valNodo(tbody);
        setlistConversionExcel(dataList)
        if (valChidrens) {
            for (const row of dataList) {
                const tr = document.createElement('tr');
                tr.id = row.USUARIO;
                tr.dataset.dKey = row.USUARIO;

                //prueba de estado
                //row.ESTADO = 'Activo'

                const dataRow = (Object.values(row));
                dataRow.unshift(contRow + 1);

                let contUsuario = 0
                for (let list of dataRow) {
                    const td = document.createElement('td');
                    let classList = contUsuario === 0 ? 'colorTd' : 'elementRow';
                    td.className = classList;

                    const input = document.createElement('input');
                    input.id = `${row.USUARIO}_${contUsuario}`;
                    input.name = row.USUARIO;
                    input.dataset.data = row.USUARIO;
                    input.type = 'text';
                    input.className = 'classInput';
                    input.readOnly = true;
                    input.value = list;
                    input.onclick = (e) => fnConsulta(e)

                    tr.appendChild(td);
                    td.appendChild(input);

                    contUsuario++
                };

                tbody.appendChild(tr);
                contRow++;
            };
        };

        setShowLoading(false);
    };


    const fnConsulta = (e) => {
        let elementUsuario = document.getElementById('userId')
        elementUsuario.value = e.target.dataset.data
        setUsuario({ id: e.target.dataset.data });
    };


    const valFnProfile = async (e) => {
        const pass = `${e.target.value}`; //Pass para consultar usuarios.
        
        if (e.target.value === '') {
            callModal(true, 'Ingrese el usuario', 'Ok', '', '', 'none', () => cerrarMod, null);
            return
        };

        setShowLoading(true);
        const responseProfile = JSON.parse(await val_fn_profile(e.target.value, pass));

        switch (responseProfile.codeState) {
            case 401:
                setShowLoading(false)
                document.frmDataUser.nombre.value = responseProfile.name;
                document.frmDataUser.correo.value = responseProfile.mail;
                break;
            case '202':
                setShowLoading(false)
                callModal(true, 'Usuario no existe', 'Ok', '', '', 'none', () => cerrarMod, null);
                break;
            case 500:
                setShowLoading(false)
                callModal(true, 'Directorio activo no disponible', 'Ok', '', '', 'none', () => cerrarMod, null);
                break;
            default:
                break;
        }
    };


    const valNodo = (nodo) => {
        if (nodo.childNodes.length > 0) {
            while (nodo.firstChild) {
                nodo.removeChild(nodo.firstChild);
            };
        };

        return true;
    };


    const focusNombreCorreo = () => {
        let idUsuarioFocus = document.getElementById('cargo');
        idUsuarioFocus.focus();
    };


    // Función para convertir datos a CSV
    const convertToCSV = (data) => {
        const headers = Object.keys(data[0]).join(";");
        const rows = data.map((item) => Object.values(item).join(";"));
        return `${headers}\n${rows.join("\n")}`;
    };


    const exportToCSV = () => {
        const csvContent = convertToCSV(listConversionExcel);
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


    const filtrarConsulta = async (e) => {
        const { name, value } = e.target;
        if (value != '') {
            const listaFiltrada = listConversionExcel.filter(item =>
                String(item[name]).toLowerCase().includes(value.toLowerCase())
            );

            fnListData(listaFiltrada.length > 0 ? listaFiltrada : listConversionExcel);

        } else {
            await loadListUsuarios();
        };
    };


    const onChangeEstado = async (e) => {
        const { value } = e.target;
        setMensajeObservacion(value == 1 ? 'Activar' : value == 2 ? 'Inactivar' : '')
        setEstadoSeleccionado(e.target.value)
        setMostrarModalObservacion(true)
    };


    const cerrarModalObservacion = async (e) => {
        setMensajeObservacion('');
        setObservaciotextArea('');
        setMostrarModalObservacion(false);
    };


    const cerrarObservacion = async (e) => {
        setMensajeObservacion('');
        setMostrarModalObservacion(false);
    };


    const cerrarMod = () => {
        setShowModal(false);
    };


    const controlSi = () => {

        if (opcionEliminarEstado === 1) {
            cerrarObservacion();
            setOpcionEliminarEstado(0);
            eliminar();
        } else {
            cerrarObservacion();
        }
    }


    return (
        <>
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

            {
                mostrarModalObservacion ?
                    <ModalObservacion titulo={'Confirmación!'} textBtnContinuar="Si" mostrarModal={controlSi} cerrarModal={cerrarModalObservacion}>
                        <h3>{`Seguro(a) desea ${mensajeObservacion} el usuario seleccionado?`}</h3>
                        <div className="text-center">
                            <label htmlFor="observacion" className="text-center w-full font-bold text-gray-500">{'Diligencie las observaciones de inactivación o Activación.'}</label>
                            <textarea
                                id="observacion"
                                className="border outline-none border-sky-400 rounded-md  py-2 px-2 mt-4  text-coomeva_color-grisLetras"
                                type="text"
                                placeholder="Observación..."
                                cols={45}
                                rows={1}
                                value={observaciotextArea}
                                onChange={(e) => { setObservaciotextArea(e.target.value) }}
                            />
                        </div>
                    </ModalObservacion>
                    : undefined
            }


            <div className="">
                <div className="container-user">
                    <section className=" mt-10 ">
                        <form name="frmUsuario" onSubmit={() => Adicionar()}>
                            <div className="flex">
                                <div className="hr mr-3">
                                    <label className="label-user" htmlFor='userId'>Usuario:</label>
                                    <input
                                        onKeyDown={enterId}
                                        onChange={handleChange}
                                        type="text"
                                        id="userId"
                                        name="id"
                                        className="text-right mr-3 focus: outline-0"
                                        placeholder="Digite el usuario"
                                        autoComplete="off"
                                        tabIndex={0}
                                        autoFocus
                                        required
                                    />
                                </div>
                                <input
                                    onClick={(e) => consultar(e)}
                                    type="button"
                                    id="btnConsulta"
                                    value={btnConsultar}
                                    tabIndex={0}
                                    className="btn-user sizeBtn ml-6"
                                />
                                <input
                                    onClick={usuarioEditar}
                                    type="button"
                                    id="btnEditar"
                                    value={btnEditar}
                                    tabIndex={0}
                                    className="disabled_btn-user mr-6 ml-6 sizeBtn"
                                />
                                <input
                                    onClick={usuarioEliminar}
                                    type="button"
                                    id="btnEliminar"
                                    value={btnEliminar}
                                    tabIndex={0}
                                    className="disabled_btn-user mr-6 ml-6 sizeBtn"
                                />
                                <input
                                    onClick={usuarioNuevo}
                                    type="button"
                                    id="btnUserNuevo"
                                    value={btnNuevo}
                                    tabIndex={0}
                                    className="btn-user sizeBtn ml-6"
                                />
                                <input
                                    onClick={exportToCSV}
                                    type="button"
                                    id="btnExportarExcel"
                                    value={btnExportarExcel}
                                    tabIndex={0}
                                    className="bg-coomeva_color-verdeLetras text-white sizeBtn ml-6"
                                />
                            </div>
                        </form>
                    </section>
                    <section className="section-top">
                        <form id="frmDataUser" name="frmDataUser" hidden>
                            <table className=" table-fixed border-collapse w-full border-slate-400 mb-10">
                                <thead>
                                    <tr>
                                        <th className="border-x-0 border-b-2 label">USUARIO</th>
                                        <th className="border-x-0 border-b-2 label">NOMBRE</th>
                                        <th className="border-x-0 border-b-2 label">CORREO</th>
                                        <th className="border-x-0 border-b-2 label">CARGO</th>
                                        <th className="border-x-0 border-b-2 label">REGIONAL</th>
                                        <th className="border-x-0 border-b-2 label">OFICINA</th>
                                        <th className="border-x-0 border-b-2 label">CANAL</th>
                                        <th className="border-x-0 border-b-2 label">PERFIL</th>
                                        <th className="border-x-0 border-b-2 label" id="thAprobador" hidden>TIPO APROBADOR</th>
                                        <th className="border-x-0 border-b-2 label">ESTADO</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td className="">
                                            <input
                                                type="text"
                                                id="idUsuario"
                                                name="idUsuario"
                                                tabIndex={0}
                                                disabled
                                                hidden
                                                autoComplete="off"
                                                className="text-sm sizeElementRowUser"
                                                onBlur={(e) => valFnProfile(e)}
                                                onKeyDown={enterUsusario}
                                            />
                                        </td>
                                        <td className="">
                                            <input
                                                type="text"
                                                name="nombre"
                                                tabIndex={0}
                                                disabled
                                                hidden
                                                autoComplete="off"
                                                className="text-sm sizeElementRowUser"
                                                onFocus={focusNombreCorreo}
                                            />
                                        </td>
                                        <td className="">
                                            <input
                                                type="email"
                                                name="correo"
                                                tabIndex={0}
                                                disabled
                                                hidden
                                                autoComplete="off"
                                                className="text-sm sizeElementRowUser"
                                                onFocus={focusNombreCorreo}
                                            />
                                        </td>
                                        <td className="">
                                            <select
                                                id="cargo"
                                                name="cargo"
                                                tabIndex={0}
                                                className="text-sm sizeElementRowUser"
                                                defaultValue={''}
                                                disabled
                                                hidden
                                            >
                                                <option value="" disabled>Seleccione Cargo</option>
                                                {listItemsCargo}
                                            </select>
                                        </td>
                                        <td className="">
                                            <select
                                                name="regional"
                                                className="text-sm sizeElementRowUser"
                                                defaultValue={''}
                                                disabled
                                                hidden
                                                onChange={(e) => filtrarOficinas(e.target.value)}
                                            >
                                                <option value="" disabled>Seleccione Regional</option>
                                                {listItemsRegional}
                                            </select>
                                        </td>
                                        <td className="">
                                            <select
                                                name="oficina"
                                                className="text-sm sizeElementRowUser"
                                                defaultValue={''}
                                                disabled
                                                hidden
                                            >
                                                <option value="" disabled>Seleccione Oficina</option>
                                                {listItemsOficina}
                                            </select>
                                        </td>
                                        <td className="">
                                            <select
                                                name="canal"
                                                className="text-sm sizeElementRowUser"
                                                defaultValue={''}
                                                disabled
                                                hidden
                                            >
                                                <option value="" disabled>Seleccione Canal</option>
                                                {listItemsCanal}
                                            </select>
                                        </td>
                                        <td className="">
                                            <select
                                                onChange={(e) => statusPerfil(e, document.frmDataUser.perfiles.length)}
                                                name="perfiles"
                                                className="text-sm sizeElementRowUser"
                                                defaultValue={''}
                                                disabled
                                                hidden
                                            >
                                                {/* <option value="" disabled>Seleccione Perfil</option> */}
                                                {listItemsPerfil}
                                            </select>
                                        </td>
                                        <td className="" id="tdAprobador" >
                                            <select
                                                name="aprobador"
                                                className="text-sm sizeElementRowUser"
                                                defaultValue={''}
                                                disabled
                                            >
                                                <option value="" disabled>Seleccione Tipo</option>
                                                {listItemsAprobador}
                                            </select>
                                        </td>
                                        <td className=""  >
                                            <select
                                                id="estado"
                                                name="estado"
                                                className="text-sm sizeElementRowUser"
                                                defaultValue={estadoSeleccionado}
                                                disabled
                                                onChange={onChangeEstado}
                                            >
                                                <option value="" disabled>Seleccione Estado</option>
                                                {listItemEstado}
                                            </select>
                                        </td>
                                        <td className="ocultar"> {/*observacion*/}
                                            <input
                                                id="iObservacion"
                                                type="text"
                                                name="iObservacion"
                                                autoComplete="off"
                                                className="text-sm sizeElementRowUser"
                                                readOnly
                                                value={observaciotextArea}
                                            />
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>
                        <form id="frmDataList" name="frmDataList" className="frmDataListUser" >
                            <table className="w-full">
                                <thead>
                                    <tr>
                                        <th className="border-b-2 text-left frmDataListColorTh w-[5%]">n°</th>
                                        <th className="border-b-2 text-left frmDataListColorTh w-[5%]">USUARIO</th>
                                        <th className="border-b-2 text-left frmDataListColorTh w-[12%]">NOMBRE</th>
                                        <th className="border-b-2 text-left frmDataListColorTh w-[12%]">CORREO</th>
                                        <th className="border-b-2 text-left frmDataListColorTh w-[10%]">CARGO</th>
                                        <th className="border-b-2 text-left frmDataListColorTh w-[10%]">PERFIL</th>
                                        <th className="border-b-2 text-left frmDataListColorTh w-[10%]">TIPO APROBADOR</th>
                                        <th className="border-b-2 text-left frmDataListColorTh w-[10%]">ESTADO</th>
                                    </tr>
                                    <tr>
                                        <th className="border-b-2 text-left frmDataListColorTh w-[2%]">
                                            <input
                                                name="numero"
                                                className="w-[3.5rem] text-sm outline-none border border-coomeva_color-grisLetras rounded-md px-2 py-1"
                                                type="text"
                                                placeholder="Buscar..."
                                                onChange={filtrarConsulta}
                                            />
                                        </th>
                                        <th className="border-b-2 text-left frmDataListColorTh w-[5%]">
                                            <input
                                                name="USUARIO"
                                                className="text-sm outline-none border border-coomeva_color-grisLetras rounded-md px-2 py-1"
                                                type="text"
                                                placeholder="Buscar..."
                                                onChange={filtrarConsulta}
                                            />
                                        </th>
                                        <th className="border-b-2 text-left frmDataListColorTh w-[12%]">
                                            <input
                                                name="NOMBRE"
                                                className="text-sm outline-none border border-coomeva_color-grisLetras rounded-md px-2 py-1"
                                                type="text"
                                                placeholder="Buscar..."
                                                onChange={filtrarConsulta}
                                            />
                                        </th>
                                        <th className="border-b-2 text-left frmDataListColorTh w-[12%]">
                                            <input
                                                name="CORREO"
                                                className="text-sm outline-none border border-coomeva_color-grisLetras rounded-md px-2 py-1"
                                                type="text"
                                                placeholder="Buscar..."
                                                onChange={filtrarConsulta}
                                            />
                                        </th>
                                        <th className="border-b-2 text-left frmDataListColorTh w-[10%]">
                                            <input
                                                name="CARGO"
                                                className="text-sm outline-none border border-coomeva_color-grisLetras rounded-md px-2 py-1"
                                                type="text"
                                                placeholder="Buscar..."
                                                onChange={filtrarConsulta}
                                            />
                                        </th>
                                        <th className="border-b-2 text-left frmDataListColorTh w-[10%]">
                                            <input
                                                name="PERFIL"
                                                className="text-sm outline-none border border-coomeva_color-grisLetras rounded-md px-2 py-1"
                                                type="text"
                                                placeholder="Buscar..."
                                                onChange={filtrarConsulta}
                                            />
                                        </th>
                                        <th className="border-b-2 text-left frmDataListColorTh w-[10%]">
                                            <input
                                                name="TIPO_APROBADOR"
                                                className="text-sm outline-none border border-coomeva_color-grisLetras rounded-md px-2 py-1"
                                                type="text"
                                                placeholder="Buscar..."
                                                onChange={filtrarConsulta}
                                            />
                                        </th>
                                        <th className="border-b-2 text-left frmDataListColorTh w-[10%]">
                                            <input
                                                name="ESTADO"
                                                className="text-sm outline-none border border-coomeva_color-grisLetras rounded-md px-2 py-1"
                                                type="text"
                                                placeholder="Buscar..."
                                                onChange={filtrarConsulta}
                                            />
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="dataList" >
                                    {/* contenido */}
                                </tbody>
                            </table>
                        </form>
                    </section>
                    <section className="lg:section-down-btn peq:max-lg:mt-14 mt-10">
                        <input
                            type="button"
                            form="frmUsuario"
                            id="btnCancelar"
                            className="disabled_btn-user mr-6, sizeBtn"
                            value="Cancelar"
                            onClick={() => refrescar()}
                        />
                    </section>
                </div>
            </div >
        </>
    );
};

export default Usuarios;