package com.sistemaAeropuerto.Controladores;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sistemaAeropuerto.DAO.ClsPromocion;
import com.sistemaAeropuerto.DAO.ClsVuelo;
import com.sistemaAeropuerto.Entidades.Itinerario;
import com.sistemaAeropuerto.Entidades.Promociones;
import com.sistemaAeropuerto.Entidades.Vuelo;
import com.google.gson.Gson;

/**
 * Servlet implementation class ControllerVuelo
 */
public class ControllerVuelo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ControllerVuelo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String IdVuelo = request.getParameter("vuelo");
		String AeropuertoO = request.getParameter("selectAeropuertoO");
		String AeropuertoD =request.getParameter("selectAeropuertoD");
		String FechaString = request.getParameter("fecha");
		SimpleDateFormat formatodeFecha = new SimpleDateFormat("yyyy-MM-dd");
		String FechaIString = request.getParameter("fechaI");
		String FechaFString = request.getParameter("fechaF");
		Date Fecha = null;
		Date FechaI = null;
		Date FechaF = null;
		try {
			Fecha = formatodeFecha.parse(FechaString);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		
		
		String Hora = request.getParameter("hora");
		String Minutos = request.getParameter("minutos");
		String Company = request.getParameter("selectcompany");
		String Tipos = request.getParameter("seletTipos");
		String Avion = request.getParameter("selectAvion");
		String Descuento = request.getParameter("descuento");
		String Finalizando = request.getParameter("Finalizar");
		
		
		ClsVuelo clsVuelo = new ClsVuelo();
		Vuelo vuelo = new Vuelo();
		Itinerario itinerario = new Itinerario();
		Promociones promo = new Promociones();
		ClsPromocion clsPromo = new ClsPromocion();
		

		if(Finalizando.equals("btnf")){
			vuelo.setIdVuelo(Integer.parseInt(IdVuelo));
			clsVuelo.VueloFinalizado(vuelo);
			response.sendRedirect("vuelo.jsp");
		}else {
			if(Descuento.equals("0")) {
				FechaI = null;
				FechaF= null;
			}else {
				try {
					FechaI = formatodeFecha.parse(FechaIString);
					FechaF = formatodeFecha.parse(FechaFString);
				} catch (Exception e) {
					FechaI = null;
					FechaF= null;
				}
			}
			
		itinerario.setFecha(Fecha);
		itinerario.setHora(Hora);
		itinerario.setMinutos(Minutos);
		itinerario.setIdAeropuertoDestino(Integer.parseInt(AeropuertoD));
		itinerario.setIdAeropuertoOrigen(Integer.parseInt(AeropuertoO));
		
		vuelo.setIdCompany(Integer.parseInt(Company));
		vuelo.setIdAvion(Integer.parseInt(Avion));
		vuelo.setIdTiposVuelo(Integer.parseInt(Tipos));
		
		promo.setDescuento(Double.parseDouble(Descuento));
		promo.setFechaInicio(FechaI);
		promo.setFechaFinal(FechaF);
		
		String agregando = request.getParameter("Guardar");
		
		if(agregando.equals("btna")) {
				if(IdVuelo==null||IdVuelo=="") {
					clsVuelo.AgregarVuelo(vuelo, itinerario);
					clsPromo.AgregarPromo(promo);
					
					Gson json = new Gson();

					String Mensaje = "Agregado";
					response.getWriter().append(json.toJson(Mensaje));
					
				}else {
					vuelo.setIdVuelo(Integer.parseInt(IdVuelo));
					clsVuelo.ActualizarVuelo(vuelo, itinerario, promo);
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
		
		Gson json = new Gson();

		ClsVuelo clsVuelo = new ClsVuelo();
		response.setCharacterEncoding("UTF8");
		response.getWriter().append(json.toJson(clsVuelo.MostrarVuelos()));
	}

}
