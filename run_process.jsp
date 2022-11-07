<%@ page errorPage="../error.jsp"%>
<%@ page import="ibiz.dbutils.SQL2BeanBuilder"%>
<%@ page import="issi.admin.CommonDataObject"%>
<%@ page import="issi.admin.FormBean"%>
<%@ page import="issi.admin.IBIZEscapeChars"%>
<%@ page import="issi.admin.IFClient"%>
<%@ page import="issi.admin.XMLCreator"%>
<%@ page import="java.io.File" %>
<%@ page import="java.util.ArrayList" %>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="ConMgr" scope="session" class="issi.admin.ConnectionMgr"/>
<jsp:useBean id="SecMgr" scope="session" class="issi.admin.SecurityMgr"/>
<jsp:useBean id="UserDet" scope="session" class="issi.admin.UserDetail"/>
<jsp:useBean id="CmnMgr" scope="page" class="issi.admin.CommonMgr"/>
<jsp:useBean id="fb" scope="page" class="issi.admin.FormBean"/>
<jsp:useBean id="SQLMgr" scope="page" class="issi.admin.SQLMgr"/>
<%
    SecMgr.setConnection(ConMgr);
    if (!SecMgr.checkLogin(session.getId())) throw new Exception("Usted está fuera del sistema. Por favor entre al sistema con su nombre de usuario y clave!!!");
    UserDet = SecMgr.getUserDetails(session.getId());
    session.setAttribute("UserDet",UserDet);
    issi.admin.ISSILogger.setSession(session);

    CmnMgr.setConnection(ConMgr);
    SQLMgr.setConnection(ConMgr);

    ArrayList al = new ArrayList();

    StringBuffer sbSql = new StringBuffer();
    StringBuffer tSql = new StringBuffer();
    StringBuffer tFilter = new StringBuffer();
    String fp = request.getParameter("fp");
    String actType = request.getParameter("actType");
    String docType = request.getParameter("docType");
    String docId = request.getParameter("docId");
    String docNo = request.getParameter("docNo");
    String compania = request.getParameter("compania");
    String anio = request.getParameter("anio");
    String turno = request.getParameter("turno");
    String tipoCliente = request.getParameter("tipoCliente");
    String mes = request.getParameter("mes");
    String ubicacion = request.getParameter("ubicacion");
    String estado = request.getParameter("estado");
    String docDesc = "";
    String actDesc = "";
    String pacId = request.getParameter("pacId");
    String noAdmision = request.getParameter("noAdmision");
    String tipoCob = request.getParameter("tipoCob");
    String fecha = request.getParameter("fecha");
    String aseguradora = request.getParameter("aseguradora");
    String tipoCuenta = request.getParameter("tipoCuenta");
    String categoria = request.getParameter("categoria");
    String factura = request.getParameter("factura");
    String tipo = request.getParameter("tipo");
    String ruc = request.getParameter("ruc");
    String dv = request.getParameter("dv");
    String codigo = request.getParameter("codigo");
    String monto = request.getParameter("monto");
    String habitacion = request.getParameter("habitacion");
    String refEmpresa = request.getParameter("refEmpresa");
    String refEmpresaAb = request.getParameter("refEmpresaAb");
    String fechaFinal = request.getParameter("fechaFinal");
    String acreedor = request.getParameter("acreedor");
    String grupo = request.getParameter("grupo");
    String facturar_a = request.getParameter("facturar_a");
    String fNacMadre = request.getParameter("fNacMadre");
    String codPacMadre = request.getParameter("codPacMadre");
    String pacIdMadre = request.getParameter("pacIdMadre");
    String admMadre = request.getParameter("admMadre");
    String codigoPaciente = request.getParameter("codigoPaciente");
    String extDesc = request.getParameter("extDesc");

    String codPlanilla = request.getParameter("codPlanilla");
    String numPlanilla = request.getParameter("numPlanilla");
    String comprob = request.getParameter("comprob");
    String cheque = request.getParameter("cheque");
    String cheque2 = request.getParameter("cheque2");
    String periodo = request.getParameter("periodo");
    String legales = request.getParameter("legales");
    String fechaIni = request.getParameter("fechaIni");
    String fechaFin = request.getParameter("fechaFin");
    String acreedores = request.getParameter("acreedores");
    String transDesde = request.getParameter("transDesde");
    String transHasta = request.getParameter("transHasta");
    String fechaCheck = request.getParameter("fechaCheck");
    String anioPlanilla = request.getParameter("anioPlanilla");
    String planillaGen = request.getParameter("planillaGen");
    String numPlaGen = request.getParameter("numPlaGen");
    String fechaInicia = request.getParameter("fechaInicia");
    String fechaInicial = request.getParameter("fechaInicial");
    String trxs = request.getParameter("trxs");
    String periodoMes = request.getParameter("periodoMes");
    String empId = request.getParameter("empId");
    String noEmpleado = request.getParameter("noEmpleado");
    String facturarA = request.getParameter("facturarA");
    String pAnioOr = request.getParameter("pAnioOr");
    String pCodPlanillaOr = request.getParameter("pCodPlanillaOr");
    String pNoPlanillaOr = request.getParameter("pNoPlanillaOr");
    String fg = request.getParameter("fg");
    String quincena = request.getParameter("quincena");
    String provincia = request.getParameter("provincia");
    String sigla = request.getParameter("sigla");
    String tomo = request.getParameter("tomo");
    String asiento = request.getParameter("asiento");
    String accion = request.getParameter("accion");
    String codigoDgi = request.getParameter("codigoDgi");
    String tipoHuella = request.getParameter("tipoHuella");
    String tab = request.getParameter("tab");
    String motivo = request.getParameter("motivo");
    String incentivo = request.getParameter("incentivo");
    String impuesto = request.getParameter("impuesto");
    String index = request.getParameter("index");
    String comentario = request.getParameter("comentario");
    String creadoPor = request.getParameter("creadoPor");
    String nombrePac = request.getParameter("nombrePac");
    String cdsDet= "N";
    String familia = request.getParameter("familia");
    String clase = request.getParameter("clase");
    String subclase = request.getParameter("subclase");
    String articulo = request.getParameter("articulo");
    String consignacion = request.getParameter("consignacion");
    String venta = request.getParameter("venta");
    String precioVenta = request.getParameter("precioVenta");
    String porcentaje = request.getParameter("porcentaje");
    String roundTo = request.getParameter("roundTo");
    String basis = request.getParameter("basis");
    String almacen = request.getParameter("almacen");
    String anaquel = request.getParameter("anaquel");
    String tipoReact = request.getParameter("tipoReact");
    String tiempoReact = request.getParameter("tiempoReact");
    String cuenta = request.getParameter("cuenta");
    String idPaciente = request.getParameter("idPaciente");
    String admRoot = request.getParameter("admRoot");
    String admType = request.getParameter("admType");
    String nombre_2 = request.getParameter("nombre_2");
    String cta = request.getParameter("cta");
    String ctaDest = request.getParameter("ctaDest");
    String identificacion_2 = request.getParameter("identificacion_2");
	String dv_2 = request.getParameter("dv_2");
    String fechaNoContado = request.getParameter("fecha_no_contado");
    String touch = request.getParameter("touch");
    String impresoSi = request.getParameter("impresoSi");
    String tipoPrecio = request.getParameter("tipoPrecio");
    String id_lista = request.getParameter("id_lista");

	String direccion_fe = "";
	String telefono_fe = "";
	String email_fe = "";
	String codigo_ubicacion_fe = "";
	String tipoClienteHis = "";

	String id_estacion = "";
    String id_turno = "";
    ArrayList ad_estaciones = new ArrayList();

    try {cdsDet =java.util.ResourceBundle.getBundle("issi").getString("cdsDet");}catch(Exception e){ cdsDet = "N";}
    String editClienteRuc = "N";
    String chkAdmType = "Y";
    if (fp == null) fp = "";
    if (docType == null) docType = "";
    if (actType == null) actType = "";
    if (mes == null) mes = "";
    if (ubicacion == null) ubicacion = "";
    if (estado == null) estado = "";
    if (pacId == null) pacId = "";
    if (noAdmision == null) noAdmision = "";
    if (tipoCob == null) tipoCob = "";
    if (fecha == null) fecha = "";
    if (aseguradora == null) aseguradora = "";
    if (tipoCuenta == null) tipoCuenta = "";
    if (categoria == null) categoria = "";
    if (factura == null) factura = "";
    if (tipo == null) tipo = "";
    if (ruc == null) ruc = "";
    if (dv == null) dv = "";
    if (codigo == null) codigo = "";
    if (monto == null) monto = "";
    if (habitacion == null) habitacion = "";

    if (refEmpresa == null) refEmpresa = "";
    if (refEmpresaAb == null) refEmpresaAb = "";

    if (fNacMadre == null) fNacMadre = "";
    if (codPacMadre == null) codPacMadre = "";
    if (pacIdMadre == null) pacIdMadre = "";
    if (admMadre == null) admMadre = "";
    if (codigoPaciente == null) codigoPaciente = "";

    if (fechaFinal == null) fechaFinal = "";
    if (acreedor == null) acreedor = "";
    if (grupo == null) grupo = "";
    if (facturar_a == null)  facturar_a = "";
    if (codPlanilla == null) codPlanilla = "";
    if (numPlanilla == null) numPlanilla = "";
    if (comprob == null) comprob = "";
    if (cheque == null) cheque = "";
    if (cheque2 == null) cheque2 = "";
    if (periodo == null) periodo = "";
    if (legales == null) legales = "";
    if (fechaIni == null) fechaIni = "";
    if (fechaFin == null) fechaFin = "";
    if (acreedores == null) acreedores = "";
    if (transDesde == null) transDesde = "";
    if (transHasta == null) transHasta = "";
    if (fechaCheck == null) fechaCheck = "";
    if (anioPlanilla == null) anioPlanilla = "";
    if (planillaGen == null) planillaGen = "";
    if (numPlaGen == null) numPlaGen = "";
    if (fechaInicia == null) fechaInicia = "";
    if (fechaInicial == null) fechaInicial = "";
    if (trxs == null) trxs = "";
    if (periodoMes == null) periodoMes = "";
    if (noEmpleado == null) noEmpleado = "";
    if (empId == null) empId = "";
    if (facturarA == null) facturarA = "";
    if (pAnioOr == null) pAnioOr = "";
    if (pCodPlanillaOr == null) pCodPlanillaOr = "";
    if (pNoPlanillaOr == null) pNoPlanillaOr = "";
    if (fg == null) fg = "";
    if (provincia == null) provincia = "";
    if (sigla == null) sigla = "";
    if (tomo == null) tomo = "";
    if (asiento == null) asiento = "";
    if (quincena == null) quincena = "";
    if (accion == null) accion = "";
    if (codigoDgi == null) codigoDgi = "";
    if (tipoHuella == null) tipoHuella = "";
    if (tab == null) tab = "";
    if (motivo == null) motivo = "";
    if (index == null) index = "";
    if (extDesc == null) extDesc = "";
    if (comentario == null) comentario = "";
    if (creadoPor == null) creadoPor = "";
    if (nombrePac == null) nombrePac = "";
    if (familia == null) familia = "";
    if (clase == null) clase = "";
    if (subclase == null) subclase = "";
    if (articulo == null) articulo = "";
    if (consignacion == null) consignacion = "";
    if (venta == null) venta = "";
    if (precioVenta == null) precioVenta = "";
    if (porcentaje == null) porcentaje = "";
    if (roundTo == null) roundTo = "";
    if (basis == null) basis = "PV";
    if (almacen == null) almacen = "";
    if (anaquel == null) anaquel = "";
    if (tipoReact == null) tipoReact = "";
    if (tiempoReact == null) tiempoReact = "";
    if (cuenta == null) cuenta = "";
    if (idPaciente == null) idPaciente = "";
    if (admRoot == null) admRoot = "";
    if (admType == null) admType = "";
    if (nombre_2 == null) nombre_2 = "";
    if (identificacion_2 == null) identificacion_2 = "";
	if (dv_2 == null) dv_2 = "";
    if (fechaNoContado == null) fechaNoContado = "";
    if (cta == null) cta = "";
    if (ctaDest == null) ctaDest = "";
    if (docId == null) docId = "";
    if (docNo == null) docNo = "";
    if (touch == null) touch = "";
    if (impresoSi == null) impresoSi = "";
    if (tipoPrecio == null) tipoPrecio = "";
    if (id_lista == null) id_lista = "";
    if (fp.trim().equals("")) throw new Exception("El Origen no es válido. Por favor consulte con su Administrador!");
    if (docType.trim().equals("")) throw new Exception("El Documento no es válido. Por favor consulte con su Administrador!");
    if (actType.trim().equals("")) throw new Exception("La Acción no es válida. Por favor consulte con su Administrador!");

    try{
        XMLCreator xml = new XMLCreator(ConMgr);
        xml.create(
                    java.util.ResourceBundle.getBundle("path").getString("xml")+File.separator+"IMPRESORAS_X_ESTACION.xml",
                    "SELECT " +
                    "	ID AS value_col, " +
                    "	ID||'-'||MODELO AS label_col, " +
                    "	ID_ESTACION AS key_col " +
                    "FROM " +
                    "	TBL_FAC_IMPRESORAS " +
                    "WHERE " +
                    "	    COMPANIA = " + (session.getAttribute("_companyId")) +
                    "   AND ESTADO = 'A' " +
                    "ORDER BY ID_ESTACION, ID ASC"
                  );
    }catch(Exception exp){
        System.out.println("Error generando archivo de impresoras por estación. Detalle: " + exp);
    }

    try{
        ad_estaciones = SQLMgr.getDataList(
											"SELECT " +
											"     DISTINCT A.ID, A.NOMBRE" +
											" FROM " +
											"     TBL_FAC_ESTACIONES A INNER JOIN TBL_FAC_IMPRESORAS B " +
											"         ON(A.COMPANIA = B.COMPANIA AND A.ID = B.ID_ESTACION) " +
											" WHERE " +
											"         A.COMPANIA = " + (String) session.getAttribute("_companyId") +
											"     AND A.ESTADO = 'A' " +
											" ORDER BY A.NOMBRE asc"
						);

    }
    catch(Exception expe){
        System.out.println("Error consultando las estaciones disponibles. Detalle: " + expe);
    }

    CommonDataObject cdoADE = (CommonDataObject) ad_estaciones.get(0);

    try{
		CommonDataObject cdo1 = SQLMgr.getData("SELECT " +
                                               "     D.ID_ESTACION, " +
                                               "     B.CODIGO, " +
                                               "     MAX(TO_DATE(TO_CHAR(B.FECHA, 'DD/MM/YYY') ||' '|| TO_CHAR(B.HORA_INICIO, 'HH24:MI:SS'), 'DD/MM/YYY HH24:MI:SS')) " +
                                               " FROM " +
                                               "     TBL_CJA_CAJERA A INNER JOIN TBL_CJA_TURNOS B " +
                                               "         ON(A.COMPANIA = B.COMPANIA AND A.COD_CAJERA = B.CJA_CAJERA_COD_CAJERA) " +
                                               "     INNER JOIN TBL_CJA_TURNOS_X_CAJAS C " +
                                               "         ON(B.COMPANIA = C.COMPANIA AND B.CODIGO = C.COD_TURNO) " +
                                               "     INNER JOIN TBL_CJA_CAJAS D " +
                                               "         ON(C.COMPANIA = D.COMPANIA AND C.COD_CAJA = D.CODIGO) " +
                                               "WHERE " +
                                               "         A.COMPANIA = " + ((String) session.getAttribute("_companyId")) +
                                               "     AND A.USUARIO = '" + (((String) session.getAttribute("_userName")).trim()) + "'" +
                                               "     AND A.ESTADO = 'A' " +
                                               "     AND C.ESTATUS = 'A' " +
                                               " GROUP BY D.ID_ESTACION, B.CODIGO");
        if(cdo1 != null){
            id_estacion = cdo1.getColValue("ID_ESTACION");
            id_turno = cdo1.getColValue("CODIGO");
        }
    }
    catch(Exception expt){
        System.out.println("Error consultando turno del usuario. Detalle: " + expt);
    }

    //* * * * * * * * * *   P R O C E S S   A C T I O N   * * * * * * * * * *
    boolean requiredComments = false;
    if (docType.equalsIgnoreCase("REC")) {

	    docDesc = "RECIBO";
	    if (actType.equalsIgnoreCase("7")) {

    		requiredComments = false;
	    	actDesc = "ANULAR";

	    } else if (actType.equalsIgnoreCase("56")) {

		    requiredComments = true;
		    actDesc = "ANULAR (SUPERVISOR)";

	    } else if (actType.equalsIgnoreCase("59")) {

            requiredComments = true;
            actDesc = "CAMBIAR REEMPLAZABLE";

            sbSql = new StringBuffer();
            sbSql.append("select turno, turno_anulacion from tbl_cja_transaccion_pago where codigo = ");
            sbSql.append(docId);
            sbSql.append(" and compania = ");
            sbSql.append(compania);
            sbSql.append(" and anio = ");
            sbSql.append(anio);

            CommonDataObject cdo = SQLMgr.getData(sbSql.toString());

		    if (cdo == null) cdo = new CommonDataObject();
		    else {
		
                turno = cdo.getColValue("turno_anulacion");
                tFilter.append(" and a.codigo <> ");
                tFilter.append(cdo.getColValue("turno"));

		    }

	    } else if (actType.equalsIgnoreCase("53")) actDesc = "LIBERAR";
	
            tSql = new StringBuffer();
            tSql.append("select a.codigo, a.codigo||' - '||b.nombre||' - '||(select descripcion from tbl_cja_cajas where codigo = d.cod_caja and compania = d.compania) as cajero_nombre from tbl_cja_turnos a, tbl_cja_cajera b, tbl_cja_turnos_x_cajas d where a.cja_cajera_cod_cajera = b.cod_cajera and a.compania = b.compania and a.codigo = d.cod_turno and a.compania = d.compania and a.compania = ");
            tSql.append(session.getAttribute("_companyId"));
            tSql.append(tFilter);
            tSql.append(" and d.estatus <> 'I' order by 1 desc");

        } else if (docType.equalsIgnoreCase("CHG")) {

            docDesc = "CAMBIO";
            actDesc = "ANULAR";

        } else if (docType.equalsIgnoreCase("COMP")) {

            docDesc = "COMIDAS SERVIDAS. COMPROB. ";
            actDesc = "GENERAR COMPROBANTE ";

        } else if (docType.equalsIgnoreCase("UPDFACT")) {

            docDesc = " FACTURA ";
            actDesc = "CAMBIAR ESTATUS" +(estado!=null && estado.equals("C")?" A CANCELADO":" A PENDIENTE");

        } else if (docType.equalsIgnoreCase("FACT")) {

            if (actType.equalsIgnoreCase("7")) {
            docDesc = " FACTURA ";
            actDesc = "ANULAR FACTURA";
            requiredComments = true;}
            else if (actType.equalsIgnoreCase("50")) {
            docDesc = " FACTURAS DOBLE COBERTURA ";
            actDesc = "AJUSTAR FACTURA";}
        } else if (docType.equalsIgnoreCase("LISTA_AJUSTE")) {
            if (actType.equalsIgnoreCase("5")) {
                docDesc = " LISTA DE AJUSTES POR LOTE ";
                actDesc = " RECHAZAR";
            }else if (actType.equalsIgnoreCase("51")) {
                docDesc = " LISTA DE AJUSTES POR LOTE ";
                actDesc = " REVERSAR AJUSTE";
            }
        }
    if (docType.equalsIgnoreCase("ADM")) {

        docDesc = " ADMISION ";
        if (actType.equalsIgnoreCase("7")) {actDesc = "ANULAR"; requiredComments = true;}
        else if (actType.equalsIgnoreCase("50")) actDesc = "CAMBIAR TIPO CUENTA";
        else if (actType.equalsIgnoreCase("65")) actDesc = "INACTIVAR";
        else if (actType.equalsIgnoreCase("60")) actDesc = "CAMBIAR A ESPERA";
        else if (actType.equalsIgnoreCase("61")){

		requiredComments = true;
		actDesc = "CAMBIAR DE ";
		if (estado.equalsIgnoreCase("P")) actDesc += "PRE-ADMISION";
		else if (estado.equalsIgnoreCase("A")) actDesc += "ACTIVO";
		else if (estado.equalsIgnoreCase("E")) actDesc += "ESPERA";

		sbSql = new StringBuffer();
		sbSql.append("select nvl(get_sec_comp_param(-1,'ADM_CHK_ADM_TYPE'),'Y') as chk_adm_type from dual");
		CommonDataObject cdo = SQLMgr.getData(sbSql.toString());
		chkAdmType = cdo.getColValue("chk_adm_type");

		if (estado.equalsIgnoreCase("E") || estado.equalsIgnoreCase("P")) { actDesc += " A ACTIVO"; }
	    else if (estado.equalsIgnoreCase("A")) {

			if (chkAdmType.equalsIgnoreCase("S") || chkAdmType.equalsIgnoreCase("Y")) {

				if (admType.trim().equals("I")) actDesc += " A PRE-ADMISION ";
				else if (admType.trim().equals("O")) actDesc += " A ESPERA O PRE-ADMISION ";

			} else actDesc += " A ESPERA O PRE-ADMISION ";

		}
	}
	else if (actType.equalsIgnoreCase("62")){actDesc = "CAMBIAR ESTADO DE ADMISION A ESPERA";}
    } else if (docType.equalsIgnoreCase("AUM")) {

        if (actType.equalsIgnoreCase("6")) actDesc = "APROBAR AUMENTOS";
        else if (actType.equalsIgnoreCase("50")) actDesc = "ACTUALIZAR AUMENTOS";

    } else if (docType.equalsIgnoreCase("MOR")||docType.equalsIgnoreCase("MORHPP")) {

        if (actType.equalsIgnoreCase("50")) actDesc = "MOROSIDAD CXC";
        else if (actType.equalsIgnoreCase("52")) actDesc = "MOROSIDAD CXC MENSUAL";

    } else if (docType.equalsIgnoreCase("CNDB")) {

        docDesc = "NOTA DEBITO";
        actDesc = "CORRECCION";

    } else if (docType.equalsIgnoreCase("HON_RUC_DV")) {

        docDesc = "CAMBIAR RUC/DV";
        actDesc = "CORRECCION";

    } else if (docType.equalsIgnoreCase("REVAJUSTE")) {

        docDesc = "NOTA DE AJUSTE ";
        actDesc = "REVERTIR AJUSTE INCOBRABLES";

    } else if (docType.equalsIgnoreCase("CXC_ADJ_AUTO")) {

        docDesc = "FACTURA";
        if (actType.equalsIgnoreCase("50")) actDesc = "CREAR NOTA DEBITO";
        else if (actType.equalsIgnoreCase("51")) actDesc = "AJUSTAR SALDO A 2DA. FACTURA";

    } else if (docType.equalsIgnoreCase("CAMA")) {

	    if (actType.equalsIgnoreCase("7")) {

            docDesc = "CAMA";
            actDesc = "ANULAR";

        } else if (actType.equalsIgnoreCase("3")) {

            docDesc = "ADMISION";
            if (tipo.equalsIgnoreCase("D")) actDesc = "GENERAR DEVOLUCION DE HABITACION ";
            else actDesc = "GENERAR CARGOS DE HABITACION ";

        }

    }  else if (docType.equalsIgnoreCase("CORRAJUSTE")) {

        docDesc = "NOTA DE AJUSTE ";
        actDesc = "CORREGIR AJUSTE INCOBRABLE DUPLICADO";

    }  else if (docType.equalsIgnoreCase("ACRACH")) {

        if (actType.equalsIgnoreCase("53")) actDesc = "PAGO A ACREEDORES ";

        } else if (docType.equalsIgnoreCase("FCESAN")) {

	        if (actType.equalsIgnoreCase("50")) actDesc = "FONDO DE CESANTIA ";

            } else if (docType.equalsIgnoreCase("DIST")) {

	            if (actType.equalsIgnoreCase("7")) {

                    docDesc = "DISTRIBUCION";
                    actDesc = "ANULAR";

                } else if (actType.equalsIgnoreCase("50")) {

                    docDesc = "DISTRIBUCION";
                    actDesc = "CORREGIR";

                } else if (actType.equalsIgnoreCase("51")) {

                    docDesc = "APLICACION";
                    actDesc = "ANULAR APLICACION DE PAGO";

                }

            } else if (docType.equalsIgnoreCase("AUMG")) {//Aumentos Generales por cc.

                if (actType.equalsIgnoreCase("50")) {
                    docDesc = "";
                    actDesc = "GENERAR AUMENTOS POR CONVENCIÓN COLECTIVA ";
                } else if (actType.equalsIgnoreCase("52")) {
                    docDesc = "";
                    actDesc = "ELIMINAR AUMENTOS POR CONVENCIÓN COLECTIVA ";
                } else if (actType.equalsIgnoreCase("53")) {
                    docDesc = "";
                    actDesc = "ACTUALIZAR AUMENTOS POR CONVENCIÓN COLECTIVA ";
                }

            } else if (docType.equalsIgnoreCase("CUOTASIND")) {//Aumentos Generales por cc.

	if (actType.equalsIgnoreCase("50")) {
		docDesc = "";
		actDesc = "GENERAR DESCUENTO POR CUOTA EXTRAORDINARIA DEL SINDICATO";
	}

} else if (docType.equalsIgnoreCase("TRF")) {

	if (actType.equalsIgnoreCase("51")) {

		docDesc = "ADMISION";
		actDesc = "TRANSFERIR CARGOS ";

	}

} else if (docType.equalsIgnoreCase("CORTE")) {//Corte de Cuenta

	if (actType.equalsIgnoreCase("51")) {

		docDesc = "ADMISION";
		actDesc = "CORTE DE CUENTA MANUAL ";

	}

} else if (docType.equalsIgnoreCase("EXP")) {//Datos de BB

	if (actType.equalsIgnoreCase("7")) {

		docDesc = "ADMISION DE BB";
		actDesc = "INACTIVAR TRANSACCIONES ";

	}
	else
	if (actType.equalsIgnoreCase("8")) {

		docDesc = "EXPEDIENTE CLINICO";
		actDesc = "HABILITAR ";

	}

}  else if (docType.equalsIgnoreCase("PLA")) {//Procesos de calculo de planilla

	if (actType.equalsIgnoreCase("50")) actDesc = "PLANILLA DE INCENTIVOS ";
	else if (actType.equalsIgnoreCase("51")) actDesc = "PLANILLA DE AJUSTES  ";
	else if (actType.equalsIgnoreCase("52")) actDesc = "GENERAR CHEQUES AUTOMATICOS  ";
	else if (actType.equalsIgnoreCase("53")) actDesc = "PLANILLA DE VACACIONES ";
	else if (actType.equalsIgnoreCase("54")) actDesc = "PLANILLA DE DECIMO TERCER MES  ";

} else if (docType.equalsIgnoreCase("DISTTRX")) {//DISTRIBUCION DE TRX AUSENCIAS - SOBRETIEMPOS

	if (actType.equalsIgnoreCase("50")) {
		docDesc = "";
		actDesc = " GENERACION DE TRANSACCIONES DE AUSENCIA PARA PLANILLA ("+periodo+") - ("+anio+")";
	} else if (actType.equalsIgnoreCase("51")) {
		docDesc = "EXTRA";
		actDesc = "GENERACION DE TRANSACCIONES DE SOBRETIEMPO PARA PLANILLA ("+periodo+") - ("+anio+")";
	}

} else if (docType.equalsIgnoreCase("ACHEMPAC")) {

	if (actType.equalsIgnoreCase("51")) {
		docDesc = "";
		actDesc = "ACTUALIZAR PAGO A EMPLEADOS POR ACH ";
	}
	else if (actType.equalsIgnoreCase("52")) {
		docDesc = "";
		actDesc = "ACTUALIZAR PAGO A EMPLEADOS POR CHEQUES ";
	}
	else if (actType.equalsIgnoreCase("53")) {
			docDesc = "";
			actDesc = "CREA ARCHIVO TEMPORAL DE CHEQUES ACREEDORES ";
	}

} else if (docType.equalsIgnoreCase("DELTRX")) {

	if (actType.equalsIgnoreCase("53")) {
		docDesc = "";
		actDesc = "BORRAR TRANSACCIONES GENERADAS POR LOTE";
	} else if (actType.equalsIgnoreCase("54")) {
		docDesc = "AUSENCIAS";
		actDesc = "BORRAR TRANSACCIONES GENERADAS DE ASISTENCIA";
	}

} else if (docType.equalsIgnoreCase("CONTHON")) {

	if (actType.equalsIgnoreCase("50")) {
		docDesc = "";
		actDesc = "CARGAR MOVIMIENTOS DE HONORARIOS";
	}

} else if (docType.equalsIgnoreCase("AFIJO")) {

	docDesc = "ASIENTO FIJO";
	if (actType.equalsIgnoreCase("50")) actDesc = "GENERAR COMPROBANTE";

} else if (docType.equalsIgnoreCase("FARPATIENT")) {

	docDesc = "PACIENTE";
	if (actType.equalsIgnoreCase("68")) actDesc = "GENERAR/ACTUALIZAR";

} else if (docType.equalsIgnoreCase("FARORDER")) {

	docDesc = "ORDEN MEDICA";
	if (actType.equalsIgnoreCase("50")) actDesc = "GENERAR ORDEN FARHOS";
	else if (actType.equalsIgnoreCase("51")) actDesc = "CAMBIAR # REFERENCIA";
	else if (actType.equalsIgnoreCase("52")) actDesc = "ACTUALIZAR # REFERENCIA";

} else if (docType.equalsIgnoreCase("DGI")) {//IMPRESION FISCAL

	if (actType.equalsIgnoreCase("3")) {

		actDesc = "IMPRESION";
		docDesc = "CORTE Z";

	} else if (actType.equalsIgnoreCase("4")) {

		actDesc = "IMPRESION";
		docDesc = "CORTE X";

	} else if (actType.equalsIgnoreCase("55")) {

		if (tipo.equalsIgnoreCase("FACT")) actDesc = "IMPRESION DE LISTA DE FACTURA";
		else if (tipo.equalsIgnoreCase("ND")) actDesc = "IMPRESION DE LISTA DE NOTA DE DEBITO";
		else if (tipo.equalsIgnoreCase("NC")) actDesc = "IMPRESION DE LISTA DE NOTA DE CREDITO";

	} else {

		if (actType.equalsIgnoreCase("2")){
			actDesc = "IMPRESION";
			tSql = new StringBuffer();
			tSql.append("select nvl(get_sec_comp_param(");
			tSql.append((String) session.getAttribute("_companyId"));
			tSql.append(", 'CLIENTE_RUC_EDITABLE'),'N') x, (select cliente from tbl_fac_dgi_documents where id = ");
			tSql.append(docId);
			tSql.append(" and compania = ");
			tSql.append((String) session.getAttribute("_companyId"));
			tSql.append(") nombre_2, (select ruc_cedula from tbl_fac_dgi_documents where id = ");
			tSql.append(docId);
			tSql.append(" and compania = ");
			tSql.append((String) session.getAttribute("_companyId"));
			//tSql.append(") identificacion_2  from dual");
			tSql.append(") identificacion_2, (select dv from tbl_fac_dgi_documents where id = ");
			tSql.append(docId);
			tSql.append(" and compania = ");
			tSql.append((String) session.getAttribute("_companyId"));
			tSql.append(") dv_2  from dual");


			CommonDataObject cdo = SQLMgr.getData(tSql.toString());
			if(cdo!=null && !cdo.getColValue("x").equals("")){
				editClienteRuc = cdo.getColValue("x");
				if(!fp.equals("lista_envio")){
				identificacion_2 = cdo.getColValue("identificacion_2");
				nombre_2 = cdo.getColValue("nombre_2");
				dv_2 = cdo.getColValue("dv_2");
				}
			}

			//Valores por defecto Contribuyente Facturaci�n Electr�nica
            String sqlTipoClienteTrx = "SELECT DESCRIPCION, CLIENT_ID, RUC " +
			                           "FROM tbl_fac_trx a, tbl_fac_tipo_cliente b " +
			                           "where a.client_ref_id = b.codigo " +
			                           "and other3 in (SELECT CODIGO FROM TBL_FAC_DGI_DOCUMENTS " +
			                           "                WHERE ID = " + docId +
			                           "                  AND COMPANIA = " + (String) session.getAttribute("_companyId") + ") " +
			                           "                  AND COMPANY_ID = " + (String) session.getAttribute("_companyId") +
			                           "                  AND ROWNUM = 1";

			CommonDataObject cdoTipoClienteTrx = SQLMgr.getData(sqlTipoClienteTrx);
			if(cdoTipoClienteTrx!=null && !cdoTipoClienteTrx.getColValue("DESCRIPCION").equals("")){
				String sqlDatosCliente = "";
				if (cdoTipoClienteTrx.getColValue("DESCRIPCION").equals("MEDICO")) {

					sqlDatosCliente = "SELECT IDENTIFICACION, DIGITO_VERIFICADOR, DIRECCION, TELEFONO, E_MAIL, CODIGO_UBICACION_FE " +
					 			  	  "FROM TBL_ADM_MEDICO " +
									  "WHERE CODIGO = '" + cdoTipoClienteTrx.getColValue("CLIENT_ID") + "'";

				} else if (cdoTipoClienteTrx.getColValue("DESCRIPCION").equals("ASEGURADOS") 
				           || cdoTipoClienteTrx.getColValue("DESCRIPCION").equals("EMPRESA - CUENTAS HOSPITAL")) {

					sqlDatosCliente = "SELECT RUC, DIGITO_VERIFICADOR, DIRECCION, TELEFONO, E_MAIL, CODIGO_UBICACION_FE " +
									  "FROM TBL_ADM_EMPRESA " +
					                  "WHERE CODIGO = '" + cdoTipoClienteTrx.getColValue("CLIENT_ID") + "'";

				} else if (cdoTipoClienteTrx.getColValue("DESCRIPCION").equals("EMPLEADOS") 
							|| cdoTipoClienteTrx.getColValue("DESCRIPCION").equals("EMPLEADO")) {

		 			sqlDatosCliente = "SELECT PROVINCIA || '-' || SIGLA || '-' || TOMO || '-' || ASIENTO IDENTIFICACION " +
					 				  "     , DIGITO_VERIFICADOR " +
					 				  "     , CASA__DIR DIRECCION " +
					 				  "     , TELEFONO_CASA TELEFONO " +
					 				  "     , EMAIL E_MAIL" +
					 				  "     , CODIGO_UBICACION_FE " +
				 					  "  FROM TBL_PLA_EMPLEADO " +
				                      " WHERE PROVINCIA || '-' || SIGLA || '-' || TOMO || '-' || ASIENTO = '" + cdoTipoClienteTrx.getColValue("RUC") + "'";

				} else if (cdoTipoClienteTrx.getColValue("DESCRIPCION").equals("CTAS X COBRAR OTROS")) {
				
					sqlDatosCliente = "SELECT PROVINCIA || '-' || TOMO || '-' || ASIENTO IDENTIFICACION " +
					  				  "     , DIGITO_VERIFICADOR " +
									  "     , RESIDENCIA_DIRECCION DIRECCION " +
									  "     , TELEFONO " +
									  "     , E_MAIL " +
									  "     , CODIGO_UBICACION_FE " +
			   						  "  FROM TBL_ADM_PACIENTE " +
			   						  " WHERE PROVINCIA || '-' || TOMO || '-' || ASIENTO = '" + cdoTipoClienteTrx.getColValue("RUC") + "'";
				
				}
				
				if (!sqlDatosCliente.equals("")) {
					CommonDataObject cdoDatosCliente = SQLMgr.getData(sqlDatosCliente);
					if (cdoDatosCliente != null) {
						direccion_fe = cdoDatosCliente.getColValue("DIRECCION");
						telefono_fe = cdoDatosCliente.getColValue("TELEFONO");
						email_fe = cdoDatosCliente.getColValue("E_MAIL");
						codigo_ubicacion_fe = cdoDatosCliente.getColValue("CODIGO_UBICACION_FE");
					}
				}

				tipoClienteHis = cdoTipoClienteTrx.getColValue("DESCRIPCION");

			}
		   //

		} else if (actType.equalsIgnoreCase("5")) actDesc = "REIMPRESION";
		else if (actType.equalsIgnoreCase("6")) actDesc = "CORREGIR ANULACION ";
		else if (actType.equalsIgnoreCase("52")) actDesc = "CORREGIR CODIGO DGI ";
		if (tipo.equalsIgnoreCase("FACT") || tipo.equalsIgnoreCase("FACP")) docDesc = "FACTURA";
		else if (tipo.equalsIgnoreCase("ND") || tipo.equalsIgnoreCase("NDP")) docDesc = "NOTA DE DEBITO";
		else if (tipo.equalsIgnoreCase("NC") || tipo.equalsIgnoreCase("NCP")) docDesc = "NOTA DE CREDITO";
		

	}

} else if (docType.equalsIgnoreCase("VAC")) {//Procesos de Vacaciones

	if (actType.equalsIgnoreCase("50")) actDesc = "PROCESO DE VACACIONES ";

} else if (docType.equalsIgnoreCase("CAL")) {//Procesos de actualizacion de calendario

	if (actType.equalsIgnoreCase("51")) actDesc = "ACTUALIZAR CALENDARIO ";

} else if (docType.equalsIgnoreCase("SALDO0")) {//Proceso Para generar factura con saldo 0.

	if (actType.equalsIgnoreCase("50")) {

		docDesc = " ADMISION ";
		actDesc = "GENERAR FACTURA CON SALDO 0";

	}

} else if (docType.equalsIgnoreCase("DELPLA")) {//Borrar Planilla

	if (actType.equalsIgnoreCase("51")) actDesc = " BORRAR  PLANILLA ("+docId+")";
	else if (actType.equalsIgnoreCase("6")) actDesc = " APROBAR  PLANILLA ("+docId+")";
	else if (actType.equalsIgnoreCase("52")) actDesc = " APROBAR  PLANILLA DE ACREEDOR ("+docId+")";

} else if (docType.equalsIgnoreCase("CAPLA")) {//CALCULAR ACUMULADOS

	if (actType.equalsIgnoreCase("50")) actDesc = " CALCULAR ACUMULADOS ("+docId+")";

} else if (docType.equalsIgnoreCase("SOLVAC")) {

	if (actType.equalsIgnoreCase("51")) actDesc = " APROBAR DISTRIBUCION DE  VACACIONES ";
	else if (actType.equalsIgnoreCase("5")) {

		requiredComments = true;
		actDesc = " RECHAZAR SOLICITUD DE  VACACIONES ";

	} else if (actType.equalsIgnoreCase("7")) {

		requiredComments = true;
		actDesc = " ANULAR SOLICITUD DE  VACACIONES ";

	} else if (actType.equalsIgnoreCase("52")) actDesc = " ELIMINAR DISTRIBUCION DE  VACACIONES ";

} else if (docType.equalsIgnoreCase("DISTLIC")) {//DISTRIBUIR LICENCIA

	if (actType.equalsIgnoreCase("50")) actDesc = " DISTRIBUIR LICENCIA ";
	else if (actType.equalsIgnoreCase("51")) actDesc = " ACTUALIZAR DISTRIBUCION DE SALARIOS PAGADO POR LICENCIA ";
	else if (actType.equalsIgnoreCase("52")) actDesc = " ELIMINAR DISTRIBUCION DE SALARIOS PAGADO POR LICENCIA ";

} else if (docType.equalsIgnoreCase("COMP_HIST")) {

	docDesc = "COMPROBANTE HISTORICO";
	if (actType.equalsIgnoreCase("6")) actDesc = "APROBAR";
	else if(actType.equalsIgnoreCase("7")) actDesc="DESAPROBAR";
	else if(actType.equalsIgnoreCase("50")) actDesc="ANULAR";

} else if (docType.equalsIgnoreCase("ANSOL")) {

	if (actType.equalsIgnoreCase("7")) actDesc = "ANULAR SOLICITUD DE EMPLEO [ "+anio+" - "+codigo+" ] ";

} else if (docType.equalsIgnoreCase("UPDNOEMP")) {

	if (actType.equalsIgnoreCase("50")) actDesc = "MODIFICAR NUMERO DE EMPLEADO [ "+codigo+"  POR "+noEmpleado+" ] ";

} else if (docType.equalsIgnoreCase("LIQ")||docType.equalsIgnoreCase("DELLIQ")) {

	if (actType.equalsIgnoreCase("50")) actDesc = " ELIMINAR REGISTROS DE LIQUIDACION ";
	else if (actType.equalsIgnoreCase("51")) actDesc = " CALCULAR DIAS LABORADOS";
	else if (actType.equalsIgnoreCase("52")) actDesc = " CALCULAR ACUMULADOS PARA LIQUIDACION ";

} else if (docType.equalsIgnoreCase("GENCOMP")) {//Generar comprobantes(contabilidad)
	docDesc = " COMPROBANTE ";
	if (actType.equalsIgnoreCase("50")) actDesc = "GENERAR COMPROBANTE DE CXC";
	else if (actType.equalsIgnoreCase("51")) actDesc = "GENERAR COMPROBANTE DE RECEPCIONES DE PROVEEDORES";
	else if (actType.equalsIgnoreCase("52")) actDesc = "GENERAR COMPROBANTE DE GASTOS ( TRANSF. ALMACENES)";
	else if (actType.equalsIgnoreCase("53")) actDesc = "GENERAR COMPROBANTE DE COSTOS (ENT. A PACIENTES)";
	else if (actType.equalsIgnoreCase("54")) actDesc = "GENERAR COMPROBANTE DE GASTOS (SERVICIOS ADMIN.)";
	else if (actType.equalsIgnoreCase("55")) actDesc = "GENERAR LIBRO DE INGRESO";
	else if (actType.equalsIgnoreCase("56")) actDesc = "ANULAR LIBRO DE INGRESO";
	else if (actType.equalsIgnoreCase("57")) actDesc = "GENERAR COMPROBANTE DE GASTOS (UNIDADES)";
	else if (actType.equalsIgnoreCase("58")) actDesc = "GENERAR LIBRO DE CAJA";
	else if (actType.equalsIgnoreCase("59")) actDesc = "GENERAR COMPROBANTE DE CAJA ";
	else if (actType.equalsIgnoreCase("60")) actDesc = "GENERAR COMPROBANTE DE CHEQUES ";
	else if (actType.equalsIgnoreCase("61")) actDesc = "GENERAR LIBRO DE CHEQUE ";
	else if (actType.equalsIgnoreCase("62")) actDesc = "GENERAR COMPROBANTE DE AJUSTES CXP";
	else if (actType.equalsIgnoreCase("63")) actDesc = "GENERAR COMPROBANTE DE PLAN MEDICO";
	else if (actType.equalsIgnoreCase("64")) actDesc = "GENERAR COMPROBANTE DE ASIENTOS FIJOS";
	else if (actType.equalsIgnoreCase("65")) actDesc = "GENERAR COMPROBANTE DE AJUSTES A PAQUETES";

} else if (docType.equalsIgnoreCase("CJA")) {//CAJA

	if (actType.equalsIgnoreCase("50")) actDesc = "PONER EN TRAMITE LA CAJA";
	if (actType.equalsIgnoreCase("52")) actDesc = "ACTIVAR TURNO";

} else if (docType.toUpperCase().startsWith("FP_")) {

	if (docType.toUpperCase().endsWith("_PAC")) docDesc = "HUELLA DACTILAR PACIENTE";
	else if (docType.toUpperCase().endsWith("USR")) docDesc = "HUELLA DACTILAR USUARIO";

	if (actType.equalsIgnoreCase("3")) actDesc = "REGISTRAR";
	else if (actType.equalsIgnoreCase("10")) actDesc = "REMOVER";

} else if (docType.equalsIgnoreCase("ALQ")) {

	docDesc = "CONTRATOS DE ALQUILER";
	if (actType.equalsIgnoreCase("50")) actDesc = "GENERAR CARGOS";
	else if (actType.equalsIgnoreCase("51")) actDesc = "FACTURAR CARGOS";

} else if (docType.equalsIgnoreCase("CARTA")) {//Cartas De planilla

	if (actType.equalsIgnoreCase("50")) actDesc = "BORRAR SOLICITUD DE CARTA ";

} else if (docType.equalsIgnoreCase("AJ")) {//Ajustes recibos/facturas

	docDesc = " AJUSTE ";
	if (actType.equalsIgnoreCase("50"))actDesc = "REVERTIR AJUSTE ";
	else if (actType.equalsIgnoreCase("51"))actDesc = "APROBAR AJUSTE ";
	else if (actType.equalsIgnoreCase("52"))actDesc = "RECHAZAR AJUSTE ";

} else if (docType.equalsIgnoreCase("CIERRE")) {//Cierre de contabilidad

	if (actType.equalsIgnoreCase("50")) actDesc = "GENERAR CIERRE TRANSITORIO DE AÑO";
	else if (actType.equalsIgnoreCase("51")) actDesc = "GENERAR COMPROBANTE DE CIERRE DE GASTOS Y COSTOS";
	else if (actType.equalsIgnoreCase("52")) actDesc = "GENERAR COMPROBANTE DE CIERRE DE INGRESOS";
	else if (actType.equalsIgnoreCase("53")) actDesc = "GENERAR COMPROBANTE DE RESULTADO DE OPERACIONES";
	else if (actType.equalsIgnoreCase("54")) actDesc = "GENERAR CIERRE ANUAL";
	else if (actType.equalsIgnoreCase("55")) actDesc = "GENERAR CIERRE MENSUAL";

} else if (docType.equalsIgnoreCase("PAC_PM")) {//  PACIENTE DE PLAN MEDICO

	if (actType.equalsIgnoreCase("1")) actDesc = "CREAR PACIENTE DE PLAN MEDICO";

} else if (docType.equalsIgnoreCase("APP_PM")) {//  SOLICITUD DE PLAN MEDICO

	if (actType.equalsIgnoreCase("1")) actDesc = "APROBAR SOLICITUD DE PLAN MEDICO";
	else if (actType.equalsIgnoreCase("2")) actDesc = "INACTIVAR SOLICITUD DE PLAN MEDICO";
	else if (actType.equalsIgnoreCase("3"))	actDesc = "APROBAR ADENDA DE PLAN MEDICO";
	else if (actType.equalsIgnoreCase("4"))	actDesc = "INACTIVAR ADENDA DE PLAN MEDICO";
	else if (actType.equalsIgnoreCase("5"))	actDesc = "APROBAR CUOTA EXTRAORDINARIA DE PLAN MEDICO";
	else if (actType.equalsIgnoreCase("6"))	actDesc = "INACTIVAR CUOTA EXTRAORDINARIA DE PLAN MEDICO";
} else if (docType.equalsIgnoreCase("ACTEXP")) {//ACTIVAR EXPEDIENTE CLINICO

	if (actType.equalsIgnoreCase("50")) actDesc = "ACTIVAR EXPEDIENTE";

} else if (docType.equalsIgnoreCase("COMPDIARIO")) {//COMPROBANTES DIARIOS

	docDesc = "COMPROBANTE";
	if (actType.equalsIgnoreCase("50")) actDesc = "APROBAR COMPROBANTE";
	else if (actType.equalsIgnoreCase("51")) actDesc = "DESAPROBAR COMPROBANTE";
	else if (actType.equalsIgnoreCase("52")) actDesc = "ANULAR COMPROBANTE";
	else if (actType.equalsIgnoreCase("58")) actDesc = "DESAPROBAR PRE - COMPROBANTE DE PLANILLA";

} else if (docType.equalsIgnoreCase("CITAS")) {//CITAS

	requiredComments = true;
	docDesc = "CITA";
	if (actType.equalsIgnoreCase("7")) actDesc = "CANCELAR CITA";

} else if (docType.equalsIgnoreCase("REVTRX")) {//REVERTIR TRANSACCIONES DE BANCO

	docDesc = "CITA";
	if (actType.equalsIgnoreCase("7")) actDesc = "REVERTIR TRANSACCIONES";

} else if (docType.equalsIgnoreCase("BATCH_PRICE")) {

	actDesc = "ACTUALIZAR PRECIO POR LOTE";

} else if (docType.equalsIgnoreCase("ACTCONTEO")) {
	actDesc = "ACTUALIZAR CONTEO FISICO";
	docDesc =" CONTEO FISICO";
    
    if (actType.equals("9")){
        docDesc =" NO CONTADOS CON EXISTENCIA";
        actDesc = "ACTUALIZAR NO CONTADOS CON EXISTENCIA";
    }
}else if (docType.equalsIgnoreCase("RECEP")) {
	actDesc = "ANULAR";
	docDesc =" RECEPCION";
}
else if (docType.equalsIgnoreCase("CAT")) {
	if (actType.equalsIgnoreCase("7"))actDesc = "INACTIVAR";
	else actDesc = "ACTIVAR";
	docDesc =" CUENTA CONTABLE";
} else if (docType.equalsIgnoreCase("CONT_FISICO")) {
	if (actType.equalsIgnoreCase("1"))actDesc = "REGISTRAR CONTEO";
	if (actType.equalsIgnoreCase("2"))actDesc = "REGISTRAR CONTEO Y ACTUALIZAR";
	docDesc =" CONTEO FISICO";
}
else if (docType.equalsIgnoreCase("LISTA_ENVIO")){ // 
	if (actType.equalsIgnoreCase("1")) actDesc = "REGISTRAR FECHA RECIBO";
	else if (actType.equalsIgnoreCase("2")){ actDesc = "INACTIVAR FACTURA DE LA LISTA";	requiredComments = true;}
	docDesc = "LISTA";
}
else if (docType.equalsIgnoreCase("DEVPROV")){ // 
	if (actType.equalsIgnoreCase("50")) actDesc = "ANULAR DEVOLUCION DE PROVEEDOR";
	requiredComments = true;
	docDesc =" DEVOLUCION";
}
else if (docType.equalsIgnoreCase("CORRECCTA")){ // 
	if (actType.equalsIgnoreCase("50")) actDesc = "CORRECCION DE CUENTAS CONTABLES";
	docDesc =" CORRECCION DE CUENTAS CONTABLE";
}
else if (docType.equalsIgnoreCase("LIQ_RECL")){ // 
	if (actType.equalsIgnoreCase("1")) actDesc = "ACTUALIZAR LIQUIDACION DE RECLAMO";
    docNo = docId;
}


