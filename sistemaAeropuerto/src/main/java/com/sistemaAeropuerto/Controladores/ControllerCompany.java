package com.sistemaAeropuerto.Controladores;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sistemaAeropuerto.DAO.ClsAeropuerto;
import com.sistemaAeropuerto.DAO.ClsCompany;
import com.sistemaAeropuerto.Entidades.Aeropuerto;
import com.sistemaAeropuerto.Entidades.Company;
import com.google.gson.Gson;

/**
 * Servlet implementation class ControllerCompany
 */
public class ControllerCompany extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ControllerCompany() {
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
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		String Evaluar = request.getParameter("Eliminar");
		String agregando = request.getParameter("Guardar");
		String IdCompany = request.getParameter("idCompany");
		String Nombre = request.getParameter("nombre");

		ClsCompany clscomp = new ClsCompany();
		Company comp = new Company();

		if (Evaluar != null) {
			if (Evaluar.equals("btne")) {
				comp.setIdCompany(Integer.parseInt(request.getParameter("idCompany")));
				clscomp.BorrarCompany(comp);
				response.sendRedirect("company.jsp");
			}
		} else if (agregando.equals("btna")) {
			comp.setNombre(Nombre);

			if (clscomp.ComprobarExistenciaCom(comp) == true) {
				Gson json = new Gson();
				String Mensaje = "Existente";
				response.getWriter().append(json.toJson(Mensaje));
			} else {

				if (IdCompany == null || IdCompany == "") {

					clscomp.AgregarCompany(comp);
					Gson json = new Gson();

					String Mensaje = "Agregado";
					response.getWriter().append(json.toJson(Mensaje));
				} else {
					comp.setIdCompany(Integer.parseInt(IdCompany));
					clscomp.ActualizarCompany(comp);
					Gson json = new Gson();

					String Mensaje = "Actualizado";
					response.getWriter().append(json.toJson(Mensaje));
				}
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// doGet(request, response);

		Gson json = new Gson();

		ClsCompany clsComp = new ClsCompany();
		response.setCharacterEncoding("UTF8");
		response.getWriter().append(json.toJson(clsComp.MostrarCompany()));
	}

}
