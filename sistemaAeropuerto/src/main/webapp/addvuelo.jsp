<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link rel="shortcut icon" type="image/png" href="IMG/airplane(1).png">
<link rel="stylesheet" href="CSS/estilovuelo.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<head>
<meta charset="UTF-8">
<title>Registrar Vuelo - AeroLine</title>
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
		Swal.fire({
			icon: 'error',
			  title: 'Oops...',
			  text: 'No se permiten ingresar Letras...',
			  confirmButtonText: 'Aceptar',
			  confirmButtonColor: '#ff2600',
			  showCloseButton: true
			})
		return false;
	}
}

</script>
</head>
<body onload="verificarUpdate()">
<%
	HttpSession sesion = (HttpSession) request.getSession();
	String usuSession = String.valueOf(sesion.getAttribute("usuario"));

	if (usuSession.equals(null) || usuSession.equals("null")) {

		response.sendRedirect("index.jsp");
	}
%>

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
	
	String FechaMaxInicio = ""; 
	String FechaMaxFinal = "";
	String FechaMinFinal = ""; 

   	if(Fecha != null){
   		FechaMaxInicio = Fecha;
   		FechaMaxFinal = Fecha;
   	}
   	if(FechaI != null){
   		FechaMinFinal = FechaI; 
   	}
   	if(FechaF != null){
   		FechaMaxInicio = FechaF;
   	}
	
	
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
		FechaI = "";
		FechaF = "";
	}
	%>
<script type="text/javascript">
	$(document).ready(function () {
		$("#Cerrar").click(function (){
				location.href = 'http://localhost:8080/sistemaAeropuerto/vuelo.jsp';
	
		});
	});

	//Verificar Descuento Funcion
	function verificarUpdate(){ 
	   	if (<%=Descuento%> == 0){
			var FechaI = document.getElementById('FechaI')
			FechaI.disabled = true;
			var FechaF = document.getElementById('FechaF')
			FechaF.disabled = true;
	   	}else{
	   		var FechaI = document.getElementById('FechaI')
			FechaI.disabled = false;
			var FechaF = document.getElementById('FechaF')
			FechaF.disabled = false;
	   	}
	} 
			
			//Funcion Cargar Combobox Company
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
				
			//Funcion Cargar Combobox Avion
				$(document).ready(function () {
					$.post('ControllerAvion', {
					}, function (response) {
						let datos = JSON.parse(response);

						console.log(datos);

						var combo = document.getElementById('cmbavion');
						for (let item of datos) {
							if(item.estado == "Activo"){
								combo.innerHTML += `
									<option value="${item.idAvion}">${item.modeloAvion}</option>
									`
							}
						}
					});
				});
				
			//Funcion Cargar Tipo de Vuelo
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
			
				//Funcion Cargar Combobox Aeropuertos
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
				
		//FuncionFechaMaxDependiendo de la Fecha de Vuelo
				$(document).ready(function () {
					$("#Fecha").change(function (){
						//Recogiendo el value del combo
						var Fecha = $("#Fecha").val();
						var FechaI = document.getElementById('FechaI')
						var FechaF = document.getElementById('FechaF')
						FechaI.setAttribute("max", Fecha);
						FechaF.setAttribute("max", Fecha);
						
			});
		});		
				
		//FechaMin
				$(document).ready(function () {
					$("#FechaI").change(function (){
						//Recogiendo el value del combo
						var FechaI = $("#FechaI").val();
						var FechaF = document.getElementById('FechaF')
						FechaF.setAttribute("min", FechaI);
						
			});
		});
				
		//FechaMax Dependiendo de la Fecha Final de Descuento
				$(document).ready(function () {
					$("#FechaF").change(function (){
						//Recogiendo el value del combo
						var FechaF = $("#FechaF").val();
						var FechaI = document.getElementById('FechaI')
						FechaI.setAttribute("max", FechaF);
						
			});
		});		
				
		//FuncionValidarDescuento y Activar Inputs Fecha
				$(document).ready(function () {
					$("#Descuento").blur(function (){
						//Recogiendo el value del combo
						var Descuento = $("#Descuento").val();
						console.log(Descuento);
						if(Descuento > 99 || Descuento < 0 ){
							Swal.fire({
								  icon: 'error',
								  title: 'Oops...',
								  text: 'El Descuento no puede ser menor a 0% o mayor a 99%...',
								  confirmButtonText: 'Aceptar',
								  confirmButtonColor: '#ff2600',
								  showCloseButton: true
								}).then(() => {
									var descuento = document.getElementById('Descuento');
									descuento.value = "0";
									var FechaI = document.getElementById('FechaI')
									FechaI.disabled = true;
									var FechaF = document.getElementById('FechaF')
									FechaF.disabled = true;
							})
						}else if(Descuento > 0){
							var FechaI = document.getElementById('FechaI')
							FechaI.disabled = false;
							var FechaF = document.getElementById('FechaF')
							FechaF.disabled = false;
						}else{
							var FechaI = document.getElementById('FechaI')
							FechaI.disabled = true;
							var FechaF = document.getElementById('FechaF')
							FechaF.disabled = true;
						}
						
			});
		});	
				
				
		//FuncionGuardar
				$(document).ready(function () {
					$("#guardar").click(function (){
						var vuelo = $("#Vuelo").val();
						var fecha  = $("#Fecha").val();
						var hora = $("#Hora").val();
						var minutos = $("#Minutos").val();
						var selectcompany = $("#cmbcompany").val();
						var selectAvion = $("#cmbavion").val();
						var seletTipos = $("#cmbTipo").val();
						var selectAeropuertoO = $("#cmbAeropuertoO").val();
						var selectAeropuertoD = $("#cmbAeropuertoD").val();
						var descuento = $("#Descuento").val();
						var fechaI = $("#FechaI").val();
						var fechaF = $("#FechaF").val();
						var Guardar = $("#guardar").val();
						
						if(selectAeropuertoO == selectAeropuertoD){
							Swal.fire({
								  icon: 'error',
								  title: 'Oops...',
								  text: 'El Aeropuerto de Origen y de Destino no pueden ser el mismo...',
								  confirmButtonText: 'Aceptar',
								  confirmButtonColor: '#ff2600',
								  showCloseButton: true
								})
						}else{
							if(fecha == null || hora == null || hora == "" || minutos == null 
									|| minutos == "" || selectcompany == null  || selectcompany == "" 
									|| selectAvion == null || selectAvion == "" || seletTipos == null 
									|| seletTipos == "" || selectAeropuertoO == null || selectAeropuertoO == "" 
									|| selectAeropuertoD == null || selectAeropuertoD == ""){
									
									Swal.fire({
										  icon: 'error',
										  title: 'Oops...',
										  text: 'Complete todos los campos para continuar...',
										  confirmButtonText: 'Aceptar',
										  confirmButtonColor: '#ff2600',
										  showCloseButton: true
										})
									
								}else{
									$.get('ControllerVuelo', {
										//Enviando variable al controlador.
										vuelo, fecha, hora, minutos, selectcompany, selectAvion, seletTipos, selectAeropuertoO, selectAeropuertoD, descuento, fechaI, fechaF, Guardar
									}, function (response) {
										
										let datos = JSON.parse(response);
										console.log(datos);
										
										if(datos == "Agregado"){
											Swal.fire({
												  icon: 'success',
												  title: 'Vuelo Registrado...',
												  showConfirmButton: false,
												  timer: 10000
												}).then(() => {
													location.href = 'http://localhost:8080/sistemaAeropuerto/vuelo.jsp';
												})
											//location.href = 'http://localhost:8080/sistemaAeropuerto/company.jsp';
										}else if(datos == "Actualizado"){
											Swal.fire({
												  icon: 'success',
												  title: 'Vuelo Actualizado...',
												  showConfirmButton: false,
												  timer: 1500
												}).then(() => {
													location.href = 'http://localhost:8080/sistemaAeropuerto/vuelo.jsp';
												})
										}
									});
								}
						}
					});
				});
				
				
		//ValidarHora
				$(document).ready(function () {
					$("#Hora").blur(function (){
						//Recogiendo el value del combo
						var Hora = $("#Hora").val();
						if(Hora > 24 || Hora < 0 ){
							Swal.fire({
								icon: 'error',
								  title: 'Oops...',
								  text: 'Introduzca el formato de hora correcto...',
								  confirmButtonText: 'Aceptar',
								  confirmButtonColor: '#ff2600',
								  showCloseButton: true
								}).then(() => {
									var hora = document.getElementById('Hora');
									hora.value = "00";
							})
					}
						
			});
		});	
		
		//ValidarMinutos
				
				$(document).ready(function () {
					$("#Minutos").blur(function (){
						//Recogiendo el value del combo
						var Minutos = $("#Minutos").val();
						if(Minutos > 60 || Minutos < 0 ){
							Swal.fire({
								icon: 'error',
								  title: 'Oops...',
								  text: 'Introduzca el formato de hora correcto...',
								  confirmButtonText: 'Aceptar',
								  confirmButtonColor: '#ff2600',
								  showCloseButton: true
								}).then(() => {
									var minutos = document.getElementById('Minutos');
									minutos.value = "00";
							})
					}
						
			});
		});	
				
				
