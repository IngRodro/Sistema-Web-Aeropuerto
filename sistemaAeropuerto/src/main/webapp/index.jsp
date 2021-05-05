<html>
<link rel="stylesheet" href="CSS/estilosindex.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<body>
<form action="ControllerAcceso" method="post">
			<div class="loginbox">
				<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg" alt="Logo avion">
				<h1><b>Iniciar Sesion</b></h1>
				<div class="input-group mt-5 mb-5">
					<span class="input-group-text fa fa-user"></span>
					<input class="form-control" type="text" name="user" placeholder="Ingrese su Usuario">
				</div>
				<div class="input-group mt-5 mb-5">
					<span class="input-group-text fa fa-key"></span>
					<input class="form-control" type="password" name="pass" placeholder="Ingrese su Contraseña">
				</div>
				<center>
					<button class="mb-4"><b>LOGIN</b><i class="fa fa-sign-in-alt"></i></button>
				</center>
				<center>
					<a href="NuevoUser.jsp"><b>¿Aun no eres Usuario? ¡Registrate!</b></a>
				</center>
			</div>
		</form>
</body>
</html>
