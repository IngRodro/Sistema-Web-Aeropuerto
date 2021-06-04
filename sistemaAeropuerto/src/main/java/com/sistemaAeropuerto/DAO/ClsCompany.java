package com.sistemaAeropuerto.DAO;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.swing.JOptionPane;

import com.sistemaAeropuerto.Conexion.ConexionBd;
import com.sistemaAeropuerto.Entidades.Company;

public class ClsCompany {


    public ArrayList<Company> MostrarCompany() {
    	
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
        ArrayList<Company> companies = new ArrayList<>();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_S_Company()");
            ResultSet rs = Statement.executeQuery();
            while (rs.next()) {
                Company com = new Company();
                com.setIdCompany(rs.getInt("idCompany"));
                com.setNombre(rs.getString("nombre"));
                String estado = rs.getString("estado");
                if(estado.equals("Activo")) {
                companies.add(com);
                }
            }
            conexion.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return companies;
    }

    public void AgregarCompany(Company Com) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
        try {
            if (ComprobarEstadoCom(Com) == true) {
                if (ComprobarExistenciaCom(Com) == true) {
                } else {
                    CallableStatement Statement = conexion.prepareCall("call SP_I_Company(?)");
                    Statement.setString("PNombre", Com.getNombre());
                    Statement.execute();
                    System.out.println("Guardado");
                }
            }else{
                CallableStatement Statement = conexion.prepareCall("call SP_A_Company(?)");
                Statement.setString("PNombre", Com.getNombre());
                Statement.execute();
                System.out.println("Guardado");
            }
            conexion.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void BorrarCompany(Company Com) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_D_Company(?)");
            Statement.setInt("PidCompany", Com.getIdCompany());
            Statement.execute();
            System.out.println("Eliminado");
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void ActualizarCompany(Company Com) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_U_Company(?,?)");
            Statement.setInt("PidCompany", Com.getIdCompany());
            Statement.setString("PNombre", Com.getNombre());
            Statement.execute();
            System.out.println("Actualizado");
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public boolean ComprobarExistenciaCom(Company Com) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
        
        boolean Existencia = false;
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_S_Company()");
            ResultSet rs = Statement.executeQuery();
            while (rs.next()) {
                if (Com.getNombre().equals(rs.getString("nombre")) && rs.getString("estado").equals("Activo")) {
                    Existencia = true;
                    break;
                };
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return Existencia;
    }

    public boolean ComprobarEstadoCom(Company Com) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
        
        boolean Estado = true;
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_S_Company()");
            ResultSet rs = Statement.executeQuery();
            while (rs.next()) {
                if (Com.getNombre().equals(rs.getString("nombre"))) {
                    if (rs.getString("estado").equals("Inactivo")) {
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
