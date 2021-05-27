<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function SoloNumeros(evt){
	if(window.event){
		keynum = evt.keyCode;
	}else{
		keynum = evt.which;
	}
	
	if((keynum > 47 && keynum < 58) || keynum == 46 || keynum == 8 || keynum == 13){
		return true;
	}else{
		alert("No se permiten ingresar Letras...");
		return false;
	}
}
</script>
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
	String IdAeropuertoD = request.getParameter("IdAeropuertoD");
	String IdAeropuertoO = request.getParameter("IdAeropuertO");
	String IdAvion = request.getParameter("IdAvion");
	String IdCompany = request.getParameter("IdCompany");
	String IdTipo = request.getParameter("IdTipo");
	String Modelo = request.getParameter("Modelo");
	String Tipo = request.getParameter("Tipo");
	String estado = request.getParameter("estado");
	String AeropuertoD = request.getParameter("AeropuertoD");
	String AeropuertoO = request.getParameter("AeropuertoO");
	String Company = request.getParameter("Company");
	
	String FechaI = request.getParameter("FechaI");
	String FechaF = request.getParameter("FechaF");
	
	SimpleDateFormat formatodeFecha = new SimpleDateFormat("yyyy-MM-dd");
	
	Date FechaDate = null;
	Date FechaIDate = null;
	Date FechaFDate = null;
	try {
		FechaDate = formatodeFecha.parse(Fecha);
	} catch (Exception e) {
		// TODO: handle exception
	}
	//String FechaString = formatodeFecha.format(FechaDate);
	
	if (Vuelo == null) {
		Vuelo = "";
		Fecha = "";
		Hora = "00";
		Minutos = "00";
		Descuento = "0";
		IdAeropuertoD =  "";
		IdAeropuertoO =  "";
		IdAvion =  "";
		IdCompany =  "";;
		IdTipo =  "";
		Modelo =  "Modelos de Avion";
		Tipo =  "Tipos de Vuelos";
		estado = "";
		AeropuertoD =  "Aeropuerto Destino";
		AeropuertoO =  "Aeropuerto Origen";
		Company =  "Compañias";
	}
	%>

	<div class="userbox">
		<form action="ControllerVuelo" method="get">
			<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
				alt="Logo avion">
			<h1>Registro Vuelo</h1>
			<input type="hidden" name="vuelo" value="<%=Vuelo%>">
			<input type="hidden" name="estado" value="<%=estado%>">
			<label>Fecha Vuelo</label> 
			<input type="date" name="fecha" value="<%=Fecha%>" onkeypress="return SoloNumeros(event);" required>
			<label>Hora</label> 
			<input type="number"name="hora" value="<%=Hora%>" onkeypress="return SoloNumeros(event);" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off required min="0" max="23">
			<label>Minutos</label> 
			<input type="number" name="minutos" value="<%=Minutos%>" onkeypress="return SoloNumeros(event);" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off required min="0" max="59">
			<select class="form-select form-select-lg mb-3" name="selectcompany" id="cmbcompany" required>
			<option value="<%=IdCompany %>"><%=Company %></option>
			</select>
			<select class="form-select form-select-lg mb-3" name="selectAvion" id="cmbavion" required>
			<option value="<%=IdAvion %>"><%=Modelo %></option>
			</select>
			<select class="form-select form-select-lg mb-3" name="seletTipos" id="cmbTipo" required>
			<option value="<%=IdTipo %>"><%=Tipo %></option>
			</select>
			<select class="form-select form-select-lg mb-3" name="selectAeropuertoO" id="cmbAeropuertoO" required>
			<option value="<%=IdAeropuertoO %>"><%=AeropuertoO %></option>
			</select>
			<select class="form-select form-select-lg mb-3" name="selectAeropuertoD" id="cmbAeropuertoD" required>
			<option value="<%=IdAeropuertoD %>"><%=AeropuertoD %></option>
			</select>
			<label>Fecha Inicio</label> 
			<input type="date" name="fechaI" value="<%=FechaI%>" onkeypress="return SoloNumeros(event);" >
			<label>Fecha Final</label> 
			<input type="date" name="fechaF" value="<%=FechaF%>" onkeypress="return SoloNumeros(event);" >
			<label>Descuento</label> 
			<input type="number"name="descuento" value="<%=Descuento%>" onkeypress="return SoloNumeros(event);" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off required min="0" max="100">
				<div align="center">
			<button name="Guardar" value="btna"><b>Guardar/Actualizar</b></button>
				</div>
		</form>
	</div>
</body>
</html>