</script>



	<div class="userbox">
		<button id="Cerrar" class="Cerrar"><i class="far fa-window-close"></i></button>
			<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
				alt="Logo avion">
			<h1>Registro Vuelo</h1>
			<input type="hidden" name="vuelo" id="Vuelo" value="<%=Vuelo%>">
			<input type="hidden" name="estado" value="<%=estado%>">
			<label>Fecha Vuelo</label> 
			<input type="date" name="fecha" value="<%=Fecha%>" id="Fecha" onkeypress="return SoloNumeros(event);" required>
			<label>Hora</label> 
			<input type="number"name="hora" value="<%=Hora%>" id="Hora" onkeypress="return SoloNumeros(event);" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off required min="0" max="23">
			<label>Minutos</label> 
			<input type="number" name="minutos" value="<%=Minutos%>" id="Minutos" onkeypress="return SoloNumeros(event);" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off required min="0" max="59">
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
			<label>Descuento</label> 
			<input type="number"name="descuento" value="<%=Descuento%>" id="Descuento"onkeypress="return SoloNumeros(event);" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off required min="0" max="100">
			<label>Fecha Inicio</label> 
			<input type="date" name="fechaI" value="<%=FechaI%>" id="FechaI" onkeypress="return SoloNumeros(event);" max="<%=FechaMaxInicio%>">
			<label>Fecha Final</label> 
			<input type="date" name="fechaF" value="<%=FechaF%>" id="FechaF" onkeypress="return SoloNumeros(event);"  min="<%=FechaMinFinal%>" max="<%=FechaMaxFinal%>">
			<div align="center">
			<button name="Guardar" value="btna" class="Confirmar" id="guardar"><b>Guardar/Actualizar</b></button>
				</div>
	</div>
</body>
</html>