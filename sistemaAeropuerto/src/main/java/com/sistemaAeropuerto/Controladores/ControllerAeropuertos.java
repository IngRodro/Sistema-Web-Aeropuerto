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
		String IdUsuario = request.getParameter("IdAeropuerto");
		String Nombre = request.getParameter("Nombre");
		String Ciudad = request.getParameter("Ciudad");
		String Pais = request.getParameter("Pais");
	

		ClsAeropuerto clsusu = new ClsAeropuerto();
		Aeropuerto aeropuerto = new Aeropuerto();

		if (Evaluar != null) {
			if (Evaluar.equals("btne")) {
				aeropuerto.setIdAeropuerto(Integer.parseInt(request.getParameter("IdAeropuerto")));
				clsusu.BorrarAeropuerto(aeropuerto);
				response.sendRedirect("aeropuerto.jsp");
			}
		}else if(agregando.equals("btna")) {
			aeropuerto.setNombre(Nombre);
			aeropuerto.setCiudad(Ciudad);
			aeropuerto.setPais(Pais);
			System.out.println(IdUsuario);
			
			if(IdUsuario==null||IdUsuario=="") {
				
				clsusu.AgregarAeropuerto(aeropuerto);
				response.sendRedirect("Saludo.jsp");
			}else {
				aeropuerto.setIdAeropuerto(Integer.parseInt(IdUsuario));
				clsusu.ActualizarAeropuerto(aeropuerto);
				response.sendRedirect("Saludo.jsp");
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
		response.getWriter().append(json.toJson(clsAerpuerto.MostrAeropuerto()));
	}

}
