package com.sistemaAeropuerto.Controladores;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sistemaAeropuerto.DAO.ClsVuelo;
import com.sistemaAeropuerto.DAO.InnerJoinEscalas;
import com.sistemaAeropuerto.Entidades.Escala;

/**
 * Servlet implementation class ControllerVuelosEscalas
 */
public class ControllerVuelosEscalas extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ControllerVuelosEscalas() {
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
		
		Gson json = new Gson();

		
		
		ClsVuelo clsVuelo = new ClsVuelo();
		response.setCharacterEncoding("UTF8");
		
		ArrayList<InnerJoinEscalas> Vuelos = new ArrayList<>();
		Vuelos = clsVuelo.MostrarVuelosEscala();
		for(var iterarescala: Vuelos) {
			System.out.println(iterarescala.getFechaInicio());
			System.out.println(iterarescala.getFechaFinal());
		}
		
		response.getWriter().append(json.toJson(clsVuelo.MostrarVuelosEscala()));
	}

}