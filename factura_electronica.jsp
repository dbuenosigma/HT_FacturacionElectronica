<%@ page errorPage="../error.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="issi.admin.FormBean"%>
<%@ page import="issi.admin.CommonDataObject"%>
<%@ page import="issi.admin.IBIZEscapeChars"%>
<%@ page import="issi.service.HTTPClientHandler"%>
<%@ page import="issi.admin.IFRestClient"%>

<%@ page import="java.io.File"%>
<%@ page import="java.io.FileNotFoundException"%>
<%@ page import="java.io.FileOutputStream"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Base64"%>
<%@ page import="java.util.Date"%>

<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.math.RoundingMode"%>

<%@ page import="java.util.ResourceBundle" %>

<%@ page import="com.htconsulting.facturacionelectronica.datosenvio.DatosDocumento"%>
<%@ page import="com.htconsulting.facturacionelectronica.datosenvio.DatosTransaccion"%>
<%@ page import="com.htconsulting.facturacionelectronica.datosenvio.DocumentoElectronico"%>
<%@ page import="com.htconsulting.facturacionelectronica.datosenvio.DocFiscalReferenciado"%>
<%@ page import="com.htconsulting.facturacionelectronica.datosenvio.FormaPago"%>
<%@ page import="com.htconsulting.facturacionelectronica.datosenvio.Item"%>
<%@ page import="com.htconsulting.facturacionelectronica.datosenvio.Retencion"%>
<%@ page import="com.htconsulting.facturacionelectronica.datosenvio.TotalesSubTotales"%>
<%@ page import="com.htconsulting.facturacionelectronica.respuestasenvio.DescargaPDFResponse"%>
<%@ page import="com.htconsulting.facturacionelectronica.respuestasenvio.DescargaXMLResponse"%>
<%@ page import="com.htconsulting.facturacionelectronica.respuestasenvio.EnviarResponse"%>
<%@ page import="com.htconsulting.facturacionelectronica.ManejadorFE"%>
<%@ page import="com.htconsulting.facturacionelectronica.datosenvio.Cliente"%>
<%@ page import="com.htconsulting.facturacionelectronica.datosenvio.Credenciales"%>
<%@ page import="com.htconsulting.facturacionelectronica.ebihkadriver.ManejadorFEParaEBIyHKA"%>

<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="ConMgr" scope="session" class="issi.admin.ConnectionMgr"/>
<jsp:useBean id="SecMgr" scope="session" class="issi.admin.SecurityMgr"/>
<jsp:useBean id="UserDet" scope="session" class="issi.admin.UserDetail"/>
<jsp:useBean id="CmnMgr" scope="page" class="issi.admin.CommonMgr"/>
<jsp:useBean id="SQLMgr" scope="page" class="issi.admin.SQLMgr"/>
<jsp:useBean id="fb" scope="page" class="issi.admin.FormBean"/>
<jsp:useBean id="impfisc" scope="page" class="issi.wsclient.WSCLIENT"/>
<%!
    private static void grabarDocBase64FileSystem(String base64String, String rutaFileSystem) {
        String originalInput = base64String;
        byte[] result = Base64.getDecoder().decode(originalInput);
           File file = new File(rutaFileSystem);
           try (FileOutputStream outputStream = new FileOutputStream(file)) {
               outputStream.write(result);
           } catch (FileNotFoundException e) {
               System.out.println(e.getMessage());
               e.printStackTrace();
           } catch (IOException e) {
               System.out.println(e.getMessage());
               e.printStackTrace();   			
           }
    
    }

    public static boolean isNumeric(String strNum) {
        if (strNum == null) {
            return false;
        }
        try {
            double d = Double.parseDouble(strNum);
        } catch (NumberFormatException nfe) {
            return false;
        }
        return true;
    }
    
    private static DocumentoElectronico generarDocumentoFE() {
        
        Cliente cliente = new Cliente(
                "01" //String tipoClienteFE 01=Contribuyente, 02=No Contribuyente
                , "2"//String tipoContribuyente
                , "155596713-2-2015"//String numeroRUC
                , "59"//String digitoVerificadorRUC
                , "Ambiente de pruebas" //String razonSocial
                , "Ave. La Paz " //String direccion
                , "1-2-3" //String codigoUbicacion
                , "BOCAS DEL TORO" //String provincia
                , "CHANGUINOLA" //String distrito
                , "GUABITO" //String corregimiento
                , null //String tipoIdentificacion
                , "" //String nroIdentificacionExtranjero
                , "" //String paisExtranjero
                , "9999-9999" //String telefono1
                , null //String telefono2
                , null //String telefono3
                , "sucursal000@empresa.com"//String correoElectronico1
                , null //String correoElectronico2
                , null //String correoElectronico3
                , "PA" //String pais
                , null //String paisOtro
                );
        
        DatosTransaccion datosGeneralesTransaccion = new DatosTransaccion(
                  "01" //String tipoEmision
                , "" //String fechaInicioContingencia
                , "" //String motivoContingencia
                , "01" //String tipoDocumento
                , "7012" //String numeroDocumentoFiscal
                , "002"//String puntoFacturacionFiscal
                , new SimpleDateFormat("yyyy-MM-dd"+"'T'"+"HH:mm:ss"+"'-05:00'").format(new Date())//String fechaEmision -- // formato 2020-11-18T11:45:13-05:00
                , "" //String fechaSalida
                , "01"//String naturalezaOperacion
                , "1"//String tipoOperacion
                , "1"//String destinoOperacion
                , "1"//String formatoCAFE
                , "1"//String entregaCAFE
                , "1"//String envioContenedor
                , "1"//String procesoGeneracion
                , "1"//String tipoVenta
                , "Demo para Facturacion Electronica"//String informacionInteres
                , cliente
                , null //DatosFacturaExportacion datosFacturaExportacion
                , null //ArrayList<DocFiscalReferenciado> listaDocsFiscalReferenciados
                , null //ArrayList<AutorizadoDescargaFEyEventos> listaAutorizadosDescargaFEyEventos
                );
        
        ArrayList<Item> listaItems = new ArrayList<Item>();
        Item itemFE = new Item(
                  "Lapiz" //String descripcion
                , "CA-001" //String codigo
                , "cm" //String unidadMedida
                , "2.00" //String cantidad
                , "" //String fechaFabricacion
                , "" //String fechaCaducidad
                , null //String codigoCPBSAbrev
                , "1410" //String codigoCPBS
                , "cm" //String unidadMedidaCPBS
                , "Lapiz con Goma" //String infoItem
                , "69.000000" //String precioUnitario
                , "0.00" //String precioUnitarioDescuento
                , "138.00" //String precioItem
                , "1.01" //String precioAcarreo
                , "12.01" //String precioSeguro
                , "171.72" //String valorTotal
                , "" //String codigoGTIN
                , "" //String cantGTINCom
                , "" //String codigoGTINInv
                , "" //String cantGTINComInv
                , "03" //String tasaITBMS
                , "20.70" //String valorITBMS
                , "" //String tasaISC
                , "" //String valorISC
                , null //ArrayList<Oti> listaItemOTI
                , null //Vehiculo vehiculo
                , null //Medicina medicina
                , null //PedidoComercialItem pedidoComercialItem
                );
        listaItems.add(itemFE);
        
        ArrayList<FormaPago> listaFormaPago
        = new ArrayList<FormaPago>();
        FormaPago formaPago
        = new FormaPago(
                  "01"//String formaPagoFact
                , "" //String descFormaPago
                , "171.72"//String valorCuotaPagada
                );
        listaFormaPago.add(formaPago);
        
        Retencion retencion
        = new Retencion(
                "8" //String codigoRetencion
                , "1.00" //String montoRetencion
                );
        
        TotalesSubTotales totalesSubTotales =
                new TotalesSubTotales(
                          "138.00" //String totalPrecioNeto
                        , "20.70" //String totalITBMS
                        , "" //String totalISC
                        , "20.70" //String totalMontoGravado
                        , "0.00" //String totalDescuento
                        , "" //String totalAcarreoCobrado
                        , ""//String valorSeguroCobrado
                        , "171.72" //String totalFactura
                        , "171.72" //String totalValorRecibido
                        , "0.00"//String vuelto
                        , "1" //String tiempoPago
                        , "1" //String nroItems
                        , "171.72" //String totalTodosItems
                        , null //ArrayList<DescuentoBonificacion> listaDescBonificacion
                        , listaFormaPago //ArrayList<FormaPago> listaFormaPago
                        , retencion//Retencion retencion
                        , null //ArrayList<PagoPlazo> listaPagoPlazo
                        , null //ArrayList<TotalOTI> listaTotalOTI
                        );
        
        return new DocumentoElectronico(
                "0000"//String codigoSucursalEmisor
                , ""//String tipoSucursal
                , datosGeneralesTransaccion //DatosGeneralesTransaccion datosGeneralesTransaccion
                , listaItems //ArrayList<ItemFE> listaItems
                , totalesSubTotales //TotalesSubTotales totalesSubTotales
                , null //PedidoComercialGlobal pedidoComercialGlobal
                , null //InfoLogistica infoLogistica
                , null //InfoEntrega infoEntrega
                , null //UsoPosterior usoPosterior
                , null //ArrayList<Extra> listaExtras
                , null//String serialDispositivo
                );
    }
%>

<%
CmnMgr.setConnection(ConMgr);
SQLMgr.setConnection(ConMgr);

ArrayList al = new ArrayList();
StringBuffer xtraNotes = new StringBuffer();
StringBuffer sbSql = new StringBuffer();
StringBuffer tSql = new StringBuffer();
StringBuffer tFilter = new StringBuffer();
String responseText="";
String errMsg="";
String factElecException = "";
String fp = request.getParameter("fp");
String actType = request.getParameter("actType");
String docType = request.getParameter("docType");
String docId = request.getParameter("docId");
String docNo = request.getParameter("docNo");
String compania = request.getParameter("compania");
String tipo = request.getParameter("tipo");
String ruc = request.getParameter("ruc");
String dv = request.getParameter("dv");
String codigoDgi = request.getParameter("codigoDgi");
String id_lista = request.getParameter("id_lista");
String e_mail = request.getParameter("e_mail");
String tipocliente = request.getParameter("tipocliente");
String ubicacion_fe = request.getParameter("ubicacion_fe");

String ip = (SecMgr.getParValue(UserDet,"DGI")!=null? SecMgr.getParValue(UserDet,"DGI"):"");

String url="http://"+(!ip.equals("")? ip:request.getRemoteHost());

if (e_mail == "" || e_mail == null){
    e_mail = "";
}

