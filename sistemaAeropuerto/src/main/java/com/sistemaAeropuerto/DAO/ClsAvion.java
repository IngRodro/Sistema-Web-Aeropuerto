package com.sistemaAeropuerto.DAO;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.swing.JOptionPane;

import com.sistemaAeropuerto.Conexion.ConexionBd;
import com.sistemaAeropuerto.Entidades.Avion;

public class ClsAvion {
	
	ConexionBd cn = new ConexionBd();
    Connection conexion = cn.RetornarConexion();

    public ArrayList<Avion> MostrarAvion() {
        ArrayList<Avion> companies = new ArrayList<>();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_S_Avion()");
            ResultSet rs = Statement.executeQuery();
            while (rs.next()) {
                Avion com = new Avion();
                com.setIdAvion(rs.getInt("idAvion"));
                com.setModeloAvion(rs.getString("modelo"));
                com.setCapacidad(rs.getInt("capacidad"));
                com.setEstado(rs.getString("estado"));
                companies.add(com);
            }
            conexion.close();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
        return companies;
    }

    public void AgregarAvion(Avion Avi) {
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_I_Avion(?,?)");
            Statement.setString("PModelo", Avi.getModeloAvion());
            Statement.setInt("PCapacidad", Avi.getCapacidad());
            Statement.execute();
            JOptionPane.showMessageDialog(null, "Guardado");
            conexion.close();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
    }

    public void BorrarAvion(Avion Avi) {
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_D_Avion(?)");
            Statement.setInt("PidAvion", Avi.getIdAvion());
            Statement.execute();
            JOptionPane.showMessageDialog(null, "Eliminado");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
    }

    public void ActualizarAvion(Avion Avi) {
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_U_Avion(?,?,?)");
            Statement.setInt("PidAvion", Avi.getIdAvion());
            Statement.setString("PModelo", Avi.getModeloAvion());
            Statement.setInt("PCapacidad", Avi.getCapacidad());
            Statement.execute();
            JOptionPane.showMessageDialog(null, "Actualizado");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
    }

    public Avion SeleccionarAvion(int idAvion) {
        Avion avion = new Avion();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_S_1Avion(?)");
            Statement.setInt("PidAvion", idAvion);
            ResultSet rs = Statement.executeQuery();
            while (rs.next()) {
                avion.setIdAvion(rs.getInt("idAvion"));
                avion.setModeloAvion(rs.getString("modelo"));
                avion.setCapacidad(rs.getInt("capacidad"));
                avion.setEstado(rs.getString("estado"));
            }
            conexion.close();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
        return avion;
    }

    public void EstadoAvion(int idAvion, String Estado) {
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_U_EstadoAvion(?,?)");
            Statement.setInt("PidAvion", idAvion);
            Statement.setString("PEstado", Estado);
            Statement.execute();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
    }

}
