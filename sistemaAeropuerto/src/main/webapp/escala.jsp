<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="CSS/estilostablas.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<body>

<%
HttpSession sesion = (HttpSession) request.getSession();
String usuSession = String.valueOf(sesion.getAttribute("usuario"));

if (usuSession.equals(null) || usuSession.equals("null")) {

	response.sendRedirect("index.jsp");
}
%>
	
<%
String IdVuelo = request.getParameter("IdVuelo");
%>
<script type="text/javascript">
				$(document).ready(function () {
					
					var IdVuelo = <%=IdVuelo%>
					$.post('ControllerEscala', {
						IdVuelo
					}, function (response) {
						let datos = JSON.parse(response);

						console.log(datos);

						var tabla = document.getElementById('tablaAviones');
						for (let item of datos) {
							tabla.innerHTML += `
					<tr>
						<td>${item.idEscala}</td>
						<td>${item.numeroEscala}</td>
						<td>$${item.Precio}</td>
						<td>${item.nombre}</td>
						<td><a class="btn btn-danger" href="ControllerEscala?IdEscala=${item.idEscala}&numeroEscala=${item.numeroEscala}&idVuelo=<%=IdVuelo%>&Eliminar=btne">Eliminar</a>
						<a href="addescala.jsp?Id=${item.idEscala}&Precio=${item.Precio}&nombre=${item.nombre}&IdAeropuerto=${item.idAeropuerto}&numeroEscala=${item.numeroEscala}&IdVuelo=<%=IdVuelo %>" class="btn btn-warning"> Actualizar</a>
						</td>
					</tr>
					`
						}
					});
				});
			</script>

<header>
	<input type="checkbox" id="btn-menu">
	<label for="btn-menu"><img alt="" src="IMG/menu.png" height="30px" width="30px"></label>
		
		<nav class="menu">
			<ul>
				<li><a href="menu.jsp">Inicio</a></li>
				<li><a href="aeropuerto.jsp">Aeropuertos</a></li>
				<li><a href="company.jsp">Compañias</a></li>
				<li><a href="avion.jsp">Aviones</a></li>
				<li><a href="tipos.jsp">Tipos de Vuelo</a></li>
				<li><a href="vuelo.jsp">Vuelos</a></li>
				<li><a href="cerrar.jsp">Cerrar Sesion</a></li>
			</ul>
	</nav>
	</header>

	<div class="containertabla">
		<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
			alt="Logo avion">
		<h1 align="center">Aviones</h1>
		<table>
			<thead>
				<th>Id Escala</th>
				<th>N Escala</th>
				<th>Precio</th>
				<th>Aeropuerto</th>
				<th>Acciones</th>
			</thead>
			<tbody id="tablaAviones">

			</tbody>
		</table>
		<div align="center">
			<a href="addescala.jsp?IdVuelo=<%=IdVuelo %>" type="button" class="btn btn-primary"><b>Agregar</b></a>
		</div>
	</div>
</body>
</html>