//* * * * * * * * * *   C O N F I R M A T I O N   M E S S A G E   * * * * * * * * * *
StringBuffer sbConfirmMsg = new StringBuffer();
sbConfirmMsg.append("<cellbytelabel>¿Est&aacute; seguro de ejecutar la acci&oacute;n</cellbytelabel> [<font class=\"RedText\">");
sbConfirmMsg.append(actDesc);
sbConfirmMsg.append("</font>]");

//-- CONFIRMATION MESSAGE BLOCK 1 STARTS
if (docType.equalsIgnoreCase("CJA")) {//CAJA

	if (actType.equalsIgnoreCase("50")) {

		sbConfirmMsg.append(" #");
		sbConfirmMsg.append(docNo);
		sbConfirmMsg.append(" turno ");
		sbConfirmMsg.append(docId);

	}
	else if (actType.equalsIgnoreCase("52")) {

		sbConfirmMsg.append(" #");
		sbConfirmMsg.append(docId);
		sbConfirmMsg.append(" de la Caja ");
		sbConfirmMsg.append(docNo);
	}

} else if (docType.equalsIgnoreCase("ACRACH")) {

	sbConfirmMsg.append(" <cellbytelabel>para el mes</cellbytelabel> ");
	sbConfirmMsg.append(mes);
	sbConfirmMsg.append(" <cellbytelabel>del a&ntilde;o</cellbytelabel> ");
	sbConfirmMsg.append(anio);

} else if (docType.equalsIgnoreCase("FCESAN")) {

	sbConfirmMsg.append(" <cellbytelabel>para el trimestre</cellbytelabel> ");
	sbConfirmMsg.append(mes);
	sbConfirmMsg.append(" <cellbytelabel>del a&ntilde;o</cellbytelabel> ");
	sbConfirmMsg.append(anio);

} else if (docType.equalsIgnoreCase("VAC") || docType.equalsIgnoreCase("CAL") || (docType.equalsIgnoreCase("CIERRE") && !actType.equals("55"))) {

	if (docType.equalsIgnoreCase("CIERRE")) sbConfirmMsg.append("<font class=\"RedText\">");
	sbConfirmMsg.append(" <cellbytelabel>para el A&ntilde;o</cellbytelabel> ");
	sbConfirmMsg.append(anio);
	if (docType.equalsIgnoreCase("CIERRE")) sbConfirmMsg.append("</font>");

} else if (docType.equalsIgnoreCase("SOLVAC") || docType.equalsIgnoreCase("DISTLIC") || docType.equalsIgnoreCase("LIQ")|| docType.equalsIgnoreCase("DELLIQ")) {

	sbConfirmMsg.append(" <cellbytelabel>para el Empleado</cellbytelabel> [");
	sbConfirmMsg.append(empId);
	sbConfirmMsg.append("]");

	//if((!docType.equals("DISTLIC") && actType.equals("51"))&&(!docType.equals("LIQ") && actType.equals("51")&& actType.equals("52")))
	if (!docType.equalsIgnoreCase("DISTLIC") && actType.equals("51")) {

		sbConfirmMsg.append(" <cellbytelabel>para el periodo</cellbytelabel> ");
		sbConfirmMsg.append(periodo);
		sbConfirmMsg.append(" <cellbytelabel>del A&ntilde;o</cellbytelabel> ");
		sbConfirmMsg.append(anio);

	}

} else if (docType.equalsIgnoreCase("APP_PM")) {//  SOLICITUD DE PLAN MEDICO

	if (actType.equalsIgnoreCase("1") || actType.equalsIgnoreCase("2")) {

		sbConfirmMsg.append(" <cellbytelabel>para el Documento</cellbytelabel> [");
		sbConfirmMsg.append(docId);
		sbConfirmMsg.append("]");

	}

}  else if (docType.equalsIgnoreCase("LISTA_AJUSTE")) {//  LISTA DE AJUSTE AUTOMATICO

	if (actType.equalsIgnoreCase("5")||actType.equalsIgnoreCase("51")) {

		sbConfirmMsg.append(" <cellbytelabel>para el Documento</cellbytelabel> [ LISTA # : ");
		sbConfirmMsg.append(anio);
		sbConfirmMsg.append(" - ");
		sbConfirmMsg.append(docId);
		sbConfirmMsg.append("]");

	}

}
 else if (docType.equalsIgnoreCase("AUM") || docType.equalsIgnoreCase("MOR") || docType.equalsIgnoreCase("MORHPP")|| docType.equalsIgnoreCase("HON_RUC_DV") || docType.equalsIgnoreCase("AUMG") || docType.equalsIgnoreCase("CUOTASIND") || docType.equalsIgnoreCase("PLA") || docType.equalsIgnoreCase("ACTAJ") || docType.equalsIgnoreCase("DELPLA") || docType.equalsIgnoreCase("CAPLA") || docType.equalsIgnoreCase("ACHEMPAC") || docType.equalsIgnoreCase("DELTRX") || docType.equalsIgnoreCase("ANSOL") || docType.equalsIgnoreCase("UPDNOEMP") || docType.equalsIgnoreCase("BATCH_PRICE")) {

	//nothing

}  else {

	if (docType.equalsIgnoreCase("FARPATIENT")) sbConfirmMsg.append(" <cellbytelabel>para</cellbytelabel> [");
	else sbConfirmMsg.append(" <cellbytelabel>para el Documento</cellbytelabel> [");
	sbConfirmMsg.append(docDesc);
	sbConfirmMsg.append("]");

	if (docType.equalsIgnoreCase("DGI") && (actType.equals("3") || actType.equals("4") || actType.equals("55"))) {

		//nothing

	} else if (docType.equalsIgnoreCase("FARORDER") && actType.equalsIgnoreCase("51")) {

		sbConfirmMsg.append(" #");
		sbConfirmMsg.append(docId);
		sbConfirmMsg.append(" (ORDEN FARHOS #");
		sbConfirmMsg.append(docNo);
		sbConfirmMsg.append(")");

	} else {

		sbConfirmMsg.append(" #");
		sbConfirmMsg.append(docNo);

	}

}
//-- CONFIRMATION MESSAGE BLOCK 1 ENDS


