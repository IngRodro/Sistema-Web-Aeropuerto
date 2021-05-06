<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="CSS/estilotipo.css">
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script>
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
	<%
	String IdTipo = request.getParameter("Id");
	String Tipo = request.getParameter("Tipo");
	String Descuento = request.getParameter("Porcentaje");

	if (IdTipo == null) {
		IdTipo = "";
		Tipo = "";
		Descuento = "";
	}
	%>

	<div class="userbox">
		<form action="ControllerTipos" method="get">
			<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
				alt="Logo avion">
			<h1>Registro Tipos de Vuelo</h1>
			<input type="hidden" name="idTipo" value=<%=IdTipo%>>
			<label>Tipo de Vuelo</label> 
			<input type="text" name="tipo"value="<%=Tipo%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloLetras(event);" required> 
				<div align="center">
				<label>Descuento</label> 
			<input type="number" name="descuento" min="0" max="100"  step="any"  value="<%=Descuento%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloNumeros(event);" required> 
				<div align="center">
			<button name="Guardar" value="btna"><b>Guardar/Actualizar</b></button>
				</div>
		</form>
	</div>
</body>
</html>