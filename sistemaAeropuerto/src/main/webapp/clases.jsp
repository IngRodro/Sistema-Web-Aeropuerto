<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="shortcut icon" type="image/png" href="IMG/airplane(1).png">
<title>Clases - AeroLine</title>
</head>
<link rel="stylesheet" href="CSS/estilostablas.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">

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

						var tabla = document.getElementById('tablaClases');
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
										<td><a class="btn btn-danger" href="ControllerClases?IdClase=${item.idClase}&idAvion=${item.idAvion}&Eliminar=btne">Eliminar</a>
										<a href="addClase.jsp?Id=${item.idClase}&nombreClase=${item.nombreClase}&nAsientos=${item.nAsientos}&Porcentaje=${item.porcentajeEPrecio}&idAvion=<%=IdAvion%>" class="btn btn-warning"> Actualizar</a>
										</td>
									</tr>
									`
							}
							
						}
					});
				});
				$(document).ready(function () {
					$("#Agregar").click(function (){
							location.href = 'http://localhost:8080/sistemaAeropuerto/addClase.jsp?idAvion=<%=IdAvion%>';
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
				<li><a href="#" id="Cerrar" >Cerrar Sesion</a></li>
			</ul>
	</nav>
	</header>

	<div class="containertabla">
		<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
			alt="Logo avion">
		<h1 align="center">Clases</h1>
		<table>
			<thead>
				<th>ID</th>
				<th>Nombre Clase</th>
				<th>N Asientos</th>
				<th>Descuentos</th>
				<th>Acciones</th>
			</thead>
			<tbody id="tablaClases">
			</tbody>
		</table>
		<div align="center">
			<button class="agregar" id="Agregar"><b>Agregar</b></button>
		</div>
	</div>
</body>
</html>