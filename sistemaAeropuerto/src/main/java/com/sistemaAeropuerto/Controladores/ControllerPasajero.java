package com.sistemaAeropuerto.Controladores;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sistemaAeropuerto.DAO.ClsPasajero;
import com.sistemaAeropuerto.Entidades.Pasajero;

/**
 * Servlet implementation class ControllerPasajero
 */
public class ControllerPasajero extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ControllerPasajero() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String Evaluar = request.getParameter("Eliminar");
		String agregando = request.getParameter("Guardar");
		String IdPasajero = request.getParameter("idPasajero");
		String Nombres = request.getParameter("nombres");
		String Apellidos = request.getParameter("apellidos");
		String Edad = request.getParameter("edad");
		String Sexo = request.getParameter("sexo");
		String DocumentoIdentidad = request.getParameter("documentoidentidad");
		String Pasaporte = request.getParameter("pasaporte");
		
		ClsPasajero clspasajero = new ClsPasajero();
		Pasajero pasajero = new Pasajero();
		
		if(Evaluar != null) {
			if (Evaluar.equals("btne")) {
				pasajero.setIdPasajero(Integer.parseInt(request.getParameter("IdPasajero")));
				clspasajero.BorrarPasajero(pasajero);
				response.sendRedirect("vuelouser.jsp");
			}
		}else if(agregando.equals("btna")){
			pasajero.setNombres(Nombres);
			pasajero.setApellidos(Apellidos);
			pasajero.setEdad(Integer.parseInt(Edad));
			pasajero.setSexo(Sexo);
			pasajero.setDocumentoIdentidad(DocumentoIdentidad);
			pasajero.setPasaporte(Pasaporte);
			
			if(IdPasajero==null||IdPasajero=="") {
				
				clspasajero.AgregarPasajero(pasajero);
				response.sendRedirect("vuelouser.jsp");
			}else {
				pasajero.setIdPasajero(Integer.parseInt(IdPasajero));
				clspasajero.ActualizarPasajero(pasajero);
				response.sendRedirect("vuelouser.jsp");
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		String DUI = request.getParameter("NumeroDUI");
		ClsPasajero clsPasajero = new ClsPasajero();
		if(clsPasajero.ExistenciaPasajero(DUI) == true){
			Gson json = new Gson();
			response.getWriter().append(json.toJson(DUI));
		}else {
			DUI = null;
			Gson json = new Gson();
			response.getWriter().append(json.toJson(DUI));
		}
		
		
	}

}