/**********************************************************************************************************************/
ArrayList d_enca = new ArrayList();
ArrayList d_items = new ArrayList();
ArrayList d_Payments = new ArrayList();
ArrayList d_WS = new ArrayList();
ArrayList d_ubicacion = new ArrayList();
ArrayList d_WS_FactElec = new ArrayList();

String p_pago = request.getParameter("p_pago");
String p_cambio = request.getParameter("p_cambio");

String items = "";
String Payments = "";

if (docNo.equals("POS")){
    StringBuffer sbo = new StringBuffer();
    CommonDataObject cdodn = new CommonDataObject();
    sbo.append("SELECT CODIGO FROM TBL_FAC_DGI_DOCUMENTS WHERE COMPANIA = " + ((String) session.getAttribute("_companyId")) + " AND ID = " + docId);
	cdodn = SQLMgr.getData(sbo.toString());
	docNo = cdodn.getColValue("CODIGO");
}

String q_enca = "SELECT " +
                "    REPLACE(CUSTOMERNAME, CHR(34), '') CUSTOMERNAME, " +
                "    REPLACE(CUSTOMERRUC, CHR(34), '') CUSTOMERRUC, " +
                "    ADDINFO, " +
                "    TO_CHAR(NVL(TRAILER, 0), 'fm9990.00') CT_TRAILER, " +
                "    TO_CHAR(NVL(DISCOUNT,0), 'fm9990.00') DISCOUNT, " +
                "    TO_CHAR((NVL(TRAILER, 0) + MONTO), 'fm9990.00') TOTAL_MAS_CT_TRAILER, " +
                "    TIPO_DOCTO, " +
                "    TIPO_DOCTO_R, " +
                "    CODIGO_DGI_F, " +
                "    DV, " +
                "    CAMPO11 DIRECCION, " +
                "    CASE WHEN CUSTOMERNAME = 'CLIENTE CONTADO' OR CUSTOMERRUC IS NULL OR DV IS NULL OR CUSTOMERRUC = 'RUC' OR DV = '00' THEN '02' ELSE '01' END TIPO_CLIENTEFE, " +
				"	 REPLACE(CAMPO2, CHR(34), '') CAMPO2, " +
                "    REPLACE(COMENTARIO, CHR(34), '') COMENTARIO, " +
                "    QUERY.TIPO_DOCTO_REAL, " +
                "    CASE WHEN QUERY.TIPO_DOCTO_REAL = 'NCP' THEN " +
                "      CASE WHEN QUERY.COD_REF LIKE 'FE%' THEN " +
                "         (SELECT 'CUFE_REF;' || QUERY.COD_REF || ';' || TO_CHAR(FECHA, 'YYYY-MM-DD') || 'T' || TO_CHAR(FECHA, 'HH24:MI:SS') || '-05:00' " +
                "            FROM TBL_FAC_DGI_DOCUMENTS " +
                "           WHERE CODIGO_DGI = QUERY.COD_REF " +
                "             AND ROWNUM = 1) " +
                "      ELSE " +
                "         (SELECT 'FISC_REF;' || QUERY.COD_REF || ';' || TO_CHAR(FECHA, 'YYYY-MM-DD') || 'T' || TO_CHAR(FECHA, 'HH24:MI:SS') || '-05:00' " +
                "            FROM TBL_FAC_DGI_DOCUMENTS " +
                "           WHERE CODIGO_DGI = QUERY.COD_REF " +
                "             AND ROWNUM = 1) " +
                "      END " +
                "    WHEN TIPO_DOCTO IN ('NC', 'ND') THEN " +
                "      (SELECT (CASE WHEN CODIGO_DGI IS NULL THEN " +
                "                  'PAPEL_REF;' || QUERY.COD_REF || ';' || TO_CHAR(FECHA, 'YYYY-MM-DD') || 'T' || TO_CHAR(FECHA, 'HH24:MI:SS') || '-05:00' " +
                "               WHEN CODIGO_DGI LIKE 'FE%' THEN " +
                "                  'CUFE_REF;' || CODIGO_DGI || ';' || TO_CHAR(FECHA, 'YYYY-MM-DD') || 'T' || TO_CHAR(FECHA, 'HH24:MI:SS') || '-05:00' " +
                "               ELSE " +
                "                  'FISC_REF;' || CODIGO_DGI || ';' || TO_CHAR(FECHA, 'YYYY-MM-DD') || 'T' || TO_CHAR(FECHA, 'HH24:MI:SS') || '-05:00' " +
                "               END) " +
                "         FROM TBL_FAC_DGI_DOCUMENTS " +
                "        WHERE CODIGO = QUERY.COD_REF " +
                "          AND COMPANIA = QUERY.COMPANIA) " +
                "        END REFERENCIA, " +
                "    TO_CHAR(QUERY.FECHA, 'YYYY-MM-DD') || 'T' || TO_CHAR(QUERY.FECHA, 'HH24:MI:SS') || '-05:00' FECHA_EMISION " +
                "FROM " +
                "    (  " +
                      "SELECT " +
					  "	   CAMPO2, " +
                      "    CASE " +
                      "        WHEN A.FACTURAR_A = 'E' THEN " +
                      "            A.CAMPO4 " +
                      "        ELSE " +
                      "            A.CLIENTE " +
                      "    END AS \"CUSTOMERNAME\", " +
                      "    CASE " +
                      "        WHEN A.CAMPO8 != 'NA' THEN " +
                      "            A.CAMPO8 " +
                      "        ELSE " +
                      "            '' " +
                      "    END AS \"COMENTARIO\", " +
                      "    CASE " +
                      "        WHEN A.FACTURAR_A = 'P' THEN " +
                      "            A.IDENTIFICACION " +
                      "        ELSE " +
                      "            A.RUC_CEDULA " +
                      "    END AS \"CUSTOMERRUC\", " +
                      "    CASE " +
                      "        WHEN A.FACTURAR_A = 'P' THEN " +
                      "            A.CAMPO4 " +
                      "        WHEN A.FACTURAR_A = 'E' THEN " +
                      "            'PAC. '||A.CLIENTE " +
                      "        ELSE " +
                      "            '' " +
                      "    END AS \"ADDINFO\", " +
                      "    REPLACE(GETMONTOCENTROTERCERO(A.CODIGO, A.COMPANIA), '=', '') AS \"TRAILER\", " +
                      "    NVL(GETMONTOCOPAGO(A.COMPANIA, A.CODIGO),0) AS \"DISCOUNT\", " +
                      "    A.MONTO, " +
                      "    DECODE(A.TIPO_DOCTO, 'NC', 'C', 'NCP', 'C', 'ND', 'D', 'NDP', 'D' ,'F') AS \"TIPO_DOCTO\", " +
                      "    A.TIPO_DOCTO TIPO_DOCTO_REAL, " +
                      "    DECODE(A.TIPO_DOCTO, 'NC', 'NP', 'NCP', 'SP', 'ND', 'NP', 'NDP', 'SP', 'FACT', 'NP', 'SP') AS \"TIPO_DOCTO_R\", " +
                      "    CASE " +
                      "        WHEN A.TIPO_DOCTO = 'NCP' THEN " +
                      "            (SELECT CODIGO FROM TBL_FAC_DGI_DOCUMENTS WHERE CODIGO_DGI = A.COD_REF) " +
                      "        ELSE " +
                      "            A.COD_REF " +
                      "    END AS \"CODIGO_DGI_F\", " +
                      "    DV, " +
                      "    CAMPO11, " +
                      "    COD_REF, " +
                      "    COMPANIA, " +
                      "    FECHA " +
                      "FROM " +
                      "    TBL_FAC_DGI_DOCUMENTS A " +
                      "WHERE " +
                      "        A.COMPANIA = " + ((String) session.getAttribute("_companyId")) +
                      "    AND A.ID = " + docId +
                "    )  QUERY";

String q_items = "SELECT " +
                 "     ROWNUM AS \"ID\", " +
                 "     TO_CHAR(PRECIO, 'fm999999999999999990D00') AS \"PRICE\", " +
                 "     TO_CHAR(NVL(CANTIDAD, 1), 'fm999999999999999990D00') AS \"Qty\", " +
                 "     REPLACE(DESCRIPCION, CHR(34), '') AS \"Desc\", " +
                 "     CASE " +
                 "         WHEN IMPUESTO > 0 THEN " +
                 "            '01' " +
                 "         ELSE " +
                 "            '00' " +
                 "         END AS \"Tax\", " +
                 "     TO_CHAR(NVL(DESCUENTO,0), 'fm999999999999999990D00') AS \"damt\", " +
                 "     CODIGO AS \"Code\", " +
                 "     CODIGO_CPBS, " +
                 "     TO_CHAR(IMPUESTO, 'fm999999999999999990D00') as \"MontoImpuesto\", " + //Precio del �tem. Si el �tem no es valorable: informar campo en 0.00 PrecioItem <> Cantidad * (PrecioUnitario - PrecioUnitarioDescuento)
                 "     TO_CHAR(((NVL(CANTIDAD,1) * PRECIO) - DESCUENTO), 'fm999999999999999990D00') as \"PrecioItem\", " + 
                 "     TO_CHAR(((NVL(CANTIDAD,1) * PRECIO) - DESCUENTO + IMPUESTO), 'fm999999999999999990D00') as \"ValorTotalItem\" " +
                 "     , TO_CHAR(SUM(((NVL(CANTIDAD,1) * PRECIO) - DESCUENTO)) OVER (PARTITION BY ID), 'fm999999999999999990D00') AS \"TotalPrecioNeto\" " +
                 "     , TO_CHAR(SUM(IMPUESTO) OVER (PARTITION BY ID), 'fm999999999999999990D00') as \"TotalITBMS\" " +
                 "     , TO_CHAR(SUM(((NVL(CANTIDAD,1) * PRECIO) - DESCUENTO + IMPUESTO)) OVER (PARTITION BY ID), 'fm999999999999999990D00') as \"TotalTodosItems\" " +
                 "     , TO_CHAR(SUM(((NVL(CANTIDAD,1) * PRECIO) - DESCUENTO + IMPUESTO)) OVER (PARTITION BY ID), 'fm999999999999999990D00') as \"TotalFactura\" " +                 
                 "     , COUNT(*) OVER (PARTITION BY ID) as \"NroItems\" " +                 
                 " FROM " +
                 "     TBL_FAC_DGI_DOCTO_DET " +
                 " WHERE " +
                 "         COMPANIA = " + ((String) session.getAttribute("_companyId")) +
                 "     AND ID = " + docId;

