package com.sistemaAeropuerto.Controladores;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sistemaAeropuerto.DAO.ClsAvion;
import com.sistemaAeropuerto.DAO.ClsClase;
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
		String IdAvion = request.getParameter("idAvion");
		String Modelo = request.getParameter("modelo");
		String Capacidad = request.getParameter("capacidad");
		String IdAvionVerif = request.getParameter("IdAvionVerificar");
	

		ClsAvion clsavion = new ClsAvion();
		Avion aeropuerto = new Avion();
		
		if(IdAvionVerif != null) {
			ClsClase clsClase = new ClsClase();
			int MinAsientos = clsClase.MaximoAsientosDisponibles(Integer.parseInt(IdAvionVerif));
			Gson json = new Gson();

			response.getWriter().append(json.toJson(MinAsientos));
		}else {
		
		if (Evaluar != null) {
			if (Evaluar.equals("btne")) {
				aeropuerto.setIdAvion(Integer.parseInt(request.getParameter("IdAvion")));
				clsavion.BorrarAvion(aeropuerto);
				response.sendRedirect("avion.jsp");
			}
		}else if(agregando.equals("btna")) {
			aeropuerto.setModeloAvion(Modelo);
			aeropuerto.setCapacidad(Integer.parseInt(Capacidad));
			
			if(IdAvion==null||IdAvion=="") {
				
				clsavion.AgregarAvion(aeropuerto);
				Gson json = new Gson();

				String Mensaje = "Agregado";
				response.getWriter().append(json.toJson(Mensaje));
			}else {
				aeropuerto.setIdAvion(Integer.parseInt(IdAvion));
				clsavion.ActualizarAvion(aeropuerto);
				Gson json = new Gson();

				String Mensaje = "Actualizado";
				response.getWriter().append(json.toJson(Mensaje));
				}
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
