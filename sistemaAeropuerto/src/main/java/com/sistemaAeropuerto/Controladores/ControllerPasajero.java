package com.sistemaAeropuerto.Controladores;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sistemaAeropuerto.DAO.ClsPasajero;

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
		response.getWriter().append("Served at: ").append(request.getContextPath());
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
