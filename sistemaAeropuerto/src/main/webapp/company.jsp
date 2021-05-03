<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="CSS/estilomenu.css">
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
</head>
<body>
	<script type="text/javascript">
		$(document).ready(function() {
			$.post('ControllerCompany', {
			}, function(response) {
				let datos = JSON.parse(response);
				
				console.log(response);
				
				var tabla = document.getElementById('tablaCompany');
				for(let item of datos){
					tabla.innerHTML += `
					<tr>
						<td>${item.idCompany}</td>
						<td>${item.nombre}</td>
						<td><a class="btn btn-danger" href="ControllerMostrarInformacion?usu=${item.idUsuario}&Eliminar=btne">Eliminar</a>
						<a href="add.jsp?Id=${item.idUsuario}&Usuario=${item.Usuario}&Pass=${item.Password}" class="btn btn-warning"> Actualizar</a>
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
				<li><a href="aeropuerto.jsp">Aeropuertos</a></li>
				<li class="barra">|</li>
				<li><a class="actual" href="company.jsp">Compa�ias</a></li>
				<li class="barra">|</li>
				<li><a href="#">Vuelos</a></li>
				<li class="barra">|</li>
				<li><a href="#">Usuarios</a></li>
			</ul>
		</div>
	</nav>
	<div class="containertabla">
		<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
			alt="Logo avion">
		<h1 align="center">Compa�ias</h1>
		<table class="table table-light table-striped" id="tablaCompany">
			<thead class="table-info">
				<th>ID</th>
				<th>Nombre</th>
				<th>Acciones</th>
			</thead>
		</table>
	</div>
</body>
</html>