package com.sistemaAeropuerto.DAO;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;

import javax.swing.JOptionPane;

import com.sistemaAeropuerto.Conexion.ConexionBd;
import com.sistemaAeropuerto.Entidades.Itinerario;
import com.sistemaAeropuerto.Entidades.Vuelo;

public class ClsItinerario {
	
	ConexionBd cn = new ConexionBd();
    Connection conexion = cn.RetornarConexion();

    public void AgregarItinerario(Itinerario Iti) {
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_I_Itinerario(?,?,?,?,?)");
            Statement.setInt("PidAeropuertoDestino", Iti.getIdAeropuertoDestino());
            Statement.setInt("PidAeropuertoOrigen", Iti.getIdAeropuertoOrigen());
            Statement.setDate("Pfecha", new java.sql.Date(Iti.getFecha().getTime()));
            Statement.setString("Phora", Iti.getHora());
            Statement.setString("Pminutos", Iti.getMinutos());
            Statement.execute();
            conexion.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void ActualizarItinerario(Itinerario Iti, Vuelo vuelo) {
    	
        try {
            ClsVuelo clsVuelo = new ClsVuelo();
            Vuelo vueloIti = new Vuelo();
            vueloIti = clsVuelo.SeleccionarVuelo(vuelo.getIdVuelo());
            CallableStatement Statement = conexion.prepareCall("call SP_U_Itinerario(?,?,?,?,?,?)");
            Statement.setInt("PidItinerario", vueloIti.getIdIterinario());
            Statement.setInt("PidAeropuertoDestino", Iti.getIdAeropuertoDestino());
            Statement.setInt("PidAeropuertoOrigen", Iti.getIdAeropuertoOrigen());
            Statement.setDate("Pfecha", new java.sql.Date(Iti.getFecha().getTime()));
            Statement.setString("Phora", Iti.getHora());
            Statement.setString("Pminutos", Iti.getMinutos());
            Statement.execute();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public Itinerario SeleccionarIterinario(int idIterinario) {
        Itinerario itinerario = new Itinerario();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_S_1Itinerario(?)");
            Statement.setInt("PidItinerario", idIterinario);
            ResultSet resultadoDeConsulta = Statement.executeQuery();
            while (resultadoDeConsulta.next()) {
                itinerario.setIdAeropuertoDestino(resultadoDeConsulta.getInt("idAeropuertoDestino"));
                itinerario.setIdAeropuertoOrigen(resultadoDeConsulta.getInt("idAeropuertoOrigen"));
                itinerario.setFecha(resultadoDeConsulta.getDate("fecha"));
                itinerario.setHora(resultadoDeConsulta.getString("hora"));
                itinerario.setMinutos(resultadoDeConsulta.getString("minutos"));
            }

            conexion.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return itinerario;
    }

}