String q_Payments = "SELECT " +
                    "   TO_CHAR(SUM(B.MONTO), 'fm999999999999999990D00') AS \"amt\", " +
                    "   A.FISCAL_CODIGO AS  \"type\", " +
                    "   A.DESCRIPCION, " +
                    "   A.CODIGO_FE " +
                    //"   DECODE(B.FP_CODIGO, 3, C.COD_FISCAL, A.COD_FISCAL) AS  type " +
                    //"   NVL(B.TIPO_TARJETA, A.COD_FISCAL) AS  \"type\" " +
                    "FROM " +
                    "   TBL_CJA_FORMA_PAGO A INNER JOIN TBL_FAC_TRX_FORMA_PAGOS B " +
                    "       ON(A.CODIGO = B.FP_CODIGO) " +
                    "   LEFT JOIN TBL_CJA_TIPO_TARJETA C " +
                    "       ON(B.TIPO_TARJETA = C.CODIGO) " +
                    "WHERE " +
                    "       B.COMPANIA = " + ((String) session.getAttribute("_companyId")) +
                    "   AND EXISTS (SELECT NULL FROM TBL_FAC_TRX T WHERE T.OTHER3 = '" + docNo + "' AND T.DOC_ID = B.DOC_ID) " +
                    //"GROUP BY A.COD_FISCAL, B.FP_CODIGO, C.COD_FISCAL";
                    //"GROUP BY A.COD_FISCAL";
                    "GROUP BY A.FISCAL_CODIGO, A.DESCRIPCION, A.CODIGO_FE";

String q_ubicacion = "SELECT PROVINCIA, DISTRITO, CORREGIMIENTO FROM TBL_ADM_FE_PROVDISTCORR WHERE CODIGO_UBICACION = '" + ubicacion_fe + "'";

String q_WS = "SELECT " +
              "    MYNAMESPACE, " +
              "    MYNAMESPACEURI, " +
              "    TCOMPANYID, " +
              "    TPWD, " +
              "    TUSR, " +
              "    WEBSERVICEURI " +
              "FROM " +
              "    TBL_ADM_WEB_SERVICE " +
              "WHERE " +
              "    COMPANIA = " + ((String) session.getAttribute("_companyId"));

String ambiente_fe = java.util.ResourceBundle.getBundle("issi").getString("ambiente_fe");
String proveedor_fe = java.util.ResourceBundle.getBundle("issi").getString("proveedor_fe");

String q_WS_FactElec = "SELECT " +
"    WEBSERVICEURI, " +
"    TUSR, " +
"    TPWD " +
"FROM " +
"    TBL_ADM_WS_FACT_ELEC " +
"WHERE " +
"    COMPANIA = " + ((String) session.getAttribute("_companyId")) +
" AND AMBIENTE = '" + ambiente_fe + "'" +
" AND PROVEEDOR_FE = '" + proveedor_fe + "'"
;


/**********************************************************************************************************************/

