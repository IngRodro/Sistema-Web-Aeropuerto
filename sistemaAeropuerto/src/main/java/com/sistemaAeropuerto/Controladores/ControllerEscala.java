package com.sistemaAeropuerto.Controladores;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sistemaAeropuerto.DAO.ClsEscala;
import com.sistemaAeropuerto.DAO.ClsVuelo;
import com.sistemaAeropuerto.Entidades.Escala;
import com.sistemaAeropuerto.Entidades.Vuelo;

/**
 * Servlet implementation class ControllerEscala
 */
public class ControllerEscala extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ControllerEscala() {
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
		String IdVuelo = request.getParameter("idVuelo");
		String IdEscala = request.getParameter("IdEscala");
		String Precio = request.getParameter("precio");
		String Aeropuerto =request.getParameter("selectAeropuerto");
		String NumeroEscala = request.getParameter("numeroEscala");
		
		ClsVuelo clsvuelo = new ClsVuelo();
		Vuelo vuelo = new Vuelo();
		
		ClsEscala clsEscala = new ClsEscala();
		Escala escala = new Escala();
		
		
		
		if (Evaluar != null) {
			if (Evaluar.equals("btne")) {
				escala.setIdEscala(Integer.parseInt(request.getParameter("IdEscala")));
				clsEscala.BorrarEscala(escala);
				vuelo = clsvuelo.SeleccionarVuelo(Integer.parseInt(IdVuelo));
				ArrayList<Escala> Escalas = clsEscala.EscalasSuperiores(vuelo.getIdIterinario(), Integer.parseInt(NumeroEscala));
                for (var iterarescala : Escalas) {
                	clsEscala.ActualizarNEscala(iterarescala.getIdItinerario(), iterarescala.getNumeroEscala());
                }
				response.sendRedirect("escala.jsp?IdVuelo=" + IdVuelo);
			}
		}else if(agregando.equals("btna")) {
			
			vuelo = clsvuelo.SeleccionarVuelo(Integer.parseInt(IdVuelo));
			int NEscala = clsEscala.UltimaEscala(vuelo.getIdIterinario());
			escala.setPrecio(Double.parseDouble(Precio));
			escala.setIdAeropuerto(Integer.parseInt(Aeropuerto));
			escala.setIdItinerario((vuelo.getIdIterinario()));
			
			
			if(IdEscala==null||IdEscala=="") {
				escala.setNumeroEscala(NEscala + 1);
				clsEscala.AgregarEscala(escala, vuelo.getIdIterinario());
				Gson json = new Gson();

				String Mensaje = "Agregado";
				response.getWriter().append(json.toJson(Mensaje));
			}else {
				escala.setNumeroEscala(Integer.parseInt(NumeroEscala));
				escala.setIdEscala(Integer.parseInt(IdEscala));
				clsEscala.ActualizarEscala(escala);
				Gson json = new Gson();

				String Mensaje = "Actualizado";
				response.getWriter().append(json.toJson(Mensaje));
				
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		String StringIdVuelo = request.getParameter("IdVuelo");
		int IdVuelo = Integer.parseInt(StringIdVuelo);
	
		ClsVuelo clsVuelo = new ClsVuelo();
		
		Vuelo vuelo = new Vuelo();
		
		vuelo = clsVuelo.SeleccionarVuelo(IdVuelo);
		
		Gson json = new Gson();

		ClsEscala clsEsc = new ClsEscala();
		response.setCharacterEncoding("UTF8");
		response.getWriter().append(json.toJson(clsEsc.MostrarEscala(vuelo.getIdIterinario())));
	}

}
