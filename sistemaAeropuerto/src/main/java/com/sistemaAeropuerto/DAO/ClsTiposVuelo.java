package com.sistemaAeropuerto.DAO;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.swing.JOptionPane;

import com.sistemaAeropuerto.Conexion.ConexionBd;
import com.sistemaAeropuerto.Entidades.Tipos_vuelo;

public class ClsTiposVuelo {

	ConexionBd cn = new ConexionBd();
    Connection conexion = cn.RetornarConexion();

    public ArrayList<Tipos_vuelo> MostrarTipos() {
        ArrayList<Tipos_vuelo> companies = new ArrayList<>();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_S_Tipos()");
            ResultSet rs = Statement.executeQuery();
            while (rs.next()) {
                Tipos_vuelo tipo = new Tipos_vuelo();
                tipo.setIdTipos_vuelo(rs.getInt("idTipos_vuelo"));
                tipo.setTipo(rs.getString("Tipo"));
                tipo.setPorcentajeDesc(rs.getDouble("PorcentajeDesc"));
                companies.add(tipo);
            }
            conexion.close();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
        return companies;
    }

    public void AgregarTipo(Tipos_vuelo Tipo) {
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_I_Tipos(?,?)");
            Statement.setString("PTipo", Tipo.getTipo());
            Statement.setDouble("PDescuento", Tipo.getPorcentajeDesc());
            Statement.execute();
            JOptionPane.showMessageDialog(null, "Guardado");
            conexion.close();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
    }

    public void BorrarTipo(Tipos_vuelo Tipo) {
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_D_Avion(?)");
            Statement.setInt("PidTipos_vuelo", Tipo.getIdTipos_vuelo());
            Statement.execute();
            JOptionPane.showMessageDialog(null, "Eliminado");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
    }

    public void ActualizarTipo(Tipos_vuelo Tipo) {
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_U_Avion(?,?,?)");
            Statement.setInt("PidTipos_vuelo", Tipo.getIdTipos_vuelo());
            Statement.setString("PTipo", Tipo.getTipo());
            Statement.setDouble("PDescuento", Tipo.getPorcentajeDesc());
            Statement.execute();
            JOptionPane.showMessageDialog(null, "Actualizado");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
    }

    public Tipos_vuelo SeleccionarTipo(int idTipo) {
        Tipos_vuelo tipo = new Tipos_vuelo();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_S_1Tipo(?)");
            Statement.setInt("PidTipo", idTipo);
            ResultSet rs = Statement.executeQuery();
            while (rs.next()) {
                tipo.setIdTipos_vuelo(rs.getInt("idTipos_vuelo"));
                tipo.setTipo(rs.getString("Tipo"));
                tipo.setPorcentajeDesc(rs.getDouble("PorcentajeDesc"));
            }
            conexion.close();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
        return tipo;
    }

}
