<html>
<link rel="stylesheet" href="CSS/estilosindex.css">

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">

<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link rel="shortcut icon" type="image/png" href="IMG/airplane(1).png">
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<%
HttpSession sesion = (HttpSession) request.getSession();
String adminSession = String.valueOf(sesion.getAttribute("usuario"));
String usuSession	= String.valueOf(sesion.getAttribute("user"));

if (usuSession.equals(null) || usuSession.equals("null")) {

	if (adminSession.equals(null) || adminSession.equals("null")) {

		
		
	}else{
		response.sendRedirect("menu.jsp");
	}
	
}else{
	
	response.sendRedirect("menuuser.jsp");
}
%>
<title>AeroLine</title>
<body>
<script type="text/javascript">
$(document).ready(function () {
	$("#Login").click(function (){
		var user = $("#User").val();
		var pass = $("#Pass").val();
		
		var verificaruser ="";
		verificaruser = user.split(" ").join("");
		var verificarpass ="";
		verificarpass = pass.split(" ").join("");
		
		if(user == null || verificaruser.length == 0 || verificarpass.lenght == 0 || pass == null){
			Swal.fire({
				  icon: 'error',
				  title: 'Oops...',
				  text: 'Complete todos los campos para continuar...',
				  confirmButtonText: 'Aceptar',
				  confirmButtonColor: '#ff2600',
				  showCloseButton: true
				}).then(() => {
					  if(verificaruser.length == 0){
						  var user = document.getElementById('User');
						  user.value = "";
					  }
					  if(verificarpass.length == 0){
						  var pass = document.getElementById('Pass');
						  pass.value = "";
					  }
				})
		}else{
				$.post('ControllerAcceso', {
					//Enviando variable al controlador.
					user, pass
				}, function (response) {
					
					let datos = JSON.parse(response);
					console.log(datos);
					
					if(datos == "Admin"){
						 Swal.fire({
							  title: 'Iniciando Sesion como Administrador...',
							  html: 'Espere unos instantes',
							  timer: 2500,
							  showConfirmButton: false,
							  timerProgressBar: true,
							  backdrop: `
								    rgba(0,0,123,0.4)
								    left top
								    no-repeat
								  `,
							  didOpen: () => {
							    Swal.showLoading()
							  },
							}).then(() => {
								location.href = 'http://localhost:8080/sistemaAeropuerto/menu.jsp';
							})
					}else if(datos == "Usuario"){
						Swal.fire({
							  title: 'Iniciando Sesion como Usuario...',
							  html: 'Espere unos instantes',
							  timer: 2500,
							  showConfirmButton: false,
							  timerProgressBar: true,
							  backdrop: `
								    rgba(0,0,123,0.4)
								    left top
								    no-repeat
								  `,
							  didOpen: () => {
							    Swal.showLoading()
							  },
							}).then(() => {
								location.href = 'http://localhost:8080/sistemaAeropuerto/menuuser.jsp';
							})
					}else if(datos == "Error"){
						Swal.fire({
							  icon: 'error',
							  title: 'Error de Sesion',
							  text: 'Las credenciales ingresadas no son validas...',
							  confirmButtonText: 'Aceptar',
							  confirmButtonColor: '#ff2600',
							  showCloseButton: true
							}).then(() => {
								var user = document.getElementById('User');
								user.value = "";
								var pass = document.getElementById('Pass');
								pass.value = "";
						})
					}
				});
		}
	});
});
</script>
			<div class="loginbox">
				<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg" alt="Logo avion">
				<h1>Inicia Sesion</h1>
				<div class="input-group mt-5 mb-5">
					<span class="input-group-text fa fa-user"></span>
					<input class="form-control" type="text" name="user" id="User" placeholder="Ingrese su Usuario" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off required>
				</div>
				<div class="input-group mt-5 mb-5">
					<span class="input-group-text fa fa-key"></span>
					<input class="form-control" type="password" name="pass" id="Pass" placeholder="Ingrese su Contraseña" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off required>
				</div>
				<div align="center">
					<button class="mb-4" id="Login"><b>Login</b><i class="fa fa-sign-in-alt btn-sm"></i></button>
				</div>
				<div align="center">
					<a href="NuevoUser.jsp">¿Aun no eres Usuario? ¡Registrate!</a>
				</div>
			</div>
</body>
</html>
