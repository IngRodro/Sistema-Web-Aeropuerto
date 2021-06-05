package com.sistemaAeropuerto.Controladores;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sistemaAeropuerto.DAO.ClsUsuario;
import com.sistemaAeropuerto.Entidades.Usuario;

/**
 * Servlet implementation class ControllerUser
 */
public class ControllerUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ControllerUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String Nombres = request.getParameter("nombres");
		String Apellidos =request.getParameter("apellidos");
		String User = request.getParameter("usuario");
		String Pass = request.getParameter("pass");
		String Edad = request.getParameter("edad");
		String Telefono = request.getParameter("telefono");
		String passadmin = request.getParameter("passadmin");
		
		
		
		ClsUsuario clsusu = new ClsUsuario();
		Usuario usu = new Usuario();
			
		usu.setNombreUsuario(User);
		usu.setPassword(Pass);
		usu.setNombres(Nombres);
		usu.setApellidos(Apellidos);
		usu.setEdad(Integer.parseInt(Edad));
		usu.setTelefono(Telefono);
		if(passadmin.equals("2158")) {
			usu.setTipoUser(1);
		}else {
			usu.setTipoUser(0);
		}
			
		if(clsusu.ComprobarExistencia(User)==false) {
			clsusu.AgregarUsuario(usu);
			Gson json = new Gson();
			String Mensaje = "Agregado";
			response.getWriter().append(json.toJson(Mensaje));
				
		}else {
			Gson json = new Gson();
			String Mensaje = "Existente";
			response.getWriter().append(json.toJson(Mensaje));
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
