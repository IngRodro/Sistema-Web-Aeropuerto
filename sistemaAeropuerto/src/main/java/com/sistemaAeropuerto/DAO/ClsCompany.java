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
                companies.add(com);
            }
            conexion.close();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
        return companies;
    }

    public void AgregarCompany(Company Com) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
        try {
            if (ComprobarExistenciaCom(Com) == true) {
                if (ComprobarEstadoCom(Com) == true) {
                    JOptionPane.showMessageDialog(null, "La Compañia ya se encuentra registrada");
                } else {
                    CallableStatement Statement = conexion.prepareCall("call SP_A_Company(?)");
                    Statement.setString("PNombre", Com.getNombre());
                    Statement.execute();
                    JOptionPane.showMessageDialog(null, "Guardado");
                }
            } else {
                CallableStatement Statement = conexion.prepareCall("call SP_I_Company(?)");
                Statement.setString("PNombre", Com.getNombre());
                Statement.execute();
                JOptionPane.showMessageDialog(null, "Guardado");
            }
            conexion.close();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
    }

    public void BorrarCompany(Company Com) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_D_Company(?)");
            Statement.setInt("PidCompany", Com.getIdCompany());
            Statement.execute();
            JOptionPane.showMessageDialog(null, "Eliminado");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
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
            JOptionPane.showMessageDialog(null, "Actualizado");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
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
                if (Com.getNombre().equals(rs.getString("nombre"))) {
                    Existencia = true;
                    break;
                };
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
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
