package com.sistemaAeropuerto.Controladores;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sistemaAeropuerto.DAO.ClsAvion;
import com.sistemaAeropuerto.DAO.ClsClase;

/**
 * Servlet implementation class ControllerClases
 */
public class ControllerClases extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ControllerClases() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String IdAeropuerto = request.getParameter("idAvion");
		String Evaluar = request.getParameter("Ver");
		if (Evaluar != null) {
			if (Evaluar.equals("btne")) {
				request.setAttribute("IdAvion", IdAeropuerto);
				response.sendRedirect("clases.jsp");
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		String StringIdAvion = request.getParameter("IdAvion");
		int IdAvion = Integer.parseInt(StringIdAvion);
	
		Gson json = new Gson();

		ClsClase clsAvion = new ClsClase();
		response.setCharacterEncoding("UTF8");
		response.getWriter().append(json.toJson(clsAvion.MostrarClase(IdAvion)));
	}

}
