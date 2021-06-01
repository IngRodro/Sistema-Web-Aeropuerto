<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="CSS/estilopasajero.css">
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script>
function SoloLetras(e){
	key = e.keyCode || e.which;
	tecla = String.fromCharCode(key).toString();
	letras = "ABCDEFGHYJKLMNOPQRSTUVWXYZÁÉÍÓÚÜabcdefghijklmnopqrstuvwxyzáéíóúü ";
	
	especiales = [8,13];
	tecla_especial = false
	for(var i in especiales){
		if(key == especiales[1]){
			tecla_especial = true;
			break;
		}
	}
	if(letras.indexOf(tecla) == -1 && !tecla_especial){
		alert("No se permiten ingresar Numeros o Caracteres Especiales...");
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
		alert("No se permiten ingresar Letras...");
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
			<input type="text" name="sexo" value="<%=Sexo%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloLetras(event);" required>
			<label>DocumentoIdentidad</label> 
			<input type="text" name="documentoidentidad" value="<%=DocumentoIdentidad%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloNumerosGuion(event);" required>
			<label>Pasaporte</label> 
			<input type="text" name="pasaporte" value="<%=Pasaporte%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off required>
				<div align="center">
			<button name="Guardar" value="btna"><b>Guardar/Actualizar</b></button>
				</div>
		</form>
	</div>
</body>
</html>