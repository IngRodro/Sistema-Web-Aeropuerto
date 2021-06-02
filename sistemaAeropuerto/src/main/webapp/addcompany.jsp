<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="CSS/estilocompany.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
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
		alert("No se permiten ingresar Numeros...");
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
	String IdCompany = request.getParameter("Id");
	String Nombre = request.getParameter("Nombre");

	if (IdCompany == null) {
		IdCompany = "";
		Nombre = "";
	}
	%>
<script>

$(document).ready(function () {
	$("#guardar").click(function (){
		var nombre = $("#Nombre").val();
		var idCompany = $("#IdCompany").val();
		var Guardar = $("#guardar").val();
		
		
		$.get('ControllerCompany', {
			//Enviando variable al controlador.
			nombre, idCompany, Guardar
		}, function (response) {
			
			let datos = JSON.parse(response);
			console.log(datos);
			
			if(datos == "Actualizado"){
				alert("Compañia Actualizada...");
				location.href = 'http://localhost:8080/sistemaAeropuerto/company.jsp';
			}else if(datos == "Agregado"){
				alert("Compañia Registrada...");
				location.href = 'http://localhost:8080/sistemaAeropuerto/company.jsp';
			}

			
});
});
});

</script>
	<div class="userbox">
			<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
				alt="Logo avion">
			<h1>Registro Compañias</h1>
			<input type="hidden" name="idCompany" id="IdCompany" value=<%=IdCompany%>>
			<label>Nombre</label> <input type="text" name="nombre" id="Nombre" value="<%=Nombre%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloLetras(event);" required> 
				<div align="center">
			<button name="Guardar" id="guardar" value="btna"><b>Guardar/Actualizar</b></button>
				</div>
	</div>
</body>
</html>