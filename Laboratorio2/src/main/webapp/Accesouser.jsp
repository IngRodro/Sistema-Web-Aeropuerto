<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
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
<script type="text/javascript">
		$(document).ready(function() {
			$.post('ControllerMostrarVuelos', {
			}, function(response) {
				let datos = JSON.parse(response);
				
				console.log(datos);
				
				var tabla = document.getElementById('tablaDatos');
				for(let item of datos){
					tabla.innerHTML += `
					<tr>
						<td>${item.Vuelo}</td>
						<td>${item.NumeroEscala}</td>
						<td>${item.Nombre}</td>
						<td><a class="btn btn-danger" href="ControllerMostrarInformacion?usu=${item.idUsuario}&Eliminar=btne">Eliminar</a>
						<a href="add.jsp?Id=${item.idUsuario}&Usuario=${item.Usuario}&Pass=${item.Password}" class="btn btn-warning"> Actualizar</a>
						</td>
					</tr>
					`
					console.log(item.Pass);
				}
			});
		});
		</script>
	<h1>Bienvenido</h1>
	<a href="add.jsp" type="button" class="btn btn-primary">Agregar</a>
	<table class="table table-dark table-striped" id="tablaDatos">
		<thead>
			<th>Vuelo</th>
			<th>Numero Escala</th>
			<th>Aeropuerto Destino</th>
		</thead>
	</table>
</body>
</html>