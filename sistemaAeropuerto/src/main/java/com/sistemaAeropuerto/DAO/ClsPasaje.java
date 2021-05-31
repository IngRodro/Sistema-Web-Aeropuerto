package com.sistemaAeropuerto.DAO;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.swing.JOptionPane;

import com.sistemaAeropuerto.Conexion.ConexionBd;
import com.sistemaAeropuerto.Entidades.Clases;
import com.sistemaAeropuerto.Entidades.Pasaje;
import com.sistemaAeropuerto.Entidades.Vuelo;

public class ClsPasaje {

	public ArrayList<Pasaje> ListaPasaje(int idVuelo, int NEscala) {
		ConexionBd cn = new ConexionBd();
		Connection conexion = cn.RetornarConexion();
		ArrayList<Pasaje> pasajes = new ArrayList<>();
		try {
			CallableStatement statement = conexion.prepareCall("call SP_S_Pasaje(?,?)");
			statement.setInt("PidVuelo", idVuelo);
			statement.setInt("PNEscala", NEscala);
			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
				Pasaje psj = new Pasaje();
				psj.setIdPasaje(rs.getInt("idPasaje"));
				psj.setIdPasajero(rs.getInt("idPasajero"));
				psj.setIdVuelo(rs.getInt("idVuelo"));
				psj.setIdClase(rs.getInt("idClase"));
				psj.setNAsiento(rs.getInt("NAsiento"));
				psj.setPrecionTotal(rs.getFloat("precioTotal"));
				psj.setNEscala(rs.getInt("NEscala"));
				pasajes.add(psj);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return pasajes;
	}

	public ArrayList<Integer> AsientosOcupados(int idVuelo, int idClase) {
		ConexionBd cn = new ConexionBd();
	    Connection conexion = cn.RetornarConexion();
		ArrayList<Integer> Asientos = new ArrayList<>();
		ArrayList<Pasaje> pasajes = new ArrayList<>();

		try {
			CallableStatement statement = conexion.prepareCall("call SP_S_AsientosPasaje(?,?)");
			statement.setInt("PidVuelo", idVuelo);
			statement.setInt("PidClase", idClase);
			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
				Pasaje psj = new Pasaje();
				psj.setIdPasaje(rs.getInt("idPasaje"));
				psj.setIdPasajero(rs.getInt("idPasajero"));
				psj.setIdVuelo(rs.getInt("idVuelo"));
				psj.setIdClase(rs.getInt("idClase"));
				psj.setNAsiento(rs.getInt("NAsiento"));
				psj.setPrecionTotal(rs.getFloat("precioTotal"));
				psj.setNEscala(rs.getInt("NEscala"));
				pasajes.add(psj);
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		ClsVuelo clsvuelo = new ClsVuelo();
		Vuelo vuelo = new Vuelo();
		vuelo = clsvuelo.SeleccionarVuelo(idVuelo);

		ClsClase clsClase = new ClsClase();
		ArrayList<Clases> clases = clsClase.MostrarClase(vuelo.getIdAvion());
		Clases clase = new Clases();
		clase = clsClase.SeleccionarClase(idClase);

		int Asiento = 0;
		for (var iterarclases : clases) {
			if (iterarclases.getIdClase() != idClase) {
				Asiento = Asiento + iterarclases.getnAsientos();
			} else {
				break;
			}
		}
		for (int i = 0; i < clase.getnAsientos(); i++) {

			Asiento = Asiento + 1;
			boolean ComprobarAsiento = false;
			for (var iterarAsientos : pasajes) {
				if (iterarAsientos.getNAsiento() == Asiento) {
					ComprobarAsiento = true;
					break;
				}
			}
			if (ComprobarAsiento == false) {
				Asientos.add(Asiento);
			}

		}

		return Asientos;
	}

	public void AgregarPasaje(Pasaje pasa) {
		ConexionBd cn = new ConexionBd();
	    Connection conexion = cn.RetornarConexion();
		try {
			CallableStatement Statement = conexion.prepareCall("call SP_I_Pasaje(?,?,?,?,?,?,?)");
			Statement.setInt("PidPasajero", pasa.getIdPasajero());
			Statement.setInt("PidVuelo", pasa.getIdVuelo());
			Statement.setInt("PidClase", pasa.getIdClase());
			Statement.setInt("PNAsiento", pasa.getNAsiento());
			Statement.setDouble("PprecioTotal", pasa.getPrecionTotal());
			Statement.setInt("PNEscala", pasa.getNEscala());
			Statement.setString("PnombreUsuario", pasa.getNombreUsuario());
			Statement.execute();
			System.out.println("Guardado");
			conexion.close();
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	public ArrayList<Pasaje> SeleccionarPasajesVuelo(int idVuelo) {
		ConexionBd cn = new ConexionBd();
	    Connection conexion = cn.RetornarConexion();
		ArrayList<Pasaje> pasajes = new ArrayList<>();
		try {
			CallableStatement statement = conexion.prepareCall("call SP_S_PasajeVuelo(?)");
			statement.setInt("PidVuelo", idVuelo);
			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
				Pasaje psj = new Pasaje();
				psj.setIdPasaje(rs.getInt("idPasaje"));
				psj.setIdPasajero(rs.getInt("idPasajero"));
				psj.setIdVuelo(rs.getInt("idVuelo"));
				psj.setIdClase(rs.getInt("idClase"));
				psj.setNAsiento(rs.getInt("NAsiento"));
				psj.setPrecionTotal(rs.getFloat("precioTotal"));
				psj.setNEscala(rs.getInt("NEscala"));
				pasajes.add(psj);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return pasajes;
	}

}
