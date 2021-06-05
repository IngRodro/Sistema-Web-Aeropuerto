<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="CSS/estilotipo.css">
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
	
	if((keynum > 47 && keynum < 58) || keynum == 46 || keynum == 8 || keynum == 13){
		return true;
	}else{
		Swal.fire({
			  icon: 'error',
			  title: 'Oops...',
			  text: 'Solo se permiten numeros...',
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
	String IdTipo = request.getParameter("Id");
	String Tipo = request.getParameter("Tipo");
	String Descuento = request.getParameter("Porcentaje");

	if (IdTipo == null) {
		IdTipo = "";
		Tipo = "";
		Descuento = "0";
	}
	%>
<script type="text/javascript">
	$(document).ready(function () {
		$("#Cerrar").click(function (){
				location.href = 'http://localhost:8080/sistemaAeropuerto/tipos.jsp';
		
		});
	});
	
	$(document).ready(function () {
		$("#Descuento").blur(function (){
			//Recogiendo el value del combo
			var Minutos = $("#Descuento").val();
			if(Minutos > 60 || Minutos < 0 ){
				Swal.fire({
					icon: 'error',
					  title: 'Oops...',
					  text: 'El Descuento no puede ser menor a 0% o mayor a 99%...',
					  confirmButtonText: 'Aceptar',
					  confirmButtonColor: '#ff2600',
					  showCloseButton: true
					}).then(() => {
						var descuento = document.getElementById('Descuento');
						descuento.value = "0";
				})
		}
			
});
});	
	
	
	$(document).ready(function () {
		$("#guardar").click(function (){
			var descuento = $("#Descuento").val();
			var tipo = $("#Tipo").val();
			var idTipo = $("#IdTipo").val();
			var Guardar = $("#guardar").val();
			var Descuento ="<%=Descuento%>"
			var Tipo = "<%=Tipo%>";
			var IdTipo = "<%=IdTipo%>";
			
			var verificar ="";

			verificar = tipo.split(" ").join("");
			
			if(tipo == null || verificar.length == 0 || descuento == null || descuento ==""){
				Swal.fire({
					  icon: 'error',
					  title: 'Oops...',
					  text: 'Complete todos los campos para continuar...',
					  confirmButtonText: 'Aceptar',
					  confirmButtonColor: '#ff2600',
					  showCloseButton: true
					}).then((result) => {
						  if (verificar.length == 0) {
							  var tipo = document.getElementById('Tipo');
							  tipo.value = "";
						  }
						  if(descuento == "" || descuento == null){
							  var descuento = document.getElementById('Descuento');
							  descuento.value = "0";
						  }
						})
			}else{
				if(descuento == Descuento  && tipo == Tipo && idTipo == IdTipo){
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
							  location.href = 'http://localhost:8080/sistemaAeropuerto/tipos.jsp';
						  }
						})
					
				}else{
					$.get('ControllerTipos', {
						//Enviando variable al controlador.
						descuento, tipo, idTipo, Guardar
					}, function (response) {
						
						let datos = JSON.parse(response);
						console.log(datos);
						
						if(datos == "Actualizado"){
							Swal.fire({
								  icon: 'success',
								  title: 'Tipo de Vuelo Actualizado...',
								  showConfirmButton: false,
								  timer: 1500
								}).then(() => {
									location.href = 'http://localhost:8080/sistemaAeropuerto/tipos.jsp';
								})
							//location.href = 'http://localhost:8080/sistemaAeropuerto/company.jsp';
						}else if(datos == "Agregado"){
							Swal.fire({
								  icon: 'success',
								  title: 'Tipo de Vuelo Registrado...',
								  showConfirmButton: false,
								  timer: 1500
								}).then(() => {
									location.href = 'http://localhost:8080/sistemaAeropuerto/tipos.jsp';
								})
							//location.href = 'http://localhost:8080/sistemaAeropuerto/company.jsp';
						}else if(datos == "Existente"){
							Swal.fire({
								  icon: 'error',
								  title: 'Oops...',
								  text: 'El tipo de vuelo ya esta registrado...',
								  confirmButtonText: 'Aceptar',
								  confirmButtonColor: '#ff2600',
								  showCloseButton: true
								}).then(() => {
									var tipos_vuelo = document.getElementById('Tipo');
									tipos_vuelo.value = "";
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
			<h1>Registro Tipos de Vuelo</h1>
			<input type="hidden" name="idTipo" value=<%=IdTipo%> id="IdTipo">
			<label>Tipo de Vuelo</label> 
			<input type="text" name="tipo"value="<%=Tipo%>" id="Tipo" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloLetras(event);" required>
				<label>Descuento</label> 
			<input type="number" name="descuento" id="Descuento" min="0" max="100"  step="any"  value="<%=Descuento%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloNumeros(event);" required> 
				<div align="center">
			<button name="Guardar" value="btna" class="Confirmar" id="guardar"><b>Guardar/Actualizar</b></button>
				</div>
	</div>
</body>
</html>