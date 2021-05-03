<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="CSS/estilocompany.css">
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	String IdCompany = request.getParameter("Id");
	String Nombre = request.getParameter("Nombre");

	if (IdCompany == null) {
		IdCompany = "";
		Nombre = "";
	}
	%>

	<div class="userbox">
		<form action="ControllerCompany" method="get">
			<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
				alt="Logo avion">
			<h1>Registro Compañias</h1>
			<input type="hidden" name="idCompany" value=<%=IdCompany%>>
			<label>Nombre</label> <input type="text" name="nombre"
				value="<%=Nombre%>"> 
				<div align="center">
			<button name="Guardar" value="btna">Guardar/Actualizar</button>
				</div>
		</form>
	</div>
</body>
</html>