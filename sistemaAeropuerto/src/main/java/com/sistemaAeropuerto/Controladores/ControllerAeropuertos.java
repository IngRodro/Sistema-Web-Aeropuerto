package com.sistemaAeropuerto.Controladores;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sistemaAeropuerto.DAO.ClsAeropuerto;
import com.sistemaAeropuerto.Entidades.Aeropuerto;
import com.google.gson.Gson;

/**
 * Servlet implementation class ControllerAeropuertos
 */
public class ControllerAeropuertos extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ControllerAeropuertos() {
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
		String IdAeropuerto = request.getParameter("idAeropuerto");
		String Nombre = request.getParameter("nombre");
		String Ciudad = request.getParameter("ciudad");
		String Pais = request.getParameter("pais");
	

		ClsAeropuerto clsaeropuerto = new ClsAeropuerto();
		Aeropuerto aeropuerto = new Aeropuerto();

		if (Evaluar != null) {
			if (Evaluar.equals("btne")) {
				aeropuerto.setIdAeropuerto(Integer.parseInt(request.getParameter("IdAeropuerto")));
				clsaeropuerto.BorrarAeropuerto(aeropuerto);
				response.sendRedirect("aeropuerto.jsp");
			}
		}else if(agregando.equals("btna")) {
			aeropuerto.setNombre(Nombre);
			aeropuerto.setCiudad(Ciudad);
			aeropuerto.setPais(Pais);
			
			if(IdAeropuerto==null||IdAeropuerto=="") {
				
				clsaeropuerto.AgregarAeropuerto(aeropuerto);
				response.sendRedirect("aeropuerto.jsp");
			}else {
				aeropuerto.setIdAeropuerto(Integer.parseInt(IdAeropuerto));
				clsaeropuerto.ActualizarAeropuerto(aeropuerto);
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

		ClsAeropuerto clsAerpuerto = new ClsAeropuerto();
		response.setCharacterEncoding("UTF8");
		response.getWriter().append(json.toJson(clsAerpuerto.MostrAeropuerto()));
	}

}
