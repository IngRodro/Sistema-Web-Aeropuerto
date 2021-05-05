package com.sistemaAeropuerto.DAO;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.swing.JOptionPane;

import com.sistemaAeropuerto.Conexion.ConexionBd;
import com.sistemaAeropuerto.Entidades.Pasaje;

public class ClsPasaje {

	ConexionBd cn = new ConexionBd();
    Connection conexion = cn.RetornarConexion();
    
    public ArrayList<Pasaje> ListaPasaje(int idVuelo, int NEscala){
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
    
    public ArrayList<Pasaje> AsientosOcupados(int idVuelo, int idClase){
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
        return pasajes;
    }
    
    public void AgregarPasaje(Pasaje pasa){
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_I_Pasaje(?,?,?,?,?,?,?)");
            Statement.setInt("PidPasajero", pasa.getIdPasajero());
            Statement.setInt("PidVuelo", pasa.getIdVuelo());
            Statement.setInt("PidClase", pasa.getIdClase());
            Statement.setInt("PNAsiento",pasa.getNAsiento());
            Statement.setFloat("PprecioTotal", pasa.getPrecionTotal());
            Statement.setInt("PNEscala", pasa.getNEscala());
            Statement.setString("PnombreUsuario", "RodroUser");
            Statement.execute();
            System.out.println("Guardado");
            conexion.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    
    public ArrayList<Pasaje> SeleccionarPasajesVuelo(int idVuelo){
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
