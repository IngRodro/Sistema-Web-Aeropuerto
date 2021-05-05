package com.sistemaAeropuerto.Controladores;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sistemaAeropuerto.Entidades.Usuario;
import com.sistemaAeropuerto.Negocio.ClsLoguin;

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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// doGet(request, response);

		HttpSession session = request.getSession(true);

		String btncerrar = request.getParameter("btncerrar");
		String btnnocerrar = request.getParameter("btnnocerrar");

		if (btncerrar != null) {
			response.sendRedirect("index.jsp");
			session.invalidate();

		} else if(btnnocerrar != null)
		{
			response.sendRedirect("menu.jsp");
		}
		
		else{

			String user = request.getParameter("user");
			String pass = request.getParameter("pass");
			Usuario usuario = new Usuario();

			usuario.setNombreUsuario(user);
			usuario.setPassword(pass);

			ClsLoguin clsL = new ClsLoguin();

			int valoracceso = clsL.acceso(usuario);

			if (valoracceso == 1) {
				if (clsL.tipoacceso(usuario) == 1) {
					response.sendRedirect("menu.jsp");
					session.setAttribute("usuario", user);
				} else {
					response.sendRedirect("Accesouser.jsp");
				}
			} else {
				response.sendRedirect("Error.jsp");

			}
		}
	}
}
