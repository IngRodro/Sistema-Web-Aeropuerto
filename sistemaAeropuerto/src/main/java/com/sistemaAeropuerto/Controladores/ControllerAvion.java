package com.sistemaAeropuerto.Controladores;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sistemaAeropuerto.DAO.ClsAvion;
import com.sistemaAeropuerto.Entidades.Avion;

/**
 * Servlet implementation class ControllerAvion
 */
public class ControllerAvion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ControllerAvion() {
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
		String IdAeropuerto = request.getParameter("idAvion");
		String Modelo = request.getParameter("modelo");
		String Capacidad = request.getParameter("capacidad");
	

		ClsAvion clsavion = new ClsAvion();
		Avion aeropuerto = new Avion();

		if (Evaluar != null) {
			if (Evaluar.equals("btne")) {
				aeropuerto.setIdAvion(Integer.parseInt(request.getParameter("IdAvion")));
				clsavion.BorrarAvion(aeropuerto);
				response.sendRedirect("aeropuerto.jsp");
			}
		}else if(agregando.equals("btna")) {
			aeropuerto.setModeloAvion(Modelo);
			aeropuerto.setCapacidad(Integer.parseInt(Capacidad));
			
			if(IdAeropuerto==null||IdAeropuerto=="") {
				
				clsavion.AgregarAvion(aeropuerto);
				response.sendRedirect("aeropuerto.jsp");
			}else {
				aeropuerto.setIdAvion(Integer.parseInt(IdAeropuerto));
				clsavion.ActualizarAvion(aeropuerto);
				response.sendRedirect("aeropuerto.jsp");
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		Gson json = new Gson();

		ClsAvion clsAvion = new ClsAvion();
		response.setCharacterEncoding("UTF8");
		response.getWriter().append(json.toJson(clsAvion.MostrarAvion()));
	}

}
