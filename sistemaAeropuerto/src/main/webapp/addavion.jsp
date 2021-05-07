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
	<%
	String IdAvion = request.getParameter("Id");
	String Modelo = request.getParameter("Modelo");
	String Capacidad = request.getParameter("Capacidad");

	if (IdAvion == null) {
		IdAvion = "";
		Modelo = "";
		Capacidad = "";
	}
	%>

	<div class="userbox">
		<form action="ControllerAvion" method="get">
			<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
				alt="Logo avion">
			<h1>Registro Aviones</h1>
			<input type="hidden" name="idAvion" value=<%=IdAvion%>>
			<label>Modelo</label> 
			<input type="text" name="modelo"value="<%=Modelo%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off required> 
				<div align="center">
				<label>Capacidad</label> 
			<input type="number" name="capacidad" min="0" value="<%=Capacidad%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloNumeros(event);" required> 
				<div align="center">
			<button name="Guardar" value="btna"><b>Guardar/Actualizar</b></button>
				</div>
		</form>
	</div>
</body>
</html>