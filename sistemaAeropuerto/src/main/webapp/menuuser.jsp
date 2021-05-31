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
	String usuSession = String.valueOf(sesion.getAttribute("user"));

	if (usuSession.equals(null) || usuSession.equals("null")) {

		response.sendRedirect("index.jsp");
	}
	%>

	<header>
		<input type="checkbox" id="btn-menu"> <label for="btn-menu"><img
			alt="" src="IMG/menu.png" height="30px" width="30px"></label>

		<nav class="menu">
			<div class="container">
				<ul>
					<li><a href="menuuser.jsp">Inicio</a></li>
					<li><a href="vuelouser.jsp">Vuelos</a></li>
					<li><a href="cerrar.jsp">Cerrar Sesion</a></li>
				</ul>
			</div>
		</nav>
	</header>
	<div class="containertabla">
		<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
			alt="Logo avion">
		<h1 align="center">
			Bienvenido
			<%
		out.print(sesion.getAttribute("user"));
		%>
		</h1>
	</div>
</body>
</html>