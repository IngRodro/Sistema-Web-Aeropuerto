<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="CSS/estiloadd.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<meta charset="UTF-8">
<link rel="shortcut icon" type="image/png" href="IMG/airplane(1).png">
<title>Registrar Usuario - AeroLine</title>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
function SoloNumeros(evt){
	if(window.event){
		keynum = evt.keyCode;
	}else{
		keynum = evt.which;
	}
	
	if((keynum > 47 && keynum < 58) || keynum == 8 || keynum == 13){
		return true;
	}else{
		Swal.fire({
			  icon: 'error',
			  title: 'Oops...',
			  text: 'No se permite ingresar letras...',
			  confirmButtonText: 'Aceptar',
			  confirmButtonColor: '#ff2600',
			  showCloseButton: true
			})
		return false;
	}
}

function SoloNumerosGuion(evt){
	if(window.event){
		keynum = evt.keyCode;
	}else{
		keynum = evt.which;
	}
	
	if((keynum > 47 && keynum < 58) || keynum == 45 || keynum == 8 || keynum == 13){
		return true;
	}else{
		Swal.fire({
			  icon: 'error',
			  title: 'Oops...',
			  text: 'No se permite ingresar letras...',
			  confirmButtonText: 'Aceptar',
			  confirmButtonColor: '#ff2600',
			  showCloseButton: true
			})
		return false;
	}
}

