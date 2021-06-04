<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
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
<script src="js/sweetAlert.js"></script>
<script>
function SoloLetras(e){
	key = e.keyCode || e.which;
	tecla = String.fromCharCode(key).toString();
	letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZÁÉÍÓÚÜabcdefghijklmnopqrstuvwxyzáéíóúü ";
	
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
		alert("No se permiten ingresar Letras...");
		return false;
	}
}



</script>
</head>
<body>
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
</script>
	<%
	String IdPasajero = request.getParameter("Id");
	String Nombres = request.getParameter("Nombres");
	String Apellidos = request.getParameter("Apellidos");
	String Edad = request.getParameter("Edad");
	String Sexo = request.getParameter("Sexo");
	String DocumentoIdentidad = request.getParameter("DocumentoIdentidad");
	String Pasaporte = request.getParameter("Pasaporte");

	if (IdPasajero == null) {
		IdPasajero = "";
		Nombres = "";
		Apellidos = "";
		Edad = "";
		Sexo = "";
		DocumentoIdentidad = "";
		Pasaporte = "";
	}
	%>
	
	<div class="userbox">
		<form action="ControllerPasajero" method="get">
			<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
				alt="Logo avion">
			<h1>Registro Pasajero</h1>
			<input type="hidden" name="idPasajero" value=<%=IdPasajero%>>
			<label>Nombres</label> 
			<input type="text" name="nombres" value="<%=Nombres%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloLetras(event);" required> 
			<label>Apellidos</label> 
			<input type="text" name="apellidos" value="<%=Apellidos%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloLetras(event);" required> 
			<label>Edad</label> 
			<input type="text" name="edad" value="<%=Edad%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloNumeros(event);" required>
			<label>Sexo</label> 
			<select class="form-select form-select-lg mb-3" name="sexo"
				id="cmbAsientos" required>
				<option value=>Seleccione una opcion</option>
				<option value="Masculino">Masculino</option>
				<option value="Femenino">Femenino</option>
			</select> 
			<label>DocumentoIdentidad</label> 
			<input type="text" name="documentoidentidad" id="DocumentoIdentidad" value="<%=DocumentoIdentidad%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloNumerosGuion(event);" required>
			<label>Pasaporte</label> 
			<input type="text" name="pasaporte" value="<%=Pasaporte%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off required>
				<div align="center">
					<button name="Guardar" value="btna"><b>Guardar/Actualizar</b></button>
				</div>
		</form>
	</div>
</body>
</html>