<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="CSS/estilomenu.css">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js&quot; integrity="
	sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
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
		<h3 align="center">
			¿Estas seguro que deseas cerrar tu sesion?
		</h3>
		<div align="center">
			<form action="ControllerAcceso" method="post">
				<button class="btn btn-danger" name="btncerrar" value="Si"><b>Si</b></button>
				<button class="btn btn-success" name="btnnocerrar" value="No"><b>No</b></button>
			</form>
		</div>
	</div>
</body>
</html>