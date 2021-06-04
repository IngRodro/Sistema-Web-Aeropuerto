<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="CSS/estiloaeropuerto.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="js/sweetAlert.js"></script>
<script>
function SoloLetras(e){
	key = e.keyCode || e.which;
	tecla = String.fromCharCode(key).toString();
	letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZÁÉÍÓÚÜabcdefghijklmnopqrstuvwxyzáéíóúü ";
	
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
<script type="text/javascript">
	$(document).ready(function () {
		$("#Cerrar").click(function (){
				location.href = 'http://localhost:8080/sistemaAeropuerto/aeropuerto.jsp';
			
		});
	});
	
	$(document).ready(function () {
		$("#guardar").click(function (){
			var nombre = $("#Nombre").val();
			var pais = $("#Pais").val();
			var ciudad = $("#Ciudad").val();
			var idAeropuerto = $("#IdAeropuerto").val();
			var Guardar = $("#guardar").val();
			var Nombre = "<%=Nombre%>";
			var Ciudad = "<%=Ciudad%>";
			var Pais = "<%=Pais%>";
			var IdAeropuerto = "<%=IdAeropuerto%>";
			
			if(nombre == Nombre && Ciudad == ciudad && Pais == pais && IdAeropuerto == idAeropuerto){
				Swal.fire({
					  title: 'No se resgistraron cambios',
					  text: "Desea seguir editando?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#3085d6',
					  cancelButtonColor: '#d33',
					  confirmButtonText: 'Si'
					}).then((result) => {
					  if (result.isConfirmed) {
					    
					  }else{
						  location.href = 'http://localhost:8080/sistemaAeropuerto/aeropuerto.jsp';
					  }
					})
			}else{
				if(nombre == null || nombre == " "){
					
					Swal.fire({
						  icon: 'error',
						  title: 'Oops...',
						  text: 'Complete todos los campos para continuar...',
						  confirmButtonText: 'Aceptar',
						  confirmButtonColor: '#ff2600',
						  showCloseButton: true
						})
					
				}else{
					$.get('ControllerAeropuertos', {
						//Enviando variable al controlador.
						nombre, pais, ciudad, idAeropuerto, Guardar
					}, function (response) {
						
						let datos = JSON.parse(response);
						console.log(datos);
						
						if(datos == "Actualizado"){
							Swal.fire({
								  icon: 'success',
								  title: 'Compañia Actualizada...',
								  showConfirmButton: false,
								  timer: 1500
								}).then(() => {
									location.href = 'http://localhost:8080/sistemaAeropuerto/aeropuerto.jsp';
								})
							//location.href = 'http://localhost:8080/sistemaAeropuerto/company.jsp';
						}else if(datos == "Agregado"){
							Swal.fire({
								  icon: 'success',
								  title: 'Aeropuerto Registrado...',
								  showConfirmButton: false,
								  timer: 1500
								}).then(() => {
									location.href = 'http://localhost:8080/sistemaAeropuerto/aeropuerto.jsp';
								})
							//location.href = 'http://localhost:8080/sistemaAeropuerto/company.jsp';
						}else if(datos == "Existente"){
							Swal.fire({
								  icon: 'error',
								  title: 'Oops...',
								  text: 'El Aeropuerto ya esta registrada...',
								  confirmButtonText: 'Aceptar',
								  confirmButtonColor: '#ff2600',
								  showCloseButton: true
								}).then(() => {
									var company = document.getElementById('Nombre');
									company.value = "";
							})
						}
					});
				}
			}
		});
	});
</script>
	

	<div class="userbox">
		<button id="Cerrar" class="Cerrar"><i class="far fa-window-close"></i></button>
			<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
				alt="Logo avion">
			<h1>Registro Aeropuerto</h1>
			<input type="hidden" name="idAeropuerto" id="IdAeropuerto" value=<%=IdAeropuerto%>>
			<label>Nombre</label> 
			<input type="text" name="nombre" id="Nombre" value="<%=Nombre%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloLetras(event);" required> 
			<label>Pais</label> 
			<input type="text" name="pais" id="Pais" value="<%=Pais%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloLetras(event);" required> 
			<label>Ciudad</label> 
			<input type="text" name="ciudad" id="Ciudad" value="<%=Ciudad%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloLetras(event);" required>
				<div align="center">
			<button name="Guardar" value="btna" id="guardar" class="Confirmar"><b>Guardar/Actualizar</b></button>
				</div>
	</div>
</body>
</html>