//-- CONFIRMATION MESSAGE BLOCK 2 STARTS
if (docType.equalsIgnoreCase("ADM") && actType.equals("7")) {

	sbConfirmMsg.append(" <cellbytelabel>del paciente</cellbytelabel> ");
	sbConfirmMsg.append(docId);

} else if (docType.equalsIgnoreCase("DIST")) {

	sbConfirmMsg.append(" <cellbytelabel>de la factura</cellbytelabel> ");
	sbConfirmMsg.append(factura);

	if (!actType.equals("50") && !actType.equals("51")) {

		sbConfirmMsg.append(" <cellbytelabel>por</cellbytelabel> ");
		sbConfirmMsg.append(monto);

	}

} else if (docType.equalsIgnoreCase("GENCOMP")) {

	sbConfirmMsg.append("<font class=\"RedText\"> <cellbytelabel>desde</cellbytelabel> ");
	sbConfirmMsg.append(fechaIni);
	sbConfirmMsg.append(" <cellbytelabel>hasta</cellbytelabel> ");
	sbConfirmMsg.append(fechaFin);
	sbConfirmMsg.append("</font>");

} else if (docType.equalsIgnoreCase("ACTEXP")) {

	sbConfirmMsg.append("<font class=\"RedText\"> <cellbytelabel>del paciente</cellbytelabel> [");
	sbConfirmMsg.append(pacId);
	sbConfirmMsg.append(" - ");
	sbConfirmMsg.append(noAdmision);
	sbConfirmMsg.append("]</font>");

} else if (docType.equalsIgnoreCase("CITAS")) {

	sbConfirmMsg.append("<cellbytelabel>No</cellbytelabel>. ");
	sbConfirmMsg.append(docId);
	sbConfirmMsg.append(" <cellbytelabel>del Paciente</cellbytelabel>: ");
	sbConfirmMsg.append(nombrePac);

}
//-- CONFIRMATION MESSAGE BLOCK 2 ENDS

