<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="CSS/estilocompany.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js&quot"
	; integrity="
	sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
	crossorigin="anonymous"></script>
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
	String IdVuelo = request.getParameter("IdVuelo");
	String IdEscala = request.getParameter("Id");
	String Precio = request.getParameter("Precio");
	String Nombre = request.getParameter("nombre");
	String IdAeropuerto = request.getParameter("IdAeropuerto");
	String numeroEscala = request.getParameter("numeroEscala");
	
	if (IdEscala == null) {
		IdEscala = "";
		Precio = "0";
		Nombre = "";
	}
	%>
	
<script>	
$(document).ready(function () {
	$.post('ControllerAeropuertos', {
	}, function (response) {
		let datos = JSON.parse(response);

		console.log(datos);
		
		var combo = document.getElementById("cmbAeropuerto")
		for (let item of datos) {
			combo.innerHTML +=`
				<option value="${item.idAeropuerto}">${item.nombre}</option>
				`
		}
	});
});
</script>

	<div class="userbox">
		<form action="ControllerEscala" method="get">
			<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
				alt="Logo avion">
				
			<input type="hidden" name="idVuelo" value=<%=IdVuelo%>>
			<h1>Registro Clases</h1>
			<input type="hidden" name="idEscala" value=<%=IdEscala%>>
			<input type="hidden" name="numeroEscala" value=<%=numeroEscala %>>
			<label>Aeropuerto</label> 
			<select class="form-select form-select-lg mb-3" name="selectAeropuerto" id="cmbAeropuerto" required>
			<option value="<%=IdAeropuerto %>"><%=Nombre %></option>
			</select>
			<label>Precio</label> 
			<input type="number" name="precio" min="0" max=""  step="any"  value="<%=Precio%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloNumeros(event);" required> 
				<div align="center">
			<button name="Guardar" value="btna"><b>Guardar/Actualizar</b></button>
				</div>
		</form>
	</div>
</body>
</html>