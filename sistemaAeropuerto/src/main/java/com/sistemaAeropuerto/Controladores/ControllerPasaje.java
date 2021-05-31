package com.sistemaAeropuerto.Controladores;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sistemaAeropuerto.DAO.ClsPasaje;
import com.sistemaAeropuerto.DAO.ClsPasajero;
import com.sistemaAeropuerto.Entidades.Pasaje;
import com.sistemaAeropuerto.Entidades.Pasajero;

/**
 * Servlet implementation class ControllerPasaje
 */
public class ControllerPasaje extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ControllerPasaje() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		HttpSession sesion = (HttpSession) request.getSession();
		String usuSession = String.valueOf(sesion.getAttribute("user"));
		
		String DUI = request.getParameter("NDUI");
		String IdClase = request.getParameter("selectclases");
		String NAsiento = request.getParameter("selectAsiento");
		String Vuelo = request.getParameter("Vuelo");
		String NEscala = request.getParameter("NEscala");
		String Precio = request.getParameter("Precio");
		
		System.out.println(Precio);
		System.out.println(NEscala);
		
		Pasaje pasaje = new Pasaje();
		ClsPasaje clsPasaje = new ClsPasaje();
		int Idpasajero;
		ClsPasajero clsPasajero = new ClsPasajero();
		
		Idpasajero = clsPasajero.IdPasajero(DUI);
		
		pasaje.setIdClase(Integer.parseInt(IdClase));
		pasaje.setIdPasajero(Idpasajero);
		pasaje.setNAsiento(Integer.parseInt(NAsiento));
		pasaje.setNEscala(Integer.parseInt(NEscala));
		pasaje.setPrecionTotal(Double.parseDouble(Precio));
		pasaje.setIdVuelo(Integer.parseInt(Vuelo));
		pasaje.setNombreUsuario(usuSession);
		
		clsPasaje.AgregarPasaje(pasaje);
		response.sendRedirect("vuelouser.jsp");
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
	}

}
