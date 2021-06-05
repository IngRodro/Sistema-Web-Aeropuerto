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
String IdAvion = request.getParameter("IdAvion");
%>
<script type="text/javascript">
				$(document).ready(function () {
					
					var IdAvion = <%=IdAvion%>
					$.post('ControllerClases', {
						IdAvion
					}, function (response) {
						let datos = JSON.parse(response);

						console.log(datos);

						var tabla = document.getElementById('tablaAviones');
						for (let item of datos) {
							if(item.estado == 0){
								tabla.innerHTML += `
									<tr>
										<td>${item.idClase}</td>
										<td>${item.nombreClase}</td>
										<td>${item.nAsientos}</td>
										<td>${item.porcentajeEPrecio}%</td>
										<td>Opciones no disponibles</td>
									</tr>
									`
							}else{
								tabla.innerHTML += `
									<tr>
										<td>${item.idClase}</td>
										<td>${item.nombreClase}</td>
										<td>${item.nAsientos}</td>
										<td>${item.porcentajeEPrecio}%</td>
										<td><a class="btn btn-danger" href="ControllerClases?IdClase=${item.idClase}&Eliminar=btne">Eliminar</a>
										<a href="addClase.jsp?Id=${item.idClase}&nombreClase=${item.nombreClase}&nAsientos=${item.nAsientos}&Porcentaje=${item.porcentajeEPrecio}&idAvion=<%=IdAvion%>" class="btn btn-warning"> Actualizar</a>
										</td>
									</tr>
									`
							}
							
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
				<th>ID</th>
				<th>Nombre Clase</th>
				<th>N Asientos</th>
				<th>Descuentos</th>
				<th>Acciones</th>
			</thead>
			<tbody id="tablaAviones">

			</tbody>
		</table>
		<div align="center">
			<a href="addClase.jsp?idAvion=<%=IdAvion%>" type="button" class="btn btn-primary"><b>Agregar</b></a>
		</div>
	</div>
</body>
</html>