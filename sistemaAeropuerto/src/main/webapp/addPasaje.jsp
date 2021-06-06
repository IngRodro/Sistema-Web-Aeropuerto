<%@page import="com.sistemaAeropuerto.DAO.ClsVuelo"%>
<%@page import="com.sistemaAeropuerto.Entidades.Vuelo"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="CSS/estilopasaje.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script>
function SoloNumerosGuion(evt){
	if(window.event){
		keynum = evt.keyCode;
	}else{
		keynum = evt.which;
	}
	
	if((keynum > 47 && keynum < 58) || keynum == 45 || keynum == 8 || keynum == 13){
		return true;
	}else{
		Swal.fire({
			  icon: 'error',
			  title: 'Oops...',
			  text: 'No se permite ingresar Letras...',
			  confirmButtonText: 'Aceptar',
			  confirmButtonColor: '#ff2600',
			  showCloseButton: true
			})
		return false;
	}
}

</script>
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
				$("#Cerrar").click(function (){
					location.href = 'http://localhost:8080/sistemaAeropuerto/vuelouser.jsp';
				});
			});
	
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
						//Recogiendo el value
						var NumeroDUI = $("#DUI").val();
						console.log(NumeroDUI);
						
						
						
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
				
				$(document).ready(function () {
					$("#guardar").click(function (){
						var NEscala = $("#nEscala").val();
						var NDUI = $("#DUI").val();
						var NumeroDUI = $("#DUI").val();
						var Vuelo = $("#vuelo").val();
						var selectAsiento = $("#cmbAsientos").val();
						var Precio = $("#PrecioTotal").val();
						var selectclases = $("#cmbclases").val();
						
						
				if(NDUI == null || NDUI == "" || selectAsiento == "" || Precio == null ||
						Precio == "" || selectclases == "" || selectclases == null ||
						selectAsiento == null || NEscala == null || NEscala == "" || Vuelo == ""
						|| Vuelo == null){
							
							Swal.fire({
								  icon: 'error',
								  title: 'Oops...',
								  text: 'Complete todos los campos para continuar...',
								  confirmButtonText: 'Aceptar',
								  confirmButtonColor: '#ff2600',
								  showCloseButton: true
								}).then((result) => {
								})
							
						}else{
							
							$.post('ControllerPasajero', {
								//Enviando variable al controlador.
								NumeroDUI
							}, function (response) {
								
								let datos = JSON.parse(response);
								console.log(datos);

								if(datos == null){
									Swal.fire({
										  title: 'Pasajero no encontrado',
										  text: "¿Desea registrar Nuevo Pasajero?",
										  icon: 'warning',
										  showCancelButton: true,
										  confirmButtonColor: '#3085d6',
										  cancelButtonColor: '#d33',
										  confirmButtonText: 'Si',
										  cancelButtonText: 'Cancelar'
										}).then((result) => {
											if (result.isConfirmed) {
												location.href = 'http://localhost:8080/sistemaAeropuerto/addPasajero.jsp?Documento=' + NumeroDUI;
											}else{
												var Documento = document.getElementById('DUI');
												Documento.value = "";
											}
									})
							}else{
								$.get('ControllerPasaje', {
									//Enviando variable al controlador.
									NEscala, NDUI, Vuelo, selectAsiento, Precio, selectclases
								}, function (response) {
									let datos = JSON.parse(response);
									console.log(datos);
									
									if(datos == "Agregado"){
										Swal.fire({
											  icon: 'success',
											  title: 'Pasaje Registrado...',
											  showConfirmButton: false,
											  timer: 2000
											}).then(() => {
												location.href = 'http://localhost:8080/sistemaAeropuerto/vuelouser.jsp';
											})
										};
									
									})
							}
					});
							
							
				}
		});
	});
	</script>
	<div class="userbox">
			<button id="Cerrar" class="Cerrar"><i class="far fa-window-close"></i></button>
			<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
				alt="Logo avion">
			<h1>Registro Pasaje</h1>
			<label>Vuelo</label>
			<input type="text" value="<%=Vuelo%>" name="Vuelo" id="vuelo" readonly>
			<label>Escala</label> 
			<input type="text" value="<%=NEscala%>" name="NEscala" id="nEscala" readonly> 
			<label>Documento de Identidad</label> 
			<input type="text" id="DUI" name="NDUI" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloNumerosGuion(event);" required> 
			<select class="form-select form-select-lg mb-3" name="selectclases" id="cmbclases" required>
				<option value="">Seleccione una clase</option>
			</select> 
				<select class="form-select form-select-lg mb-3" name="selectAsiento"
				id="cmbAsientos" required>
				<option value="">Seleccione su Numero de Asiento</option>
			</select> 
			<label>Precio Final</label> 
			<input type="text" value="<%=PrecioTotal%>" id="PrecioTotal" name="Precio" readonly>
			
			<div align="center">
				<button name="Guardar" id="guardar" class="Confirmar" value="btna"><b>Guardar</b></button>
			</div>
	</div>
</body>
</html>