<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link rel="stylesheet" href="CSS/estilopasajero.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
function SoloLetras(e){
	key = e.keyCode || e.which;
	tecla = String.fromCharCode(key).toString();
	letras = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZÁÉÍÓÚÜabcdefghijklmnñopqrstuvwxyzáéíóúü ";
	
	especiales = [8,13];
	tecla_especial = false
	for(var i in especiales){
		if(key == especiales[1]){
			tecla_especial = true;
			break;
		}
	}
	if(letras.indexOf(tecla) == -1 && !tecla_especial){
		Swal.fire({
			  icon: 'error',
			  title: 'Oops...',
			  text: 'No se permite ingresar numeros...',
			  confirmButtonText: 'Aceptar',
			  confirmButtonColor: '#ff2600',
			  showCloseButton: true
			})
		return false;
	}
}

function SoloNumeros(evt){
	if(window.event){
		keynum = evt.keyCode;
	}else{
		keynum = evt.which;
	}
	
	if((keynum > 47 && keynum < 58) || keynum == 8 || keynum == 13){
		return true;
	}else{
		Swal.fire({
			  icon: 'error',
			  title: 'Oops...',
			  text: 'No se permite ingresar letras...',
			  confirmButtonText: 'Aceptar',
			  confirmButtonColor: '#ff2600',
			  showCloseButton: true
			})
		return false;
	}
}

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
	String Document = request.getParameter("Documento");
%>
<script>
	$(document).ready(function () {
		$("#DocumentoIdentidad").blur(function (){
			//Recogiendo el value del INM
			var NumeroDUI = $("#DocumentoIdentidad").val();
			console.log(NumeroDUI);
		
			
			$.post('ControllerPasajero', {
				//Enviando variable al controlador.
				NumeroDUI
			}, function (response) {
			
				let datos = JSON.parse(response);
				console.log(datos);
			
				var DocumentoIdentidad = document.getElementById('DocumentoIdentidad');
				if(datos != null){
					alert("El Numero de Documento ya existe");
					DocumentoIdentidad.value = "";
				}
			});
		});
	});
	
	$(document).ready(function () {
		$("#Cerrar").click(function (){
				location.href = 'http://localhost:8080/sistemaAeropuerto/vuelouser.jsp';
			
		});
	});
	
	$(document).ready(function () {
		$("#guardar").click(function (){
			var pasaporte = $("#Pasaporte").val();
			var documentoidentidad = $("#DocumentoIdentidad").val();
			var sexo = $("#Sexo").val();
			var edad = $("#Edad").val();
			var apellidos = $("#Apellidos").val();
			var nombres = $("#Nombres").val();
			var idPasajero = $("#IdPasajero").val();
			var Guardar = $("#guardar").val();
			
			var verificar ="";
			verificar = nombres.split(" ").join("");
			
if(nombres == null || verificar.length == 0){
				
				Swal.fire({
					  icon: 'error',
					  title: 'Oops...',
					  text: 'Complete todos los campos para continuar...',
					  confirmButtonText: 'Aceptar',
					  confirmButtonColor: '#ff2600',
					  showCloseButton: true
					}).then((result) => {
						  if (verificar.length == 0) {
							  var nombres = document.getElementById('Nombres');
							  nombres.value = "";
						  }
						})
				
			}else{
				$.get('ControllerPasajero', {
					//Enviando variable al controlador.
					pasaporte, documentoidentidad, sexo, edad, apellidos, nombres, idPasajero, Guardar
				}, function (response) {
					let datos = JSON.parse(response);
					console.log(datos);
					
					if(datos == "Agregado"){
						Swal.fire({
							  icon: 'success',
							  title: 'Pasajero Registrado...',
							  showConfirmButton: false,
							  timer: 2000
							}).then(() => {
								location.href = 'http://localhost:8080/sistemaAeropuerto/company.jsp';
							})
						};
					
					})
				}
			});
		});
	</script>
	
	<div class="userbox">
			<button id="Cerrar" class="Cerrar"><i class="far fa-window-close"></i></button>
			<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
				alt="Logo avion">
			<h1>Registro Pasajero</h1>
			<input type="hidden" name="idPasajero" id="IdPasajero" >
			<label>Nombres</label> 
			<input type="text" name="nombres" id="Nombres" " onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloLetras(event);" required> 
			<label>Apellidos</label> 
			<input type="text" name="apellidos" id="Apellidos" " onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloLetras(event);" required> 
			<label>Edad</label> 
			<input type="text" name="edad" id="Edad" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloNumeros(event);" required>
			<label>Sexo</label> 
			<select class="form-select form-select-lg mb-3" id="Sexo" name="sexo"
				id="cmbAsientos" required>
				<option value=>Seleccione una opcion</option>
				<option value="Masculino">Masculino</option>
				<option value="Femenino">Femenino</option>
			</select> 
			<label>DocumentoIdentidad</label> 
			<input type="text" name="documentoidentidad" id="DocumentoIdentidad" value="<%=Document%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloNumerosGuion(event);" required>
			<label>Pasaporte</label> 
			<input type="text" name="pasaporte" id="Pasaporte" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off required>
				<div align="center">
					<button name="Guardar" id="guardar" class="Confirmar" value="btna"><b>Guardar</b></button>
				</div>
	</div>
</body>
</html>