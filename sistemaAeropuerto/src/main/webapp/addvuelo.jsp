<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="CSS/estilovuelo.css">
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
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
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
					$.post('ControllerCompany', {
					}, function (response) {
						let datos = JSON.parse(response);

						console.log(datos);

						var combo = document.getElementById('cmbcompany');
						for (let item of datos) {
							combo.innerHTML += `
								<option value="${item.idCompany}">${item.nombre}</option>
					`
						}
					});
				});
				
				$(document).ready(function () {
					$.post('ControllerAvion', {
					}, function (response) {
						let datos = JSON.parse(response);

						console.log(datos);

						var combo = document.getElementById('cmbavion');
						for (let item of datos) {
							combo.innerHTML += `
								<option value="${item.idAvion}">${item.modeloAvion}</option>
					`
						}
					});
				});
				
				$(document).ready(function () {
					$.post('ControllerTipos', {
					}, function (response) {
						let datos = JSON.parse(response);

						console.log(datos);

						var combo = document.getElementById('cmbTipo');
						for (let item of datos) {
							combo.innerHTML += `
								<option value="${item.idTipos_vuelo}">${item.Tipo}</option>
					`
						}
					});
				});
				
				$(document).ready(function () {
					$.post('ControllerAeropuertos', {
					}, function (response) {
						let datos = JSON.parse(response);

						console.log(datos);
						
						var comboO = document.getElementById('cmbAeropuertoO')
						var comboD = document.getElementById('cmbAeropuertoD');
						for (let item of datos) {
							comboO.innerHTML += `
								<option value="${item.idAeropuerto}">${item.nombre}</option>
					`
								comboD.innerHTML += `
									<option value="${item.idAeropuerto}">${item.nombre}</option>
						`
						}
					});
				});
			</script>

<%
	String Vuelo = request.getParameter("Vuelo");
	String Fecha = request.getParameter("Fecha");
	String Hora = request.getParameter("Hora");
	String Minutos = request.getParameter("Minutos");
	String Descuento = request.getParameter("Descuento");
	String FechaI = request.getParameter("FechaI");
	String FechaF = request.getParameter("FechaF");
	

	if (Vuelo == null) {
		Vuelo = "";
		Fecha = "";
		Hora = "";
		Minutos = "";
	}
	%>

	<div class="userbox">
		<form action="ControllerVuelo" method="get">
			<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
				alt="Logo avion">
			<h1>Registro Vuelo</h1>
			<input type="hidden" name="vuelo" value=<%=Vuelo%>>
			<label>Fecha Vuelo</label> 
			<input type="date" name="fecha" value="<%=Fecha%>">
			<label>Hora</label> 
			<input type="number"name="hora" value="<%=Hora%>">
			<label>Minutos</label> 
			<input type="number" name="minutos" value="<%=Minutos%>" required>
			<select class="form-select form-select-lg mb-3" name="selectcompany" id="cmbcompany" required>
			<option value>Compañias</option>
			</select>
			<select class="form-select form-select-lg mb-3" name="selectAvion" id="cmbavion" required>
			<option value>Aviones</option>
			</select>
				<select class="form-select form-select-lg mb-3" name="seletTipos" id="cmbTipo" required>
			<option value>Tipos de Vuelo</option>
			</select>
				<select class="form-select form-select-lg mb-3" name="selectAeropuertoO" id="cmbAeropuertoO" required>
			<option value>Aeropuerto Origen</option>
			</select>
				<select class="form-select form-select-lg mb-3" name="selectAeropuertoD" id="cmbAeropuertoD" required>
			<option value>Aeropuerto Destino</option>
			</select>
			<label>Fecha Inicio</label> 
			<input type="date" name="fechaI" value="<%=FechaI%>">
			<label>Fecha Final</label> 
			<input type="date" name="fechaF" value="<%=FechaF%>">
			<label>Descuento</label> 
			<input type="number"name="descuento" value="<%=Descuento%>">
				<div align="center">
			<button name="Guardar" value="btna"><b>Guardar/Actualizar</b></button>
				</div>
		</form>
	</div>
</body>
</html>