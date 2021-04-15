/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.Laboratorio.DAO;

import com.Laboratorio.Entidades.Vuelo;
import com.Laboratorio.Conexion.ConexionBd;
import com.Laboratorio.Entidades.Promociones;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import javax.swing.JOptionPane;

/**
 *
 * @author Usuario
 */
public class ClsPromocion {

	ConexionBd cn = new ConexionBd();
    Connection conexion = cn.RetornarConexion();

    public void AgregarPromo(Promociones Promo) {
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_I_Promocion(?,?,?)");
            if (Promo.getFechaInicio() == null && Promo.getFechaFinal() == null) {
                Statement.setDate("PfechaInicio", null);
                Statement.setDate("PfechaFinal", null);
                Statement.setDouble("PDescuento", Promo.getDescuento());
                Statement.execute();
            } else {
                Statement.setDate("PfechaInicio", new java.sql.Date(Promo.getFechaInicio().getTime()));
                Statement.setDate("PfechaFinal", new java.sql.Date(Promo.getFechaFinal().getTime()));
                Statement.setDouble("PDescuento", Promo.getDescuento());
                Statement.execute();
            }

            JOptionPane.showMessageDialog(null, "Guardado");
            conexion.close();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
    }

    public void ActualizarPromo(Promociones Promo, Vuelo vuelo) {
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_U_Promocion(?,?,?,?)");
            Statement.setInt("PidVuelo", vuelo.getIdVuelo());
            Statement.setDate("PfechaInicio", new java.sql.Date(Promo.getFechaInicio().getTime()));
            Statement.setDate("PfechaFinal", new java.sql.Date(Promo.getFechaFinal().getTime()));
            Statement.setDouble("PDescuento", Promo.getDescuento());
            Statement.execute();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
    }

    public Promociones SeleccionarPromo(int idVuelo) {
        Promociones promo = new Promociones();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_S_1Promocion(?)");
            Statement.setInt("PidVuelo", idVuelo);
            ResultSet resultadoDeConsulta = Statement.executeQuery();
            while (resultadoDeConsulta.next()) {
                promo.setDescuento(resultadoDeConsulta.getDouble("Descuento"));
                promo.setFechaInicio(resultadoDeConsulta.getDate("FechaInicio"));
                promo.setFechaFinal(resultadoDeConsulta.getDate("FechaFinal"));
            }
            conexion.close();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
        return promo;
    }

}
