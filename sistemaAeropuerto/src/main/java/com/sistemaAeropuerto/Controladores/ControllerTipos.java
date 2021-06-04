package com.sistemaAeropuerto.Controladores;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sistemaAeropuerto.DAO.ClsCompany;
import com.sistemaAeropuerto.DAO.ClsTiposVuelo;
import com.sistemaAeropuerto.Entidades.Company;
import com.sistemaAeropuerto.Entidades.Tipos_vuelo;

/**
 * Servlet implementation class ControllerTipos
 */
public class ControllerTipos extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ControllerTipos() {
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
		String IdTipo = request.getParameter("idTipo");
		String Tipo = request.getParameter("tipo");
		String Descuento = request.getParameter("descuento");

		ClsTiposVuelo clstipo = new ClsTiposVuelo();
		Tipos_vuelo tipo = new Tipos_vuelo();

		if (Evaluar != null) {
			if (Evaluar.equals("btne")) {
				tipo.setIdTipos_vuelo(Integer.parseInt(request.getParameter("idTipos")));
				clstipo.BorrarTipo(tipo);
				response.sendRedirect("tipos.jsp");
			}
		} else if (agregando.equals("btna")) {
			tipo.setTipo(Tipo);
			tipo.setPorcentajeDesc(Double.parseDouble(Descuento));

			if (clstipo.ComprobarExistenciaTip(tipo) == true) {
				Gson json = new Gson();
				String Mensaje = "Existente";
				response.getWriter().append(json.toJson(Mensaje));
			} else {
				if (IdTipo == null || IdTipo == "") {

					clstipo.AgregarTipo(tipo);
					Gson json = new Gson();

					String Mensaje = "Agregado";
					response.getWriter().append(json.toJson(Mensaje));
				} else {
					tipo.setIdTipos_vuelo(Integer.parseInt(IdTipo));
					clstipo.ActualizarTipo(tipo);
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

		ClsTiposVuelo clsTipos = new ClsTiposVuelo();
		response.setCharacterEncoding("UTF8");
		response.getWriter().append(json.toJson(clsTipos.MostrarTipos()));
	}

}
