<%@page import="com.sistemaAeropuerto.DAO.ClsVuelo"%>
<%@page import="com.sistemaAeropuerto.Entidades.Vuelo"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="CSS/estilopasaje.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	HttpSession sesion = (HttpSession) request.getSession();
	String usuSession = String.valueOf(sesion.getAttribute("user"));

	if (usuSession.equals(null) || usuSession.equals("null")) {

		response.sendRedirect("index.jsp");
	}
	%>
	<%
	String Vuelo = request.getParameter("IdVuelo");
	String Descuento = request.getParameter("Descuento");
	String NEscala = request.getParameter("NEscala");
	String DescuentoTipo = request.getParameter("DescuentoTipo");
	String Precio = request.getParameter("Precio");

	Vuelo vuelo = new Vuelo();
	ClsVuelo clsvuelo = new ClsVuelo();
	vuelo = clsvuelo.SeleccionarVuelo(Integer.parseInt(Vuelo));
	int idAvion = vuelo.getIdAvion();

	Double PorcentajeTotalDescuento = (((Double.parseDouble(Descuento) + Double.parseDouble(DescuentoTipo)) / 100));
	Double DoublePrecio = Double.parseDouble(Precio);
	Double PrecioTotal = DoublePrecio - DoublePrecio * PorcentajeTotalDescuento;
	%>

	<script type="text/javascript">
				$(document).ready(function () {
					var IdAvion = <%=idAvion%>
					$.post('ControllerClases', {
						IdAvion
					}, function (response) {
						let datos = JSON.parse(response);

						console.log(datos);

						var combo = document.getElementById('cmbclases');
						for (let item of datos) {
							combo.innerHTML += `
								<option value="${item.idClase}">${item.nombreClase}</option>
					`
						}
					});
				});
		
				$(document).ready(function () {
					$("#cmbclases").change(function (){
						var Precio = <%=DoublePrecio%>
						var PorcentajeTotalDescuento = <%=PorcentajeTotalDescuento%>
						//Recogiendo el value del combo
						var comboID = $("#cmbclases").val();
						console.log(comboID);
						
						
						$.post('ControllerClases', {
							//Enviando variable al controlador.
							comboID, Precio, PorcentajeTotalDescuento
						}, function (response) {
							
							let datos = JSON.parse(response);
							console.log(datos);

							var precio = document.getElementById('PrecioTotal');
							precio.value = datos;
				});
			});
		});
				
				$(document).ready(function () {
					$("#DUI").blur(function (){
						//Recogiendo el value del INM
						var NumeroDUI = $("#DUI").val();
						console.log(NumeroDUI);
						
						
						$.post('ControllerPasajero', {
							//Enviando variable al controlador.
							NumeroDUI
						}, function (response) {
							
							let datos = JSON.parse(response);
							console.log(datos);

							if(datos == null){
								location.href = 'http://localhost:8080/sistemaAeropuerto/addPasajero.jsp?Acceso=2';
							}
				});
			});
		});
				
				$(document).ready(function () {
					$("#cmbclases").change(function (){
					var Vuelo = <%=Vuelo%>
					var comboID = $("#cmbclases").val();
					$.post('ControllerAsientos', {
						Vuelo, comboID
					}, function (response) {
						let datos = JSON.parse(response);

						console.log(datos);

						var combo = document.getElementById('cmbAsientos');
						for (let i = combo.length; i >= 0; i--) {
							combo.remove(i);
						  }
						for (let item of datos) {
							combo.innerHTML += `
								<option value="${item}">${item}</option>
					`
						}
					});
				})
			});
	</script>
	<div class="userbox">
		<form action="ControllerPasaje" method="get">
			<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
				alt="Logo avion">
			<h1>Registro Pasaje</h1>
			<label>Vuelo</label> 
			<input type="text" value="<%=Vuelo%>" name="Vuelo" readonly>
			<label>Escala</label> 
			<input type="text" value="<%=NEscala%>" name="NEscala" readonly> 
			<label>Documento de Identidad</label> 
			<input type="text" id="DUI" name="NDUI" required> 
			<select class="form-select form-select-lg mb-3" name="selectclases" id="cmbclases" required>
				<option value=>Seleccione una clase</option>
			</select> 
				<select class="form-select form-select-lg mb-3" name="selectAsiento"
				id="cmbAsientos" required>
				<option value=>Seleccione su Numero de Asiento</option>
			</select> 
			<label>Precio Final</label> 
			<input type="text" value="<%=PrecioTotal%>" id="PrecioTotal" name="Precio" readonly>
			
			<div align="center">
				<button name="Guardar" value="btna"><b>Guardar</b></button>
			</div>
		</form>
	</div>
</body>
</html>