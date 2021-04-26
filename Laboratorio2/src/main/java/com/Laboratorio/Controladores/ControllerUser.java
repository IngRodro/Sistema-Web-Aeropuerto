package com.Laboratorio.Controladores;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Laboratorio.Entidades.Usuario;
import com.Laboratorio.Negocio.clsLoguin;
import com.Laboratorio.DAO.ClsUsuario;
import com.Laboratorio.Entidades.Usuario;

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
		
		String Nombres = request.getParameter("Nombres");
		String Apellidos =request.getParameter("Apellidos");
		String User = request.getParameter("Usuario");
		String Pass = request.getParameter("Pass");
		String Edad = request.getParameter("Edad");
		String Telefono = request.getParameter("Telefono");
		
		
		System.out.println(Nombres);	
		System.out.println(Apellidos);	
		System.out.println(User);
		System.out.println(Pass);
		System.out.println(Edad);	
		System.out.println(Telefono);
		
		ClsUsuario clsusu = new ClsUsuario();
		Usuario usu = new Usuario();
		
		usu.setNombreUsuario(User);
		usu.setPassword(Pass);
		usu.setNombres(Nombres);
		usu.setApellidos(Apellidos);
		usu.setEdad(Integer.parseInt(Edad));
		usu.setTelefono(Telefono);
		usu.setTipoUser(1);
		
		clsusu.AgregarUsuario(usu);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
	}

}
