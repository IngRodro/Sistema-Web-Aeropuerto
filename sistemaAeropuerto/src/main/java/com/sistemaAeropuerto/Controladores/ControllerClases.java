package com.sistemaAeropuerto.Controladores;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sistemaAeropuerto.DAO.ClsAvion;
import com.sistemaAeropuerto.DAO.ClsClase;
import com.sistemaAeropuerto.DAO.ClsCompany;
import com.sistemaAeropuerto.Entidades.Clases;
import com.sistemaAeropuerto.Entidades.Company;

/**
 * Servlet implementation class ControllerClases
 */
public class ControllerClases extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ControllerClases() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String Evaluar = request.getParameter("Eliminar");
		String agregando = request.getParameter("Guardar");
		String IdAvion = request.getParameter("idAvion");
		String IdClase = request.getParameter("idClase");
		String Nombre = request.getParameter("nombre");
		String NAsientos = request.getParameter("asientos");
		String Porcentaje = request.getParameter("porcentaje");
	

		ClsClase clsClase = new ClsClase();
		Clases clases = new Clases();

		if (Evaluar != null) {
			if (Evaluar.equals("btne")) {
				clases.setIdClase(Integer.parseInt(request.getParameter("IdClase")));
				clsClase.BorrarClase(clases);
				request.setAttribute("IdAvion", IdAvion);
				response.sendRedirect("avion.jsp");
			}
		}else if(agregando.equals("btna")) {
			clases.setNombreClase(Nombre);
			clases.setnAsientos(Integer.parseInt(NAsientos));
			clases.setPorcentajeEPrecio(Double.parseDouble(Porcentaje));
			clases.setIdAvion(Integer.parseInt(IdAvion));
			
			
			if(IdClase==null||IdClase=="") {
				clsClase.AgregarClase(clases);
				request.setAttribute("IdAvion", IdAvion);
				response.sendRedirect("avion.jsp");
			}else {
				clases.setIdClase(Integer.parseInt(IdClase));
				clases.setIdAvion(Integer.parseInt(IdAvion));
				clsClase.ActualizarClase(clases);
				request.setAttribute("IdAvion", IdAvion);
				response.sendRedirect("avion.jsp");
				
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		String StringIdAvion = request.getParameter("IdAvion");
		int IdAvion = Integer.parseInt(StringIdAvion);
	
		Gson json = new Gson();

		ClsClase clsAvion = new ClsClase();
		response.setCharacterEncoding("UTF8");
		response.getWriter().append(json.toJson(clsAvion.MostrarClase(IdAvion)));
	}

}