sbConfirmMsg.append("?");


if (request.getMethod().equalsIgnoreCase("GET"))
{
%>
<html>
<head>
<%@ include file="../common/nocache.jsp"%>
<%@ include file="../common/header_param.jsp"%>
<%@ include file="../common/calendar_base.jsp"%>
<script language="javascript">
document.title = 'Ejecutar Proceso - '+document.title;
function closeW(){parent.hidePopWin(false);<%if (docType.equalsIgnoreCase("DGI") && fp.equalsIgnoreCase("nota_ajuste_otros")) {%>parent.window.close();<%}%>}
function chkFecha(){
	var fecha = document.formDetalle.fecha_ini_plan.value;
	var valreturn = true;
	var x = getDBData('<%=request.getContextPath()%>','\'S\'','dual','trunc(sysdate)<= to_date(\''+fecha+'\', \'dd/mm/yyyy\')','')||'N';
	if(x=='N'){
		alert('La fecha debe ser mayor a la fecha Actual!');
		document.formDetalle.fecha_ini_plan.value='';
		valreturn = false;
	}
	return valreturn;
}
function validDate(){
	var error=0;
	var c=splitCols(getDBData('<%=request.getContextPath()%>','z.estado as estado_cuota, (select estado from tbl_pm_solicitud_contrato where id = z.id_solicitud) as estado_contrato, case when fecha_inicio >= (select fecha_ini_plan from tbl_pm_solicitud_contrato where id = z.id_solicitud) then 1 else 0 end cuota_valida', 'tbl_pm_cuota_extra z','id = <%=docId%>',''));

	if(c[1]=='A'){
		var estado=c[0];
		if(estado=='I'){alert('La Cuota está inactiva y no se puede aprobar!');error++;}
		else if(estado=='A'){alert('La Cuota ya está aprobada!');error++;}
		else if(estado=='F'){alert('La Cuota ya está ejecutada!');error++;}
		else if(c[2]==0){alert('No puede ejecutar la cuota extraordinaria con Fecha de Inicio menor a la Fecha de Inicio del Contrato (verifique)!!');error++;}
	}else{alert('Estado del Contrato ['+c[1]+'] inválido!');error++;}
	return (error==0);
}

function impresoras(){
    console.log("OK;");
}
function selUbicacion(){abrir_ventana1('../common/check_provdistcorr.jsp?fp=run_process');}
</script>
</head>
<body topmargin="0" leftmargin="0" rightmargin="0" onLoad="">
<table align="center" width="100%" cellpadding="0" cellspacing="0">
<tr>
	<td class="TableBorder">
		<table align="center" width="100%" cellpadding="1" cellspacing="1">
<!-- ================================   F O R M   S T A R T   H E R E   ================================ -->
<%fb = new FormBean("formDetalle",request.getContextPath()+request.getServletPath(),FormBean.POST);%>
<%=fb.formStart(true)%>
<%=fb.hidden("fp",fp)%>
<%=fb.hidden("actType",actType)%>
<%=fb.hidden("docType",docType)%>
<%=fb.hidden("docId",docId)%>
<%=fb.hidden("docNo",docNo)%>
<%=fb.hidden("compania",compania)%>
<%=fb.hidden("anio",anio)%>
<%=fb.hidden("turno",turno)%>
<%=fb.hidden("tipoCliente",tipoCliente)%>
<%=fb.hidden("mes",mes)%>
<%=fb.hidden("estado",estado)%>
<%=fb.hidden("ubicacion",ubicacion)%>
<%=fb.hidden("pacId",pacId)%>
<%=fb.hidden("noAdmision",noAdmision)%>
<%=fb.hidden("tipoCob",tipoCob)%>
<%=fb.hidden("fecha",fecha)%>
<%=fb.hidden("tipoCuenta",tipoCuenta)%>
<%=fb.hidden("aseguradora",aseguradora)%>
<%=fb.hidden("categoria",categoria)%>
<%=fb.hidden("factura",factura)%>
<%=fb.hidden("tipo",tipo)%>
<%=fb.hidden("ruc",ruc)%>
<%=fb.hidden("dv",dv)%>
<%=fb.hidden("codigo",codigo)%>
<%=fb.hidden("monto",monto)%>
<%=fb.hidden("refEmpresaAb",refEmpresaAb)%>
<%=fb.hidden("refEmpresa",refEmpresa)%>
<%=fb.hidden("fechaFinal",fechaFinal)%>
<%=fb.hidden("acreedor",acreedor)%>
<%=fb.hidden("grupo",grupo)%>
<%=fb.hidden("facturar_a",facturar_a)%>
<%=fb.hidden("habitacion",habitacion)%>
<%=fb.hidden("fNacMadre",fNacMadre)%>
<%=fb.hidden("codPacMadre",codPacMadre)%>
<%=fb.hidden("pacIdMadre",pacIdMadre)%>
<%=fb.hidden("admMadre",admMadre)%>
<%=fb.hidden("codigoPaciente",codigoPaciente)%>
<%=fb.hidden("fechaFinal",fechaFinal)%>
<%=fb.hidden("codPlanilla",codPlanilla)%>
<%=fb.hidden("numPlanilla",numPlanilla)%>
<%=fb.hidden("comprob",comprob)%>
<%=fb.hidden("cheque",cheque)%>
<%=fb.hidden("cheque2",cheque2)%>
<%=fb.hidden("periodo",periodo)%>
<%=fb.hidden("periodoMes",periodoMes)%>
<%=fb.hidden("legales",legales)%>
<%=fb.hidden("fechaIni",fechaIni)%>
<%=fb.hidden("fechaFin",fechaFin)%>
<%=fb.hidden("fechaInicial",fechaInicial)%>
<%=fb.hidden("acreedores",acreedores)%>
<%=fb.hidden("transDesde",transDesde)%>
<%=fb.hidden("transHasta",transHasta)%>
<%=fb.hidden("fechaCheck",fechaCheck)%>
<%=fb.hidden("anioPlanilla",anioPlanilla)%>
<%=fb.hidden("planillaGen",planillaGen)%>
<%=fb.hidden("numPlaGen",numPlaGen)%>
<%=fb.hidden("fechaInicia",fechaCheck)%>
<%=fb.hidden("trxs",trxs)%>
<%=fb.hidden("empId",empId)%>
<%=fb.hidden("noEmpleado",noEmpleado)%>
<%=fb.hidden("facturarA",facturarA)%>
<%=fb.hidden("pAnioOr",pAnioOr)%>
<%=fb.hidden("pCodPlanillaOr",pCodPlanillaOr)%>
<%=fb.hidden("pNoPlanillaOr",pNoPlanillaOr)%>
<%=fb.hidden("fg",fg)%>
<%=fb.hidden("provincia",provincia)%>
<%=fb.hidden("sigla",sigla)%>
<%=fb.hidden("tomo",tomo)%>
<%=fb.hidden("asiento",asiento)%>
<%=fb.hidden("quincena",quincena)%>
<%=fb.hidden("codigoDgi",codigoDgi)%>
<%=fb.hidden("motivo",motivo)%>
<%=fb.hidden("tab",tab)%>
<%=fb.hidden("incentivo",incentivo)%>
<%=fb.hidden("impuesto",impuesto)%>
<%=fb.hidden("index",index)%>
<%=fb.hidden("comentario",comentario)%>
<%=fb.hidden("creadoPor",creadoPor)%>
<%=fb.hidden("nombrePac",nombrePac)%>
<%=fb.hidden("familia",familia)%>
<%=fb.hidden("clase",clase)%>
<%=fb.hidden("subclase",subclase)%>
<%=fb.hidden("articulo",articulo)%>
<%=fb.hidden("consignacion",consignacion)%>
<%=fb.hidden("venta",venta)%>
<%=fb.hidden("precioVenta",precioVenta)%>
<%=fb.hidden("porcentaje",porcentaje)%>
<%=fb.hidden("accion",accion)%>
<%=fb.hidden("roundTo",roundTo)%>
<%=fb.hidden("basis",basis)%>
<%=fb.hidden("almacen",almacen)%>
<%=fb.hidden("anaquel",anaquel)%>
<%=fb.hidden("tipoReact",tipoReact)%>
<%=fb.hidden("tiempoReact",tiempoReact)%>
<%=fb.hidden("cuenta",cuenta)%>
<%=fb.hidden("idPaciente",idPaciente)%>
<%=fb.hidden("admRoot",admRoot)%>
<%=fb.hidden("admType",admType)%>
<%=fb.hidden("cta",cta)%>
<%=fb.hidden("fecha_no_contado",fechaNoContado)%>
<%=fb.hidden("touch",touch)%>
<%=fb.hidden("impresoSi",impresoSi)%>
<%=fb.hidden("tipoPrecio",tipoPrecio)%>
<%=fb.hidden("id_lista",id_lista)%>
<%=fb.hidden("id_turno",id_turno)%>
<% if (docType.equals("DGI") && ruc!=null && ruc.equals("") && actType.equals("2")) { %>
<%fb.appendJsValidation("if(document."+fb.getFormName()+".ruc_cedula.value==''){alert('Introduzca RUC/Cédula!');"+fb.getFormName()+"BlockButtons(false);return false;}");%>
<%fb.appendJsValidation("if(!checkFactAnulada()){alert('Introduzca RUC/Cédula!');"+fb.getFormName()+"BlockButtons(false);return false;}");%>
<% } else if (docType.equals("APP_PM") && (actType.equals("1") || actType.equals("5"))) { %>
<%fb.appendJsValidation("if(document."+fb.getFormName()+".fecha_ini_plan.value==''){alert('Introduzca Fecha!');"+fb.getFormName()+"BlockButtons(false);return false;}");%>
<% } %>
<%
if (docType.equalsIgnoreCase("APP_PM") && (actType.equalsIgnoreCase("1") || actType.equalsIgnoreCase("5") || actType.equalsIgnoreCase("3"))) {
	fb.appendJsValidation("if(!chkFecha()){"+fb.getFormName()+"BlockButtons(false);return false;}");
	if (actType.equalsIgnoreCase("5")) fb.appendJsValidation("if(!validDate()){"+fb.getFormName()+"BlockButtons(false);return false;}");
}
%>
		<tr class="TextHeader" align="center">
			<td><%=actDesc%> <%=docDesc%></td>
		</tr>
		<tr class="TextRow01">
			<td align="center"><%=sbConfirmMsg%></td>
		</tr>
		<% if (docType.equalsIgnoreCase("DGI") /*&& ruc != null && ruc.trim().equals("")*/ && actType.equals("2")) { %>
		<tr class="TextRow01">
			<!--<td align="center"><cellbytelabel>A nombre de: </cellbytelabel> <%=fb.textBox("nombre_2",nombre_2,true,false,(editClienteRuc.equals("N")),40,30)%></td>-->
			<td align="center"><cellbytelabel>A nombre de: </cellbytelabel> <%=fb.textBox("nombre_2",nombre_2,false,false,false,40,30)%></td>
		</tr>
		<tr class="TextRow01">
			<!--<td align="center"><cellbytelabel>Introduzca RUC/CEDULA: </cellbytelabel> <%=fb.textBox("ruc_cedula",identificacion_2,true,false,(editClienteRuc.equals("S") || (ruc != null && ruc.trim().equals(""))?false:true),40,30)%></td>-->
			<td align="center"><cellbytelabel>Introduzca RUC/CEDULA: </cellbytelabel> <%=fb.textBox("ruc_cedula",identificacion_2,false,false,false,40,30)%></td>
		</tr>
		<tr class="TextRow01">
			<!--<td align="center"><cellbytelabel>DV: </cellbytelabel> <%=fb.textBox("dv_nuevo",dv_2,true,false,(editClienteRuc.equals("S") || (dv != null && dv.trim().equals(""))?false:true),40,30)%></td>-->
			<td align="center"><cellbytelabel>DV: </cellbytelabel> <%=fb.textBox("dv_nuevo",dv_2,false,false,false,40,30)%></td>
		</tr>
		<tr class="TextRow01">
			<td align="center"><cellbytelabel>E-mail: </cellbytelabel> <%=fb.textBox("e_mail",email_fe,false,false,false,40,50)%></td>
		</tr>
		<%
		if (java.util.ResourceBundle.getBundle("issi").getString("facturacion_electronica_activa").equals("S")) {
		%>
		<tr class="TextRow01">
			<td align="center"><cellbytelabel>Tipo de Cliente: </cellbytelabel> <%=fb.select("tipocliente","01=Contribuyente,02=Consumidor Final,03=Gobierno","02",false,false,0,"Text10",null,null,null,"")%></td>
		</tr>
		<tr class="TextRow01">
			<td align="center"><cellbytelabel>Si el cliente es contribuyente o gobierno, introduzca su direcci&oacute;n: </cellbytelabel> <%=fb.textBox("direccion",direccion_fe,false,false,false,40,50)%></td>
		</tr>		
		<tr class="TextRow01">
			<td align="center"><cellbytelabel>Si el cliente es contribuyente o gobierno, seleccione su ubicaci&oacute;n: </cellbytelabel> 				
				<%=fb.textBox("ubicacion_fe",codigo_ubicacion_fe,false,false,false,30,50,null,null,"")%>
				<%=fb.button("buscar","...",true,false,null,null,"onClick=\"javascript:selUbicacion()\"")%>
				<%=fb.hidden("tipoClienteHis",tipoClienteHis)%>
			</td>
		</tr>
		<tr class="TextRow01">
			<td align="center"><cellbytelabel>Si el cliente es contribuyente o gobierno, introduzca su tel&eacute;fono (formato 9999-9999): </cellbytelabel> <%=fb.textBox("telefono_fe",telefono_fe,false,false,false,40,50)%></td>
		</tr>		
		<tr class="TextRow01">
			<td align="center"><cellbytelabel>Si el cliente es de tipo gobierno, colocar para cada l&iacute;nea su c&oacute;digo CPBS. Si no aparece el c&oacute;digo requerido en la lista puede colocar sus cuatro d&iacute;gitos en la caja de texto: </cellbytelabel> 				
			</td>
		</tr>
		<%	
		}
		%>

		<%
		ArrayList d_items = new ArrayList();
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
		"     TO_CHAR(DESCUENTO, 'fm999999999999999990D00') AS \"damt\", " +
		"     CODIGO AS \"Code\", " +
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

		d_items = SQLMgr.getDataList(q_items);

		for (int i=0; i<d_items.size(); i++)
		{
			CommonDataObject cdoI = (CommonDataObject) d_items.get(i);
			//items = items + "   <Item Id=\""+cdoI.getColValue("ID")+"\" Price=\""+cdoI.getColValue("Price")+"\" Qty=\""+cdoI.getColValue("Qty")+"\" Desc=\""+cdoI.getColValue("Desc")+"\" Tax=\""+cdoI.getColValue("Tax")+"\" Code=\""+cdoI.getColValue("Code")+"\" damt=\""+cdoI.getColValue("damt")+"\"/>\n";

	        %>
			<tr class="TextRow01">
				<td align="center"><cellbytelabel><%=cdoI.getColValue("Code") + " - " + cdoI.getColValue("Desc")%> </cellbytelabel> 				
					<%=fb.select(ConMgr.getConnection(),"select cpbs || '-" + cdoI.getColValue("Code") + "', cpbs ||' - '||descripcion from tbl_adm_dgi_cpbs","cpbs" + i,"",false,false,false,0,"Text10","","")%>
					<%=fb.textBox("cpbsText" + i,"",false,false,false,30,50,null,null,"")%>
					<%=fb.hidden("itemFECode" + i,cdoI.getColValue("Code"))%>
				</td>
			</tr>

			<%
		}
		%>
		<!--<tr class="TextRow01">
			<td align="center"><cellbytelabel>Estaci&oacuten: </cellbytelabel>
                <%=fb.select(
                   	ConMgr.getConnection(),
                   	"SELECT " +
                    "     DISTINCT A.ID, A.NOMBRE, A.ID " +
                    " FROM " +
                    "     TBL_FAC_ESTACIONES A INNER JOIN TBL_FAC_IMPRESORAS B " +
                    "         ON(A.COMPANIA = B.COMPANIA AND A.ID = B.ID_ESTACION) " +
                    " WHERE " +
                    "         A.COMPANIA = " + (String) session.getAttribute("_companyId") +
                    "     AND A.ESTADO = 'A' " +
                    " ORDER BY A.NOMBRE asc",
                    "estacion",
                    id_estacion,
                    true,
                    false,
                    (id_estacion.equals("") ? false : true),
                    0,
                    "",
                    "",
                    "onChange=\"loadXML('../xml/IMPRESORAS_X_ESTACION.xml','impresora','','VALUE_COL','LABEL_COL',"+(id_estacion.equals("")?"+this.value":id_estacion)+",'KEY_COL','');\""
                )%>
			</td>
		</tr>
		<tr class="TextRow01">
			<td align="center"><cellbytelabel>Impresora: <cellbytelabel>
			    <%=fb.select(
                   		ConMgr.getConnection(),
                   		"SELECT ID, ID, ID FROM tbl_fac_impresoras where compania = "+(String) session.getAttribute("_companyId")+" and id_estacion = "+(id_estacion == "" ? cdoADE.getColValue("ID"):id_estacion)+" and ESTADO = 'A' order by 1 asc",
                   		"impresora",
                   		"",
                   		true,
                   		false,
                   		false,
                   		0,
                   		"",
                   		"",
                   		""
                )%>
                <script>
                    loadXML('../xml/IMPRESORAS_X_ESTACION.xml','impresora','','VALUE_COL','LABEL_COL','<%=(id_estacion == "" ? cdoADE.getColValue("ID"):id_estacion)%>','KEY_COL','');
                </script>
			</td>
		</tr>-->
		<% } else if ((docType.equalsIgnoreCase("DGI")) && (actType.equals("3") || actType.equals("4") || actType.equals("5"))) {%>
            <!--<tr class="TextRow01">
                <td align="center"><cellbytelabel>Estaci&oacuten: </cellbytelabel>
                    <%=fb.select(
                        ConMgr.getConnection(),
                        "SELECT " +
                        "     DISTINCT A.ID, A.NOMBRE, A.ID " +
                        " FROM " +
                        "     TBL_FAC_ESTACIONES A INNER JOIN TBL_FAC_IMPRESORAS B " +
                        "         ON(A.COMPANIA = B.COMPANIA AND A.ID = B.ID_ESTACION) " +
                        " WHERE " +
                        "         A.COMPANIA = " + (String) session.getAttribute("_companyId") +
                        "     AND A.ESTADO = 'A' " +
                        " ORDER BY A.NOMBRE asc",
                        "estacion",
                        id_estacion,
                        true,
                        false,
                        (id_estacion.equals("") ? false : true),
                        0,
                        "",
                        "",
                        "onChange=\"loadXML('../xml/IMPRESORAS_X_ESTACION.xml','impresora','','VALUE_COL','LABEL_COL',"+(id_estacion.equals("")?"+this.value":id_estacion)+",'KEY_COL','');\""
                    )%>
                </td>
            </tr>
            <tr class="TextRow01">
                <td align="center"><cellbytelabel>Impresora: <cellbytelabel>
                    <%=fb.select(
                        ConMgr.getConnection(),
                        "SELECT ID, ID, ID FROM tbl_fac_impresoras where compania = "+(String) session.getAttribute("_companyId")+" and id_estacion = "+(id_estacion == "" ? cdoADE.getColValue("ID"):id_estacion)+" and ESTADO = 'A' order by 1 asc",
                        "impresora",
                        "",
                        true,
                        false,
                        false,
                        0,
                        "",
                        "",
                        ""
                    )%>
                    <script>
                        loadXML('../xml/IMPRESORAS_X_ESTACION.xml','impresora','','VALUE_COL','LABEL_COL','<%=(id_estacion == "" ? cdoADE.getColValue("ID"):id_estacion)%>','KEY_COL','');
                    </script>
                </td>
            </tr>-->

		<% } else if (docType.equalsIgnoreCase("DGI") && actType.equals("52")) { %>
		<tr class="TextRow01">
			<td align="center"><cellbytelabel>C&oacute;digo DGI Correcto</cellbytelabel> <%=fb.textBox("codigo_correcto",codigoDgi,true,false,false,40,22)%>&nbsp;
			<%if(impresoSi.trim().equals("S")){%>Impreso:<%=fb.select("impreso","Y=Si, N=No","Y","")%> <font color="#FF0000" size="+2">Estimado usuario: </font><font color="#FF0000" size="+3"><%=UserDet.getUserName()%></font><font color="#FF0000" size="+2"> , Recuerde realizar las Notas de Creditos para las Facturas IMPRESAS</font><%}%>
			
			</td>
		</tr>
		<% } else if (docType.equalsIgnoreCase("LISTA_ENVIO") && (actType.equalsIgnoreCase("1"))) { %>
		<tr class="TextRow01">
			<td align="center">Introduzca fecha de Recibo:
			<jsp:include page="../common/calendar.jsp" flush="true">
				<jsp:param name="noOfDateTBox" value="1" />
				<jsp:param name="nameOfTBox1" value="fecha_recibo" />
				<jsp:param name="valueOfTBox1" value="<%=fecha%>" />
				<jsp:param name="fieldClass" value="Text10" />
				<jsp:param name="buttonClass" value="Text10" />
				<jsp:param name="clearOption" value="true" />
				</jsp:include>
			</td>
		</tr>
		<% } else if (docType.equalsIgnoreCase("APP_PM") && (actType.equalsIgnoreCase("1") || actType.equalsIgnoreCase("5") || actType.equalsIgnoreCase("3"))) { %>
		<tr class="TextRow01">
			<td align="center">Introduzca fecha de Inicio de <%=(actType.equalsIgnoreCase("1")?"Plan":(actType.equalsIgnoreCase("3")?"Adenda":"Cuota"))%>:
			<jsp:include page="../common/calendar.jsp" flush="true">
				<jsp:param name="noOfDateTBox" value="1" />
				<jsp:param name="nameOfTBox1" value="fecha_ini_plan" />
				<jsp:param name="valueOfTBox1" value="<%=fecha%>" />
				<jsp:param name="fieldClass" value="Text10" />
				<jsp:param name="buttonClass" value="Text10" />
				<jsp:param name="clearOption" value="true" />
				<jsp:param name="jsEvent" value="chkFecha();" />
				</jsp:include>
			</td>
		</tr>
		
			<% } else if (docType.equalsIgnoreCase("EXP") && actType.equals("8")) { %>
		<tr class="TextRow01">
			<td align="center"><cellbytelabel>Estado:<%=fb.select("estado_atencion","E=EN ESPERA,P=PROCESO","E","")%></td>
		</tr>
		<% } else if (docType.equalsIgnoreCase("ADM") && actType.equals("61") && estado.equalsIgnoreCase("A")) {
			String optDesc = "P=PRE ADMISIONES";
			if (chkAdmType.equalsIgnoreCase("S") || chkAdmType.equalsIgnoreCase("Y")) {

				if (admType.trim().equals("O")) optDesc = "E=ESPERA,P=PRE ADMISIONES";

			} else optDesc = "E=ESPERA,P=PRE ADMISIONES";
		%>
		<tr class="TextRow01">
			<td align="center"><cellbytelabel>Estado:<%=fb.select("estado_new",optDesc,"S","")%></td>
		</tr>
		<%} if (requiredComments) { %>
		<tr class="TextRow01">
			<td align="center"><cellbytelabel>C O M E N T A R I O S</cellbytelabel> <%=fb.textarea("comments","",true,false,false,80,5,2000,null,"","")%></td>
		</tr>
		<%}%>
		<%if (docType.equalsIgnoreCase("REC")) { if (actType.equalsIgnoreCase("56") || actType.equalsIgnoreCase("59")) {%>
		<tr class="TextRow01">
			<td align="center"><cellbytelabel>Turno Activo</cellbytelabel><%=fb.select(ConMgr.getConnection(),tSql.toString(),"turnoReemplazo",turno,true,false,false,0,"S")%></td>
			<!--Afectar Saldo :<%=fb.select("afectar_saldo","S=Si, N=No","S","")%> -->
		</tr>
		
		<%} } %>
		<% if (docType.equalsIgnoreCase("DIST") && actType.equals("50")) { %>
		<tr class="TextRow01">
			<td align="center"><cellbytelabel>Monto Correcto</cellbytelabel> <%=fb.decBox("montoCorregido","",true,false,false,40,10.2)%></td>
		</tr>
		<% } %>
		<% if (docType.equalsIgnoreCase("CORRECCTA") && actType.equals("50")) { %>
		<tr class="TextRow01">
			<td align="center"><cellbytelabel>Cuenta Correcta</cellbytelabel> <%=fb.textBox("cta1","",true,false,false,3,3)%>
			<%=fb.textBox("cta2","",true,false,false,3,2)%>
			<%=fb.textBox("cta3","",true,false,false,3,3)%>
			<%=fb.textBox("cta4","",true,false,false,3,3)%>
			<%=fb.textBox("cta5","",true,false,false,3,3)%>
			<%=fb.textBox("cta6","",true,false,false,3,3)%>
			</td>
		</tr>
		<% } %>
		
		
<% if (docType.equalsIgnoreCase("COMPDIARIO") && (actType.equalsIgnoreCase("51")||actType.equalsIgnoreCase("58"))) {//COMPROBANTES DIARIOS 
%>
	<tr class="TextRow01">
			<td align="center"><cellbytelabel>Eliminar Registros:<%=fb.select("del_reg","S=Si, N=No","N","")%></td>
		</tr>
	
	<%}%>
		<tr class="TextHeader" align="center">
			<td align="center">
				<%=fb.submit("exe","Ejecutar",true,false,"Text10",null,null,actDesc+" "+docDesc)%>
				<%if(fp.equalsIgnoreCase("int_farmacia")){} else {%>
				<%=fb.button("cancel","Cancelar",false,false,"Text10",null,"onClick=\"javascript:closeW();\"")%>
				<%}%>
			</td>
		</tr>
<%=fb.formEnd(true)%>
<!-- ================================   F O R M   E N D   H E R E   ================================ -->
		<% if ( (docType.equalsIgnoreCase("LISTA_ENVIO") && (actType.equalsIgnoreCase("1"))) || (docType.equalsIgnoreCase("APP_PM") && (actType.equalsIgnoreCase("1") || actType.equalsIgnoreCase("5") || actType.equalsIgnoreCase("3"))) ) { %>
		<tr align="center">
			<td align="center"></br></br></br></br></br></br></br></br></br></td>
		</tr>
		<% } %>
		</table>
	</td>
</tr>
</table>
</body>
</html>
<%
}//GET
else
{
	StringBuffer xtraNotes = new StringBuffer();
	StringBuffer sbNewMsg = new StringBuffer();
	String comments = request.getParameter("comments");
	String turnoReemplazo  = request.getParameter("turnoReemplazo");
	String afectar_saldo = request.getParameter("afectar_saldo");
	if (comments == null) comments = "";
	if (turnoReemplazo == null) turnoReemplazo = "-1";
	if (afectar_saldo == null) afectar_saldo = "S";
	boolean isCallableStatement = false;//si utiliza la implementación de procedimientos que devuelve valores
	CommonDataObject param = new CommonDataObject();//parametros para el procedimiento
	String id = null;//id que devuelve el procedimiento
	String rParam = null;//parámetro que devuelve el procedimiento almacenado
	sbSql = new StringBuffer();
		
	if (docType.equalsIgnoreCase("REC")) {

		if (actType.equalsIgnoreCase("7")) {

			sbSql.append("call sp_cja_anular_recibo(");
			sbSql.append(docId);
			sbSql.append(",");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("',");
			sbSql.append(turno);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(comments));
			sbSql.append("')");

		} else if (actType.equalsIgnoreCase("56")) {

			sbSql.append("call sp_cja_anular_recibosup(");
			sbSql.append(docId);
			sbSql.append(",");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("',");
			sbSql.append(turnoReemplazo);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(comments));
			sbSql.append("','");
			sbSql.append(afectar_saldo);
			sbSql.append("')");

		} else if (actType.equalsIgnoreCase("59")) {

			sbSql.append("call sp_cja_replaceable_receipt(");
			sbSql.append(docId);
			sbSql.append(",");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("',");
			sbSql.append(turnoReemplazo);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(comments));
			sbSql.append("','");
			sbSql.append(afectar_saldo);
			sbSql.append("')");

		} else if (actType.equalsIgnoreCase("53")) {

			sbSql.append("call sp_cja_liberar_recibo(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(docId);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(tipoCliente.trim()));
			sbSql.append("')");
		}
		xtraNotes.append("&tipoCliente=");
		xtraNotes.append(tipoCliente);

	} else if (docType.equalsIgnoreCase("CHG")) {

		sbSql.append("call sp_cja_anular_cambio(");
		sbSql.append(docId);
		sbSql.append(")");

	} else if (docType.equalsIgnoreCase("COMP")) {

		sbSql.append("call sp_con_comprobante_servidas(");
		sbSql.append(compania);
		sbSql.append(",23");//tipo Comprobante
		sbSql.append(",'");
		sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
		sbSql.append("',8,");//codigo Asiento Fijo
		sbSql.append(anio);
		sbSql.append(",");
		sbSql.append(mes);
		sbSql.append(")");

	} else if (docType.equalsIgnoreCase("UPDFACT")) {

		sbSql.append("update tbl_fac_factura set estatus = '");
		sbSql.append(estado);
		sbSql.append("',ubicacion='");
		sbSql.append(IBIZEscapeChars.forSingleQuots((ubicacion).trim()));
		sbSql.append("',usuario_modificacion='");
		sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
		sbSql.append("' where  codigo = '");
		sbSql.append(docNo);
		sbSql.append("' and compania=");
		sbSql.append(compania);

	} else if (docType.equalsIgnoreCase("FACT")) {

		if (actType.equalsIgnoreCase("7")) {

			sbSql.append("call sp_fac_anular_factura(");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(docId));
			sbSql.append("','");
			sbSql.append(tipoCob);
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("',");
			sbSql.append(pacId);
			sbSql.append(",");
			sbSql.append(noAdmision);			
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(comments));
			sbSql.append("')");
			
		}
		else if (actType.equalsIgnoreCase("50")) {

			sbSql.append("call sp_cxc_ajuste_doble_cob(");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(docId));
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(factura));
			sbSql.append("',");
			sbSql.append(noAdmision);
			sbSql.append(",");
			sbSql.append(pacId);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("',");
			sbSql.append(monto);
			sbSql.append(",");
			sbSql.append(aseguradora);
			sbSql.append(",'");
			sbSql.append(facturarA);
			sbSql.append("')");
		}
	} else if (docType.equalsIgnoreCase("ADM")) {

		if (actType.equalsIgnoreCase("65")) {

			sbSql.append("call sp_adm_inactivar_admision(");
			sbSql.append(pacId);
			sbSql.append(",");
			sbSql.append(noAdmision);
			sbSql.append(",");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		} else if (actType.equalsIgnoreCase("7")) {

			sbSql.append("call sp_adm_anular_admision(");
			sbSql.append(pacId);
			sbSql.append(",");
			sbSql.append(noAdmision);
			sbSql.append(",");
			sbSql.append(compania);
			
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(comments));
			sbSql.append("','");
			sbSql.append(fecha);
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		} else if (actType.equalsIgnoreCase("50")) {

			sbSql.append("update  tbl_adm_admision set conta_cred = '");
			sbSql.append(estado);
			sbSql.append("',usuario_modifica='");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("' where  pac_id =");
			sbSql.append(docId);
			sbSql.append(" and secuencia=");
			sbSql.append(docNo);

		} else if (actType.equalsIgnoreCase("60")) {

			sbSql.append("call sp_adm_actualizar_estado(");
			sbSql.append(pacId);
			sbSql.append(",");
			sbSql.append(noAdmision);
			sbSql.append(")");

		}else if (actType.equalsIgnoreCase("61")) {
			String _estado = "";
			if (estado.trim().equalsIgnoreCase("A"))if(request.getParameter("estado_new") !=null)_estado =request.getParameter("estado_new"); else _estado = "E";
			else if( estado.trim().equalsIgnoreCase("E") || estado.trim().equalsIgnoreCase("P") ) _estado = "A";
					
			sbSql.append("call sp_adm_update_status(");
			sbSql.append(pacId);
			sbSql.append(",");
			sbSql.append(noAdmision);
			sbSql.append(",'");
			sbSql.append(_estado);
			sbSql.append("'");
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(comments));
			sbSql.append("')");	
		}
		else if (actType.equalsIgnoreCase("62"))
		{
			sbSql.append("call sp_adm_actualizar_estado(");
			sbSql.append(pacId);
			sbSql.append(",");
			sbSql.append(noAdmision);
			sbSql.append(",'ADM','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");
		}

	} else if (docType.equalsIgnoreCase("AUM")) {

		if (actType.equalsIgnoreCase("6")) {

			sbSql.append("update  tbl_pla_aumento_cc set estado_aprobacion = 'S',usuario_aprobacion='");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("', fecha_aprobacion = sysdate where compania=");
			sbSql.append(compania);
			sbSql.append(" and trunc(fecha_aumento)= to_date('");
			sbSql.append(fecha);
			sbSql.append("','dd/mm/yyyy')");
			sbSql.append(" and tipo_aumento in (2,3,4) and  actualizado ='N' and nvl(estado_aprobacion,'N') = 'N'");

		} else if (actType.equalsIgnoreCase("50")) {

			sbSql.append("call sp_pla_act_aumentos_otros(");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(fecha);
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		}

	} else if (docType.equalsIgnoreCase("MOR")||docType.equalsIgnoreCase("MORHPP")) {

	 if (docType.equalsIgnoreCase("MOR")){
		if (actType.equalsIgnoreCase("50")) {

			sbSql.append("call sp_cxc_seleccion_morosidad('");
			sbSql.append(fecha);
			sbSql.append("','");
			sbSql.append(categoria);
			sbSql.append("','");
			sbSql.append(tipoCuenta);
			sbSql.append("','");
			sbSql.append(aseguradora);
			sbSql.append("',");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("','");
			sbSql.append(tipo);
			sbSql.append("')");

		}
		else if (actType.equalsIgnoreCase("52")) {

			sbSql.append("call sp_cxc_seleccion_morosidadM(");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(mes);
			sbSql.append(",'");
			sbSql.append(categoria);
			sbSql.append("','");
			sbSql.append(tipoCuenta);
			sbSql.append("','");
			sbSql.append(aseguradora);
			sbSql.append("',");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("','");
			sbSql.append(tipo);
			sbSql.append("')");

		}
	  }
	  else if (docType.equalsIgnoreCase("MORHPP")){
		if (actType.equalsIgnoreCase("50")) {

			sbSql.append("call sp_cxc_seleccion_morosidad_hpp('");
			sbSql.append(fecha);
			sbSql.append("','");
			sbSql.append(categoria);
			sbSql.append("','");
			sbSql.append(tipoCuenta);
			sbSql.append("','");
			sbSql.append(aseguradora);
			sbSql.append("',");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("','");
			sbSql.append(tipo);
			sbSql.append("')");

		}
      }
	} else if (docType.equalsIgnoreCase("CNDB")) {

			// jabes sbSql.append("call sp_cxc_corregir_nota_debito(");
			sbSql.append("call sp_cxc_corregir_nota_debito(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(docId);
			sbSql.append(",'");
			sbSql.append(factura);
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

	} else if (docType.equalsIgnoreCase("INCOB")) {

		if (actType.equalsIgnoreCase("1")) {

			// jabes sbSql.append("call pa_seleccion_cxc(");
			sbSql.append("call sp_cxc_seleccion_morosidad('");
			sbSql.append(fecha);
			sbSql.append("','");
			sbSql.append(categoria);
			sbSql.append("','");
			sbSql.append(tipoCuenta);
			sbSql.append("','");
			sbSql.append(aseguradora);
			sbSql.append("',");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		}

	} else if (docType.equalsIgnoreCase("HON_RUC_DV")) {

		if (actType.equalsIgnoreCase("4")) {

			sbSql.append("call sp_cxp_hon_upd_ruc_dv('");
			sbSql.append(docId);
			sbSql.append("','");
			sbSql.append(tipo);
			sbSql.append("','");
			sbSql.append(ruc);
			sbSql.append("','");
			sbSql.append(dv);
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");
		}

	} else if (docType.equalsIgnoreCase("REVAJUSTE")) {

		if (actType.equalsIgnoreCase("50")) {

			sbSql.append("call sp_cxc_rev_ajuste_incob(");
			sbSql.append(docNo);
			sbSql.append(",");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("',");
			sbSql.append(aseguradora);
			sbSql.append(")");

		} 
	} else if (docType.equalsIgnoreCase("CORRAJUSTE")) {

		if (actType.equalsIgnoreCase("50")) {

			sbSql.append("call sp_cxc_corregir_ajuste_incob(");
			sbSql.append(docNo);
			sbSql.append(",");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		}
		
	}  	else if (docType.equalsIgnoreCase("CXC_ADJ_AUTO")) {

		if (actType.equalsIgnoreCase("50")) {

			sbSql.append("call sp_cxc_ndebito_ajuste_automat(");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(docId).trim());//factura1
			sbSql.append("',");
			sbSql.append(monto);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(fecha).trim());
			sbSql.append("',");
			sbSql.append(codigo);
			sbSql.append(",");
			sbSql.append(noAdmision);
			sbSql.append(",");
			sbSql.append(aseguradora);
			sbSql.append(",");
			sbSql.append(pacId);
			sbSql.append(")");

		} else if (actType.equalsIgnoreCase("51")) {

			sbSql.append("call sp_cxc_ajusta_factura2(");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(docId).trim());//factura1
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(factura).trim());//factura2
			sbSql.append("',");
			sbSql.append(monto);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(fecha).trim());
			sbSql.append("',");
			sbSql.append(codigo);
			sbSql.append(",");
			sbSql.append(noAdmision);
			sbSql.append(",");
			sbSql.append(aseguradora);
			sbSql.append(",");
			sbSql.append(pacId);
			sbSql.append(")");

		}

	} else if (docType.equalsIgnoreCase("CAMA")) {

		if (actType.equalsIgnoreCase("7")) {

			sbSql.append("call sp_adm_anula_cama(");
			sbSql.append(noAdmision);
			sbSql.append(",");
			sbSql.append(pacId);
			sbSql.append(",");
			sbSql.append(docId);
			sbSql.append(",'");
			sbSql.append(docNo);
			sbSql.append("','");
			sbSql.append(habitacion);
			sbSql.append("',");
			sbSql.append(compania);
			sbSql.append(")");

		} else if (actType.equalsIgnoreCase("3")) {

			sbSql.append("call sp_sal_corrida_cama('");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("',");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(fecha).trim());
			sbSql.append("',");
			sbSql.append(pacId);
			sbSql.append(",'");
			sbSql.append(tipo);
			sbSql.append("',");
			sbSql.append(noAdmision);
			sbSql.append(",'N'");
			sbSql.append(")");

		}

	} else if (docType.equalsIgnoreCase("DIST")) {

		if (actType.equalsIgnoreCase("7")) {

			sbSql.append("call sp_cja_anular_dist(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(docId);
			sbSql.append(",");
			sbSql.append(docNo);
			sbSql.append(")");

		} else if (actType.equalsIgnoreCase("50")) {

			if (request.getParameter("montoCorregido") != null && !request.getParameter("montoCorregido").trim().equals("")) {

				sbSql.append(" update tbl_cja_distribuir_pago set monto =");
				sbSql.append(request.getParameter("montoCorregido"));
				sbSql.append(" where compania =");
				sbSql.append(compania);
				sbSql.append(" and tran_anio = ");
				sbSql.append(anio);
				sbSql.append(" and codigo_transaccion = ");
				sbSql.append(docId);
				sbSql.append(" and secuencia_pago =");
				sbSql.append(docNo);
				sbSql.append(" and secuencia =");
				sbSql.append(codigo);
				sbSql.append("");

			}

		} else if (actType.equalsIgnoreCase("51")) {

			sbSql.append("call sp_cja_liberar_pago_fac(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(docId);
			sbSql.append(",");
			sbSql.append(docNo);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("','");
			sbSql.append(factura);
			sbSql.append("')");

		}

	} else if (docType.equalsIgnoreCase("TRF")) {//Transferencia de Cargos

		if (actType.equalsIgnoreCase("51")) {

			sbSql.append("call sp_fac_transferir_cargos(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(pacId);
			sbSql.append(",");
			sbSql.append(docNo);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(fNacMadre).trim());
			sbSql.append("',");
			sbSql.append(codPacMadre);
			sbSql.append(",");
			sbSql.append(pacIdMadre);
			sbSql.append(",");
			sbSql.append(admMadre);
		    sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("','");
			sbSql.append(fg);
			sbSql.append("')");

		}

	} else if (docType.equalsIgnoreCase("CORTE")) {//Corte de Cuenta

		if (actType.equalsIgnoreCase("51")) {

			sbSql.append("call sp_fac_corte_cuenta_manual(");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(fecha).trim());
			sbSql.append("',");
			sbSql.append(codigoPaciente);
			sbSql.append(",");
			sbSql.append(noAdmision);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("','");
			sbSql.append(aseguradora);
			sbSql.append("',");
			sbSql.append(pacId);
			sbSql.append(")");

		}

	} else if (docType.equalsIgnoreCase("EXP")) {//Corte de Cuenta

		if (actType.equalsIgnoreCase("7")) {

			sbSql.append("call sp_adm_inactivar_datos_bb(");
			sbSql.append(pacId);
			sbSql.append(",");
			sbSql.append(noAdmision);
			sbSql.append(",");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(pacIdMadre);
			sbSql.append(",");
			sbSql.append(codigo);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		}else if (actType.equalsIgnoreCase("8")) {
		
		    sbSql = new StringBuffer();
			sbSql.append(" update tbl_adm_atencion_cu set estado ='");
			sbSql.append(request.getParameter("estado_atencion"));
			sbSql.append("'");
			sbSql.append(" where estado = 'Z' and pac_id =");
			sbSql.append(pacId);
			sbSql.append(" and secuencia = ");
			sbSql.append(noAdmision);
			SQLMgr.execute(sbSql.toString());
		}

	} else if (docType.equalsIgnoreCase("ACRACH")) {//Pago ach Acredores

		if (actType.equalsIgnoreCase("53")) {

			sbSql.append("call sp_pla_pago_acr_ach(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(mes);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(fecha).trim());
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		}

	} else if (docType.equalsIgnoreCase("LISTA_AJUSTE")) {//Fondo de Cesantia

		if (actType.equalsIgnoreCase("5")) {

			sbSql.append("call sp_cxc_rechaza_lista(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(docId);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		}
		else if (actType.equalsIgnoreCase("51")) {

			sbSql.append("call sp_cxc_rev_ajustes_lote(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(docId);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		}

	}  else if (docType.equalsIgnoreCase("FCESAN")) {//Fondo de Cesantia

		if (actType.equalsIgnoreCase("50")) {

			sbSql.append("call sp_pla_cal_fondo_cesantia(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(mes);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(fecha).trim());
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(fechaFinal).trim());
			sbSql.append("')");

		}

	} else if (docType.equalsIgnoreCase("DGI")) {//I M P R E S O R A   F I S C A L
		String facturacion_electronica_activa= java.util.ResourceBundle.getBundle("issi").getString("facturacion_electronica_activa");
		if (facturacion_electronica_activa.equals("S")) {
		%>
			<jsp:forward page="../common/factura_electronica.jsp"/>
		<%	
		} else {		
		%>
		
			<jsp:forward page="../common/print_fiscal.jsp"/>
		<%
		}
	} else if (docType.equalsIgnoreCase("VAC")) {//Vacaciones

		if (actType.equalsIgnoreCase("50")) {

			if (estado.equalsIgnoreCase("3")) sbSql.append("call sp_pla_vacaciones_cesante(");
			else sbSql.append("call sp_pla_vacaciones(");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(tipo);
			sbSql.append(",");
			sbSql.append(compania);
			sbSql.append(")");

		}

	} else if (docType.equalsIgnoreCase("CAL")) {//Calendario de planilla

		if (actType.equalsIgnoreCase("51")) {

			sbSql.append("call sp_pla_cambio_calendario(");
			sbSql.append(anio);
			sbSql.append(")");

		}

	} else if (docType.equalsIgnoreCase("AUMG")) {//Aumentos Generales por cc.

		if (actType.equalsIgnoreCase("50")) {

			sbSql.append("call sp_pla_cargar_aumento_gral(");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(fecha).trim());
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		} else if (actType.equalsIgnoreCase("52")) {

			sbSql.append("delete from tbl_pla_aumento_cc where compania = ");
			sbSql.append(compania);
			sbSql.append(" and actualizado ='N' and tipo_aumento = 1 and trunc(fecha_aumento) = to_date('");
			sbSql.append(IBIZEscapeChars.forSingleQuots(fecha).trim());
			sbSql.append("','dd/mm/yyyy')");

		} else if (actType.equalsIgnoreCase("53")) {

			sbSql.append("call sp_pla_actualizar_aumentos(");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(fecha).trim());
			sbSql.append("','1','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		}

	} else if (docType.equalsIgnoreCase("CUOTASIND")) {//Cuota extraordinaria.

		if (actType.equalsIgnoreCase("50")) {

			sbSql.append("call sp_pla_descuento_sind(");
			sbSql.append(monto);
			sbSql.append(",");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(acreedor);
			sbSql.append(",");
			sbSql.append(grupo);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		}

	}  else if (docType.equalsIgnoreCase("PLA")) {//CALCULO DE PLANILLA POR TIPO

		if (actType.equalsIgnoreCase("50") || actType.equalsIgnoreCase("51")) {

			sbSql.append("call sp_pla_calculo_planilla(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(codPlanilla);
			sbSql.append(",");
			sbSql.append(numPlanilla);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(comprob);
			sbSql.append(",");
			sbSql.append(cheque);
			sbSql.append(",");
			sbSql.append(cheque2);
			sbSql.append(",");
			sbSql.append(periodo);
			sbSql.append(",'");
			sbSql.append(fecha);
			sbSql.append("','");
			sbSql.append(legales);
			sbSql.append("','");
			sbSql.append(fechaIni);
			sbSql.append("','");
			sbSql.append(fechaFin);
			sbSql.append("','");
			sbSql.append(acreedores);
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("',");
			sbSql.append(periodoMes);
			sbSql.append(",'");
			sbSql.append(transDesde);
			sbSql.append("','");
			sbSql.append(transHasta);
			sbSql.append("','");
			sbSql.append(fechaCheck);
			sbSql.append("','");
			sbSql.append(estado);
			sbSql.append("','");
			sbSql.append(anioPlanilla);
			sbSql.append("','");
			sbSql.append(planillaGen);
			sbSql.append("','");
			sbSql.append(numPlaGen);
			sbSql.append("','");
			sbSql.append(fechaFinal);
			sbSql.append("','");
			sbSql.append(fechaInicia);
			sbSql.append("','");
			sbSql.append(trxs);
			sbSql.append("','");
			sbSql.append(pAnioOr);
			sbSql.append("','");
			sbSql.append(pCodPlanillaOr);
			sbSql.append("','");
			sbSql.append(pNoPlanillaOr);
			sbSql.append("')");/**/

		} else if (actType.equalsIgnoreCase("52")) {

			sbSql.append("call sp_pla_contabilidad_ck(");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(codPlanilla);
			sbSql.append(",");
			sbSql.append(numPlanilla);
			sbSql.append(",");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(cuenta);
			sbSql.append("',");
			sbSql.append(codigo);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		}

	} else if (docType.equalsIgnoreCase("ACTAJ")) {//ACTUALIZAR PLANILLA DE AJUSTE

		if (actType.equalsIgnoreCase("50")) {

			sbSql.append("call sp_pla_actualiza_ajuste(");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(noEmpleado).trim());
			sbSql.append("',");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(codPlanilla);
			sbSql.append(",");
			sbSql.append(numPlanilla);
			sbSql.append(",");
			sbSql.append(codigo);
			sbSql.append(",");
			sbSql.append(empId);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("',");
			sbSql.append(periodo);

		}

	} else if (docType.equalsIgnoreCase("SALDO0")) {//FACTURA CON SALDO 0

		if (actType.equalsIgnoreCase("50")) {

			sbSql.append("call sp_fac_facturar_cuenta0(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(pacId);
			sbSql.append(",");
			sbSql.append(noAdmision);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(factura));
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(facturarA));
			sbSql.append("')");

		}

	} else if (docType.equalsIgnoreCase("DELPLA")) {//BORRAR PLANILLA

		if (actType.equalsIgnoreCase("51")) {

			sbSql.append("call sp_pla_elimina_planilla(");
			sbSql.append(codPlanilla);
			sbSql.append(",");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(numPlanilla);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		} else if (actType.equalsIgnoreCase("6")||actType.equalsIgnoreCase("52")) { 
			
			if (actType.equalsIgnoreCase("6")){sbSql.append("call sp_pla_planilla_definitva(");}
			else if(actType.equalsIgnoreCase("52")){sbSql.append("call sp_pla_planilla_acr_definitiva(");}
			sbSql.append(codPlanilla);
			sbSql.append(",");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(numPlanilla);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		}

	} else if (docType.equalsIgnoreCase("DISTTRX")) {//DISTRIBUCION DE TRX AUSENCIAS - SOBRETIEMPO

		if (actType.equalsIgnoreCase("50")) {

			sbSql.append("call sp_pla_generacion(");
			sbSql.append("'");
			sbSql.append(fechaIni);
			sbSql.append("','");
			sbSql.append(fechaFin);
			sbSql.append("',");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(grupo);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(periodo);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		} else if (actType.equalsIgnoreCase("51")) {

			sbSql.append("call sp_pla_generar_sobretiempo(");
			sbSql.append(periodo);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(empId);
			sbSql.append(",");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(grupo);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(periodo);
			sbSql.append(",'");
			sbSql.append(estado);
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

	}

	}  else if (docType.equalsIgnoreCase("CAPLA")) {//CALCULO DE ACUMULADOS DE PLANILLA

		if (actType.equalsIgnoreCase("50")) {

			sbSql.append("call sp_pla_cargar_acumulados(");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(mes);
			sbSql.append(",");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		}

	} else if (docType.equalsIgnoreCase("SOLVAC")) {//APROBAR DISTRIBUCION DE VACACIONES

		if (actType.equalsIgnoreCase("51")) {

			sbSql.append("call sp_rh_pago_vacaciones_def(");
			sbSql.append(empId);
			sbSql.append(",");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(periodo);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		} else if (actType.equalsIgnoreCase("5")|| actType.equalsIgnoreCase("7")) {//Rechazar , anular solicitud de vacaciones.

			sbSql.append("call sp_pla_accion_sol_vac(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(empId);
			sbSql.append(",");
			sbSql.append(codigo);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots((comments).trim()));
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("','");
			sbSql.append(fg);
			sbSql.append("','");
			sbSql.append(periodo);
			sbSql.append("')");

		} else if (actType.equalsIgnoreCase("52")) {//anular distribucion de vacaciones

			sbSql.append("call sp_rh_pago_vacaciones_dist_an(");
			sbSql.append(empId);
			sbSql.append(",");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(periodo);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		}

	} else if (docType.equalsIgnoreCase("COMP_HIST")) {//Comprobante Historico

		if (actType.equalsIgnoreCase("6") || actType.equalsIgnoreCase("7")) {

			sbSql.append("call sp_con_aprob_comprobante_temp(");
			sbSql.append((String) session.getAttribute("_companyId"));
			sbSql.append(", '");
			sbSql.append((String) session.getAttribute("_userName"));
			sbSql.append("', ");
			sbSql.append(anio);
			sbSql.append(", ");
			sbSql.append(mes);
			sbSql.append(", ");
			sbSql.append(docId);
			if (actType.equalsIgnoreCase("6"))sbSql.append(",'AP'");
			else if (actType.equalsIgnoreCase("7"))sbSql.append(",'DE'");
			sbSql.append(",");
			sbSql.append(tipo);
			sbSql.append(")");

		}
		else if (actType.equalsIgnoreCase("50")) {

			sbSql.append("call sp_con_anula_comprobante_temp(");
			sbSql.append(anio);
			sbSql.append(", ");
			sbSql.append(docId);
			sbSql.append(", ");
			sbSql.append(mes);
			sbSql.append(", ");
			sbSql.append((String) session.getAttribute("_companyId"));
			sbSql.append(", '");
			sbSql.append((String) session.getAttribute("_userName"));
			sbSql.append("')");
		}

	} else if (docType.equalsIgnoreCase("DISTLIC")) {//DISTRIBUIR LICENCIA

		if (actType.equalsIgnoreCase("50")) {

			sbSql.append("call sp_pla_lic_distribuir_salario(");
			sbSql.append(monto);
			sbSql.append(",");
			sbSql.append(quincena);
			sbSql.append(",'");
			sbSql.append(fechaFin);
			sbSql.append("','");
			sbSql.append(fechaIni);
			sbSql.append("',");
			sbSql.append(empId);
			sbSql.append(",");
			sbSql.append(provincia);
			sbSql.append(",'");
			sbSql.append(sigla);
			sbSql.append("',");
			sbSql.append(tomo);
			sbSql.append(",");
			sbSql.append(asiento);
			sbSql.append(",");
			sbSql.append(codigo);
			sbSql.append(",");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		} else if (actType.equalsIgnoreCase("51")) {//ACTUALIZAR DISTRIBUCION

			sbSql.append("call sp_pla_lic_acumular_decimo(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(empId);
			sbSql.append(",");
			sbSql.append(codigo);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		} else if (actType.equalsIgnoreCase("52")) {//ELIMINAR DISTRIBUCION

			sbSql.append("delete from tbl_pla_pago_licencia where  compania  = ");
			sbSql.append(compania);
			sbSql.append(" and emp_id  = ");
			sbSql.append(empId);
			sbSql.append(" and codigo  =");
			sbSql.append(codigo);
			sbSql.append(" and estado  = 'P'");

		}

	} else if (docType.equalsIgnoreCase("ANSOL")) {//ANULAR SOLICITUD DE EMPLEO

		if (actType.equalsIgnoreCase("7")) {

			sbSql.append("call sp_pla_anula_sol_empleo(");
			sbSql.append(codigo);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(")");

		}

	} else if (docType.equalsIgnoreCase("UPDNOEMP")) {//ACTUALIZAR NUMERO DE EMPLEADO

		if (actType.equalsIgnoreCase("50")) {

			sbSql.append("call sp_rh_upd_num_empleado('");
			sbSql.append(codigo);
			sbSql.append("','");
			sbSql.append(noEmpleado);
			sbSql.append("',");
			sbSql.append(empId);
			sbSql.append(")");

		}

	} else if (docType.equalsIgnoreCase("LIQ") || docType.equalsIgnoreCase("DELLIQ")) {//LIQUIDACION

		if (actType.equalsIgnoreCase("50")) {//ELIMINAR REGISTROS DE LIQUIDACION

			sbSql.append("call sp_pla_elimina_liq(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(codPlanilla);
			sbSql.append(",");
			sbSql.append(numPlanilla);
			sbSql.append(",");
			sbSql.append(empId);
			sbSql.append(",'");
			sbSql.append(noEmpleado);
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(fecha.trim()));
			sbSql.append("')");

		} else if (actType.equalsIgnoreCase("51")) {//calcular dias laborados

			sbSql.append("call sp_pla_calc_diasLaborados(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(empId);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(fechaIni.trim()));
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(fechaFin.trim()));
			sbSql.append("','");
			sbSql.append(noEmpleado);
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(fecha.trim()));
			sbSql.append("')");

		} else if (actType.equalsIgnoreCase("52")) {//calcular Acumulados

			sbSql.append("call sp_pla_calculo_liquidacion(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(empId);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(fecha.trim()));
			sbSql.append("','AC'");
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		}

	} else if (docType.equalsIgnoreCase("ACHEMPAC")) {//ACH - CHEQUES EMPLEADOS ACTUALUZAR CONTABILIDAD

		if (actType.equalsIgnoreCase("51")) {

			sbSql.append("call sp_pla_contabilidad(");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(codPlanilla);
			sbSql.append(",");
			sbSql.append(numPlanilla);
			sbSql.append(",");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(fecha);
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		}
		else if (actType.equalsIgnoreCase("52")) {

			sbSql.append("call sp_pla_contabilidad_rango(");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(codPlanilla);
			sbSql.append(",");
			sbSql.append(numPlanilla);
			sbSql.append(",");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(fecha);
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("',");
			sbSql.append(cheque);
			sbSql.append(",");
			sbSql.append(cheque2);
			sbSql.append(",");
			sbSql.append(tipoCuenta);
			sbSql.append(")");

		}
		else if (actType.equalsIgnoreCase("53")) {

			sbSql.append("call sp_pla_cargar_temporal_cheque(");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(mes);
			sbSql.append(",");
			sbSql.append(quincena);
			sbSql.append(",'");
			sbSql.append(fecha);
			sbSql.append("',");
			sbSql.append(compania);
			sbSql.append(")");

		}

	} else if (docType.equalsIgnoreCase("DELTRX")) {//BORRAR TRANSACCIONES CREADAS POR LOTE

		if (actType.equalsIgnoreCase("53")) {

			sbSql.append("call sp_pla_elimina_transaccion(");
			sbSql.append(codPlanilla);
			sbSql.append(",");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(periodo);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(trxs);
			sbSql.append(",'");
			sbSql.append(accion);
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		} else if (actType.equalsIgnoreCase("54")) {

			sbSql.append("call sp_pla_elimina_temp_generacion(");
			sbSql.append("'");
			sbSql.append(fechaIni);
			sbSql.append("','");
			sbSql.append(fechaFin);
			sbSql.append("',");
			sbSql.append(grupo);
			sbSql.append(",");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(docDesc).trim());
			sbSql.append("')");

		}

	} else if (docType.equalsIgnoreCase("CONTHON")) {

		if (actType.equalsIgnoreCase("50")) {

			sbSql.append("call sp_con_cargar_hon(");
			sbSql.append("'");
			sbSql.append(fecha);
			sbSql.append("'");
			sbSql.append(",");
			sbSql.append("'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		}

	} else if (docType.equalsIgnoreCase("GENCOMP")) {//GENERAR COMPROBANTES

		if (actType.equalsIgnoreCase("50")) sbSql.append("call sp_con_comprobante_cxc2(");
		else if (actType.equalsIgnoreCase("51")) sbSql.append("call sp_con_comprobante_recep(");
		else if (actType.equalsIgnoreCase("52")) sbSql.append("call sp_con_comprobante_transf_wh(");
		else if (actType.equalsIgnoreCase("53")) sbSql.append("call sp_con_comprobante_costos(");
		else if (actType.equalsIgnoreCase("54")) sbSql.append("call sp_con_comprobante_gastos_ser(");
		else if (actType.equalsIgnoreCase("55")) sbSql.append("call sp_con_generar_libro_ingreso(");
		else if (actType.equalsIgnoreCase("56")) sbSql.append("call sp_con_anular_libro_ingreso(");
		else if (actType.equalsIgnoreCase("57")) sbSql.append("call sp_con_comprobante_entregas_ua(");
		else if (actType.equalsIgnoreCase("58")) sbSql.append("call sp_con_generar_libro(");//libro de caja
		else if (actType.equalsIgnoreCase("59")) sbSql.append("call sp_con_comprobante_libro(");
		else if (actType.equalsIgnoreCase("61")) sbSql.append("call sp_con_gen_libro_ck(");
		//else if (actType.equalsIgnoreCase("61")) sbSql.append("call sp_cxp_reversar_trx(");
		else if (actType.equalsIgnoreCase("62")) sbSql.append("call sp_con_comprobante_ajuste_prov(");
		else if (actType.equalsIgnoreCase("60")) sbSql.append("call sp_con_comprobante_cxp_ck(");
		else if (actType.equalsIgnoreCase("63")) sbSql.append("call sp_con_comprobante_pm(");
		else if (actType.equalsIgnoreCase("64")) sbSql.append("call sp_con_comprobante_fijos(");
		else if (actType.equalsIgnoreCase("65")) sbSql.append("call sp_con_comprobante_paq(");
		//call sp_cxp_gen_comprob_ck(' + p_compania + ', \'' + fecha_desde + '\', \'' + fecha_hasta + '\', \'' + v_user + '\')')){
		// else if (actType.equalsIgnoreCase("60")) 'call sp_con_anular_libro(' + p_compania + ', \'' + fecha+ '\')')
//         sp_cxp_reversar_trx
//sp_cxp_cierre_trx

		sbSql.append(compania);
		sbSql.append(",'");
		sbSql.append(IBIZEscapeChars.forSingleQuots(fechaIni.trim()));
		sbSql.append("','");
		sbSql.append(IBIZEscapeChars.forSingleQuots(fechaFin.trim()));

		if (!actType.equalsIgnoreCase("56")) {

			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));

		}
		if (actType.equalsIgnoreCase("55") || actType.equalsIgnoreCase("56") || actType.equalsIgnoreCase("58")|| actType.equalsIgnoreCase("61")) sbSql.append("'");
		else {

			sbSql.append("',");
			sbSql.append(tipo);

		}
		

		sbSql.append(")");
		//sql='call sp_con_comprobante_cxc2(' + p_compania+ ', \'' + fecha+ '\',\'' + fecha_hasta+ '\', \'' + v_user + '\','+v_tipo+ ')';
		//sql='call sp_con_comprobante_recep(' + p_compania+ ', \'' + fecha+ '\',\'' + fecha_hasta+ '\', \'' + v_user + '\','+v_tipo+ ')';
		//sql='call sp_con_comprobante_transf_al(' + p_compania+ ', \'' + fecha+ '\',\'' + fecha_hasta+ '\', \'' + v_user + '\','+v_tipo+','+v_tipo+ ')';
		//sql='call sp_con_comprobante_costos(' + p_compania+ ', \'' + fecha+ '\',\'' + fecha_hasta+ '\', \'' + v_user + '\','+v_tipo+','+v_tipo+ ')';
		//sql='call sp_con_comprobante_gastos_ser(' + p_compania+ ', \'' + fecha+ '\',\'' + fecha_hasta+ '\', \'' + v_user + '\','+v_tipo+')';
		//sql='call sp_con_generar_libro_ingreso(' + p_compania+ ', \'' + fecha+ '\',\'' + fecha_hasta+ '\', \'' + v_user + '\')';
		//sql='call sp_con_anular_libro_ingreso(' + p_compania+ ', \'' + fecha+ '\',\'' + fecha_hasta+ '\')';

		//call sp_con_comprobante_libro(' + p_compania + ', \'' + fechaIni+ '\',\'' + fechaFin+ '\', \'' + v_user +'\','+v_tipo+ ')')) comprobante de caja
		//call sp_con_generar_libro(' + p_compania + ', \'' + fecha+ '\', \'' + v_user + '\')')) //Generar libro de caja

	} else if (docType.equalsIgnoreCase("CJA")) {//CAJA

		if (actType.equalsIgnoreCase("50")) {

			sbSql.append("call sp_cja_tramite_caja(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(docNo);
			sbSql.append(",");
			sbSql.append(docId);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		}
		else if (actType.equalsIgnoreCase("52")) {

			sbSql.append("call sp_cja_activar_turno(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(docNo);
			sbSql.append(",");
			sbSql.append(docId);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		}

	} else if (docType.equalsIgnoreCase("CARTA")) {

		if (actType.equalsIgnoreCase("50")) {

			sbSql.append("delete from tbl_pla_sol_carta where  id  = ");
			sbSql.append(docId);

		}

	} else if (docType.equalsIgnoreCase("AFIJO")) {

		if (actType.equalsIgnoreCase("50")) {

			isCallableStatement = true;
			sbSql.append("call sp_con_genera_comprobante_fijo (?,?,?,?,?,?)");
			param.setSql(sbSql.toString());
			param.addInNumberStmtParam(1,compania);
			param.addInNumberStmtParam(2,docId);
			param.addInNumberStmtParam(3,anio);
			param.addInNumberStmtParam(4,mes);
			param.addInNumberStmtParam(5,"23");
			param.addOutNumberStmtParam(6);

		}

	} else if (docType.equalsIgnoreCase("AJ")) {

		if (actType.equalsIgnoreCase("50")){
			sbSql.append("call sp_fac_revertir_ajuste(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(docNo);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(docId));
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(tipo));
			sbSql.append("')");
		}
		else if (actType.equalsIgnoreCase("51")||actType.equalsIgnoreCase("52")){
			sbSql.append("call sp_fac_upd_status_ajuste(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(docNo);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(docId));
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(tipo));
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(estado));
			sbSql.append("')");
		}

	} else if (docType.toUpperCase().startsWith("FP_")) {

		if (actType.equalsIgnoreCase("3")) {

			isCallableStatement = true;
			sbSql.append("call sp_bio_save_fp_tmp2owner (?,?,?)");
			param.setSql(sbSql.toString());
			param.addInStringStmtParam(1,session.getId());
			param.addInStringStmtParam(2,docId);
			param.addInStringStmtParam(3,docType.toUpperCase().substring(docType.indexOf("_")+1));

		} else if (actType.equalsIgnoreCase("10")) {

			isCallableStatement = true;
			sbSql.append("call sp_bio_remove_fp (?,?)");
			param.setSql(sbSql.toString());
			param.addInStringStmtParam(1,docId);
			param.addInStringStmtParam(2,docType.toUpperCase().substring(docType.indexOf("_")+1));

		}

	} else if (docType.equalsIgnoreCase("CIERRE")) {//CIERRE ANUAL TRANSITORIO

		if (actType.equalsIgnoreCase("50") || actType.equalsIgnoreCase("55")) {

			if (actType.equalsIgnoreCase("50")) sbSql.append("call sp_con_cierreanual_trans(");
			else if (actType.equalsIgnoreCase("55")) sbSql.append("call sp_con_genera_cierre_mes(");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		} else if (actType.equalsIgnoreCase("51") || actType.equalsIgnoreCase("52")) {

			if (actType.equalsIgnoreCase("51")) sbSql.append("call sp_con_genera_gastos_cerrado(");
			else if (actType.equalsIgnoreCase("52")) sbSql.append("call sp_con_genera_ingreso_cerrado(");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("',");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(mes);
			sbSql.append(")");

		} else if (actType.equalsIgnoreCase("53")) {

			sbSql.append("call sp_con_genera_resultado_cer(");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("',");
			sbSql.append(incentivo);
			sbSql.append(",");
			sbSql.append(impuesto);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(mes);
			sbSql.append(")");

		} else if (actType.equalsIgnoreCase("54")) {

			sbSql.append("call sp_con_cierreanual(");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("',");
			sbSql.append(anio);
			sbSql.append(")");

		}

	} else if (docType.equalsIgnoreCase("PAC_PM")) {//CREAR PACIENTE DE PLAN MEDICO

		if (actType.equalsIgnoreCase("1")) {

			isCallableStatement = true;
			sbSql.append("call sp_pm_crear_paciente (?,?,?,?,?)");
			param.setSql(sbSql.toString());
			param.addInNumberStmtParam(1,docId);
			param.addInStringStmtParam(2,IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			param.addInStringStmtParam(3,fecha);
			param.addOutNumberStmtParam(4);
			param.addOutNumberStmtParam(5);

		}
	} else if (docType.equalsIgnoreCase("APP_PM")) //APROBAR SOLICITUD DE PLAN MEDICO
	{
		if (actType.equalsIgnoreCase("1") || actType.equalsIgnoreCase("2"))
	   {		 
			isCallableStatement = false;
			sbSql.append("call sp_pm_aprobar_solicitud (");
			sbSql.append(docId);
			sbSql.append(", '");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("', '");
			sbSql.append((actType.equalsIgnoreCase("1")?"A":"I"));
			sbSql.append("', '");
			sbSql.append(request.getParameter("fecha_ini_plan"));
			sbSql.append("')");
	   } else if (actType.equalsIgnoreCase("3") || actType.equalsIgnoreCase("4"))
	   {
		 
			isCallableStatement = false;
			sbSql.append("call sp_pm_aprobar_adenda (");
			sbSql.append(docId);
			sbSql.append(", '");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("', '");
			sbSql.append((actType.equalsIgnoreCase("3")?"A":"I"));
			sbSql.append("','");
			sbSql.append(request.getParameter("fecha_ini_plan"));
			sbSql.append("')");
	   } else if (actType.equalsIgnoreCase("5") || actType.equalsIgnoreCase("6"))
	   {
		 
			isCallableStatement = false;
			sbSql.append("call sp_pm_aprobar_cuota (");
			sbSql.append(docId);
			sbSql.append(", '");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("', '");
			sbSql.append((actType.equalsIgnoreCase("5")?"A":"I"));
			sbSql.append("', '");
			sbSql.append(request.getParameter("fecha_ini_plan"));
			sbSql.append("')");
	   }
	}	 else if (docType.equalsIgnoreCase("ACTEXP")) {//ACTIVAR EXPEDIENTE

		if (actType.equalsIgnoreCase("50")) {

			sbSql.append("call sp_adm_activar_exp(");
			sbSql.append(pacId);
			sbSql.append(",");
			sbSql.append(noAdmision);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(comentario.trim()));
			sbSql.append("','");
			sbSql.append(tipoReact);
			sbSql.append("','");
			sbSql.append(tiempoReact);
			sbSql.append("','");
			sbSql.append((String)session.getAttribute("_userName"));
			sbSql.append("')");
		}

	} else if (docType.equalsIgnoreCase("COMPDIARIO")) {//APROBAR,ANULACION,ELIMINAR COMPROBANTES DIARIOS

		if (actType.equalsIgnoreCase("50")) {

			// call sp_con_upd_estado_comprob(,2011,13,null,,1,'benito')
			sbSql.append("call sp_con_upd_estado_comprob(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(mes);
			sbSql.append(",");
			sbSql.append(docNo);
			sbSql.append(",");
			sbSql.append(comprob);
			sbSql.append(",");
			sbSql.append(tipo);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		} else if (actType.equalsIgnoreCase("51")||actType.equalsIgnoreCase("58")) {
			sbSql.append("call sp_con_desap_comprobante(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(docNo);
			sbSql.append(",");
			sbSql.append(comprob);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("','");
			if (actType.equalsIgnoreCase("51")) sbSql.append(IBIZEscapeChars.forSingleQuots(creadoPor.trim()));		
			else sbSql.append("PLA");	
			sbSql.append("','");
			sbSql.append(request.getParameter("del_reg"));
			sbSql.append("')");
		} else if (actType.equalsIgnoreCase("52")) {

			sbSql.append("call sp_con_anula_comprobante(");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(docNo);
			sbSql.append(",");
			sbSql.append(mes);
			sbSql.append(",");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("')");

		}

	} else if (docType.equalsIgnoreCase("CITAS")) {//CITAS

		if (actType.equalsIgnoreCase("7")) {//CANCELAR CITAS

			sbSql.append("update tbl_cdc_cita set estado_cita='C', usuario_cancelacion='");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("', motivo_cancelacion='");
			sbSql.append(IBIZEscapeChars.forSingleQuots(comments));
			sbSql.append("', fecha_cancelacion=sysdate where codigo=");
			sbSql.append(docId);
			sbSql.append(" and fecha_registro=to_date('");
			sbSql.append(fecha);
			sbSql.append("','dd/mm/yyyy')");

		}

	} else if (docType.equalsIgnoreCase("BATCH_PRICE")) {

		isCallableStatement = true;
		sbSql.append("{ call sp_inv_upd_pricexlote (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
		param.setSql(sbSql.toString());
		param.addInNumberStmtParam(1,(String) session.getAttribute("_companyId"));
		param.addInNumberStmtParam(2,familia);
		param.addInNumberStmtParam(3,clase);
		param.addInNumberStmtParam(4,articulo);
		param.addInNumberStmtParam(5,subclase);
		param.addInNumberStmtParam(6,porcentaje);
		param.addInNumberStmtParam(7,accion);
		param.addInNumberStmtParam(8,roundTo);
		param.addInStringStmtParam(9,basis);
		param.addInNumberStmtParam(10,precioVenta);
		param.addInNumberStmtParam(11,almacen);
		param.addInNumberStmtParam(12,anaquel);
		param.addInStringStmtParam(13,estado);			
        param.addInStringStmtParam(14,consignacion);			
        param.addInStringStmtParam(15,venta);
		param.addInStringStmtParam(16,tipoPrecio);

	} else if (docType.equalsIgnoreCase("ACTCONTEO")) {//ACTUALIZAR CONTEO FISICO

		if (actType.equalsIgnoreCase("7")) {

			sbSql.append("call sp_inv_upd_inv_fisico(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(almacen);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("',");
			sbSql.append(docId);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(mes);
			sbSql.append(")");

		} else if (actType.equalsIgnoreCase("8")) {

			sbSql.append("call sp_inv_upd_inv_fisico_lote(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(almacen);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("',");
			sbSql.append(anio);
			sbSql.append(")");

		}else if (actType.equalsIgnoreCase("9")) {

			sbSql.append("call sp_inv_upd_sin_existencia(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(almacen);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("',");
			sbSql.append(anio);
			sbSql.append(",'");
			sbSql.append(fechaNoContado);
			sbSql.append("'");
			sbSql.append(")");

		}

	}
	 else if (docType.equalsIgnoreCase("RECEP")) {

		if (actType.equalsIgnoreCase("7")) {

			sbSql.append("call sp_inv_anula_recepcion(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(docId);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("',");
			sbSql.append(almacen);
			sbSql.append(",'");
			sbSql.append(fecha);
			sbSql.append("','");
			sbSql.append(tipo);
			sbSql.append("','AN')");
		}
		xtraNotes.append("&docId=");
		xtraNotes.append(docId);
		xtraNotes.append("&anio=");
		xtraNotes.append(anio);

	}
	 else if (docType.equalsIgnoreCase("CAT")) {
			sbSql.append("call sp_con_inactiva_cta(");
			sbSql.append(compania);
			sbSql.append(",'");
			sbSql.append(docId);
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("','");
			sbSql.append(estado);
			sbSql.append("')");
	} else if (docType.equalsIgnoreCase("CONT_FISICO")) {
		if (actType.equals("1") || actType.equals("2")) {
			sbSql.append("call sp_inv_carga_pdt(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(docId);
			if (actType.equals("1"))sbSql.append(",'N','");
			if (actType.equals("2"))sbSql.append(",'Y','");
			sbSql.append((String) session.getAttribute("_userName"));
			sbSql.append("')");
		}
	}
	else if (docType.equalsIgnoreCase("LISTA_ENVIO"))
	{
		if (actType.equalsIgnoreCase("1"))
			{

			isCallableStatement = false;
			sbSql.append("call sp_fact_updt_lista (");
			sbSql.append(compania);
			sbSql.append(", ");
			sbSql.append(docId);
			sbSql.append(", '");
			sbSql.append(request.getParameter("fecha_recibo"));
			sbSql.append("', '");
			sbSql.append((String) session.getAttribute("_userName"));
			sbSql.append("', 'R')");
			} else if (actType.equalsIgnoreCase("2"))
			{

			isCallableStatement = false;
			sbSql.append("call sp_fact_updt_lista_fact (");
			sbSql.append(compania);
			sbSql.append(", ");
			sbSql.append(docId);
			sbSql.append(", '");
			sbSql.append(request.getParameter("codigo"));
			sbSql.append("', '");
			sbSql.append((String) session.getAttribute("_userName"));
			sbSql.append("', '");
			sbSql.append(IBIZEscapeChars.forSingleQuots(comments));
			sbSql.append("')");
			}
	}
	else if (docType.equalsIgnoreCase("DEVPROV"))
	{
		if (actType.equalsIgnoreCase("50")){
			sbSql.append("call sp_inv_anula_devolucion(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",");
			sbSql.append(docId);
			sbSql.append(",'");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(comments));
			sbSql.append("','");
			sbSql.append(tipo);
			sbSql.append("')");
		}
	}
	else if (docType.equalsIgnoreCase("CORRECCTA"))
	{
		if (actType.equalsIgnoreCase("50")){
			sbSql.append("call sp_con_actualiza_cuenta(");
			sbSql.append(compania);
			sbSql.append(",");
			sbSql.append(anio);
			sbSql.append(",'");
			sbSql.append(docId);
			sbSql.append("','");
			sbSql.append(IBIZEscapeChars.forSingleQuots(((String) session.getAttribute("_userName")).trim()));
			sbSql.append("','");
			sbSql.append(request.getParameter("cta1"));
			sbSql.append("','");
			sbSql.append(request.getParameter("cta2"));
			sbSql.append("','");
			sbSql.append(request.getParameter("cta3"));
			sbSql.append("','");
			sbSql.append(request.getParameter("cta4"));
			sbSql.append("','");
			sbSql.append(request.getParameter("cta5"));
			sbSql.append("','");
			sbSql.append(request.getParameter("cta6"));
			sbSql.append("')");
		}
	}
	else if (docType.equalsIgnoreCase("NUEVO_DOC_TYPE")) {

		if (actType.equalsIgnoreCase("NUEVO_ACT_TYPE")) {

			sbSql.append("QUERY");

		}

	}
    else if (docType.equalsIgnoreCase("LIQ_RECL")) {
		if (actType.equalsIgnoreCase("1")) {
			sbSql.append("update tbl_pm_liquidacion_reclamo set status = 'A', fecha_modificacion = sysdate, usuario_modificacion = '");
            sbSql.append((String)session.getAttribute("_userName"));
            sbSql.append("' where codigo in (");
			sbSql.append(docId);
			sbSql.append(") and compania = ");
            sbSql.append((String)session.getAttribute("_companyId"));
		}
	}

	System.out.println("sbSql.length()................................................="+sbSql.length());
	if (sbSql.length() > 0) {
		ConMgr.setClientIdentifier(((String) session.getAttribute("_userName")).trim()+":"+request.getRemoteAddr(),true);
		ConMgr.setAppCtx(ConMgr.AUDIT_SOURCE,request.getServletPath());
		ConMgr.setAppCtx(ConMgr.AUDIT_NOTES,"fp="+fp+"&actType="+actType+"&docType="+docType+xtraNotes.toString());
		if (isCallableStatement) {

			param = SQLMgr.executeCallable(param);
			for (int i=0; i<param.getStmtParams().size(); i++) {
				CommonDataObject.StatementParam pp = param.getStmtParam(i);

				if (pp.getType().contains("o")) {

					if (docType.equalsIgnoreCase("AFIJO") || (docType.equalsIgnoreCase("COMP") && actType.equalsIgnoreCase("53"))) {

						if (pp.getIndex() == 6) id = pp.getData().toString();

					} else if(docType.equalsIgnoreCase("PAC_PM")) {

						if (pp.getIndex() == 4) id = pp.getData().toString();
						if (pp.getIndex() == 5) rParam = pp.getData().toString();

					}

				}

			}

		} else  SQLMgr.execute(sbSql.toString());
		ConMgr.clearAppCtx(null);

	} else {

		if (docType.equalsIgnoreCase("DGI")) {

			SQLMgr.setErrCode("1");

		} else {

			SQLMgr.setErrCode("0");
			SQLMgr.setErrException("No hay proceso definido para ejecutar!");

		}

	}


	StringBuffer sbMsg = new StringBuffer();
	sbMsg.append("La acción [");
	sbMsg.append(actDesc);
	sbMsg.append("]");

	if (docType.equalsIgnoreCase("AUM") || docType.equalsIgnoreCase("MOR") || docType.equalsIgnoreCase("ACRACH") || docType.equalsIgnoreCase("FCESAN") || docType.equalsIgnoreCase("VAC") || docType.equalsIgnoreCase("CAL") || docType.equalsIgnoreCase("AUMG") || docType.equalsIgnoreCase("CUOTASIND") || docType.equalsIgnoreCase("PLA") || docType.equalsIgnoreCase("DELPLA") || docType.equalsIgnoreCase("CAPLA") || docType.equalsIgnoreCase("SOLVAC") || docType.equalsIgnoreCase("DISTLIC") || docType.equalsIgnoreCase("ANSOL") || docType.equalsIgnoreCase("UPDNOEMP") || docType.equalsIgnoreCase("LIQ") || docType.equalsIgnoreCase("GENCOMP") || docType.equalsIgnoreCase("CJA") || docType.equalsIgnoreCase("ACHEMPAC") || docType.equalsIgnoreCase("DELTRX") || docType.equalsIgnoreCase("APP_PM") || docType.equalsIgnoreCase("BATCH_PRICE")) {

		//nothing

	} else {

		if (docType.equalsIgnoreCase("FARPATIENT")) sbMsg.append(" para [");
		else sbMsg.append(" para el Documento [");

		sbMsg.append(docDesc);
		sbMsg.append("]");


		if (docType.equalsIgnoreCase("DGI") && (actType.equals("3") || actType.equals("4"))) {

		} else {

			sbMsg.append(" #");
			if (docType.equalsIgnoreCase("FARORDER") && actType.equalsIgnoreCase("51")) sbMsg.append(docId);
			else sbMsg.append(docNo);

		}

	}

	sbMsg.append(" se ejecutó correctamente!");

	if (id != null && !id.trim().equals("")) {

		if (docType.equalsIgnoreCase("AFIJO") || (docType.equalsIgnoreCase("COMP") && actType.equalsIgnoreCase("53"))) {

			sbMsg.append(" ( COMPROBANTE #");
			sbMsg.append(id);
			sbMsg.append(")");

		}

	}

	if (rParam != null && !rParam.trim().equals("")) {

		if (docType.equalsIgnoreCase("ALQ")) {

				sbMsg.append("\\n");
				sbMsg.append(rParam);

		}

	}
%>
<html>
<head>
<script language="javascript">
function closeWindow(){
<% if (SQLMgr.getErrCode().equals("1")) { %>
	<% if (docType.equalsIgnoreCase("CXC_ADJ_AUTO") && actType.equalsIgnoreCase("50")) { %>parent.printAjuste('<%=docId%>');<% } %>
	alert('<%=(sbNewMsg.length() > 0)?sbNewMsg:sbMsg%>');
<% } else throw new Exception(SQLMgr.getErrException()); %>

<% if (docType.equalsIgnoreCase("MOR") || docType.equalsIgnoreCase("FCESAN") || docType.equalsIgnoreCase("ACRACH") || docType.equalsIgnoreCase("CAPLA") || docType.equalsIgnoreCase("AUMG") || docType.equalsIgnoreCase("ACHEMPAC") || docType.equalsIgnoreCase("GENCOMP") || docType.toUpperCase().startsWith("FP_")) { %>
	<% if (docType.equalsIgnoreCase("AUMG")) { %>
		<% if (actType.equalsIgnoreCase("50")) { %>
parent.document.form_0.go.disabled=true;parent.document.form_0.gover.disabled=false;parent.document.form_0.goeli.disabled=false;parent.document.form_0.goact.disabled=false;
		<% } else if (actType.equalsIgnoreCase("52") || actType.equalsIgnoreCase("53")) { %>
			<% if (actType.equalsIgnoreCase("52")) { %>
parent.document.form_0.go.disabled=false;
			<% } else { %>
parent.document.form_0.go.disabled=true;
			<% } %>
parent.document.form_0.gover.disabled=true;parent.document.form_0.goeli.disabled=true;parent.document.form_0.goact.disabled=true;
		<% } %>
	<% } else if (docType.toUpperCase().startsWith("FP_")) { %>
		<% if (fp.equalsIgnoreCase("patient_list")) { %>parent.window.location.reload(true);<% } %>
		if(parent.reloadOwner)parent.reloadOwner();
		<% if (docType.toUpperCase().endsWith("PAC")) { %>
			<% if (actType.equalsIgnoreCase("3")) { %>if(parent.reloadApplet)parent.reloadApplet();<% } else if (actType.equalsIgnoreCase("10")) { %>var x=parent.window.frames['appletFrame'].location.pathname.split('/');if(parent.reloadApplet)if(x[x.length-1]=='capture_fingerprint_applet.jsp')parent.reloadApplet();else parent.reloadApplet('');<% } %>
		<% } %>
		<% if (!fp.equalsIgnoreCase("admision_list")) { %>if(parent.reloadOpener)parent.reloadOpener();<% } %>
	<% } %>
	parent.hidePopWin(false);
<% } else if (docType.equalsIgnoreCase("CXC_ADJ_AUTO")) { %>parent.window.location='../cxc/ajuste_automatico_config.jsp';
<% } else if (docType.equalsIgnoreCase("CORTE")) { %>parent.window.location='../facturacion/fac_corte_cuenta_manual.jsp';
<% } else if (docType.equalsIgnoreCase("COMP")) { %> /*NUEVO*/
parent.hidePopWin(false);
parent.window.opener.location='<%=request.getContextPath()%>/contabilidad/list_comidas_servidas.jsp';
parent.window.close();
<% } else if (docType.equalsIgnoreCase("DISTTRX")) { %> /*NUEVO*/
parent.hidePopWin(false);

<% if (actType.equalsIgnoreCase("50")) { %>
parent.window.opener.location='<%=request.getContextPath()%>/rhplanilla/proc_generacion_ausencia.jsp?grupo=<%=grupo%>';
<% } else if (actType.equalsIgnoreCase("51")) { %>
parent.window.opener.location='<%=request.getContextPath()%>/rhplanilla/proc_generacion_sobretiempo.jsp?';
<% } %>
parent.window.close();

<% } else if (docType.equalsIgnoreCase("DELTRX")) { %> /*NUEVO*/
parent.hidePopWin(false);

<% if (actType.equalsIgnoreCase("54")) { %>
parent.window.opener.location='<%=request.getContextPath()%>/rhplanilla/proc_generacion_ausencia.jsp?grupo=<%=grupo%>';
<% } %>
parent.window.close();

<% } else if (docType.equalsIgnoreCase("TRF")) { %>{/*parent.window.location='../facturacion/transferir_cargos_admision.jsp?fp=trans<%=fg%>&fg=<%=fg%>&pacId=<%=pacId%>&noAdmision=<%=docNo%>&admRoot=<%=admRoot%>&cedulaPasaporte=<%=idPaciente%>&pacIdDest=<%=pacIdMadre%>&noAdmisionDest=<%=admMadre%>';*/
parent.window.close();
parent.window.opener.refrescaAdm();

}
<% } else if (docType.equalsIgnoreCase("LIQ") && (actType.equalsIgnoreCase("51") || actType.equalsIgnoreCase("52"))) { %>parent.window.location='../rhplanilla/reg_liquidacionNew.jsp?fp=<%=fg%>&mode=edit&tab=<%=tab%>&fechaEgreso=<%=fecha%>&motivo=<%=motivo%>&empId=<%=empId%>&noEmpleado=<%=noEmpleado%>';
<% } else if (docType.equals("PAC_PM")) { %>parent.setPaciente(<%=id%>,<%=index%>, <%=rParam%>);
<% } else if (docType.equalsIgnoreCase("DGI") && (fp.equalsIgnoreCase("reg_analisis_fact") || fp.equalsIgnoreCase("mantenimiento_turno") || fp.equalsIgnoreCase("cierre_caja") || fp.equalsIgnoreCase("reg_analisis_fact"))) {%>parent.hidePopWin(false);
<% } else if (docType.equalsIgnoreCase("DGI") && fp.equalsIgnoreCase("nota_ajuste_otros")) {%>parent.hidePopWin(false);parent.window.close();
<% } else if (docType.equalsIgnoreCase("DGI") && fp.equalsIgnoreCase("INT_FARMACIA")){%>parent.window.frames['itemFramePrint']=null;//'../facturacion/ver_impresion_dgi.jsp?fp=docto_dgi_list&actType=2&docType=DGI&docId=<%=request.getParameter("docId")%>&docNo=request.getParameter("docId")%>&tipo=FACP';
<% } else if (docType.equalsIgnoreCase("ACTEXP")) { %>parent.window.close();
<% } else if ((docType.equalsIgnoreCase("EXP") && actType.equals("8")) || fp.equals("lista_envio")) { %>
  parent.hidePopWin(false);
  parent.window.location.reload(true);
<% } else if (docType.equalsIgnoreCase("CJA") && actType.equals("50") && touch.equalsIgnoreCase("Y")) { %>
  parent.hidePopWin(false);
  parent.window.location.reload(true);
<%} else { %>parent.window.location.reload(true);
	<% if (docType.equalsIgnoreCase("REVAJUSTE") || docType.equalsIgnoreCase("CORRAJUSTE")) { %>parent.window.opener.location.reload(true);<% } %>
<% } %>
}
</script>
</head>
<body onLoad="closeWindow()">
</body>
</html>
<%
}//POST
%>