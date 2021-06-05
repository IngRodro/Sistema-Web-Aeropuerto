package com.sistemaAeropuerto.Controladores;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sistemaAeropuerto.DAO.ClsClase;
import com.sistemaAeropuerto.Entidades.Clases;

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
		Clases clase = new Clases();

		if (Evaluar != null) {
			if (Evaluar.equals("btne")) {
				clase.setIdClase(Integer.parseInt(request.getParameter("IdClase")));
				clsClase.BorrarClase(clase);
				request.setAttribute("IdAvion", IdAvion);
				response.sendRedirect("clases.jsp" + "?IdAvion="+ IdAvion);
			}
		}else if(agregando.equals("btna")) {
			clase.setNombreClase(Nombre);
			clase.setnAsientos(Integer.parseInt(NAsientos));
			clase.setPorcentajeEPrecio(Double.parseDouble(Porcentaje));
			clase.setIdAvion(Integer.parseInt(IdAvion));
			
			if (clsClase.ComprobarExistenciaClass(clase) == true) {
				Gson json = new Gson();
				
				String Mensaje = "Existente";
				response.getWriter().append(json.toJson(Mensaje));
			} else {
			
			if(IdClase==null||IdClase=="") {
				clsClase.AgregarClase(clase);
				request.setAttribute("IdAvion", IdAvion);
				Gson json = new Gson();

				String Mensaje = "Agregado";
				response.getWriter().append(json.toJson(Mensaje));
			}else {
				clase.setIdClase(Integer.parseInt(IdClase));
				clase.setIdAvion(Integer.parseInt(IdAvion));
				clsClase.ActualizarClase(clase);
				request.setAttribute("IdAvion", IdAvion);
				Gson json = new Gson();

				String Mensaje = "Actualizado";
				response.getWriter().append(json.toJson(Mensaje));
				
				}
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		String comboID = request.getParameter("comboID");
		String StringIdAvion = request.getParameter("IdAvion");
		String Precio = request.getParameter("Precio");
		String PorcentajeTotalDescuento = request.getParameter("PorcentajeTotalDescuento");
		
		
		if(comboID != null) {
			
			Gson json = new Gson();
			int idClase = Integer.parseInt(comboID);
			Double PorcentajeDesc = Double.parseDouble(PorcentajeTotalDescuento);
			Double PrecioDoule = Double.parseDouble(Precio);
			ClsClase clsClase = new ClsClase();
			Clases clase = new Clases();
			clase = clsClase.SeleccionarClase(idClase);
			response.setCharacterEncoding("UTF8");
			Double Total = PrecioDoule - (PrecioDoule*(PorcentajeDesc - (clase.getPorcentajeEPrecio()/100)));
			response.getWriter().append(json.toJson(Total));
		}else {
		
		int IdAvion = Integer.parseInt(StringIdAvion);
	
		Gson json = new Gson();

		ClsClase clsClase = new ClsClase();
		response.setCharacterEncoding("UTF8");
		response.getWriter().append(json.toJson(clsClase.MostrarClase(IdAvion)));
		}
	}

}
