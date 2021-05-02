package com.sistemaAeropuerto.DAO;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.swing.JOptionPane;

import com.sistemaAeropuerto.Conexion.ConexionBd;
import com.sistemaAeropuerto.Entidades.Aeropuerto;

public class ClsAeropuerto {

	ConexionBd cn = new ConexionBd();
    Connection conexion = cn.RetornarConexion();

    public ArrayList<Aeropuerto> MostrAeropuerto() {
        ArrayList<Aeropuerto> aeropuertos = new ArrayList<>();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_S_Aeropuerto()");
            ResultSet resultadoDeConsulta = Statement.executeQuery();
            while (resultadoDeConsulta.next()) {
                Aeropuerto aeropuerto = new Aeropuerto();
                aeropuerto.setIdAeropuerto(resultadoDeConsulta.getInt("idAeropuerto"));
                aeropuerto.setNombre(resultadoDeConsulta.getString("nombre"));
                aeropuerto.setPais(resultadoDeConsulta.getString("pais"));
                aeropuerto.setCiudad(resultadoDeConsulta.getString("ciudad"));
                aeropuertos.add(aeropuerto);
            }
            conexion.close();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
        return aeropuertos;
    }

    public void AgregarAeropuerto(Aeropuerto Aero) {
        try {
            if (ComprobarExistenciaAeroP(Aero) == true) {
                if (ComprobarEstadoAeroP(Aero) == true) {
                    JOptionPane.showMessageDialog(null, "La Compañia ya se encuentra registrada");
                } else {
                    CallableStatement Statement = conexion.prepareCall("call SP_A_Aeropuerto(?)");
                    Statement.setString("PNombre", Aero.getNombre());
                    Statement.execute();
                    JOptionPane.showMessageDialog(null, "Aeropuerto Registrado");
                }
            } else {
                CallableStatement Statement = conexion.prepareCall("call SP_I_Aeropuerto(?,?,?)");
                Statement.setString("Pnombre", Aero.getNombre());
                Statement.setString("Ppais", Aero.getPais());
                Statement.setString("Pciudad", Aero.getCiudad());
                Statement.execute();
                JOptionPane.showMessageDialog(null, "Aeropuerto Registrado");
                conexion.close();
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
    }

    public void ActualizarAeropuerto(Aeropuerto Aero) {
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_U_Aeropuerto(?,?,?,?)");
            Statement.setInt("PidAeropuerto", Aero.getIdAeropuerto());
            Statement.setString("Pnombre", Aero.getNombre());
            Statement.setString("Ppais", Aero.getPais());
            Statement.setString("Pciudad", Aero.getCiudad());
            Statement.execute();
            JOptionPane.showMessageDialog(null, "Guardado");
            conexion.close();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
    }

    public void BorrarAeropuerto(Aeropuerto Aero) {
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_D_Aeropuerto(?)");
            Statement.setInt("PidAeropuerto", Aero.getIdAeropuerto());
            Statement.execute();
            JOptionPane.showMessageDialog(null, "Eliminado");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
    }

    public boolean ComprobarExistenciaAeroP(Aeropuerto Aero) {
        boolean Existencia = false;
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_S_Company()");
            ResultSet rs = Statement.executeQuery();
            while (rs.next()) {
                if (Aero.getNombre().equals(rs.getString("nombre"))) {
                    Existencia = true;
                    break;
                };
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
        return Existencia;
    }

    public boolean ComprobarEstadoAeroP(Aeropuerto Aero) {
        boolean Estado = true;
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_S_Company()");
            ResultSet rs = Statement.executeQuery();
            while (rs.next()) {
                if (Aero.getNombre().equals(rs.getString("nombre"))) {
                    if (rs.getString("nombre").equals("Inactivo")) {
                        Estado = false;
                    }
                };
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
        return Estado;
    }
	
}
