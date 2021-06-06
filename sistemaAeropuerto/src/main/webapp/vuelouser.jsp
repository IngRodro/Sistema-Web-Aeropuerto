<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="CSS/estilostablas.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<body><script type="text/javascript">$(document).ready(function () {
		$("#Cerrar").click(function (){
			Swal.fire({
				  title: 'Cierre de Sesion',
				  text: "¿Esta seguro que desea cerrar sesion?",
				  icon: 'question',
				  showCancelButton: true,
				  confirmButtonColor: '#3085d6',
				  cancelButtonColor: '#d33',
				  confirmButtonText: 'Si',
				  cancelButtonText: 'Cancelar',
				  backdrop: `
					    rgba(0,0,123,0.4)
					    left top
					    no-repeat
					  `
				}).then((result) => {
					if (result.isConfirmed) {
						  Swal.fire({
							  title: 'Cerrando Sesion...',
							  html: 'Espere unos instantes',
							  timer: 3000,
							  showConfirmButton: false,
							  timerProgressBar: true,
							  backdrop: `
								    rgba(0,0,123,0.4)
								    left top
								    no-repeat
								  `,
							  didOpen: () => {
							    Swal.showLoading()
							  },
							}).then((result) => {
								var btncerrar = "Cerrar";
								$.post('ControllerAcceso', {
									//Enviando variable al controlador.
									btncerrar
									},
									function (response) {
								location.href = 'http://localhost:8080/sistemaAeropuerto/index.jsp';
									});
							})
						  	
					 }
			})
		})
	})
	</script>
	<%
	HttpSession sesion = (HttpSession) request.getSession();
	String usuSession = String.valueOf(sesion.getAttribute("user"));

	if (usuSession.equals(null) || usuSession.equals("null")) {

		response.sendRedirect("index.jsp");
	}
	%>
	<script type="text/javascript">
				$(document).ready(function () {
					$.post('ControllerVuelosEscalas', {
					}, function (response) {
						let datos = JSON.parse(response);

						console.log(datos);
						var tabla = document.getElementById("tablaVuelos");
						for (let item of datos) {
							if(item.FechaInicio == null){
								item.FechaInicio = "N/A"
							}
							if(item.FechaFinal == null){
								item.FechaFinal = "N/A"
							}
							
							if(item.Descuento == 0){
							tabla.innerHTML += `
								
								<tr>
									<td>${item.Vuelo}</td>
									<td>${item.AeropuertoEscala}</td>
									<td>${item.Tipo}</td>
									<td>${item.Precio}</td>
									<td>${item.FechaString}</td>
									<td>${item.hora}:${item.minutos}</td>
									<td>${item.Descuento}%</td>
									<td>${item.FechaInicio}</td>
									<td>${item.FechaFinal}</td>
									<td><a class="btn btn-success" href="addPasaje.jsp?IdVuelo=${item.Vuelo}&Descuento=${item.Descuento}&NEscala=${item.NumeroEscala}&DescuentoTipo=${item.DescuentoTipo}&Precio=${item.Precio}">Nuevo Pasaje</a></td>	
								</tr>
								`
							}else{
									tabla.innerHTML += `
										
										<tr>
											<td>${item.Vuelo}</td>
											<td>${item.AeropuertoEscala}</td>
											<td>${item.Tipo}</td>
											<td>${item.Precio}</td>
											<td>${item.FechaString}</td>
											<td>${item.hora}:${item.minutos}</td>
											<td>${item.Descuento}%</td>
											<td>${item.FechaInicio}</td>
											<td>${item.FechaFinal}</td>
											<td><a class="btn btn-success" href="addPasaje.jsp?IdVuelo=${item.Vuelo}&Descuento=${item.Descuento}&FechaInicio=${item.FechaInicioDesc}&FechaFinal=${item.FechaFinalDesc}&NEscala=${item.NumeroEscala}&DescuentoTipo=${item.DescuentoTipo}&Precio=${item.Precio}">Nuevo Pasaje</a></td>	
										</tr>
										`
										
							}
						}
					});
				});
			</script>

	<header>
		<input type="checkbox" id="btn-menu"> <label for="btn-menu"><img
			alt="" src="IMG/menu.png" height="30px" width="30px"></label>

		<nav class="menu">
			<div class="container">
				<ul>
					<li><a href="menuuser.jsp">Inicio</a></li>
					<li><a href="vuelouser.jsp">Vuelos</a></li>
					<li><a href="#" id="Cerrar">Cerrar Sesion</a></li>
				</ul>
			</div>
		</nav>
	</header>

	<div class="containertabla">
		<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
			alt="Logo avion">
		<h1 align="center">Vuelos</h1>
		<table>
			<thead>
				<th>Vuelo</th>
				<th>Aeropuerto</th>
				<th>Tipo de Vuelo</th>
				<th>Precio</th>
				<th>Fecha</th>
				<th>Hora</th>
				<th>Descuento</th>
				<th>Fecha Inicio</th>
				<th>Fecha Finalizacion</th>
				<th>Acciones</th>
			</thead>
			<tbody id="tablaVuelos">
			</tbody>
		</table>
	</div>
</body>
</html>