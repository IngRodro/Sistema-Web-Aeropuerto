<%@page import="com.sistemaAeropuerto.DAO.ClsClase"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="CSS/estiloaeropuerto.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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
			  text: 'No se permite ingresar numeros ...',
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
	ClsClase clsClase = new ClsClase();
	String IdAvion = request.getParameter("idAvion");
	String IdClase = request.getParameter("Id");
	String nombreClase = request.getParameter("nombreClase");
	String nAsientos = request.getParameter("nAsientos");
	String Porcentaje = request.getParameter("Porcentaje");
	String MaximoAsientos;
	if(nAsientos == null){
		MaximoAsientos = String.valueOf((clsClase.MaximoAsientosDisponibles(Integer.parseInt(IdAvion))));
	}else{
		MaximoAsientos = String.valueOf((clsClase.MaximoAsientosDisponibles(Integer.parseInt(IdAvion))) + Integer.parseInt(nAsientos));
	}
	
	if (IdClase == null) {
		IdClase = "";
		nombreClase = "";
		nAsientos = "0";
		Porcentaje = "0";
	}
	%>

<script type="text/javascript">

$(document).ready(function () {
	$("#Cerrar").click(function (){
		location.href = 'http://localhost:8080/sistemaAeropuerto/clases.jsp?IdAvion=<%=IdAvion%>';
	
	});
});

	$(document).ready(function () {
		$("#Porcentaje").blur(function (){
			var Porcentaje = $("#Porcentaje").val();
			if(Porcentaje > 100 || Porcentaje < 0 ){
				Swal.fire({
					icon: 'error',
					  title: 'Oops...',
				 	 text: 'El Porcentaje Extra no puede ser menor a 0% o mayor a 100%...',
				  	confirmButtonText: 'Aceptar',
				 	 confirmButtonColor: '#ff2600',
				 	 showCloseButton: true
					}).then(() => {
						var porcentaje = document.getElementById('Porcentaje');
						porcentaje.value = "0";
				})
			}
		
		});
	});	
	
	$(document).ready(function () {
		$("#Asiento").blur(function (){
			//Recogiendo el value del combo
			var Asiento = $("#Asiento").val();
			if(Asiento > <%=MaximoAsientos%> || Asiento < 0 ){
				Swal.fire({
					icon: 'error',
					  title: 'Oops...',
				 	 text: 'El maximo de Asientos Disponibles para Asignar es de <%=MaximoAsientos%>...',
				  	confirmButtonText: 'Aceptar',
				 	 confirmButtonColor: '#ff2600',
				 	 showCloseButton: true
					}).then(() => {
						var asiento = document.getElementById('Asiento');
						asiento.value = "0";
				})
			}
		
		});
	});	
	
	$(document).ready(function () {
		$("#guardar").click(function (){
			var porcentaje = $("#Porcentaje").val();
			var asientos = $("#Asiento").val();
			var nombre = $("#Nombre").val();
			var idClase = $("#IdClase").val();
			var Guardar = $("#guardar").val();
			var idAvion = $("#IdAvion").val();
			var IdClase ="<%=IdClase%>"
			var Nombre = "<%=nombreClase%>";
			var Porcentaje = "<%=Porcentaje%>";
			var Asiento = "<%=nAsientos%>";
			
			var verificar ="";

			verificar = nombre.split(" ").join("");
			
			if(nombre == null || verificar.length == 0 || porcentaje == null || porcentaje =="" || asientos == "" || asientos == null || asientos == 0){
				Swal.fire({
					  icon: 'error',
					  title: 'Oops...',
					  text: 'Complete todos los campos para continuar...',
					  confirmButtonText: 'Aceptar',
					  confirmButtonColor: '#ff2600',
					  showCloseButton: true
					}).then((result) => {
						  if (verificar.length == 0) {
							  var Nombre = document.getElementById('Nombre');
							  Nombre.value = "";
						  }
						  if(porcentaje == "" || porcentaje == null){
							  var Porcentaje = document.getElementById('Porcentaje');
							  Porcentaje.value = "0";
						  }
						  if(asiento == "" || asiento == null){
							  var Asiento = document.getElementById('Asiento');
							  Asiento.value = "0";
						  }
						})
			}else{
				if(nombre == Nombre  && porcentaje == Porcentaje && asientos == Asiento){
					Swal.fire({
						  title: 'No se resgistraron cambios',
						  text: "¿Desea seguir editando?",
						  icon: 'warning',
						  showCancelButton: true,
						  confirmButtonColor: '#3085d6',
						  cancelButtonColor: '#d33',
						  confirmButtonText: 'Si',
						  cancelButtonText: 'No'
						}).then((result) => {
						  if (result.isConfirmed) {
						    
						  }else{
							  location.href = 'http://localhost:8080/sistemaAeropuerto/clases.jsp?IdAvion=<%=IdAvion%>';
						  }
						})
					
				}else{
					var Comprobacion = null;					
					if(nombre == Nombre && IdClase != null){
						Comprobacion = "Comprobado";
					}
					$.get('ControllerClases', {
						//Enviando variable al controlador.
						porcentaje, asientos, nombre, idClase, idAvion, Guardar, Comprobacion
						
					}, function (response) {
						
						let datos = JSON.parse(response);
						console.log(datos);
						
						if(datos == "Actualizado"){
							Swal.fire({
								  icon: 'success',
								  title: 'Clase Actualizada...',
								  showConfirmButton: false,
								  timer: 1500
								}).then(() => {
									location.href = 'http://localhost:8080/sistemaAeropuerto/clases.jsp?IdAvion=<%=IdAvion%>';
								})
						}else if(datos == "Agregado"){
							Swal.fire({
								  icon: 'success',
								  title: 'Clase Registrado...',
								  showConfirmButton: false,
								  timer: 1500
								}).then(() => {
									location.href = 'http://localhost:8080/sistemaAeropuerto/clases.jsp?IdAvion=<%=IdAvion%>';
								})
						}else if(datos == "Existente"){
							Swal.fire({
								  icon: 'error',
								  title: 'Oops...',
								  text: 'La Clase ya esta registrada...',
								  confirmButtonText: 'Aceptar',
								  confirmButtonColor: '#ff2600',
								  showCloseButton: true
								}).then(() => {
									var Nombre = document.getElementById('Nombre');
									Nombre.value = "<%=nombreClase%>";
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
				
			<input type="hidden" name="idAvion" id="IdAvion" value="<%=IdAvion%>">
			<h1>Registro Clases</h1>
			<input type="hidden" name="idClase" id="IdClase" value="<%=IdClase%>">
			<label>Nombre</label> 
			<input type="text" name="nombre" id="Nombre" value="<%=nombreClase%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloLetras(event);" required> 
				
			<label>N Asientos</label> 
			<input type="number" name="asientos" id="Asiento" min="0" max="<%=MaximoAsientos%>"  step="any"  value="<%=nAsientos%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloNumeros(event);" required> 
			<label>Porcentaje Extra de Precio</label> 
			<input type="number" name="porcentaje" id="Porcentaje" min="0" max="100"  step="any"  value="<%=Porcentaje%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloNumeros(event);" required> 
				<div align="center">
			<button name="Guardar" value="btna" class="Confirmar" id="guardar"><b>Guardar/Actualizar</b></button>
				</div>
	</div>
</body>
</html>