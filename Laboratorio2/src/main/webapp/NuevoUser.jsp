<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="CSS/estilousers.css">
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<div class="userbox">
<% 
String Nombres = "";
String Apellidos = "";
String Usuario = "";
String Pass = "";
String Edad = "";
String Telefono = "";
%>
	
	<form action="ControllerUser" method = "get">
		<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg" alt="Logo avion">
			<h1>Registrate Ya!!!</h1>
		<label>Nombres</label>
		<input type="text" name="nombres" value="<%=Nombres %>">
		<label>Apellidos</label>
		<input type="text" name="apellidos" value="<%=Apellidos %>">
		<label>Nombre de Usuario</label>
		<input type="text" name="usuario" value="<%=Usuario %>">
		<label>Password</label>
		<input type="text" name="pass" value="<%=Pass %>">
		<label>Edad</label>
		<input type="number" name="edad" value="<%=Edad %>">
		<br>
		<label>Telefono</label>
		<input type="tel" name="telefono" value="<%=Telefono %>">
		<div align="center">
		<input type="submit" value="Registarme">
		</div>
	</form>
	</div>
</body>
</html>