<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="CSS/estiloaeropuerto.css">
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
	String IdAeropuerto = request.getParameter("Vuelo");
	String Nombre = request.getParameter("Nombre");
	String Ciudad = request.getParameter("Ciudad");
	String Pais = request.getParameter("Pais");

	if (IdAeropuerto == null) {
		IdAeropuerto = "";
		Nombre = "";
		Ciudad = "";
		Pais = "";
	}
	%>

	<div class="userbox">
		<form action="ControllerAeropuertos" method="get">
			<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
				alt="Logo avion">
			<h1>Registro Aeropuerto</h1>
			<input type="hidden" name="idAeropuerto" value=<%=IdAeropuerto%>>
			<label>Nombre</label> 
			<input type="text" name="nombre" value="<%=Nombre%>"> 
			<label>Pais</label> 
			<input type="text" name="pais" value="<%=Pais%>"> 
			<label>Ciudad</label> 
			<input type="text" name="ciudad" value="<%=Ciudad%>">
				<div align="center">
			<button name="Guardar" value="btna">Guardar/Actualizar</button>
				</div>
		</form>
	</div>
</body>
</html>