/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.Laboratorio.DAO;

import com.Laboratorio.Conexion.ConexionBd;
import com.Laboratorio.Entidades.Company;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.swing.JOptionPane;

/**
 *
 * @author Usuario
 */
public class ClsCompany {

	ConexionBd cn = new ConexionBd();
    Connection conexion = cn.RetornarConexion();

    public ArrayList<Company> MostrarCompany() {
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
