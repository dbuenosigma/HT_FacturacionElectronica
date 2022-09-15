<%@ page errorPage="../error.jsp"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="issi.admin.CommonDataObject"%>
<%@ page import="issi.admin.FormBean"%>
<jsp:useBean id="ConMgr" scope="session" class="issi.admin.ConnectionMgr" />
<jsp:useBean id="SecMgr" scope="session" class="issi.admin.SecurityMgr" />
<jsp:useBean id="UserDet" scope="session" class="issi.admin.UserDetail" />
<jsp:useBean id="CmnMgr" scope="page" class="issi.admin.CommonMgr" />
<jsp:useBean id="SQLMgr" scope="page" class="issi.admin.SQLMgr" />
<jsp:useBean id="fb" scope="page" class="issi.admin.FormBean" />
<%
/**
================================================================================
================================================================================
**/
SecMgr.setConnection(ConMgr);
if (!SecMgr.checkLogin(session.getId())) throw new Exception("Usted est� fuera del sistema. Por favor entre al sistema con su nombre de usuario y clave!!!");
UserDet = SecMgr.getUserDetails(session.getId());
session.setAttribute("UserDet",UserDet);
issi.admin.ISSILogger.setSession(session);

CmnMgr.setConnection(ConMgr);
SQLMgr.setConnection(ConMgr);

CommonDataObject cdo = new CommonDataObject();
StringBuffer sbSql = new StringBuffer();
String id = request.getParameter("id");

String mode = request.getParameter("mode");
boolean viewMode = false;
if (mode == null) mode = "add";
if (mode.equalsIgnoreCase("view")) viewMode = true;

