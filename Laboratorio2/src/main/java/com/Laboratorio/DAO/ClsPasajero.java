/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.Laboratorio.DAO;

import com.Laboratorio.Conexion.ConexionBd;
import com.Laboratorio.Entidades.Pasajero;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.swing.JOptionPane;

/**
 *
 * @author PREDATOR
 */
public class ClsPasajero {

	ConexionBd cn = new ConexionBd();
    Connection conexion = cn.RetornarConexion();

    public ArrayList<Pasajero> MostraPasajeros() {
        ArrayList<Pasajero> pasajeros = new ArrayList<>();
        try {
            CallableStatement statement = conexion.prepareCall("call SP_S_Pasajero");
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Pasajero psjr = new Pasajero();
                psjr.setIdPasajero(rs.getInt("idPasajero"));
                psjr.setNombres(rs.getString("nombres"));
                psjr.setApellidos(rs.getString("apellidos"));
                psjr.setEdad(rs.getInt("edad"));
                psjr.setSexo(rs.getString("sexo"));
                psjr.setDocumentoIdentidad(rs.getString("documentoIdentidad"));
                psjr.setPasaporte(rs.getString("pasaporte"));
                pasajeros.add(psjr);
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
        return pasajeros;
    }

    public void AgregarPasajero(Pasajero Pasa) {
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_I_Pasajero(?,?,?,?,?,?)");
            Statement.setString("PNombres", Pasa.getNombres());
            Statement.setString("PApellidos", Pasa.getApellidos());
            Statement.setInt("PEdad", Pasa.getEdad());
            Statement.setString("PSexo", Pasa.getSexo());
            Statement.setString("PDocumentoIdentidad", Pasa.getDocumentoIdentidad());
            Statement.setString("PPasaporte", Pasa.getPasaporte());
            Statement.execute();
            JOptionPane.showMessageDialog(null, "Guardado");
            conexion.close();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
    }

    public void BorrarPasajero(Pasajero Pasa) {
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_D_Pasajero(?)");
            Statement.setInt("PidPasajero", Pasa.getIdPasajero());
            Statement.execute();
            JOptionPane.showMessageDialog(null, "Eliminado");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
    }

    public void ActualizarPasajero(Pasajero Pasa) {
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_U_Pasajero(?,?,?,?,?,?,?)");
            Statement.setInt("PidPasajero", Pasa.getIdPasajero());
            Statement.setString("PNombres", Pasa.getNombres());
            Statement.setString("PApellidos", Pasa.getApellidos());
            Statement.setInt("PEdad", Pasa.getEdad());
            Statement.setString("PSexo", Pasa.getSexo());
            Statement.setString("PDocumentoIdentidad", Pasa.getDocumentoIdentidad());
            Statement.setString("PPasaporte", Pasa.getPasaporte());
            Statement.execute();
            JOptionPane.showMessageDialog(null, "Actualizado");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
    }

    public Boolean ExistenciaPasajero(String Document) {
        boolean existencia = false;
        ArrayList<Pasajero> pasajeros = new ArrayList<>();
        try {
            CallableStatement statement = conexion.prepareCall("call SP_S_Pasajero");
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Pasajero psjr = new Pasajero();
                psjr.setIdPasajero(rs.getInt("idPasajero"));
                psjr.setNombres(rs.getString("nombres"));
                psjr.setApellidos(rs.getString("apellidos"));
                psjr.setEdad(rs.getInt("edad"));
                psjr.setSexo(rs.getString("sexo"));
                psjr.setDocumentoIdentidad(rs.getString("documentoIdentidad"));
                psjr.setPasaporte(rs.getString("pasaporte"));
                pasajeros.add(psjr);
            }
            for (var iterarPasajero : pasajeros) {
                if (iterarPasajero.getDocumentoIdentidad().equals(Document)) {
                    existencia = true;
                }
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
        return existencia;
    }
    
    public int IdPasajero(String Document) {
        int idP = 0;
        ArrayList<Pasajero> pasajeros = new ArrayList<>();
        try {
            CallableStatement statement = conexion.prepareCall("call SP_S_Pasajero");
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Pasajero psjr = new Pasajero();
                psjr.setIdPasajero(rs.getInt("idPasajero"));
                psjr.setNombres(rs.getString("nombres"));
                psjr.setApellidos(rs.getString("apellidos"));
                psjr.setEdad(rs.getInt("edad"));
                psjr.setSexo(rs.getString("sexo"));
                psjr.setDocumentoIdentidad(rs.getString("documentoIdentidad"));
                psjr.setPasaporte(rs.getString("pasaporte"));
                pasajeros.add(psjr);
            }
            for (var iterarPasajero : pasajeros) {
                if (iterarPasajero.getDocumentoIdentidad().equals(Document)) {
                    idP = iterarPasajero.getIdPasajero();
                }
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
        return idP;
    }
}
