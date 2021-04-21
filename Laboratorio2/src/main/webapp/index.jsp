<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="CSS/estilosindex.css">
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<form action="ControllerAcceso" method = "post">
		<div class="loginbox">
		<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg" alt="Logo avion">
			<h1>Inicia Sesion</h1>
		<label>User</label>
		<br>
		<input type="text" name="user" placeholder="Escribe tu Usuario">
		<br>
		<label>Pass</label>
		<br>
		<input type="password" name="pass" placeholder="Escribe tu contrase�a">
		<br>
		<input type="submit" value="Log In">
		<a href="#">¿Aun no eres Usuario? ¡Registrate!</a>
		</div>
	</form>
</body>
</html>