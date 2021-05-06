<html>
<link rel="stylesheet" href="CSS/estilosindex.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	<script>
function SoloLetras(e){
	key = e.keyCode || e.which;
	tecla = String.fromCharCode(key).toString();
	letras = "ABCDEFGHYJKLMNOPQRSTUVWXYZ¡…Õ”⁄‹abcdefghijklmnopqrstuvwxyz·ÈÌÛ˙¸";
	
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
<body>
<form action="ControllerAcceso" method="post">
			<div class="loginbox">
				<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg" alt="Logo avion">
				<h1>Inicia Sesion</h1>
				<div class="input-group mt-5 mb-5">
					<span class="input-group-text fa fa-user"></span>
					<input class="form-control" type="text" name="user" placeholder="Ingrese su Usuario" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloLetras(event);" required>
				</div>
				<div class="input-group mt-5 mb-5">
					<span class="input-group-text fa fa-key"></span>
					<input class="form-control" type="password" name="pass" placeholder="Ingrese su ContraseÒa" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off required>
				</div>
				<center>
					<button class="mb-4"><b>Login</b><i class="fa fa-sign-in-alt btn-sm"></i></button>
				</center>
				<center>
					<a href="NuevoUser.jsp">øAun no eres Usuario? °Registrate!</a>
				</center>
			</div>
		</form>
</body>
</html>
