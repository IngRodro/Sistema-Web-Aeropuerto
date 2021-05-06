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
	String IdAvion = request.getParameter("Id");
	String Modelo = request.getParameter("Modelo");
	String Capacidad = request.getParameter("Capacidad");

	if (IdAvion == null) {
		IdAvion = "";
		Modelo = "";
		Capacidad = "";
	}
	%>

	<div class="userbox">
		<form action="ControllerAvion" method="get">
			<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
				alt="Logo avion">
			<h1>Registro Aviones</h1>
			<input type="hidden" name="idAvion" value=<%=IdAvion%>>
			<label>Modelo</label> 
			<input type="text" name="modelo"value="<%=Modelo%>"> 
				<div align="center">
				<label>Capacidad</label> 
			<input type="number" name="capacidad" min="0" value="<%=Capacidad%>"> 
				<div align="center">
			<button name="Guardar" value="btna"><b>Guardar/Actualizar</b></button>
				</div>
		</form>
	</div>
</body>
</html>