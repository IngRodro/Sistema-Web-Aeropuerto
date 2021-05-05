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
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js&quot"
	; integrity="
	sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
	crossorigin="anonymous"></script>
<body>
	<%
	HttpSession sesion = (HttpSession) request.getSession();
	String usuSession = String.valueOf(sesion.getAttribute("usuario"));

	if (usuSession.equals(null) || usuSession.equals("null")) {

		response.sendRedirect("index.jsp");
	}
	%>
	<script type="text/javascript">
				$(document).ready(function () {
					$.post('ControllerVuelo', {
					}, function (response) {
						let datos = JSON.parse(response);

						console.log(datos);

						var tabla = document.getElementById('tablaAeropuertos');
						for (let item of datos) {
							tabla.innerHTML += `
							
					<tr>
						<td>${item.Vuelo}</td>
						<td>${item.Company}</td>
						<td>${item.AeropuertoO}</td>
						<td>${item.AeropuertoD}</td>
						<td>${item.Modelo}</td>
						<td>${item.Tipo}</td>
						<td>${item.Fecha}</td>
						<td>${item.hora}:${item.minutos}</td>
						<td>${item.Descuento}%</td>
						<td>${item.estado}</td>
						<td>
						<a href="addvuelo.jsp?Vuelo=${item.Vuelo}&Hora=${item.hora}&Minutos=${item.minutos}&Fecha=${item.Fecha}" class="btn btn-warning"> Actualizar</a>
						</td>
					</tr>
					`
						}
					});
				});
			</script>

	<nav class="menu">
		<div class="container">
			<ul>
				<li><a href="menu.jsp">Inicio</a></li>
				<li class="barra">|</li>
				<li><a href="aeropuerto.jsp">Aeropuertos</a></li>
				<li class="barra">|</li>
				<li><a href="company.jsp">Compañias</a></li>
				<li class="barra">|</li>
				<li><a href="avion.jsp">Aviones</a></li>
				<li class="barra">|</li>
				<li><a href="tipos.jsp">Tipos de Vuelo</a></li>
				<li class="barra">|</li>
				<li><a href="vuelo.jsp">Vuelos</a></li>
				<li class="barra">|</li>
				<li><a href="cerrar.jsp">Cerrar Sesion</a></li>
			</ul>
		</div>
	</nav>

	<div class="containertabla">
		<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
			alt="Logo avion">
		<h1 align="center">Aeropuertos</h1>
		<table class="table table-light table-striped" id="tablaAeropuertos">
			<thead class="table-info">
				<th>Vuelo</th>
				<th>Compañia</th>
				<th>Aeropuerto Origen</th>
				<th>Aeropuerto Destino</th>
				<th>Modelo</th>
				<th>Tipo de Vuelo</th>
				<th>Fecha</th>
				<th>Hora</th>
				<th>Descuento</th>
				<th>Estado</th>
				<th>Acciones</th>
			</thead>
		</table>
		<div align="center">
			<a href="addvuelo.jsp" type="button" class="btn btn-primary">Agregar</a>
		</div>
	</div>
</body>
</html>