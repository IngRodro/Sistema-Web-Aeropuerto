package com.sistemaAeropuerto.DAO;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.swing.JOptionPane;

import com.sistemaAeropuerto.Conexion.ConexionBd;
import com.sistemaAeropuerto.Entidades.Avion;
import com.sistemaAeropuerto.Entidades.Clases;
import com.sistemaAeropuerto.Entidades.Company;
import com.sistemaAeropuerto.Entidades.Pasaje;
import com.sistemaAeropuerto.Entidades.Vuelo;

public class ClsClase {


    public ArrayList<Clases> MostrarClase(int idAvion) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();

        ClsVuelo clsV = new ClsVuelo();
        ClsPasaje clsP = new ClsPasaje();
        ArrayList<Clases> clases = new ArrayList<>();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_S_Clase(?)");
            Statement.setInt("PidAvion", idAvion);
            ResultSet rs = Statement.executeQuery();
            while (rs.next()) {
                Clases clase = new Clases();
                clase.setIdClase(rs.getInt("idClases"));
                clase.setnAsientos(rs.getInt("nAsientos"));
                clase.setNombreClase(rs.getString("nombreClase"));
                clase.setPorcentajeEPrecio(rs.getDouble("porcentajeEPrecio"));
                clase.setIdAvion(rs.getInt("idAvion"));
                Vuelo vuelo = new Vuelo();
                vuelo = clsV.SeleccionarVuelodeAvion(idAvion);
                ArrayList<Pasaje> listaPasaje = clsP.ListaPasajeClase(vuelo.getIdVuelo(), clase.getIdClase());
                if(listaPasaje.size() > 0) {
                	clase.setEstado(0);
                }else {
                	clase.setEstado(1);
                }
                if(rs.getInt("estado") == 1) {
                	clases.add(clase);
                }
            }
            conexion.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return clases;
    }

    public void AgregarClase(Clases clase) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
        try {
        	 if (ComprobarEstadoClass(clase) == true) {
                 if (ComprobarExistenciaClass(clase) == true) {
                 } else {
                     CallableStatement Statement = conexion.prepareCall("call SP_I_Clase(?,?,?,?)");
                     Statement.setString("PnombreClase", clase.getNombreClase());
                     Statement.setInt("PnAsientos", clase.getnAsientos());
                     Statement.setInt("PidAvion", clase.getIdAvion());
                     Statement.setDouble("PPorcentajeEprecio", clase.getPorcentajeEPrecio());
                     Statement.execute();
                     conexion.close();
                 }
             }else{
            	 CallableStatement Statement = conexion.prepareCall("call SP_A_Clase(?,?,?,?)");
                 Statement.setString("PnombreClase", clase.getNombreClase());
                 Statement.setInt("PnAsientos", clase.getnAsientos());
                 Statement.setInt("PidAvion", clase.getIdAvion());
                 Statement.setDouble("PPorcentajeEprecio", clase.getPorcentajeEPrecio());
                 Statement.execute();
                 conexion.close();
             }
        	
            
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void BorrarClase(Clases clase) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_D_Clase(?)");
            Statement.setInt("PidClase", clase.getIdClase());
            Statement.execute();
            System.out.println("Eliminado");
        } catch (Exception e) {
            System.out.println(e);

        }
    }

    public boolean ComprobarExistenciaClass(Clases clase) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
        
        boolean Existencia = false;
        try {
        	CallableStatement Statement = conexion.prepareCall("call SP_S_Clase(?)");
        	 Statement.setInt("PidAvion", clase.getIdAvion());
             ResultSet rs = Statement.executeQuery();
            while (rs.next()) {
                if (clase.getNombreClase().equals(rs.getString("nombreClase")) && rs.getInt("estado") == 1) {
                    Existencia = true;
                    break;
                };
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return Existencia;
    }
    
    public void ActualizarClase(Clases clase) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_U_Clase(?,?,?,?,?)");
            Statement.setString("PnombreClase", clase.getNombreClase());
            Statement.setInt("PnAsientos", clase.getnAsientos());
            Statement.setDouble("PPorcentajeEprecio", clase.getPorcentajeEPrecio());
            Statement.setDouble("PidClase", clase.getIdClase());
            Statement.execute();
            System.out.println("Actualizado");
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    
    public Clases SeleccionarClase(int idClase) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
       Clases clase = new Clases();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_S_1Clase(?)");
            Statement.setInt("PidClases", idClase);
            ResultSet rs = Statement.executeQuery();
            while (rs.next()) {
                clase.setIdClase(rs.getInt("idClases"));
                clase.setnAsientos(rs.getInt("nAsientos"));
                clase.setNombreClase(rs.getString("nombreClase"));
                clase.setPorcentajeEPrecio(rs.getDouble("porcentajeEPrecio"));
                clase.setIdAvion(rs.getInt("idAvion"));
            }
            conexion.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return clase;
    }
	
    public int MaximoAsientosDisponibles(int idAvion) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
    	ClsAvion clsAvion = new ClsAvion();
    	Avion avion = new Avion();
    	avion = clsAvion.SeleccionarAvion(idAvion);
        int Asientos = avion.getCapacidad();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_S_Clase(?)");
            Statement.setInt("PidAvion", idAvion);
            ResultSet rs = Statement.executeQuery();
            while (rs.next()) {
            	if(rs.getInt("estado") == 1) {
            	Asientos = Asientos -(rs.getInt("nAsientos"));
            	}
            }
            conexion.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return Asientos;
    }
    
    public boolean ComprobarEstadoClass(Clases clase) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
        
        boolean Estado = true;
        try {
        	CallableStatement Statement = conexion.prepareCall("call SP_S_Clase(?)");
       	 Statement.setInt("PidAvion", clase.getIdAvion());
            ResultSet rs = Statement.executeQuery();
            while (rs.next()) {
                if (clase.getNombreClase().equals(rs.getString("nombreClase"))) {
                    if (rs.getInt("estado") == 0) {
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
