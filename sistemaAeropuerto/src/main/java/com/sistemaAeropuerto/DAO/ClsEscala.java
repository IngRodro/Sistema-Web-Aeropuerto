package com.sistemaAeropuerto.DAO;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.swing.JOptionPane;

import com.sistemaAeropuerto.Conexion.ConexionBd;
import com.sistemaAeropuerto.Entidades.Escala;

public class ClsEscala {

	
    public ArrayList<Escala> MostrarEscala(int idIti) {
    	
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
    	
        ArrayList<Escala> escalas = new ArrayList<>();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_S_Escala(?)");
            Statement.setInt("PidIterinario", idIti);
            ResultSet rs = Statement.executeQuery();
            while (rs.next()) {
                Escala esc = new Escala();
                esc.setIdEscala(rs.getInt("idEscala"));
                esc.setNumeroEscala(rs.getInt("numeroEscala"));
                esc.setNombre(rs.getString("nombre"));
                esc.setPrecio(rs.getDouble("Precio"));
                esc.setIdAeropuerto(rs.getInt("idAeropuerto"));
                esc.setIdItinerario(rs.getInt("idItinerario"));
                escalas.add(esc);
            }
            conexion.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return escalas;
    }

    public void AgregarEscala(Escala Esc, int idIti) {
    	
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_I_Escala(?,?,?,?)");
            Statement.setInt("PnumeroEscala", Esc.getNumeroEscala());
            Statement.setInt("PidAeropuerto", Esc.getIdAeropuerto());
            Statement.setInt("PidiIterinario", idIti);
            Statement.setDouble("PPrecio", Esc.getPrecio());
            Statement.execute();
            System.out.println("Guardado");
            conexion.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void BorrarEscala(Escala Esc) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_D_Escala(?)");
            Statement.setInt("PidEscala", Esc.getIdEscala());
            Statement.execute();
            System.out.println("Eliminado");
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void ActualizarEscala(Escala Esc) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_U_Escala(?,?,?)");
            Statement.setInt("PidEscala", Esc.getIdEscala());
            Statement.setInt("PidAeropuerto", Esc.getIdAeropuerto());
            Statement.setDouble("PPrecio", Esc.getPrecio());
            Statement.execute();
            System.out.println("Actualizado");
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public Escala SeleccionarEscala(int idEsc) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
        Escala esc = new Escala();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_S_1Escala(?)");
            Statement.setInt("PidEscala", idEsc);
            ResultSet rs = Statement.executeQuery();
            while (rs.next()) {
                esc.setIdEscala(rs.getInt("idEscala"));
                esc.setNumeroEscala(rs.getInt("numeroEscala"));
                esc.setIdAeropuerto(rs.getInt("idAeropuerto"));
                esc.setPrecio(rs.getDouble("Precio"));
            }
            conexion.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return esc;
    }

    public ArrayList<Escala> EscalasSuperiores(int idIti, int NEscala) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
    	
        ArrayList<Escala> escalas = new ArrayList<>();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_S_Escala(?)");
            Statement.setInt("PidIterinario", idIti);
            ResultSet rs = Statement.executeQuery();
            while (rs.next()) {
                Escala esc = new Escala();
                esc.setIdEscala(rs.getInt("idEscala"));
                esc.setNumeroEscala(rs.getInt("numeroEscala"));
                esc.setNombre(rs.getString("nombre"));
                esc.setIdItinerario(rs.getInt("idItinerario"));
                if (esc.getNumeroEscala() > NEscala) {
                    escalas.add(esc);
                }
            }
            conexion.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return escalas;
    }

    public void ActualizarNEscala(int idItinerario, int NEscala) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
    	
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_U_NEscala(?,?)");
            Statement.setInt("PidItinerario", idItinerario);
            Statement.setInt("PNEscala", NEscala);
            Statement.execute();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public Boolean ComprobarEscala(int idIti, int idAero) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
        Boolean Existencia = false;
        
        ArrayList<Escala> escalas = new ArrayList<>();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_S_Escala(?)");
            Statement.setInt("PidIterinario", idIti);
            ResultSet rs = Statement.executeQuery();
            while (rs.next()) {
                Escala esc = new Escala();
                esc.setIdAeropuerto(rs.getInt("idAeropuerto"));
                escalas.add(esc);
            }
            conexion.close();
            for (var iteraridAeropuerto : escalas) {
                if (iteraridAeropuerto.getIdAeropuerto() == idAero) {
                    Existencia = true;
                }
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return Existencia;
    }

 public int UltimaEscala(int idIti) {
	 
	 ConexionBd cn = new ConexionBd();
	    Connection conexion = cn.RetornarConexion();
    	
        int NEscala = 0;
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_S_Escala(?)");
            Statement.setInt("PidIterinario", idIti);
            ResultSet rs = Statement.executeQuery();
            while (rs.next()) {
                NEscala = NEscala + 1;
            }
            conexion.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return NEscala;
    }

    
}
