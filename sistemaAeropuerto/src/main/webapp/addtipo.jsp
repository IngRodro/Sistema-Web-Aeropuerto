<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="CSS/estilotipo.css">
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	HttpSession sesion = (HttpSession) request.getSession();
	String usuSession = String.valueOf(sesion.getAttribute("usuario"));

	if (usuSession.equals(null) || usuSession.equals("null")) {

		response.sendRedirect("index.jsp");
	}
	%>
	<%
	String IdTipo = request.getParameter("Id");
	String Tipo = request.getParameter("Tipo");
	String Descuento = request.getParameter("Porcentaje");

	if (IdTipo == null) {
		IdTipo = "";
		Tipo = "";
		Descuento = "";
	}
	%>

	<div class="userbox">
		<form action="ControllerTipos" method="get">
			<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
				alt="Logo avion">
			<h1>Registro Tipos de Vuelo</h1>
			<input type="hidden" name="idTipo" value=<%=IdTipo%>>
			<label>Tipo de Vuelo</label> 
			<input type="text" name="tipo"value="<%=Tipo%>"> 
				<div align="center">
				<label>Descuento</label> 
			<input type="number" name="descuento" min="0" max="100"  step="any"  value="<%=Descuento%>"> 
				<div align="center">
			<button name="Guardar" value="btna">Guardar/Actualizar</button>
				</div>
		</form>
	</div>
</body>
</html>