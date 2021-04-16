package com.Laboratorio.Controladores;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Laboratorio.Negocio.clsLoguin;
import com.Laboratorio.Entidades.Usuario;

/**
 * Servlet implementation class ControllerAcceso
 */
public class ControllerAcceso extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ControllerAcceso() {
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
		doGet(request, response);
		
		String user = request.getParameter("user");
		String pass = request.getParameter("pass");
		Usuario usuario = new Usuario();
		
		usuario.setNombreUsuario(user);
		usuario.setPassword(pass);
		
		clsLoguin clsL = new clsLoguin();
		
		int valoracceso = clsL.acceso(usuario);
		
		if(valoracceso==1) {
			if(clsL.tipoacceso(usuario)==1) {
				response.sendRedirect("Accesoadmin.jsp");
			}else {
				response.sendRedirect("Accesouser.jsp");
			}
			
			
		}else {
			response.sendRedirect("Error.jsp");
		
	}
	}

}
