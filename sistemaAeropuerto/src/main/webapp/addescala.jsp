<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="CSS/estiloescala.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
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
	String IdVuelo = request.getParameter("IdVuelo");
	String IdEscala = request.getParameter("Id");
	String Precio = request.getParameter("Precio");
	String Nombre = request.getParameter("nombre");
	String IdAeropuerto = request.getParameter("IdAeropuerto");
	String numeroEscala = request.getParameter("numeroEscala");
	
	if (IdEscala == null) {
		IdEscala = "";
		Precio = "0";
		Nombre = "Seleccione una opcion";
	}
	%>
	
<script>
$(document).ready(function () {
	$("#Cerrar").click(function (){
		location.href = 'http://localhost:8080/sistemaAeropuerto/vuelo.jsp';
	});
});

$(document).ready(function () {
		var idVuelo = $("#IdVuelo").val();
	$.post('ControllerAeropuertos', {
		idVuelo
	}, function (response) {
		let datos = JSON.parse(response);

		console.log(datos);
		
		var combo = document.getElementById("cmbAeropuerto")
		for (let item of datos) {
			combo.innerHTML +=`
				<option value="${item.idAeropuerto}">${item.nombre}</option>
				`
		}
	});
});

$(document).ready(function () {
	$("#guardar").click(function (){
		var precio = $("#Precio").val();
		var idEscala = $("#IdEscala").val();
		var idVuelo = $("#IdVuelo").val();
		var numeroEscala = $("#NumeroEscala").val();
		var selectAeropuerto = $("#cmbAeropuerto").val();
		var Guardar = $("#guardar").val();
		var Precio = "<%=Precio%>";
		
		
		if(precio == null || precio <= 0 || selectAeropuerto == "null"){
			
			Swal.fire({
				  icon: 'error',
				  title: 'Oops...',
				  text: 'Complete todos los campos para continuar...',
				  confirmButtonText: 'Aceptar',
				  confirmButtonColor: '#ff2600',
				  showCloseButton: true
				}).then((result) => {
				})
			
		}else{
			if(selectAeropuerto == <%=IdAeropuerto%> && precio == Precio){
				
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
						  location.href = 'http://localhost:8080/sistemaAeropuerto/escala.jsp?IdVuelo=<%=IdVuelo%>';
					  }
					})
				
				
			}else{
				$.get('ControllerEscala', {
					//Enviando variable al controlador.
					precio, idVuelo, idEscala, numeroEscala, selectAeropuerto,Guardar
				}, function (response) {
					
					let datos = JSON.parse(response);
					console.log(datos);
					
					if(datos == "Actualizado"){
						Swal.fire({
							  icon: 'success',
							  title: 'Escala Actualizada...',
							  showConfirmButton: false,
							  timer: 2000
							}).then(() => {
								location.href = 'http://localhost:8080/sistemaAeropuerto/escala.jsp?IdVuelo=<%=IdVuelo%>';
							})
					}else if(datos == "Agregado"){
						Swal.fire({
							  icon: 'success',
							  title: 'Escala Registrada...',
							  showConfirmButton: false,
							  timer: 2000
							}).then(() => {
								location.href = 'http://localhost:8080/sistemaAeropuerto/escala.jsp?IdVuelo=<%=IdVuelo%>';
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
				
			<input type="hidden" name="idVuelo" id="IdVuelo" value=<%=IdVuelo%>>
			<h1>Registro Escala</h1>
			<input type="hidden" name="idEscala" id="IdEscala" value=<%=IdEscala%>>
			<input type="hidden" name="numeroEscala" id="NumeroEscala" value=<%=numeroEscala %>>
			<label>Aeropuerto</label> 
			<select class="form-select form-select-lg mb-3" name="selectAeropuerto" id="cmbAeropuerto" required>
			<option value="<%=IdAeropuerto %>"><%=Nombre %></option>
			</select>
			<label>Precio</label> 
			<input type="number" name="precio" id="Precio" min="0" max=""  step="any"  value="<%=Precio%>" onselectstart="return false" onCut="return false" onCopy="return false" onpaste="return false" onDrop="return false" onDrag="return false" autocomplete=off onkeypress="return SoloNumeros(event);" required> 
				<div align="center">
			<button name="Guardar" id="guardar" value="btna" class="Confirmar"><b>Guardar/Actualizar</b></button>
				</div>
	</div>
</body>
</html>