function SoloLetras(e){
	key = e.keyCode || e.which;
	tecla = String.fromCharCode(key).toString();
	letras = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZÁÉÍÓÚÜabcdefghijklmnñopqrstuvwxyzáéíóúü ";
	
	especiales = [8,13];
	tecla_especial = false
	for(var i in especiales){
		if(key == especiales[1]){
			tecla_especial = true;
			break;
		}
	}
	if(letras.indexOf(tecla) == -1 && !tecla_especial){
		Swal.fire({
			  icon: 'error',
			  title: 'Oops...',
			  text: 'No se permite ingresar numeros...',
			  confirmButtonText: 'Aceptar',
			  confirmButtonColor: '#ff2600',
			  showCloseButton: true
			})
		return false;
	}
}
</script>
</head>
<body>
<script type="text/javascript">
	$(document).ready(function () {
		$("#Cerrar").click(function (){
				location.href = 'http://localhost:8080/sistemaAeropuerto/index.jsp';
			
		});
	});
	
	$(document).ready(function () {
		$("#guardar").click(function (){
			
			var nombres = $("#Nombres").val();
			var passadmin  = $("#Passadmin").val();
			var telefono = $("#Telefono").val();
			var edad = $("#Edad").val();
			var pass = $("#Pass").val();
			var usuario = $("#Usuario").val();
			var apellidos = $("#Apellidos").val();
			
			var verificarnombres ="";
			verificarnombres = nombres.split(" ").join("");
			var verificarpass ="";
			verificarpass = pass.split(" ").join("");
			var verificarusuario ="";
			verificarusuario = usuario.split(" ").join("");
			var verificarapellidos ="";
			verificarapellidos = apellidos.split(" ").join("");
			
			if(nombres == null || verificarnombres.length == 0 || pass == null ||
					verificarpass.length == 0 || usuario == null  || verificarusuario.length == 0
					|| apellidos == null || verificarapellidos.length == 0 || telefono == null
					|| edad == null){
						
						Swal.fire({
							  icon: 'error',
							  title: 'Oops...',
							  text: 'Complete todos los campos para continuar...',
							  confirmButtonText: 'Aceptar',
							  confirmButtonColor: '#ff2600',
							  showCloseButton: true
							}).then((result) => {
								if(verificarnombres.length == 0){
									var nombre = document.getElementById('Nombres');
									nombre.value = "";
								}
								if(verificarpass.length == 0){
									var pass = document.getElementById('Pass');
									pass.value = "";
								}
								if(verificarusuario.length == 0){
									var usuario = document.getElementById('Usuario');
									usuario.value = "";
								}
								if(verificarapellidos.length == 0){
									var apellidos = document.getElementById('Apellidos');
									apellidos.value = "";
								}
							})
						
					}else{
						if(passadmin != 2158){
							Swal.fire({
								  title: 'Contraseña de admin Incorrecta',
								  text: "¿Desea crear su usuario sin privilegios de administrador?",
								  icon: 'warning',
								  showCancelButton: true,
								  confirmButtonColor: '#3085d6',
								  cancelButtonColor: '#d33',
								  confirmButtonText: 'Si',
								  cancelButtonText: 'No',
								  backdrop: `
									    rgba(0,0,123,0.4)
									    left top
									    no-repeat
									  `
								}).then((result) => {
									if (result.isConfirmed) {
										$.get('ControllerUser', {
											//Enviando variable al controlador.
											nombres, passadmin, telefono, edad, pass, usuario, apellidos
										}, function (response) {
											
											let datos = JSON.parse(response);
											console.log(datos);
											
											if(datos == "Agregado"){
												Swal.fire({
													  icon: 'success',
													  title: 'Usuario Registrado...',
													  showConfirmButton: false,
													  timer: 2500
													}).then(() => {
														location.href = 'http://localhost:8080/sistemaAeropuerto/index.jsp';
													})
												
											}else{
												Swal.fire({
													  icon: 'error',
													  title: 'Oops...',
													  text: 'El Nombre de Usuario ya existe en nuestros regiistros...',
													  confirmButtonText: 'Aceptar',
													  confirmButtonColor: '#ff2600',
													  showCloseButton: true
													}).then(() => {
														var user = document.getElementById('Usuario');
														user.value = "";
												})
											}
										});
									}
							})
						}else{
							$.get('ControllerUser', {
								//Enviando variable al controlador.
								nombres, passadmin, telefono, edad, pass, usuario, apellidos
							}, function (response) {
								
								let datos = JSON.parse(response);
								console.log(datos);

								if(datos == "Agregado"){
									Swal.fire({
										  icon: 'success',
										  title: 'Usuario Registrado...',
										  showConfirmButton: false,
										  timer: 2500
										}).then(() => {
											location.href = 'http://localhost:8080/sistemaAeropuerto/index.jsp';
									})
								}else{
									Swal.fire({
										  icon: 'error',
										  title: 'Oops...',
										  text: 'El Nombre de Usuario ya existe en nuestros regiistros...',
										  confirmButtonText: 'Aceptar',
										  confirmButtonColor: '#ff2600',
										  showCloseButton: true
										}).then(() => {
											var user = document.getElementById('Usuario');
											user.value = "";
									})
						}
					});
				}
			}
		});
	});
	

	
	
	
	
</script>

<div class="userbox">
	<button id="Cerrar" class="Cerrar"><i class="far fa-window-close fa-lg"></i></button>
		<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg" alt="Logo avion">
			<h1>Registro De Usuario</h1>
		<label>Nombres</label>
		<input type="text" name="nombres" id="Nombres" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloLetras(event);" required>
		<label>Apellidos</label>
		<input type="text" name="apellidos" id="Apellidos" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloLetras(event);" required>
		<label>Nombre de Usuario</label>
		<input type="text" name="usuario" id="Usuario" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off required>
		<label>Password</label>
		<input type="password" name="pass" id="Pass" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off required>
		<label>Edad</label>
		<input type="number" name="edad" id="Edad" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloNumeros(event);" required>
		<label>Telefono</label>
		<input type="tel" name="telefono" id="Telefono" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloNumerosGuion(event);" required>
		<label>Contraseña de Administrador</label>
		<input type="number" name="passadmin" id="Passadmin" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off>
		<div align="center">
			<button name="Guardar" id="guardar" class="Confirmar" value="btna"><b>Guardar/Actualizar</b></button>
		</div>
	</div>
</body>
</html>