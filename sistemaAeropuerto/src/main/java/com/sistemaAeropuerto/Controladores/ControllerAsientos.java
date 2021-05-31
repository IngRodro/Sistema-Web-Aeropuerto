package com.sistemaAeropuerto.Controladores;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sistemaAeropuerto.DAO.ClsClase;
import com.sistemaAeropuerto.DAO.ClsPasaje;

/**
 * Servlet implementation class ControllerAsientos
 */
public class ControllerAsientos extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ControllerAsientos() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		int comboID = Integer.parseInt(request.getParameter("comboID"));
		int Vuelo = Integer.parseInt(request.getParameter("Vuelo"));
		
		Gson json = new Gson();

		ClsPasaje clsPasaje = new ClsPasaje();
		response.setCharacterEncoding("UTF8");
		response.getWriter().append(json.toJson(clsPasaje.AsientosOcupados(Vuelo,comboID)));
	}

}
