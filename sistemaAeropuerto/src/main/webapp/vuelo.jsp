<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image/png" href="IMG/airplane(1).png">
<title>Vuelos - AeroLine</title>
</head>
<link rel="stylesheet" href="CSS/estilotablasvuelo.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<body>
	<script type="text/javascript">$(document).ready(function () {
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

						var tabla = document.getElementById('tablaVuelos');
						for (let item of datos) {
						if(item.estado == 1){
							tabla.innerHTML += `
								<tr>
									<td>${item.Vuelo}</td>
									<td>${item.Company}</td>
									<td>${item.AeropuertoO}</td>
									<td>${item.AeropuertoD}</td>
									<td>${item.Modelo}</td>
									<td>${item.Tipo}</td>
									<td>${item.FechaString}</td>
									<td>${item.hora}:${item.minutos}</td>
									<td>${item.Descuento}%</td>
									<td>Activo</td>
									<td>
									<button class="btntableupdate"><a class="atableupdate" href="addvuelo.jsp?Vuelo=${item.Vuelo}&Hora=${item.hora}&Minutos=${item.minutos}&Fecha=${item.FechaString}&IdAeropuertoD=${item.IdAeropuertoD}&IdAeropuertO=${item.IdAeropuertO}&IdAvion=${item.IdAvion}&IdCompany=${item.IdCompany}&IdTipo=${item.IdTipo}&Modelo=${item.Modelo}&Tipo=${item.Tipo}&estado=${item.estado}&AeropuertoD=${item.AeropuertoD}&AeropuertoO=${item.AeropuertoO}&Company=${item.Company}&Descuento=${item.Descuento}&FechaI=${item.FechaInicio}&FechaF=${item.FechaFinal}"> <i class="fas fa-edit fa-lg " style="color: black;"></i></a></button>
									<button class="btntablever"><a class="atablever" href="escala.jsp?IdVuelo=${item.Vuelo}">Ver Escalas</a>
									<button class="btntablefin"><a class="atablefin" href="ControllerVuelo?vuelo=${item.Vuelo}&Finalizar=btnf">Finalizar Vuelo</a>
									</td>
								</tr>
								`
						}else if(item.estado == 2){
								tabla.innerHTML += `
								<tr>
									<td>${item.Vuelo}</td>
									<td>${item.Company}</td>
									<td>${item.AeropuertoO}</td>
									<td>${item.AeropuertoD}</td>
									<td>${item.Modelo}</td>
									<td>${item.Tipo}</td>
									<td>${item.FechaString}</td>
									<td>${item.hora}:${item.minutos}</td>
									<td>${item.Descuento}%</td>
									<td>Retrasado</td>
									<td>
									<button class="btntableupdate"><a class="atableupdate" href="addvuelo.jsp?Vuelo=${item.Vuelo}&Hora=${item.hora}&Minutos=${item.minutos}&Fecha=${item.FechaString}&IdAeropuertoD=${item.IdAeropuertoD}&IdAeropuertO=${item.IdAeropuertO}&IdAvion=${item.IdAvion}&IdCompany=${item.IdCompany}&IdTipo=${item.IdTipo}&Modelo=${item.Modelo}&Tipo=${item.Tipo}&estado=${item.estado}&AeropuertoD=${item.AeropuertoD}&AeropuertoO=${item.AeropuertoO}&Company=${item.Company}&Descuento=${item.Descuento}&FechaI=${item.FechaInicio}&FechaF=${item.FechaFinal}"> <i class="fas fa-edit fa-lg " style="color: black;"></i></a></button>
									<button class="btntablever"><a class="atablever" href="escala.jsp?IdVuelo=${item.Vuelo}">Ver Escalas</a>
									<button class="btntablefin"><a class="atablefin" href="ControllerVuelo?vuelo=${item.Vuelo}&Finalizar=btnf">Finalizar Vuelo</a>
									</td>
								</tr>
								`
						}else if(item.estado == 3){
							tabla.innerHTML += `
								<tr>
									<td>${item.Vuelo}</td>
									<td>${item.Company}</td>
									<td>${item.AeropuertoO}</td>
									<td>${item.AeropuertoD}</td>
									<td>${item.Modelo}</td>
									<td>${item.Tipo}</td>
									<td>${item.FechaString}</td>
									<td>${item.hora}:${item.minutos}</td>
									<td>${item.Descuento}%</td>
									<td>Suspendido</td>
									<td>
									<button class="btntableupdate"><a class="atableupdate" href="addvuelo.jsp?Vuelo=${item.Vuelo}&Hora=${item.hora}&Minutos=${item.minutos}&Fecha=${item.FechaString}&IdAeropuertoD=${item.IdAeropuertoD}&IdAeropuertO=${item.IdAeropuertO}&IdAvion=${item.IdAvion}&IdCompany=${item.IdCompany}&IdTipo=${item.IdTipo}&Modelo=${item.Modelo}&Tipo=${item.Tipo}&estado=${item.estado}&AeropuertoD=${item.AeropuertoD}&AeropuertoO=${item.AeropuertoO}&Company=${item.Company}&Descuento=${item.Descuento}&FechaI=${item.FechaInicio}&FechaF=${item.FechaFinal}"> <i class="fas fa-edit fa-lg " style="color: black;"></i></a></button>
									<button class="btntablever"><a class="atablever" href="escala.jsp?IdVuelo=${item.Vuelo}">Ver Escalas</a>
									<button class="btntablefin"><a class="atablefin" href="ControllerVuelo?vuelo=${item.Vuelo}&Finalizar=btnf">Finalizar Vuelo</a>
									</td>
								</tr>
								`
							}
							
						}
					});
				});
				$(document).ready(function () {
					$("#Agregar").click(function (){
							location.href = 'http://localhost:8080/sistemaAeropuerto/addvuelo.jsp';
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
				<li><a href="#" id="Cerrar">Cerrar Sesion</a></li>
			</ul>
	</nav>
	</header>

	<div class="containertabla">
		<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
			alt="Logo avion">
		<h1 align="center">Vuelos</h1>
		<table class="tabla">
			<thead>
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
			<tbody  id="tablaVuelos">
				
			</tbody>
		</table>
		<div align="center">
			<button class="agregar" id="Agregar"><b>Agregar</b></button>
		</div>
	</div>
</body>
</html>