if (request.getMethod().equalsIgnoreCase("GET"))
{
	if (mode.equalsIgnoreCase("add"))
	{
		id = "0";
		cdo.addColValue("codigo",id);
	}
	else
	{
		if (id == null) throw new Exception("El C�digo de Caja no es v�lido. Por favor intente nuevamente!");

		sbSql.append("SELECT CODIGO, DESCRIPCION, USUARIO_CREACION as CPOR , USUARIO_MODIFICACION as MPOR, FECHA_CREACION as FC, FECHA_MODIFICACION as FM, nvl(usa, 'A') usa, codigo_fe FROM tbl_cja_forma_pago WHERE CODIGO=");
		sbSql.append(id);
		cdo = SQLMgr.getData(sbSql.toString());
	}
	System.out.println(":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
	System.out.println(mode);
	System.out.println(":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
%>
<html>
<head>
<%@ include file="../common/nocache.jsp"%>
<%@ include file="../common/header_param.jsp"%>
</head>
<body topmargin="0" leftmargin="0" rightmargin="0">
<script language="javascript">
document.title="Mantenimiento de Caja - "+document.title;
//function checkIP(obj){return duplicatedDBData('<%//=request.getContextPath()%>','<%//=mode%>',obj,'tbl_cja_cajas','ip=\''+obj.value+'\' and compania=<%//=session.getAttribute("_companyId")%>','<%//=cdo.getColValue("ip")%>');}
</script>
<jsp:include page="../common/title.jsp" flush="true">
	<jsp:param name="title" value="CAJA - MANTENIMIENTO - FORMA DE PAGO"></jsp:param>
</jsp:include>
<table align="center" width="99%" cellpadding="5" cellspacing="0">
<tr>
	<td class="TableBorder">
		<table align="center" width="100%" cellpadding="1" cellspacing="1">
<!-- ================================   F O R M   S T A R T   H E R E   ================================ -->
<%fb = new FormBean("form0",request.getContextPath()+request.getServletPath(),FormBean.POST);%>
<%=fb.formStart(true)%>
<%=fb.hidden("mode",mode)%>
<%=fb.hidden("id",id)%>
<%//fb.appendJsValidation("if(checkIP(document.form1.ip))error++;");%>
		<tr class="TextRow02">
			<td colspan="4">&nbsp;</td>
		</tr>
		<tr class="TextRow01">
			<td width="10%"><cellbytelabel>C&oacute;digo</cellbytelabel></td>
			<td width="40%"><%=fb.textBox("codigo",cdo.getColValue("CODIGO"),false,false,true,2,null,null,null)%></td>
			<td width="10%"><cellbytelabel>Descripci&oacute;n</cellbytelabel></td>
			<td width="40%"><%=fb.textBox("descripcion",cdo.getColValue("DESCRIPCION"),true,false,(viewMode||mode.equalsIgnoreCase("edit")),50)%></td>
		</tr>
		<tr class="TextRow01" >
			<td><cellbytelabel>F. Creaci�n</cellbytelabel></td>
			<td><%=fb.textBox("creado_por",cdo.getColValue("FC"),false,false,true,50)%></td>
			<td><cellbytelabel>F. Modificaci�n</cellbytelabel></td>
			<td><%=fb.textBox("modif_por",cdo.getColValue("FM"),false,false,true,50)%></td>
		</tr>
		 <tr class="TextRow01" >
			<td><cellbytelabel>Creado por</cellbytelabel>:</td>
			<td><%=fb.textBox("f_creacion",cdo.getColValue("CPOR"),false,false,true,50)%></td>
			<td><cellbytelabel>Modificado por</cellbytelabel>:</td>
			<td><%=fb.textBox("f_modif",cdo.getColValue("MPOR"),false,false,true,50)%></td>
		</tr>
		<tr class="TextRow01" >
			<td><cellbytelabel>Mostrar en:</cellbytelabel>:</td>
			<td><%=fb.select("usa","C=CAJA,P=POS,A=AMBOS,N=NINGUNA",cdo.getColValue("usa"),false,false,0,"Text10",null,null,null,"")%></td>
			<!--<td>&nbsp;</td>
			<td>&nbsp;</td>-->
			<td>C&oacute;digo Facturaci&oacute;n Electr&oacute;nica:</td>
			<td><%=fb.textBox("codigo_fe",cdo.getColValue("CODIGO_FE"),false,false,true,50)%></td>
		</tr>
	 <tr class="TextRow02">
			<td colspan="4" align="right">
				<cellbytelabel>Opciones de Guardar</cellbytelabel>:
				<%=fb.radio("saveOption","N",false,false,false)%><cellbytelabel>Crear Otro</cellbytelabel>
				<%=fb.radio("saveOption","O",true,false,false)%><cellbytelabel>Mantener Abierto</cellbytelabel>
				<%=fb.radio("saveOption","C",false,false,false)%><cellbytelabel>Cerrar</cellbytelabel>
				<%=fb.submit("save","Guardar",true,viewMode)%>
				<%=fb.button("cancel","Cancelar",true,false,null,null,"onClick=\"javascript:window.close()\"")%>
			</td>
		</tr>
<%=fb.formEnd(true)%>
<!-- ================================   F O R M   E N D   H E R E   ================================ -->
		</table>
	</td>
</tr>
</table>
<%@ include file="../common/footer.jsp"%>
</body>
</html>
<%
}//GET
else
{
	String saveOption = request.getParameter("saveOption");//N=Create New,O=Keep Open,C=Close
	cdo = new CommonDataObject();

	cdo.setTableName("tbl_cja_forma_pago");
	cdo.addColValue("DESCRIPCION",request.getParameter("descripcion"));
	cdo.addColValue("USUARIO_MODIFICACION",(String) session.getAttribute("_userName"));
    cdo.addColValue("FECHA_MODIFICACION","sysdate");
    cdo.addColValue("usa",request.getParameter("usa"));

	ConMgr.setAppCtx(ConMgr.AUDIT_SOURCE,request.getServletPath());
	if (mode.equalsIgnoreCase("add"))
	{
		cdo.setAutoIncCol("CODIGO");
		cdo.addColValue("USUARIO_CREACION",(String) session.getAttribute("_userName"));
		cdo.addColValue("FECHA_CREACION","sysdate");
		cdo.addPkColValue("CODIGO","");
		SQLMgr.insert(cdo);
		id = SQLMgr.getPkColValue("CODIGO");
		
		System.out.println("IDIDIDIDIDIIDIDIDIDIIDIDIDI:::::::::::::::"+id+"::::::::::::::::::::::::::::");
	}
	else
	{
		cdo.setWhereClause("CODIGO="+id+"");
		SQLMgr.update(cdo);
	}
	ConMgr.clearAppCtx(null);
%>
<html>
<head>
<script language="javascript" src="../js/capslock.js"></script>
<script language="javascript">
function closeWindow()
{
<% if (SQLMgr.getErrCode().equals("1")) { %>
	alert('<%=SQLMgr.getErrMsg()%>');
<% if (session.getAttribute("_urlInfo") != null && ((Hashtable) session.getAttribute("_urlInfo")).containsKey(request.getContextPath()+"/caja/forma_pago_list.jsp")) { %>
	window.opener.location='<%=(String) ((Hashtable) session.getAttribute("_urlInfo")).get(request.getContextPath()+"/caja/forma_pago_list.jsp")%>';
<% } else { %>
	window.opener.location='<%=request.getContextPath()%>/caja/forma_pago_list.jsp';
<% } if (saveOption.equalsIgnoreCase("N")) { %>
	setTimeout('addMode()',500);
<% } else if (saveOption.equalsIgnoreCase("O")) { %>
	setTimeout('editMode()',500);
<% } else if (saveOption.equalsIgnoreCase("C")) { %>
	window.close();
<% } } else throw new Exception(SQLMgr.getErrMsg()); %>
}
function addMode(){
	window.location='<%=request.getContextPath()+request.getServletPath()%>';
	}
function editMode(){
	window.location='<%=request.getContextPath()+request.getServletPath()%>?mode=edit&id=<%=id%>';
	}
</script>
</head>
<body onLoad="closeWindow()">
</body>
</html>
<%
}//POST

/*System.out.println(":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
System.out.println(""+request.getParameter("saveOption"));
System.out.println(":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
*/

%>