if (docType.equalsIgnoreCase("DGI")) {//I M P R E S O R A   F I S C A L

	String printerFlag = "";
	IFRestClient printDGI = new IFRestClient();
	HTTPClientHandler httpClient=new HTTPClientHandler();
	ConMgr.setAppCtx(ConMgr.AUDIT_SOURCE,request.getServletPath());
	ConMgr.setAppCtx(ConMgr.AUDIT_NOTES,"fp="+fp+"&actType="+actType+"&docType="+docType+xtraNotes.toString());

	if (actType.equalsIgnoreCase("2")) {

		CommonDataObject cdo = new CommonDataObject();

		sbSql = new StringBuffer();
		sbSql.append("select nvl(get_sec_comp_param(");
		sbSql.append(session.getAttribute("_companyId"));
		sbSql.append(",'DGI_DOCUMENT_COPY_INT'),'0') as DGI_DOCUMENT_COPY_INT, nvl(get_sec_comp_param(");
		sbSql.append(session.getAttribute("_companyId"));
		sbSql.append(",'DGI_DOCUMENT_COPY'),'0') as DGI_DOCUMENT_COPY, nvl(get_sec_comp_param(");
		sbSql.append(session.getAttribute("_companyId"));
		sbSql.append(",'DGI_DOCUMENT_LIM_CAR'),'40') as DGI_DOCUMENT_LIM_CAR, nvl(get_sec_comp_param(");
		sbSql.append(session.getAttribute("_companyId"));
		sbSql.append(",'DGI_DOCUMENT_CASHDRAWER'),'N') as DGI_DOCUMENT_CASHDRAWER, nvl(get_sec_comp_param(");
		sbSql.append(session.getAttribute("_companyId"));
		sbSql.append(",'FAC_DGI_LABEL_CDST'),'0') as FAC_DGI_LABEL_CDST, nvl(get_sec_comp_param(");
		sbSql.append(session.getAttribute("_companyId"));
		sbSql.append(",'SHOW_CDSH_DGI'),'Y') as SHOW_CDSH_DGI from dual");
		CommonDataObject p = SQLMgr.getData(sbSql.toString());

		if(fp.equals("lista_envio")){

			if (request.getParameter("ruc_cedula")!=null && !request.getParameter("ruc_cedula").equals("")) {
                String ruc_cedula_temp = request.getParameter("ruc_cedula");
                String[] ruc_cedula_split = ruc_cedula_temp.split("-");
                if (ruc_cedula_split.length == 4 && (ruc_cedula_split[1].equals("00") || ruc_cedula_split[1].equals("0"))) {
                    ruc_cedula_temp = ruc_cedula_split[0] + "-" + ruc_cedula_split[2] + "-" + ruc_cedula_split[3];
                }


				sbSql = new StringBuffer();
				sbSql.append("call sp_fac_dgi_upd_ruc_lista(");
				sbSql.append(id_lista);
				sbSql.append(", '");
				//sbSql.append(IBIZEscapeChars.forSingleQuots(request.getParameter("ruc_cedula")));
                sbSql.append(IBIZEscapeChars.forSingleQuots(ruc_cedula_temp));
				sbSql.append("', '");
				sbSql.append(IBIZEscapeChars.forSingleQuots(request.getParameter("nombre_2")));
				sbSql.append("', '");
				sbSql.append(IBIZEscapeChars.forSingleQuots(request.getParameter("dv_nuevo")));
				sbSql.append("')");
				//ConMgr.setAppCtx(ConMgr.AUDIT_SOURCE,request.getServletPath());
				//ConMgr.setAppCtx(ConMgr.AUDIT_NOTES,"fp="+fp+"&actType="+actType+"&docType="+docType+xtraNotes);
				SQLMgr.execute(sbSql.toString());
				//ConMgr.clearAppCtx(null);

			}

			sbSql = new StringBuffer();
			sbSql.append("select compania, 'FAC' as tipo_docto, 'FACTHOSP' as tipo_docto_orig, 'N' as anulada, '' as oc, '0.00' as centrosterceros, '");
			sbSql.append(p.getColValue("DGI_DOCUMENT_COPY"));
			sbSql.append("' as dgi_copy, '");
			sbSql.append(p.getColValue("DGI_DOCUMENT_LIM_CAR"));
			sbSql.append("' as limite_car, '");
			sbSql.append(p.getColValue("DGI_DOCUMENT_CASHDRAWER"));
			sbSql.append("' as open_cashdrawer");

			//----->CONFIG
			int numCols = 3;
			sbSql.append(", ");
			sbSql.append(numCols);
			sbSql.append(" as num_cols, ' ' as labeled");

			//----->HEADER COMMENTS
			sbSql.append(", substr(decode(ruc_cedula,'RUC',to_char(lista_envio),ruc_cedula)||' DV:'||dv,0,@@maxChar) as clientRUC");
			sbSql.append(", substr(max(cliente),0,@@maxChar) as clientName");
			sbSql.append(", substr(max(decode(campo4,null,' ','Aseguradora:'||campo4)),0,");
			sbSql.append((numCols == 3)?"@@maxChar":"70");
			sbSql.append(") as clientAseg");
			sbSql.append(", substr('-',0,@@maxChar) as docRef");
			sbSql.append(", substr('-',0,@@maxChar) as clientAge");
			sbSql.append(", substr('-',0,@@maxChar) as clientDOB");
			sbSql.append(", substr('-',0,@@maxChar) as clientCategoria");
			sbSql.append(", substr('-',0,@@maxChar) as clientMedico");

			//----->TOTAL COMMENTS
			sbSql.append(", max(trim(campo9)) as printingFlag, 'S' as printingCopago");
			sbSql.append(", substr('-',0,@@maxChar) as totalCentrosTerceros");
			sbSql.append(", substr('Copago:'||trim(to_char(max((case when tipo_docto = 'FACT' or substr(codigo,1,2) = 'A-' then getMontoCopago(compania,decode(substr(codigo,1,2),'A-',substr(codigo,3),codigo)) else 0 end)),'999999999990.00')),0,@@maxChar) as totalCopago");
			sbSql.append(", substr(max(decode(campo4,null,' ',campo4)),0,@@maxChar) as clientAsegComplete");
			sbSql.append(", substr(' ',0,@@maxChar) as subTotalplusCIII");
			sbSql.append(", substr('',0,@@maxChar) as direccion1, substr('',(@@maxChar + 1),(@@maxChar * 2)) as direccion2");

			sbSql.append(", trim(to_char(sum(case when (case when tipo_docto in ('FACP','NCP','NDP') then 0 else nvl(descuento,0) + (case when tipo_docto = 'FACT' or substr(codigo,1,2) = 'A-' then getMontoCopagoHon(compania,decode(substr(codigo,1,2),'A-',substr(codigo,3),codigo),'OT',null) else 0 end) end) > (case when tipo_docto = 'FACT' or substr(codigo,1,2) = 'A-' then (select sum(z.monto + z.descuento + z.descuento2) from tbl_fac_detalle_factura z, tbl_cds_centro_servicio y where z.fac_codigo = a.codigo and z.imprimir_sino = 'S' and z.centro_servicio = y.codigo and y.tipo_cds <> 'T' and y.codigo != (case when '");
			sbSql.append(p.getColValue("SHOW_CDSH_DGI"));
			sbSql.append("' = 'Y' then -100 else 0 end)) else 0 end) then (case when tipo_docto = 'FACT' or substr(codigo,1,2) = 'A-' then (select sum(z.monto + z.descuento + z.descuento2) from tbl_fac_detalle_factura z, tbl_cds_centro_servicio y where z.fac_codigo = a.codigo and z.imprimir_sino = 'S' and z.centro_servicio = y.codigo and y.tipo_cds <> 'T' and y.codigo != (case when '");
			sbSql.append(p.getColValue("SHOW_CDSH_DGI"));
			sbSql.append("' = 'Y' then -100 else 0 end)) else 0 end) else (case when tipo_docto in ('FACP','NCP','NDP') then 0 else nvl(descuento,0) + (case when tipo_docto = 'FACT' or substr(codigo,1,2) = 'A-' then getMontoCopagoHon(compania,decode(substr(codigo,1,2),'A-',substr(codigo,3),codigo),'OT',null) else 0 end) end) end),'999999999990.00')) as totalDiscount");

			sbSql.append(" from tbl_fac_dgi_documents a where nvl(impreso,'N') = 'N' and exists (select null from tbl_fac_lista_envio_det led where led.compania = a.compania and led.factura = a.codigo and led.estado = 'A' and exists (select null from tbl_fac_lista_envio le where le.compania = led.compania and le.id = led.id and le.id = ");
			sbSql.append(id_lista);
			sbSql.append(")) group by compania, lista_envio, ruc_cedula, dv");
			cdo = SQLMgr.getData(sbSql.toString().replaceAll("@@maxChar",p.getColValue("DGI_DOCUMENT_LIM_CAR")));
			cdo.addColValue("tipo_Doc", "FAC");

			sbSql = new StringBuffer();
			sbSql.append("select compania, ");
			sbSql.append(id_lista);
			sbSql.append(", trim (to_char (sum (case when (case when tipo_docto in ('FACP', 'NCP', 'NDP') then 0 else nvl (descuento, 0) + (case when tipo_docto = 'FACT' or substr (codigo, 1, 2) = 'A-' then getmontocopagohon (compania, decode (substr (codigo, 1, 2), 'A-', substr (codigo, 3), codigo), 'OT', null) else 0 end) end) > (case when tipo_docto = 'FACT' or substr (codigo, 1, 2) = 'A-' then (select sum (z.monto + z.descuento + z.descuento2) from tbl_fac_detalle_factura z, tbl_cds_centro_servicio y where z.fac_codigo = a.codigo and z.imprimir_sino = 'S' and z.centro_servicio = y.codigo and y.tipo_cds <> 'T' and y.codigo != (case when get_sec_comp_param ( -1, 'SHOW_CDSH_DGI') = 'Y' then -100 else 0 end)) else 0 end) then (case when tipo_docto = 'FACT' or substr (codigo, 1, 2) = 'A-' then (select sum (z.monto + z.descuento + z.descuento2) from tbl_fac_detalle_factura z, tbl_cds_centro_servicio y where z.fac_codigo = a.codigo and z.imprimir_sino = 'S' and z.centro_servicio = y.codigo and y.tipo_cds <> 'T' and y.codigo != (case when get_sec_comp_param ( -1, 'SHOW_CDSH_DGI') = 'Y' then -100 else 0 end)) else 0 end) else (case when tipo_docto in ('FACP', 'NCP', 'NDP') then 0 else nvl (descuento, 0) + (case when    tipo_docto = 'FACT' or substr (codigo, 1, 2) = 'A-' then getmontocopagohon (compania, decode (substr (codigo, 1, 2), 'A-', substr (codigo, 3), codigo), 'OT', null) else 0 end) end) end), '999999999990.00')) as discount, coalesce((select comentario from tbl_fac_lista_envio where compania = a.compania and id = a.lista_envio), 'Paquetes Corporativos '||(select count(*) from tbl_fac_lista_envio_det where estado = 'A' and compania = a.compania and id = a.lista_envio)||' Pacientes') itemname, to_char (1, '999999999990.000') itemqty, to_char (sum(monto), '999999999990.' || nvl ( (select co.no_dec_dgi from tbl_sec_compania co where co.codigo = a.compania), 99)) itemunitprice, 0 taxPerc from tbl_fac_dgi_documents a where nvl(impreso, 'N') = 'N' and a.tipo_docto = 'FACT' and exists (select null from tbl_fac_lista_envio_det led where led.compania = a.compania and led.factura = a.codigo and led.estado = 'A' and exists (select null from tbl_fac_lista_envio le where le.compania = led.compania and le.id = led.id and le.id = ");
			sbSql.append(id_lista);
			sbSql.append(")) group by compania, lista_envio ");
			al = SQLMgr.getDataList(sbSql.toString());

		} else {

			if (request.getParameter("ruc_cedula")!=null && !request.getParameter("ruc_cedula").equals("") ) {

                String ruc_cedula_temp = request.getParameter("ruc_cedula");
                String[] ruc_cedula_split = ruc_cedula_temp.split("-");
                if (ruc_cedula_split.length == 4 && (ruc_cedula_split[1].equals("00") || ruc_cedula_split[1].equals("0"))) {
                    ruc_cedula_temp = ruc_cedula_split[0] + "-" + ruc_cedula_split[2] + "-" + ruc_cedula_split[3];
                }

				sbSql = new StringBuffer();
				sbSql.append("call sp_fac_dgi_upd_ruc(");
				sbSql.append(docId);
				sbSql.append(", '");
				//sbSql.append(IBIZEscapeChars.forSingleQuots(request.getParameter("ruc_cedula")));
                sbSql.append(IBIZEscapeChars.forSingleQuots(ruc_cedula_temp));
				sbSql.append("', '");
				sbSql.append(IBIZEscapeChars.forSingleQuots(request.getParameter("nombre_2")));
				sbSql.append("', '");
				sbSql.append(IBIZEscapeChars.forSingleQuots(request.getParameter("dv_nuevo")));                
				sbSql.append("')");
				//ConMgr.setAppCtx(ConMgr.AUDIT_SOURCE,request.getServletPath());
				//ConMgr.setAppCtx(ConMgr.AUDIT_NOTES,"fp="+fp+"&actType="+actType+"&docType="+docType+xtraNotes);
				SQLMgr.execute(sbSql.toString());
				//ConMgr.clearAppCtx(null);

			}

			//if (id == null) throw new Exception("El Código no es válido. Por favor intente nuevamente!");
			sbSql = new StringBuffer();
			sbSql.append("select id, compania, decode(tipo_docto,'ND','NDD','NC','NDC','FACT','FAC','FACP','FAC','NCP','NDC','NDP','NDD',tipo_docto) as tipo_docto, (case when tipo_docto in ('ND','NC','FACT') then 'FACTHOSP' else 'FACTPOS' end) as tipo_docto_orig, anio, trim(to_char(nvl(monto,0),'999999999990.00')) as monto, nvl(impuesto,0) as impuesto, to_char(fecha,'dd/mm/yyyy') as fecha, usuario_creacion, fecha_creacion, (case when tipo_docto in ('NC','ND') then getDGICodigo(compania,cod_ref) else cod_ref end) as refFactura, tipo_docto_ref, nvl(impreso,'N') as impreso, identificacion, codigo_dgi, dv, campo3, campo7, checkfactanulada(compania,codigo,tipo_docto) as anulada, trim(campo10) as oc, '0.00' as centrosTerceros, cod_ref, tipo_docto as tipo_doc");
			sbSql.append(", decode(a.interfaz_far,'S','");
			sbSql.append(p.getColValue("DGI_DOCUMENT_COPY_INT"));
			sbSql.append("','");
			sbSql.append(p.getColValue("DGI_DOCUMENT_COPY"));
			sbSql.append("') as dgi_copy, '");
			sbSql.append(p.getColValue("DGI_DOCUMENT_LIM_CAR"));
			sbSql.append("' as limite_car, '");
			sbSql.append(p.getColValue("DGI_DOCUMENT_CASHDRAWER"));
			sbSql.append("' as open_cashdrawer");

			//----->CONFIG
			int numCols = 3;
			sbSql.append(", ");
			sbSql.append(numCols);
			sbSql.append(" as num_cols");
			// valor (incluyendo etiqueta) sin truncar (IFClient se encargaró de truncar)
			sbSql.append(", ' ' as labeled");//if label is append to value, if not the comment this line

			//----->HEADER COMMENTS
			sbSql.append(", substr(decode(ruc_cedula,'RUC',to_char(id),ruc_cedula)||' DV:'||dv,0,@@maxChar) as clientRUC"); // se agrego en RUC sin comando de abrir cashdrawer
			//sbSql.append(", substr(ruc_cedula,0,@@maxChar)||'@@0' as clientRUC"); // se agrego en RUC comando de abrir cashdrawer eso se aplica cuando ya cash drawer esta conectado a impresora fiscal
			sbSql.append(", substr(cliente,0,@@maxChar) as clientName");
			sbSql.append(", substr((case when tipo_docto in ('FACP','NCP','NDP') or facturar_a = 'O' then nvl(campo8,' ') else decode(campo4,null,' ','Aseguradora:'||campo4) end),0,");
			sbSql.append((numCols == 3)?"@@maxChar":"70");
			sbSql.append(") as clientAseg");
			sbSql.append(", substr(decode(codigo,null,' ','Referencia:'||codigo),0,@@maxChar) as docRef");
			sbSql.append(", substr(decode(cliente, null,decode(campo5,null,' ','Edad:'||(select edad from vw_adm_paciente where pac_id = a.pac_id)||decode(nvl(trim(campo9),'N'),'N',' ','S',' '||trim(campo10))),'Pac.: '||cliente),0,@@maxChar) as clientAge");
			sbSql.append(", substr(decode(campo6,null,' ','Fecha Nacimiento:'||case when tipo_docto = 'FACT' or substr(codigo,1,2) = 'A-' then (select to_char(f_nac,'dd/mm/yyyy') from vw_adm_paciente where pac_id = a.pac_id) else campo6 end),0,@@maxChar) as clientDOB");
			sbSql.append(", substr(decode(campo1,null,' ','Categoria:'||campo1),0,@@maxChar) as clientCategoria");
			sbSql.append(", substr(decode(campo2,null,' ','Medico:'||campo2),0,@@maxChar) as clientMedico");

			//----->TOTAL COMMENTS
			sbSql.append(", trim(campo9) as printingFlag, (case when (tipo_docto = 'FACT' or substr(codigo,1,2) = 'A-') and nvl(getMontoCopago(compania,decode(substr(codigo,1,2),'A-',substr(codigo,3),codigo)),0) = 0 and facturar_a = 'P' then 'N' when facturar_a = 'O' then 'N' else 'S' end) as printingCopago");
			sbSql.append(", substr((case when tipo_docto in ('FACT') or substr(codigo,1,2) = 'A-' then getMontoCentroTercero(decode(substr(codigo,1,2),'A-',substr(codigo,3),codigo),compania) else '-' end),0,@@maxChar) as totalCentrosTerceros");
			sbSql.append(", substr('Copago:'||trim(to_char((case when tipo_docto = 'FACT' or substr(codigo,1,2) = 'A-' then getMontoCopago(compania,decode(substr(codigo,1,2),'A-',substr(codigo,3),codigo)) else 0 end),'999999999990.00')),0,@@maxChar) as totalCopago");
			sbSql.append(", substr(decode(campo4,null,' ',campo4),0,@@maxChar) as clientAsegComplete");
			sbSql.append(", substr((case when tipo_docto in ('FACT') or substr(codigo,1,2) = 'A-' then decode('");
			sbSql.append(p.getColValue("FAC_DGI_LABEL_CDST"));
			sbSql.append("','0','TOTAL+CDST:','_______________A PAGAR:')||trim(to_char(gettotalfactura(codigo,compania),'999,990.00')) else ' ' end),0,@@maxChar) as subTotalplusCIII");
			sbSql.append(", substr(campo11,0,@@maxChar) as direccion1, substr(campo11,(@@maxChar + 1),(@@maxChar * 2)) as direccion2");

			//sbSql.append(", trim(to_char((case when tipo_docto in ('FACP','NCP','NDP') then 0 else nvl(descuento,0) + (case when tipo_docto = 'FACT' or substr(codigo,1,2) = 'A-' then getMontoCopagoHon(compania,decode(substr(codigo,1,2),'A-',substr(codigo,3),codigo),'OT',null) else 0 end) end),'999999999990.00')) as totalDiscount");
			sbSql.append(", trim(to_char(case when (case when tipo_docto in ('FACP','NCP','NDP') then 0 else nvl(descuento,0) + (case when tipo_docto = 'FACT' or substr(codigo,1,2) = 'A-' then getMontoCopagoHon(compania,decode(substr(codigo,1,2),'A-',substr(codigo,3),codigo),'OT',null) else 0 end) end) > (case when tipo_docto = 'FACT' or substr(codigo,1,2) = 'A-' then (select sum(z.monto + z.descuento + z.descuento2) from tbl_fac_detalle_factura z, tbl_cds_centro_servicio y where z.fac_codigo = a.codigo and z.imprimir_sino = 'S' and z.centro_servicio = y.codigo and y.tipo_cds <> 'T' and y.codigo != (case when '");
			sbSql.append(p.getColValue("SHOW_CDSH_DGI"));
			sbSql.append("' = 'Y' then -100 else 0 end)) else 0 end) then (case when tipo_docto = 'FACT' or substr(codigo,1,2) = 'A-' then (select sum(z.monto + z.descuento + z.descuento2) from tbl_fac_detalle_factura z, tbl_cds_centro_servicio y where z.fac_codigo = a.codigo and z.imprimir_sino = 'S' and z.centro_servicio = y.codigo and y.tipo_cds <> 'T' and y.codigo != (case when '");
			sbSql.append(p.getColValue("SHOW_CDSH_DGI"));
			sbSql.append("' = 'Y' then -100 else 0 end)) else 0 end) else (case when tipo_docto in ('FACP','NCP','NDP') then 0 else nvl(descuento,0) + (case when tipo_docto = 'FACT' or substr(codigo,1,2) = 'A-' then getMontoCopagoHon(compania,decode(substr(codigo,1,2),'A-',substr(codigo,3),codigo),'OT',null) else 0 end) end) end,'999999999990.00')) as totalDiscount");

			sbSql.append(" from tbl_fac_dgi_documents a where id = ");
			sbSql.append(docId);

			cdo = SQLMgr.getData(sbSql.toString().replaceAll("@@maxChar",p.getColValue("DGI_DOCUMENT_LIM_CAR")));

			if (cdo.getColValue("anulada").equalsIgnoreCase("S")) throw new Exception("La factura #"+docId+" fue ANULADA previamente! No puede imprimirla!");
			else if (cdo.getColValue("impreso").equalsIgnoreCase("Y")) throw new Exception("La factura #"+docId+" ya fue IMPRESA previamente! Si requiere imprimir una copia tendrá que utilizar la opción de RE-IMPRIMIR!");

			sbSql = new StringBuffer();
			sbSql.append("select id, tipo_docto, compania, anio, codigo_trx, codigo,  descripcion/*substr(,0,40)*/ itemName, to_char(nvl(cantidad, 1), '999999999990.000') itemQty, to_char(precio, '999999999990.'||NVL((SELECT co.no_dec_dgi FROM TBL_SEC_COMPANIA co WHERE co.codigo = dd.compania), 99)) itemUnitPrice, nvl(impuesto, 0)impuesto, nvl(taxPerc,0)taxPerc, (case when tipo_docto in ('FACP', 'NCP', 'NDP') then to_char(nvl(descuento, 0), '9999990.99') else '0' end )as discount, usuario_creacion from tbl_fac_dgi_docto_det dd where id = ");
			sbSql.append(docId);
			if(cdo.getColValue("tipo_docto_orig").equals("FACTHOSP")){
				sbSql.append(" and exists (select null from tbl_cds_centro_servicio cds where cds.tipo_cds != 'T' and cds.codigo != 0 and (to_char(cds.codigo) = dd.codigo or dd.codigo is null))");
			}

			al = SQLMgr.getDataList(sbSql.toString());

			if(al.size()==0 && cdo.getColValue("tipo_docto_orig").equals("FACTHOSP")){

				sbSql = new StringBuffer();
				sbSql.append("select 0 codigo, 'CENTROS TERCEROS' itemName, to_char(1, '999999999990.000') itemQty, to_char(0, '999999999990.00') itemUnitPrice, 0 impuesto, 0 taxPerc, 0 as discount from dual");
				al = SQLMgr.getDataList(sbSql.toString());

			}

			if (!cdo.getColValue("centrosTerceros").equals("0.00") && al.size() == 0) throw new Exception("La Factura no se puede imprimir porque el Monto corresponde a Centros Terceros!");

		}

		String  sendCmds = "";
		tipo=cdo.getColValue("tipo_docto");
		String cmdsFP = "";
		if(cdo.getColValue("tipo_Doc").equals("FACP")){

			sbSql = new StringBuffer();
			sbSql.append("select trim(getFormasPago(");
			sbSql.append((String) session.getAttribute("_companyId"));
			sbSql.append(", ");
			sbSql.append(cdo.getColValue("cod_ref"));
			sbSql.append(")) formas_pago from dual");
			CommonDataObject cdFP = SQLMgr.getData(sbSql.toString());
			if(cdFP!=null) {
				//cmdsFP = "@@201" + printDGI.getFloatSubString(cdFP.getColValue("formas_pago"),12,"0");
				cmdsFP = cdFP.getColValue("formas_pago");
			}

		}
		System.err.println(" ---------------> tipo_docto="+cdo.getColValue("tipo_docto"));
		issi.admin.ISSILogger.error("dgi",request.getContextPath()+request.getServletPath()+" ---------------> tipo_docto="+cdo.getColValue("tipo_docto"));

		String cashdrawerCmd = "";

		if(cdo.getColValue("tipo_docto").equals("FAC")) sendCmds = cashdrawerCmd+printDGI.printInvoice(cdo,al);
		else if(cdo.getColValue("tipo_docto").equals("NDD")) sendCmds = printDGI.printNDD(cdo,al);
		else if(cdo.getColValue("tipo_docto").equals("NDC")) sendCmds = printDGI.printNDC(cdo,al);

		issi.admin.ISSILogger.error("dgi",request.getContextPath()+request.getServletPath()+" "+sendCmds);


        int cpbsCount = 0;

        while (request.getParameter("cpbs" + cpbsCount) != null) {

            String codigoCPBSCajaDeTexto = request.getParameter("cpbsText" + cpbsCount);
            String codigoArticuloFacHidden = request.getParameter("itemFECode" + cpbsCount);
            String codigoCPBSLista = request.getParameter("cpbs" + cpbsCount).split("-")[0];
            String codigoArticuloFacLista = request.getParameter("cpbs" + cpbsCount).split("-")[1];

            String codigoCPBSColocar = "";
            String codigoArticuloFacColocar = "";

            if (codigoCPBSCajaDeTexto != null && !codigoCPBSCajaDeTexto.equals("")) {
                codigoCPBSColocar = codigoCPBSCajaDeTexto;
                codigoArticuloFacColocar = codigoArticuloFacHidden;
            } else {
                codigoCPBSColocar = codigoCPBSLista;
                codigoArticuloFacColocar = codigoArticuloFacLista;                
            }
            
            String sqlString = "UPDATE TBL_FAC_DGI_DOCTO_DET SET CODIGO_CPBS = '" + codigoCPBSColocar + "' WHERE " +
            "         COMPANIA = " + ((String) session.getAttribute("_companyId")) +
            "     AND ID = " + docId + 
            "     AND CODIGO = '" + codigoArticuloFacColocar + "'"
            ;
            SQLMgr.execute(sqlString);
            cpbsCount++;
        }

        try {

	        d_enca = SQLMgr.getDataList(q_enca);
            d_items = SQLMgr.getDataList(q_items);
            d_Payments = SQLMgr.getDataList(q_Payments);
            d_WS = SQLMgr.getDataList(q_WS);
            d_ubicacion = SQLMgr.getDataList(q_ubicacion);
            d_WS_FactElec = SQLMgr.getDataList(q_WS_FactElec);

            ArrayList<Item> listaItems = new ArrayList<Item>();
            boolean copagoDescontado = false;
            double totalTodosLosItems = 0;
            double totalPrecioNeto = 0;

            CommonDataObject cdoE = (CommonDataObject) d_enca.get(0);
            BigDecimal copagoValue = new BigDecimal(cdoE.getColValue("DISCOUNT")); //Copago

	        for (int i=0; i<d_items.size(); i++)
            {
            	CommonDataObject cdoI = (CommonDataObject) d_items.get(i);
                items = items + "   <Item Id=\""+cdoI.getColValue("ID")+"\" Price=\""+cdoI.getColValue("Price")+"\" Qty=\""+cdoI.getColValue("Qty")+"\" Desc=\""+cdoI.getColValue("Desc")+"\" Tax=\""+cdoI.getColValue("Tax")+"\" Code=\""+cdoI.getColValue("Code")+"\" damt=\""+cdoI.getColValue("damt")+"\"/>\n";

                BigDecimal precioUnitarioValue = new BigDecimal(cdoI.getColValue("Price")); //PrecioUnitario
                BigDecimal damtValue = new BigDecimal(cdoI.getColValue("damt"));
                BigDecimal quantityValue = new BigDecimal(cdoI.getColValue("Qty"));
                double descuentoUnitario = damtValue.doubleValue() / quantityValue.doubleValue();
                double copagoUnitarioValue = copagoValue.doubleValue() / quantityValue.doubleValue();

                double valorConDescuentoUnitario = precioUnitarioValue.doubleValue() - descuentoUnitario;
                BigDecimal precioUnitarioDescuentoValue = null;
                if ((copagoUnitarioValue < valorConDescuentoUnitario) && !copagoDescontado) {
                   
                   precioUnitarioDescuentoValue = new BigDecimal(descuentoUnitario + copagoUnitarioValue).setScale(2, RoundingMode.HALF_UP);
                   copagoDescontado = true;
                } else {
                   precioUnitarioDescuentoValue = new BigDecimal(descuentoUnitario).setScale(2, RoundingMode.HALF_UP);
                }

                double precioItem = (precioUnitarioValue.doubleValue() - precioUnitarioDescuentoValue.doubleValue()) * quantityValue.doubleValue();
                totalPrecioNeto += precioItem;

                double valorTotalItem = precioItem + new BigDecimal(cdoI.getColValue("MontoImpuesto")).doubleValue();
                totalTodosLosItems += valorTotalItem;

                Item itemFE = new Item(
                        cdoI.getColValue("Desc") //String descripcion
                      , cdoI.getColValue("Code") //String codigo
                      , "und" //String unidadMedida
                      , cdoI.getColValue("Qty") //String cantidad
                      , "" //String fechaFabricacion
                      , "" //String fechaCaducidad
                      , null //String codigoCPBSAbrev
                      , cdoI.getColValue("CODIGO_CPBS") //String codigoCPBS
                      , "und" //String unidadMedidaCPBS
                      , cdoI.getColValue("Desc") //String infoItem
                      , cdoI.getColValue("Price") //String precioUnitario
                      , precioUnitarioDescuentoValue.toString() //String precioUnitarioDescuento
                      , new BigDecimal(precioItem).setScale(2, RoundingMode.HALF_UP).toString() //String precioItem Precio del �tem. Si el �tem no es valorable: informar campo en 0.00 PrecioItem <> Cantidad * (PrecioUnitario - PrecioUnitarioDescuento)
                      , "" //String precioAcarreo
                      , "" //String precioSeguro
                      , new BigDecimal(valorTotalItem).setScale(2, RoundingMode.HALF_UP).toString() //String valorTotal
                      , "" //String codigoGTIN
                      , "" //String cantGTINCom
                      , "" //String codigoGTINInv
                      , "" //String cantGTINComInv
                      , cdoI.getColValue("Tax") //String tasaITBMS
                      , cdoI.getColValue("MontoImpuesto") //String valorITBMS
                      , "" //String tasaISC
                      , "" //String valorISC
                      , null //ArrayList<Oti> listaItemOTI
                      , null //Vehiculo vehiculo
                      , null //Medicina medicina
                      , null //PedidoComercialItem pedidoComercialItem
                      );
                listaItems.add(itemFE);
        
            }

            ArrayList<FormaPago> listaFormaPago
                = new ArrayList<FormaPago>();

            String descFormaPago = null;
            String formaPagoFact = null;
            
            for (int i=0; i<d_Payments.size(); i++)
            {
            	CommonDataObject cdoP = (CommonDataObject) d_Payments.get(i);
                Payments = Payments + "   <Payment Id=\""+(i+1)+"\" amt=\""+cdoP.getColValue("amt")+"\" type=\""+cdoP.getColValue("type")+"\"/>\n";
                
                descFormaPago = "PAGADO CON " + cdoP.getColValue("DESCRIPCION");
                formaPagoFact = cdoP.getColValue("CODIGO_FE");
                
            }
            
            CommonDataObject cdoUbicacion = ubicacion_fe!=null&&ubicacion_fe.trim()!=""?(CommonDataObject) d_ubicacion.get(0):null;
            
            String provincia = cdoUbicacion!=null?cdoUbicacion.getColValue("PROVINCIA"):null;
            String distrito = cdoUbicacion!=null?cdoUbicacion.getColValue("DISTRITO"):null;
            String corregimiento = cdoUbicacion!=null?cdoUbicacion.getColValue("CORREGIMIENTO"):null;

            String dv_cliente = isNumeric(cdoE.getColValue("DV"))?String.format("%02d", Integer.parseInt(cdoE.getColValue("DV"))):cdoE.getColValue("DV");
            String ruc_cliente_fe = cdoE.getColValue("CustomerRUC");

            Cliente cliente = new Cliente(
                //tipocliente.equals("02")?"02":tipocliente.equals("03")?"03":cdoE.getColValue("TIPO_CLIENTEFE") //String tipoClienteFE 01=Contribuyente, 02=No Contribuyente, 03=Gobierno
                  tipocliente               
                , tipocliente.equals("02")?null:((cdoE.getColValue("TIPO_CLIENTEFE").equals("01")||tipocliente.equals("01")||tipocliente.equals("03"))?
                        request.getParameter("tipoClienteHis")!=null&&(request.getParameter("tipoClienteHis").equals("ASEGURADOS")||request.getParameter("tipoClienteHis").equals("EMPRESA - CUENTAS HOSPITAL"))?"2":request.getParameter("tipoClienteHis")==null||request.getParameter("tipoClienteHis").equals("")?"2":"1":null) ///String tipoContribuyente
                , tipocliente.equals("02")?null:((cdoE.getColValue("TIPO_CLIENTEFE").equals("01")||tipocliente.equals("03"))?cdoE.getColValue("CustomerRUC"):null) //String numeroRUC
                , tipocliente.equals("02")?null:((cdoE.getColValue("TIPO_CLIENTEFE").equals("01")||tipocliente.equals("03"))?dv_cliente:null) //String digitoVerificadorRUC
                , cdoE.getColValue("CUSTOMERNAME") //String razonSocial
                , tipocliente.equals("02")?null:((cdoE.getColValue("TIPO_CLIENTEFE").equals("01")||tipocliente.equals("03"))?request.getParameter("direccion"):null)//cdoE.getColValue("DIRECCION") //String direccion
                , tipocliente.equals("02")?null:((cdoE.getColValue("TIPO_CLIENTEFE").equals("01")||tipocliente.equals("03"))?request.getParameter("ubicacion_fe"):null) //String codigoUbicacion
                , tipocliente.equals("02")?null:((cdoE.getColValue("TIPO_CLIENTEFE").equals("01")||tipocliente.equals("03"))?provincia:null) //String provincia
                , tipocliente.equals("02")?null:((cdoE.getColValue("TIPO_CLIENTEFE").equals("01")||tipocliente.equals("03"))?distrito:null) //String distrito
                , tipocliente.equals("02")?null:((cdoE.getColValue("TIPO_CLIENTEFE").equals("01")||tipocliente.equals("03"))?corregimiento:null) //String corregimiento
                , null //String tipoIdentificacion
                , "" //String nroIdentificacionExtranjero
                , "" //String paisExtranjero
                , tipocliente.equals("02")?null:((cdoE.getColValue("TIPO_CLIENTEFE").equals("01")||tipocliente.equals("03"))?request.getParameter("telefono_fe"):null) //String telefono1
                , null //String telefono2
                , null //String telefono3
                , e_mail //String correoElectronico1
                , null //String correoElectronico2
                , null //String correoElectronico3
                , "PA" //String pais
                , null //String paisOtro
                );
            
            ArrayList<DocFiscalReferenciado> listaDocsFiscalReferenciados = null;
            
            String tipoDocumento = "01"; //Inicialmente factura normal

            if (cdoE.getColValue("TIPO_DOCTO_REAL").equals("NCP") || cdoE.getColValue("TIPO_DOCTO_REAL").equals("NC") || cdoE.getColValue("TIPO_DOCTO_REAL").equals("ND")) {
                if (cdoE.getColValue("REFERENCIA") != null) {
                    listaDocsFiscalReferenciados = new ArrayList<DocFiscalReferenciado>();
                    String[] datosDocumentoReferenciado = cdoE.getColValue("REFERENCIA").split(";");
                    String tipoDocumentoReferenciado = datosDocumentoReferenciado[0];
                    String cufeFEReferenciada = null;
                    String nroFacturaPapel = null;
                    String nroFacturaImpFiscal = null;
                    
                    if (tipoDocumentoReferenciado.equals("CUFE_REF")) {
                        cufeFEReferenciada = datosDocumentoReferenciado[1];
                    } else if (tipoDocumentoReferenciado.equals("PAPEL_REF")) {
                        nroFacturaPapel = datosDocumentoReferenciado[1];
                    } else if (tipoDocumentoReferenciado.equals("FISC_REF")) {
                        nroFacturaImpFiscal = datosDocumentoReferenciado[1];
                    }

                    String fechaEmisionDocFiscalReferenciado = datosDocumentoReferenciado[2];

                    DocFiscalReferenciado docFiscalReferenciado = new DocFiscalReferenciado(
                        fechaEmisionDocFiscalReferenciado  //String fechaEmisionDocFiscalReferenciado
                      , cufeFEReferenciada  //String cufeFEReferenciada
                      , nroFacturaPapel  //String nroFacturaPapel
                      , nroFacturaImpFiscal  //String nroFacturaImpFiscal
                    );

                    listaDocsFiscalReferenciados.add(docFiscalReferenciado);

                    if (cdoE.getColValue("TIPO_DOCTO_REAL").equals("NCP") || cdoE.getColValue("TIPO_DOCTO_REAL").equals("NC")) {
                        if (cufeFEReferenciada != null) {
                           tipoDocumento = "04";
                        } else {
                            tipoDocumento = "06";
                        }
                    } else if (cdoE.getColValue("TIPO_DOCTO_REAL").equals("ND")) {
                        if (cufeFEReferenciada != null) {
                            tipoDocumento = "05";
                        } else {
                            tipoDocumento = "07";
                        }                        
                    }

                } else {
                    if (cdoE.getColValue("TIPO_DOCTO_REAL").equals("NCP") || cdoE.getColValue("TIPO_DOCTO_REAL").equals("NC")) {
                        tipoDocumento = "06";
                    } else if (cdoE.getColValue("TIPO_DOCTO_REAL").equals("ND")) {
                        tipoDocumento = "07";
                    }
                }
            }

            String informacionInteres = cdoE.getColValue("AddInfo") + " " + 
            "#Turn:"+((request.getParameter("id_turno").equals("") || request.getParameter("id_turno") == null) ? "Undef." : request.getParameter("id_turno"))+
            //"   #Station:"+request.getParameter("estacion")+"   #Printer:"+request.getParameter("impresora") +
            "   User:"+((String) session.getAttribute("_userName"));         
            
            
            if (cdoE.getColValue("TIPO_DOCTO_R").equals("SP")) {
                informacionInteres +=
                    /*"   Pago                                       "+((p_pago == "" || p_pago == null) ? cdoE.getColValue("TOTAL_MAS_CT_TRAILER") : p_pago)+
                    "   Cambio                                     "+((p_cambio == "" || p_cambio == null) ? "0.00" : p_cambio)*/
                    ""
                    ;
            }else{
                informacionInteres +=
                    "   Centros Terceros                           "+cdoE.getColValue("CT_TRAILER")+
                    "   Total + Terceros                           "+cdoE.getColValue("TOTAL_MAS_CT_TRAILER");
            }

            if (copagoValue.doubleValue() > 0) {
                informacionInteres += (" Copago: " + copagoValue.toString());
            }


            DatosTransaccion datosGeneralesTransaccion = new DatosTransaccion(
                  "01" //String tipoEmision
                , "" //String fechaInicioContingencia
                , "" //String motivoContingencia
                , tipoDocumento //String tipoDocumento
                , docNo //String numeroDocumentoFiscal
                , "002"//String puntoFacturacionFiscal
                , cdoE.getColValue("FECHA_EMISION") //String fechaEmision -- // formato 2020-11-18T11:45:13-05:00
                , "" //String fechaSalida
                , "01"//String naturalezaOperacion
                , "1"//String tipoOperacion
                , "1"//String destinoOperacion
                , "1"//String formatoCAFE
                , "1"//String entregaCAFE
                , "1"//String envioContenedor
                , "1"//String procesoGeneracion
                , "1"//String tipoVenta
                , informacionInteres //String informacionInteres
                , cliente
                , null //DatosFacturaExportacion datosFacturaExportacion
                , listaDocsFiscalReferenciados //ArrayList<DocFiscalReferenciado> listaDocsFiscalReferenciados
                , null //ArrayList<AutorizadoDescargaFEyEventos> listaAutorizadosDescargaFEyEventos
                );

                CommonDataObject cdoITot = (CommonDataObject) d_items.get(0);

            FormaPago formaPago
                = new FormaPago(
                          formaPagoFact!=null?formaPagoFact:"99"//String formaPagoFact
                        //, descFormaPago!=null?"PAGADO CON " + descFormaPago:"PAGADO AL CONTADO" //String descFormaPago
                        , formaPagoFact==null||formaPagoFact.equals("99")?descFormaPago!=null?"PAGADO CON " + descFormaPago:"PAGADO AL CONTADO":null //String descFormaPago
                        , new BigDecimal(totalTodosLosItems).setScale(2, RoundingMode.HALF_UP).toString() //String valorCuotaPagada
                        );
                listaFormaPago.add(formaPago);

            TotalesSubTotales totalesSubTotales =
                new TotalesSubTotales(
                          new BigDecimal(totalPrecioNeto).setScale(2, RoundingMode.HALF_UP).toString() //String totalPrecioNeto
                        , cdoITot.getColValue("TotalITBMS") //String totalITBMS
                        , "" //String totalISC
                        , cdoITot.getColValue("TotalITBMS") //String totalMontoGravado
                        , "0.00" //String totalDescuento
                        , "" //String totalAcarreoCobrado
                        , ""//String valorSeguroCobrado
                        , new BigDecimal(totalTodosLosItems).setScale(2, RoundingMode.HALF_UP).toString() //String totalFactura
                        , new BigDecimal(totalTodosLosItems).setScale(2, RoundingMode.HALF_UP).toString() //String totalValorRecibido
                        , "0.00"//String vuelto
                        , "1" //String tiempoPago
                        , cdoITot.getColValue("NroItems") //String nroItems
                        , new BigDecimal(totalTodosLosItems).setScale(2, RoundingMode.HALF_UP).toString() //String totalTodosItems
                        , null //ArrayList<DescuentoBonificacion> listaDescBonificacion
                        , listaFormaPago //ArrayList<FormaPago> listaFormaPago
                        , null//Retencion retencion
                        , null //ArrayList<PagoPlazo> listaPagoPlazo
                        , null //ArrayList<TotalOTI> listaTotalOTI
                        );
        
            DocumentoElectronico documentoElectronico = new DocumentoElectronico(
                "0000"//String codigoSucursalEmisor
                , ""//String tipoSucursal
                , datosGeneralesTransaccion //DatosGeneralesTransaccion datosGeneralesTransaccion
                , listaItems //ArrayList<ItemFE> listaItems
                , totalesSubTotales //TotalesSubTotales totalesSubTotales
                , null //PedidoComercialGlobal pedidoComercialGlobal
                , null //InfoLogistica infoLogistica
                , null //InfoEntrega infoEntrega
                , null //UsoPosterior usoPosterior
                , null //ArrayList<Extra> listaExtras
                , null//String serialDispositivo
                );

            CommonDataObject cdoWSFactElec = (CommonDataObject) d_WS_FactElec.get(0);

            Credenciales credenciales = new Credenciales( cdoWSFactElec.getColValue("TUSR") //String tokenEmpresa
                , cdoWSFactElec.getColValue("TPWD") //String tokenPassword
                );

            ManejadorFE manejadorFE = new ManejadorFE();
            manejadorFE.proveedorFE = new ManejadorFEParaEBIyHKA(cdoWSFactElec.getColValue("WEBSERVICEURI"));
            EnviarResponse enviarResponse = manejadorFE.proveedorFE.enviarDocumento(credenciales, documentoElectronico);
            System.out.println(enviarResponse);

            System.out.println(enviarResponse.getCufe());

            String idturno = request.getParameter("id_turno");
            String idestacion = request.getParameter("estacion");
            String idimpresora = request.getParameter("impresora");

            if (idturno == "" || idturno == null){
                idturno = null;
            }

            if (idestacion == "" || idestacion == null){
                idestacion = null;
            }

            if (idimpresora == "" || idimpresora == null){
                idimpresora = null;
            }

            if (docId == "" || docId == null){
                docId = null;
            }

            if (enviarResponse.getResultado().equals("error")) {
            %>
            <script language="javascript">alert('<%=("ERROR RETORNADO POR EL PAC: " + enviarResponse.getMensaje().replaceAll("[\\t\\n\\r]+"," "))%>');</script>
            <%

            } else if (enviarResponse != null && enviarResponse.getCufe() != null && !enviarResponse.getCufe().trim().equals("")) {

                sbSql = new StringBuffer();

                if(fp.equals("lista_envio")){
                    //Pendiente por desarrollar e integrar
                } else {

                    String numeroFiscal = enviarResponse.getCufe().trim();
                    if (numeroFiscal == "" || numeroFiscal == null){
                        numeroFiscal = null;
                    }

					//sbSql.append("call sp_fac_dgi_upd_num_fact("+docId+",'"+numeroFiscal+"',"+idturno+","+idestacion+","+idimpresora+",'"+((String) session.getAttribute("_userName"))+"')");
                    sbSql.append("call sp_fac_dgi_upd_num_fact("+docId+",'"+numeroFiscal+"')");

                }

                SQLMgr.execute(sbSql.toString());
                sbSql = new StringBuffer();

                String sqlUpdResp = "UPDATE TBL_FAC_DGI_DOCUMENTS " +
                                    "SET CODIGO_RESPUESTA_FE = '" + enviarResponse.getCodigo() + "', " +
                                    "RESULTADO_RESPUESTA_FE = '" + enviarResponse.getResultado() + "', " +
                                    "MENSAJE_RESPUESTA_FE = '" + enviarResponse.getMensaje() + "', " +
                                    "QR_FE = '" + enviarResponse.getQr() + "', " +
                                    "FECHA_RECEPCION_DGI_FE = '" + enviarResponse.getFechaRecepcionDGI() + "', " +
                                    "NRO_PROTOCOLO_AUTORIZACION_FE = '" + enviarResponse.getNroProtocoloAutorizacion() + "' " +
                                    "WHERE " +
                                    "         COMPANIA = " + ((String) session.getAttribute("_companyId")) +
                                    "     AND ID = " + docId
                                    ;

                SQLMgr.execute(sqlUpdResp);

                SQLMgr.execute("CALL SP_FAC_UPD_DATOS_CLIENTE_FE('" + docId + "', '" + 
                                                                      ((String) session.getAttribute("_companyId")) + "', '" + 
                                                                      ruc_cliente_fe + "', '" +
                                                                      dv_cliente + "', '" +
                                                                      request.getParameter("direccion") + "', '" +
                                                                      request.getParameter("telefono_fe") + "', '" + 
                                                                      e_mail + "', '" + 
                                                                      request.getParameter("ubicacion_fe") + "')");

                String directory = ResourceBundle.getBundle("path").getString("pdfdocs")+"/facturaelectronica/";

                DatosDocumento datosDocumento = new DatosDocumento( "0000" //String codigoSucursalEmisor
                , docNo //String numeroDocumentoFiscal
                , "002" //String puntoFacturacionFiscal,
                , null //String serialDispositivo
                , tipoDocumento //String tipoDocumento
                , "01" //String tipoEmision
                );
    
                DescargaPDFResponse descargaPDFResponse = manejadorFE.proveedorFE.descargarCAFE(credenciales, datosDocumento);
                DescargaXMLResponse descargaXMLResponse = manejadorFE.proveedorFE.descargarXML(credenciales, datosDocumento);
    
                grabarDocBase64FileSystem(descargaPDFResponse.getDocumento()
                    , directory + docNo + ".pdf");

                grabarDocBase64FileSystem(descargaXMLResponse.getDocumento()
                    , directory + docNo + ".xml");

            }else{
                sbSql = new StringBuffer();
                sbSql.append("call sp_fac_upd_fact("+docId+","+idturno+","+idestacion+","+idimpresora+",'"+((String) session.getAttribute("_userName"))+"')");
                SQLMgr.execute(sbSql.toString());
                sbSql = new StringBuffer();
            }

            /*impfisc.setPrintStationId(request.getParameter("estacion"));
            impfisc.setPrinterId(request.getParameter("impresora"));
            impfisc.setDocType(cdoE.getColValue("TIPO_DOCTO"));
            impfisc.setInvoiceNumber(cdoE.getColValue("CODIGO_DGI_F"));
            impfisc.setDocNumber(docNo);
            impfisc.setCustomerName(cdoE.getColValue("CustomerName"));
            impfisc.setCustomerRUC(cdoE.getColValue("CustomerRUC"));
            impfisc.setCustomerAddress(cdoE.getColValue("COMENTARIO"));
            impfisc.setEmail(e_mail);

            impfisc.setAddInfo(
                "<Line Id=\"1\">"+cdoE.getColValue("AddInfo")+"</Line>\n" +
                "<Line Id=\"2\">#Turn:"+((request.getParameter("id_turno").equals("") || request.getParameter("id_turno") == null) ? "Undef." : request.getParameter("id_turno"))+"   #Station:"+request.getParameter("estacion")+"   #Printer:"+request.getParameter("impresora")+"</Line>\n"+
				"<Line Id=\"3\">"+"User:"+((String) session.getAttribute("_userName"))+"</Line>\n"+
				((cdoE.getColValue("CAMPO2") == null || cdoE.getColValue("CAMPO2") == "") ? "" : "<Line Id=\"4\">"+"Medico: "+cdoE.getColValue("CAMPO2")+"</Line>\n")
            );

            impfisc.setItems(items);
            impfisc.setDiscount(cdoE.getColValue("DISCOUNT"));
            impfisc.setPayments(Payments);

            if (cdoE.getColValue("TIPO_DOCTO_R").equals("SP")) {
                impfisc.setTrailer(
                    "<Line Id=\"1\">Pago                                       "+((p_pago == "" || p_pago == null) ? cdoE.getColValue("TOTAL_MAS_CT_TRAILER") : p_pago)+"</Line>\n"+
                    "<Line Id=\"2\">Cambio                                     "+((p_cambio == "" || p_cambio == null) ? "0.00" : p_cambio)+"</Line>\n"
                );
            }else{
                impfisc.setTrailer(
                    "<Line Id=\"1\">Centros Terceros                           "+cdoE.getColValue("CT_TRAILER")+"</Line>\n"+
                    "<Line Id=\"2\">Total + Terceros                           "+cdoE.getColValue("TOTAL_MAS_CT_TRAILER")+"</Line>\n"
                );
            }

            CommonDataObject cdoWS = (CommonDataObject) d_WS.get(0);

            impfisc.setSOAPAction(cdoWS.getColValue("MYNAMESPACEURI")+"/SendxmlFileToPrint");
            impfisc.setMyNamespace(cdoWS.getColValue("MYNAMESPACE"));
            impfisc.setMyNamespaceURI(cdoWS.getColValue("MYNAMESPACEURI"));

            impfisc.settUsr(cdoWS.getColValue("TUSR"));
            impfisc.settPwd(cdoWS.getColValue("TPWD"));
            impfisc.settCompanyId(cdoWS.getColValue("TCOMPANYID"));

            impfisc.setEvento("SFTP");

            java.time.LocalDateTime locaDate = java.time.LocalDateTime.now();

            System.out.println("******************************************************************************************************************************************************************");
            System.out.println("Hora de inicio de la ejecucion del SendxmlFileToPrint= " + locaDate.getHour() + ":" + locaDate.getMinute() + ":" + locaDate.getSecond() + ":" + locaDate.getNano());
            impfisc.callSoapWebService(cdoWS.getColValue("WEBSERVICEURI"));
            System.out.println("Hora en que termino la ejecucion del SendxmlFileToPrint= " + locaDate.getHour() + ":" + locaDate.getMinute() + ":" + locaDate.getSecond() + ":" + locaDate.getNano());
            System.out.println("******************************************************************************************************************************************************************");

            System.out.println("******************************************************************************************************************************************************************");
            long start = System.currentTimeMillis();
            System.out.println("Tiempo de inicio de espera para hacer el  GetPrintedInfo= "+(System.currentTimeMillis()-start));
            Thread.sleep(10000);
            System.out.println("Tiempo transcurrido de espera para hacer el  GetPrintedInfo= "+(System.currentTimeMillis()-start));
            System.out.println("******************************************************************************************************************************************************************");

            impfisc.setSOAPAction(cdoWS.getColValue("MYNAMESPACEURI")+"/GetPrintedInfo");
            impfisc.setEvento("GPI");

            locaDate = java.time.LocalDateTime.now();
            System.out.println("******************************************************************************************************************************************************************");
            System.out.println("Hora de inicio de la ejecucion del GetPrintedInfo= " + locaDate.getHour() + ":" + locaDate.getMinute() + ":" + locaDate.getSecond() + ":" + locaDate.getNano());
            impfisc.callSoapWebService(cdoWS.getColValue("WEBSERVICEURI"));
            System.out.println("Hora en que termino la ejecucion del GetPrintedInfo= " + locaDate.getHour() + ":" + locaDate.getMinute() + ":" + locaDate.getSecond() + ":" + locaDate.getNano());
            System.out.println("******************************************************************************************************************************************************************");

            String idturno = request.getParameter("id_turno");
            String idestacion = request.getParameter("estacion");
            String idimpresora = request.getParameter("impresora");

            if (idturno == "" || idturno == null){
                idturno = null;
            }

            if (idestacion == "" || idestacion == null){
                idestacion = null;
            }

            if (idimpresora == "" || idimpresora == null){
                idimpresora = null;
            }

            if (docId == "" || docId == null){
                docId = null;
            }
            
            if (impfisc.getResponse() != null && !impfisc.getResponse().trim().equals("")) {

                sbSql = new StringBuffer();

                if(fp.equals("lista_envio")){
                    //Pendiente por desarrollar e integrar
                } else {

                    String numeroFiscal = impfisc.getResponse().trim();
                    if (numeroFiscal == "" || numeroFiscal == null){
                        numeroFiscal = null;
                    }

					sbSql.append("call sp_fac_dgi_upd_num_fact("+docId+",'"+numeroFiscal+"',"+idturno+","+idestacion+","+idimpresora+",'"+((String) session.getAttribute("_userName"))+"')");
                }

                SQLMgr.execute(sbSql.toString());
                sbSql = new StringBuffer();

            }else{
                sbSql = new StringBuffer();
                sbSql.append("call sp_fac_upd_fact("+docId+","+idturno+","+idestacion+","+idimpresora+",'"+((String) session.getAttribute("_userName"))+"')");
                SQLMgr.execute(sbSql.toString());
                sbSql = new StringBuffer();
            }*/
        } catch (Exception exec) {
            System.out.println("****************************************************************************************************");
            System.out.println("Error de impresión: "+exec);
            factElecException = exec.toString();
            %>
            <script language="javascript">alert('<%=factElecException%>');</script>
            <%
            exec.printStackTrace();
            System.out.println("****************************************************************************************************");
        }

	} else if (actType.equalsIgnoreCase("3") || actType.equalsIgnoreCase("4")){
	    try{
            d_WS = SQLMgr.getDataList(q_WS);

            CommonDataObject cdoWS = (CommonDataObject) d_WS.get(0);

            impfisc.setPrintStationId(request.getParameter("estacion"));
            impfisc.setPrinterId(request.getParameter("impresora"));

            if (actType.equalsIgnoreCase("3")){
                impfisc.setDocType("Z");
            } else {
                impfisc.setDocType("X");
            }

            impfisc.setSOAPAction(cdoWS.getColValue("MYNAMESPACEURI")+"/SendxmlFileToPrint");
            impfisc.setMyNamespace(cdoWS.getColValue("MYNAMESPACE"));
            impfisc.setMyNamespaceURI(cdoWS.getColValue("MYNAMESPACEURI"));

            impfisc.settUsr(cdoWS.getColValue("TUSR"));
            impfisc.settPwd(cdoWS.getColValue("TPWD"));
            impfisc.settCompanyId(cdoWS.getColValue("TCOMPANYID"));

            impfisc.setEvento("SFTP");

            impfisc.callSoapWebService(cdoWS.getColValue("WEBSERVICEURI"));

	    } catch(Exception exz){
            System.out.println("****************************************************************************************************");
            System.out.println("Error de impresión "+impfisc.getDocType()+": "+exz);
            System.out.println("****************************************************************************************************");
	    }

	} else if (actType.equalsIgnoreCase("5")) {
%><script language="javascript">
        window.location.href = '../pdfdocs/facturaelectronica/' + '<%=docNo%>' + '.pdf';
  </script>
<%
     
	} else if (actType.equalsIgnoreCase("6")) {

		if (!docId.trim().equals("")) {

			sbSql = new StringBuffer();
			sbSql.append("call sp_fac_dgi_revert_num_fact(");
			sbSql.append(docId);
			sbSql.append(")");
			SQLMgr.execute(sbSql.toString());

		}

	} else if (actType.equalsIgnoreCase("52")) {

		if (request.getParameter("codigo_correcto") != null && !request.getParameter("codigo_correcto").trim().equals("")) {

			sbSql = new StringBuffer();
			sbSql.append("call sp_fac_dgi_corrige_num_fact(");
			sbSql.append(docId);
			sbSql.append(", '");
			sbSql.append(request.getParameter("codigo_correcto"));
			sbSql.append("', '");
			sbSql.append(codigoDgi);
			sbSql.append("', '");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("', ");
			if(request.getParameter("impreso") != null && !request.getParameter("impreso").trim().equals("")) {
				sbSql.append("'");
				sbSql.append(request.getParameter("impreso"));
				sbSql.append("'");
			} else sbSql.append("null");

			sbSql.append(")");
			SQLMgr.execute(sbSql.toString());
			System.out.println("sbSql.........................................................................="+sbSql.toString());

		}

	} else if (actType.equalsIgnoreCase("55")) {

		/*if (printDGI.checkPrinter()) {

			//printerFlag = printDGI.printListDoc(tipo,transDesde,transHasta);
			if(fg.trim().equals("LIST"))printerFlag = printDGI.printListDoc(tipo,transDesde,transHasta);
			else printerFlag = printDGI.reprintDocument(tipo,fg,transDesde,transHasta,ruc);

			//reprintDocument(String tipo, String tipoFiltro, String desde,String hasta,String clientRUC)
			if (!printerFlag) throw new Exception("La re-impresión no se realizó!");

			long startTime = System.currentTimeMillis();
			long endTime = System.currentTimeMillis() + 2000;
			while (endTime < startTime) startTime = System.currentTimeMillis();

		} else throw new Exception("Por favor, revisar Impresora.  Si los problemas persisten debe reiniciar el IFServer de impresora fiscal en la PC local.!");*/
	}
}

%>
<html>
<head>
<%@ include file="../common/nocache.jsp"%>
<script language="javascript">
document.title = 'Impresion Fiscal ';
</script>
</head>
<body >
<div id="responseDiv">Por favor esperar estas imprimiendo el documento..... </br>

</div>
<script language="javascript">
function doSomething(val1,val2){
document.getElementById("responseDiv").innerHTML="Respuesta de Factura Electr�nica " + val1 +"<br>"+val2;
<% if(request.getParameter("fp")!=null && request.getParameter("fp").equals("facturarpos")){ %>
parent.closeWindow();
<% }else if(request.getParameter("fp")!=null && (request.getParameter("fp").equals("docto_dgi_list")) || request.getParameter("fp").equals("lista_envio")) { %>
parent.window.location.reload(true);
<% } %>
parent.hidePopWin(false);
}
<% if (errMsg.trim().equals("") || errMsg.equalsIgnoreCase("IMPRESORA NO CONECTADO")) { %>
doSomething('<%=errMsg%>','<%=responseText%>');
<% } else { %>
setTimeout(doSomething('<%=errMsg%>','<%=responseText%>'), 5000);
<% } %>
</script>
</body>
</html>