<%@page import="com.sistemaAeropuerto.DAO.ClsClase"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="CSS/estiloavion.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
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
</script>
</head>
<body>
<%	HttpSession sesion = (HttpSession) request.getSession();
	String usuSession = String.valueOf(sesion.getAttribute("usuario"));

	if (usuSession.equals(null) || usuSession.equals("null")) {

		response.sendRedirect("index.jsp");
	}
	%>
	<%
	String IdAvion = request.getParameter("Id");
	String Modelo = request.getParameter("Modelo");
	String Capacidad = request.getParameter("Capacidad");
	int MinAsientos = 0;
	ClsClase clsClase = new ClsClase();
	if(IdAvion != null){
	MinAsientos = clsClase.MinAsientosDisponibles(Integer.parseInt(IdAvion));
	}
	if (IdAvion == null) {
		IdAvion = "";
		Modelo = "";
		Capacidad = "0";
	}
	%>
<script type="text/javascript">
	$(document).ready(function () {
		$("#Cerrar").click(function (){
				location.href = 'http://localhost:8080/sistemaAeropuerto/avion.jsp';
			
		});
	});
	
	$(document).ready(function () {
		$("#Capacidad").blur(function (){
			//Recogiendo el value
			var IdAvionVerificar = $("#IdAvion").val();
			var capacidad = $("#Capacidad").val();
			console.log(capacidad);
			
				if(<%=MinAsientos%> != null)
				if(<%=MinAsientos%> > capacidad ){
					
					Swal.fire({
						  icon: 'error',
						  title: 'Oops...',
						  text: 'El Minimo de Asientos para asignar es de <%=MinAsientos%>...',
						  confirmButtonText: 'Aceptar',
						  confirmButtonColor: '#ff2600',
						  showCloseButton: true
						}).then((result) => {
								var Capacidad = document.getElementById('Capacidad')
								Capacidad.value = <%=MinAsientos%>;
							})
					
			}
	});
});
	
	$(document).ready(function () {
		$("#guardar").click(function (){
			var modelo = $("#Modelo").val();
			var idAvion = $("#IdAvion").val();
			var capacidad = $("#Capacidad").val();
			var Guardar = $("#guardar").val();
			var Modelo = "<%=Modelo%>";
			var IdAvion = "<%=IdAvion%>";
			var Capacidad = "<%=Capacidad%>";
			
			var verificar ="";
			verificar = modelo.split(" ").join("");
			
			if(modelo == null || verificar.length == 0 || capacidad <= 0 || capacidad == null){
				
				Swal.fire({
					  icon: 'error',
					  title: 'Oops...',
					  text: 'Complete todos los campos para continuar...',
					  confirmButtonText: 'Aceptar',
					  confirmButtonColor: '#ff2600',
					  showCloseButton: true
					}).then((result) => {
						  if (verificar.length == 0) {
							  var modelo = document.getElementById('Modelo');
							  modelo.value = "";
						  }
						})
				
			}else{
				if(modelo == Modelo && capacidad == Capacidad){
					
					Swal.fire({
						  title: 'No se resgistraron cambios',
						  text: "Desea seguir editando?",
						  icon: 'warning',
						  showCancelButton: true,
						  confirmButtonColor: '#3085d6',
						  cancelButtonColor: '#d33',
						  confirmButtonText: 'Si',
						  cancelButtonText: 'No'
						}).then((result) => {
						  if (result.isConfirmed) {
						    
						  }else{
							  location.href = 'http://localhost:8080/sistemaAeropuerto/avion.jsp';
						  }
						})
					
					
				}else{
					$.get('ControllerAvion', {
						//Enviando variable al controlador.
						modelo, idAvion, capacidad, Guardar
					}, function (response) {
						
						let datos = JSON.parse(response);
						console.log(datos);
						
						if(datos == "Actualizado"){
							Swal.fire({
								  icon: 'success',
								  title: 'Avion Actualizado...',
								  showConfirmButton: false,
								  timer: 2000
								}).then(() => {
									location.href = 'http://localhost:8080/sistemaAeropuerto/avion.jsp';
								})
						}else if(datos == "Agregado"){
							Swal.fire({
								  icon: 'success',
								  title: 'Avion Registrado...',
								  showConfirmButton: false,
								  timer: 2000
								}).then(() => {
									location.href = 'http://localhost:8080/sistemaAeropuerto/avion.jsp';
								})
						}
					});
				}
			}
		});
	});
</script>


	<div class="userbox">
			<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg" alt="Logo avion">
			<button id="Cerrar" class="Cerrar"><i class="far fa-window-close"></i></button>
			<h1>Registro Aviones</h1>
			<input type="hidden" name="idAvion" id="IdAvion" value=<%=IdAvion%>>
			<label>Modelo</label> 
			<input type="text" name="modelo"value="<%=Modelo%>" id="Modelo" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off required> 
			<label>Capacidad</label> 
			<input type="number" name="capacidad" min="0" id="Capacidad" value="<%=Capacidad%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloNumeros(event);" required> 
				<div align="center">
			<button name="Guardar" class="Confirmar" value="btna" id="guardar"><b>Guardar/Actualizar</b></button>
				</div>
	</div>
</body>
</html>