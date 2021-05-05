package com.sistemaAeropuerto.DAO;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;


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
        	System.out.println(e);
        }
        return aeropuertos;
    }

    public void AgregarAeropuerto(Aeropuerto Aero) {
        try {
            if (ComprobarExistenciaAeroP(Aero) == true) {
                if (ComprobarEstadoAeroP(Aero) == true) {
                } else {
                    CallableStatement Statement = conexion.prepareCall("call SP_A_Aeropuerto(?)");
                    Statement.setString("PNombre", Aero.getNombre());
                    Statement.execute();
                }
            } else {
                CallableStatement Statement = conexion.prepareCall("call SP_I_Aeropuerto(?,?,?)");
                Statement.setString("Pnombre", Aero.getNombre());
                Statement.setString("Ppais", Aero.getPais());
                Statement.setString("Pciudad", Aero.getCiudad());
                Statement.execute();
                conexion.close();
            }
        } catch (Exception e) {
        	System.out.println(e);
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
            conexion.close();
        } catch (Exception e) {
        	System.out.println(e);
        }
    }

    public void BorrarAeropuerto(Aeropuerto Aero) {
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_D_Aeropuerto(?)");
            Statement.setInt("PidAeropuerto", Aero.getIdAeropuerto());
            Statement.execute();
        } catch (Exception e) {
        	System.out.println(e);
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
        	System.out.println(e);
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
        	System.out.println(e);
        }
        return Estado;
    }
	
}
