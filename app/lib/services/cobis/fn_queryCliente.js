'use server'

const restConsultarCliente = require("@/app/lib/services/cobis/fn_restConsultas.js");


export const queryCliente = async (req) => {
    const { customerType } = typeof req === 'string' ? JSON.parse(req) : req;
    const dataCliente = {};

    try {
        // Llamada al servicio, puede devolver string o objeto
        const rawRes = await restConsultarCliente.fn_restConsultarCliente(req);
        const resDataCliente = typeof rawRes === 'string'
            ? JSON.parse(rawRes)
            : rawRes;

        const statusCode = resDataCliente?.data?.status;
        if (statusCode === '200' || statusCode === 200) {
            let customerInfo = {};
            
            if (customerType === 'PJ') {
                customerInfo.customerReference = resDataCliente?.data?.operationData?.OrganisationReference?.CustomerReference;
                customerInfo.customerStatus = resDataCliente?.data?.operationData?.OrganisationReference?.CustomerStatus;
                customerInfo.cliente = resDataCliente?.data?.operationData?.OrganisationReference?.OrganizationProfile?.OrganizationName?.LegalName;
                customerInfo.customerType = customerType;
                customerInfo.regional = '0'; //sin path
                customerInfo.oficina = resDataCliente?.data?.operationData?.OrganisationReference?.BranchExt?.Code;
                customerInfo.coomeva = resDataCliente?.data?.operationData?.OrganisationReference?.AdditionalDataExt?.CustomerType?.Name;
                customerInfo.vinculado = ''; //sin path
                customerInfo.antiguedad_coo = mesesTranscurridos(resDataCliente?.data?.operationData?.OrganisationReference?.AdditionalDataExt?.DateOfEntry?.Name);
                customerInfo.antiguedad_ban = mesesTranscurridos(resDataCliente?.data?.operationData?.OrganisationReference?.AdditionalDataExt?.EnrollmentDate);
                customerInfo.estado_coo = 9; //sin path
                customerInfo.estado_ban = resDataCliente?.data?.operationData?.OrganisationReference?.CustomerStatus.Code === 'A' ? 10 : 9; //Activo Normal : No Estado
                customerInfo.tipo_contrato = 5; //sin path
                customerInfo.ingreso = parseFloat(resDataCliente?.data?.operationData?.OrganisationReference?.FinancialInformationExt?.EconomicSituation[0]?.MonthlyIncome?.Value).toString();
                customerInfo.ventas_an = parseFloat(resDataCliente?.data?.operationData?.OrganisationReference?.FinancialInformationExt?.EconomicSituation[0]?.AnnualSales?.Value).toString();
                customerInfo.activos = parseFloat(resDataCliente?.data?.operationData?.OrganisationReference?.FinancialInformationExt?.FinancialSituation[0]?.Assets?.Value).toString();
                customerInfo.sector = resDataCliente?.data?.operationData?.OrganisationReference?.AdditionalDataExt?.EconomicSector?.Name || '0';
            };

            if (customerType === 'PN') {
                customerInfo.customerReference = resDataCliente?.data?.operationData?.PersonReference?.CustomerReference;
                customerInfo.customerStatus = resDataCliente?.data?.operationData?.PersonReference?.CustomerStatus;
                customerInfo.cliente = `${resDataCliente?.data?.operationData?.PersonReference?.PersonName[0]?.value} ${resDataCliente?.data?.operationData?.PersonReference?.PersonName[1]?.value} ${resDataCliente?.data?.operationData?.PersonReference?.PersonName[2]?.value} ${resDataCliente?.data?.operationData?.PersonReference?.PersonName[3]?.value}`;
                customerInfo.customerType = customerType;
                customerInfo.regional = '0'; //sin path
                customerInfo.oficina = resDataCliente?.data?.operationData?.PersonReference?.BankBranch?.Code;
                customerInfo.coomeva = '0'; //sin path
                customerInfo.vinculado = ''; //sin path
                customerInfo.antiguedad_coo = ''; //sin path
                customerInfo.antiguedad_ban = mesesTranscurridos(resDataCliente?.data?.operationData?.PersonReference?.EnrollmentDate);
                customerInfo.estado_coo = '0'; //sin path
                customerInfo.estado_ban = resDataCliente?.data?.operationData?.PersonReference?.CustomerStatus.Code === 'A' ? 10 : 9; //Activo Normal : No Estado
                customerInfo.tipo_contrato = resDataCliente?.data?.operationData?.PersonReference?.PersonProfile?.Occupation?.Code || '0';
                customerInfo.ingreso = parseFloat(resDataCliente?.data?.operationData?.PersonReference?.AdditionalDataExt?.KnowYourCustomerData?.IncomeAmount).toString();
                customerInfo.ventas_an = parseFloat(0).toString(); //sin path
                customerInfo.activos = parseFloat(resDataCliente?.data?.operationData?.PersonReference?.FinancialInformationExt?.TotalAssets?.Value).toString();
                customerInfo.sector = '0'; //sin path
            };

            dataCliente.state = 200;
            dataCliente.data = customerInfo;
        } else if (statusCode === '400' || statusCode === 400) {
            dataCliente.state = 204;
            dataCliente.message = `Code: ${statusCode}-. ${resDataCliente.data.message}.`;
        } else {
            dataCliente.state = parseInt(statusCode, 10) || 500;
            dataCliente.message = `Code: ${statusCode}-. ${resDataCliente.data.message}`;
        }

        return JSON.stringify(dataCliente);

    } catch (e) {
        console.error('Error_queryCliente:', e);
        dataCliente.state = 400;
        dataCliente.message = e.message;
        return JSON.stringify(dataCliente);
    }
};


function mesesTranscurridos(fechaInicial) {

    if (fechaInicial === null) {
        return 0;
    };

    const fecha = new Date(fechaInicial);
    const valFecha = fecha instanceof Date && !isNaN(fecha);
    const hoy = new Date();

    if (valFecha) {
        const años = hoy.getFullYear() - fecha.getFullYear();
        const meses = hoy.getMonth() - fecha.getMonth();
        return años * 12 + meses;
    };

    return 0;

};