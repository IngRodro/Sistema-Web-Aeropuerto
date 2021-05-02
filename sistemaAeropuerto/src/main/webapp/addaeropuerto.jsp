<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% 
String IdAeropuerto = request.getParameter("IdAeropuerto");
String Nombre = request.getParameter("Nombre");
String Ciudad = request.getParameter("Ciudad");
String Pais = request.getParameter("Pais");

if(IdAeropuerto == null){
	IdAeropuerto = "";
	Nombre = "";
	Ciudad = "";
	Pais = "";
}

%>
<form action="ControllerMostrarInformacion" method="get">

<input type="hidden" name="idAeropuerto" value=<%=IdAeropuerto%>>
<label>Usuario</label>
<input type="text" name="nombre" value="<%=Nombre%>" >
<label>Password</label>
<input type="text" name="pais" value="<%=Pais%>">
<label>Password</label>
<input type="text" name="ciudad" value="<%=Ciudad%>">
<button name="Guardar" value="btna">Guardar</button>
</form>
</body>
</html>