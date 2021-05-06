<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="CSS/estilomenu.css">
<head>
<meta charset="UTF-8">
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
	<nav class="menu">
		<div class="container">
			<ul>
				<li><a href="menu.jsp"><b>Inicio</b></a></li>
				<li class="barra">|</li>
				<li><a href="aeropuerto.jsp"><b>Aeropuertos</b></a></li>
				<li class="barra">|</li>
				<li><a href="company.jsp"><b>Compañias</b></a></li>
				<li class="barra">|</li>
				<li><a href="#"><b>Aviones</b></a></li>
				<li class="barra">|</li>
				<li><a href="tipo.jsp"><b>Tipos de Vuelo</b></a></li>
				<li class="barra">|</li>
				<li><a href="vuelo.jsp"><b>Vuelos</b></a></li>
				<li class="barra">|</li>
				<li><a href="cerrar.jsp"><b>Cerrar Sesion</b></a></li>
			</ul>
		</div>
	</nav>

	<div class="containertabla">
		<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
			alt="Logo avion">
		<h1 align="center">
			Bienvenido
		<%
		out.print(sesion.getAttribute("usuario"));
		%>
		</h1>
	</div>
</body>
</html>