package com.sistemaAeropuerto.DAO;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;

import javax.swing.JOptionPane;

import com.sistemaAeropuerto.Conexion.ConexionBd;
import com.sistemaAeropuerto.Entidades.Promociones;
import com.sistemaAeropuerto.Entidades.Vuelo;

public class ClsPromocion {

	public void AgregarPromo(Promociones Promo) {
		ConexionBd cn = new ConexionBd();
		Connection conexion = cn.RetornarConexion();
		try {
			CallableStatement Statement = conexion.prepareCall("call SP_I_Promocion(?,?,?)");
			if (Promo.getFechaInicio() == null && Promo.getFechaFinal() == null) {
				Statement.setDate("PfechaInicio", null);
				Statement.setDate("PfechaFinal", null);
				Statement.setDouble("PDescuento", Promo.getDescuento());
				Statement.execute();
			} else {
				Statement.setDate("PfechaInicio", new java.sql.Date(Promo.getFechaInicio().getTime()));
				Statement.setDate("PfechaFinal", new java.sql.Date(Promo.getFechaFinal().getTime()));
				Statement.setDouble("PDescuento", Promo.getDescuento());
				Statement.execute();
			}

			System.out.println("Guardado");
			conexion.close();
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	public void ActualizarPromo(Promociones Promo, Vuelo vuelo) {
		ConexionBd cn = new ConexionBd();
		Connection conexion = cn.RetornarConexion();
		try {
			if (Promo.getFechaInicio() == null && Promo.getFechaFinal() == null) {
				CallableStatement Statement = conexion.prepareCall("call SP_U_Promocion(?,?,?,?)");
				Statement.setInt("PidVuelo", vuelo.getIdVuelo());
				Statement.setDate("PfechaInicio", null);
				Statement.setDate("PfechaFinal", null);
				Statement.setDouble("PDescuento", Promo.getDescuento());
				Statement.execute();
			} else {
				CallableStatement Statement = conexion.prepareCall("call SP_U_Promocion(?,?,?,?)");
				Statement.setInt("PidVuelo", vuelo.getIdVuelo());
				Statement.setDate("PfechaInicio", new java.sql.Date(Promo.getFechaInicio().getTime()));
				Statement.setDate("PfechaFinal", new java.sql.Date(Promo.getFechaFinal().getTime()));
				Statement.setDouble("PDescuento", Promo.getDescuento());
				Statement.execute();
			}
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	public Promociones SeleccionarPromo(int idVuelo) {
		ConexionBd cn = new ConexionBd();
		Connection conexion = cn.RetornarConexion();
		Promociones promo = new Promociones();
		try {
			CallableStatement Statement = conexion.prepareCall("call SP_S_1Promocion(?)");
			Statement.setInt("PidVuelo", idVuelo);
			ResultSet resultadoDeConsulta = Statement.executeQuery();
			while (resultadoDeConsulta.next()) {
				promo.setDescuento(resultadoDeConsulta.getDouble("Descuento"));
				promo.setFechaInicio(resultadoDeConsulta.getDate("FechaInicio"));
				promo.setFechaFinal(resultadoDeConsulta.getDate("FechaFinal"));
			}
			conexion.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		return promo;
	}

}
