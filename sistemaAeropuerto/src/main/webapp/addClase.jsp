<%@page import="com.sistemaAeropuerto.DAO.ClsClase"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="CSS/estiloaeropuerto.css">
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
	
	if((keynum > 47 && keynum < 58) || keynum == 46 || keynum == 8 || keynum == 13){
		return true;
	}else{
		alert("No se permiten ingresar Letras...");
		return false;
	}
}

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
	ClsClase clsClase = new ClsClase();
	String IdAvion = request.getParameter("idAvion");
	String IdClase = request.getParameter("Id");
	String nombreClase = request.getParameter("nombreClase");
	String nAsientos = request.getParameter("nAsientos");
	String Porcentaje = request.getParameter("Porcentaje");
	String MaximoAsientos;
	if(nAsientos == null){
		MaximoAsientos = String.valueOf((clsClase.MaximoAsientosDisponibles(Integer.parseInt(IdAvion))));
	}else{
		MaximoAsientos = String.valueOf((clsClase.MaximoAsientosDisponibles(Integer.parseInt(IdAvion))) + Integer.parseInt(nAsientos));
	}
	
	if (IdClase == null) {
		IdClase = "";
		nombreClase = "";
		nAsientos = "0";
		Porcentaje = "0";
	}
	%>

	<div class="userbox">
		<form action="ControllerClases" method="get">
			<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
				alt="Logo avion">
				
			<input type="hidden" name="idAvion" value=<%=IdAvion%>>
			<h1>Registro Clases</h1>
			<input type="hidden" name="idClase" value=<%=IdClase%>>
			<label>Nombre</label> 
			<input type="text" name="nombre"value="<%=nombreClase%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloLetras(event);" required> 
				
			<label>N Asientos</label> 
			<input type="number" name="asientos" min="0" max="<%=MaximoAsientos%>"  step="any"  value="<%=nAsientos%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloNumeros(event);" required> 
			<label>Porcentaje Extra de Precio</label> 
			<input type="number" name="porcentaje" min="0" max="100"  step="any"  value="<%=Porcentaje%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloNumeros(event);" required> 
				<div align="center">
			<button name="Guardar" value="btna"><b>Guardar/Actualizar</b></button>
				</div>
		</form>
	</div>
</body>
</html>