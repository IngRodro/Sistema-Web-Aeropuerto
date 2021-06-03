<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="CSS/estiloaeropuerto.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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
</script>
</head>
<body>
<script type="text/javascript">
	$(document).ready(function () {
		$("#Cerrar").click(function (){
				location.href = 'http://localhost:8080/sistemaAeropuerto/aeropuerto.jsp';
			
		});
	});
</script>
	<%
	HttpSession sesion = (HttpSession) request.getSession();
	String usuSession = String.valueOf(sesion.getAttribute("usuario"));

	if (usuSession.equals(null) || usuSession.equals("null")) {

		response.sendRedirect("index.jsp");
	}
	%>

	<%
	String IdAeropuerto = request.getParameter("Id");
	String Nombre = request.getParameter("Nombre");
	String Ciudad = request.getParameter("Ciudad");
	String Pais = request.getParameter("Pais");

	if (IdAeropuerto == null) {
		IdAeropuerto = "";
		Nombre = "";
		Ciudad = "";
		Pais = "";
	}
	%>

	<div class="userbox">
		<button id="Cerrar" class="Cerrar"><i class="far fa-window-close"></i></button>
		<form action="ControllerAeropuertos" method="get">
			<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
				alt="Logo avion">
			<h1>Registro Aeropuerto</h1>
			<input type="hidden" name="idAeropuerto" value=<%=IdAeropuerto%>>
			<label>Nombre</label> 
			<input type="text" name="nombre" value="<%=Nombre%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloLetras(event);" required> 
			<label>Pais</label> 
			<input type="text" name="pais" value="<%=Pais%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloLetras(event);" required> 
			<label>Ciudad</label> 
			<input type="text" name="ciudad" value="<%=Ciudad%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloLetras(event);" required>
				<div align="center">
			<button name="Guardar" value="btna" class="Confirmar"><b>Guardar/Actualizar</b></button>
				</div>
		</form>
	</div>
</body>
</html>