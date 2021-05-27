package com.sistemaAeropuerto.DAO;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.swing.JOptionPane;

import com.sistemaAeropuerto.Conexion.ConexionBd;
import com.sistemaAeropuerto.Entidades.Itinerario;
import com.sistemaAeropuerto.Entidades.Promociones;
import com.sistemaAeropuerto.Entidades.Vuelo;

public class ClsVuelo {

    public ArrayList<InnerJoinVuelo> MostrarVuelos() {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
    	
        ArrayList<InnerJoinVuelo> Vuelos = new ArrayList<>();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_S_VuelosId()");
            ResultSet resultadoDeConsulta = Statement.executeQuery();
            while (resultadoDeConsulta.next()) {
                InnerJoinVuelo InJoin = new InnerJoinVuelo();
                InJoin.setVuelo(resultadoDeConsulta.getInt("Vuelo"));
                InJoin.setCompany(resultadoDeConsulta.getString("Compania"));
                InJoin.setAeropuertoO(resultadoDeConsulta.getString("Aeropuerto_Origen"));
                InJoin.setAeropuertoD(resultadoDeConsulta.getString("Aeropuerto_Destino"));
                InJoin.setModelo(resultadoDeConsulta.getString("Modelo_Avion"));
                InJoin.setTipo(resultadoDeConsulta.getString("Tipo_de_Vuelo"));
                String Fecha = resultadoDeConsulta.getString("Fecha");
                InJoin.setFechaString(Fecha);
                InJoin.setHora(resultadoDeConsulta.getString("Hora"));
                InJoin.setMinutos(resultadoDeConsulta.getString("Minutos"));
                InJoin.setDescuento(resultadoDeConsulta.getDouble("Promo"));
                InJoin.setIdAeropuertO(resultadoDeConsulta.getInt("idAeropuertoO"));
                InJoin.setIdAeropuertoD(resultadoDeConsulta.getInt("idAeropuertoD"));
                InJoin.setIdCompany(resultadoDeConsulta.getInt("idCompany"));
                InJoin.setIdAvion(resultadoDeConsulta.getInt("idAvion"));
                InJoin.setIdTipo(resultadoDeConsulta.getInt("idTipos_vuelo"));
                InJoin.setEstado(resultadoDeConsulta.getInt("Estado"));
                if (InJoin.getEstado() > 0) {
                    Vuelos.add(InJoin);
                }
            }
            conexion.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return Vuelos;
    }

    public void AgregarVuelo(Vuelo vuelo, Itinerario itine) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
        
        try {
            ClsItinerario clsItinerario = new ClsItinerario();
            clsItinerario.AgregarItinerario(itine);
            CallableStatement Statement = conexion.prepareCall("call SP_I_Vuelos(?,?,?)");
            Statement.setInt("PidCompany", vuelo.getIdCompany());
            Statement.setInt("PidAvion", vuelo.getIdAvion());
            Statement.setInt("PidTiposvuelo", vuelo.getIdTiposVuelo());
            Statement.execute();
            System.out.println("Guardado");
            conexion.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public Vuelo SeleccionarVuelo(int idVuelo) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
    	
        Vuelo vuelo = new Vuelo();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_S_1Vuelo(?)");
            Statement.setInt("PidVuelo", idVuelo);
            ResultSet rs = Statement.executeQuery();
            while (rs.next()) {
                vuelo.setIdVuelo(rs.getInt("idVuelo"));
                vuelo.setIdCompany(rs.getInt("idCompany"));
                vuelo.setIdIterinario(rs.getInt("idItinerario"));
                vuelo.setIdTiposVuelo(rs.getInt("idTiposvuelo"));
                vuelo.setIdAvion(rs.getInt("idAvion"));
                vuelo.setEstado(rs.getInt("estado"));
            }

            conexion.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return vuelo;
    }

    public void ActualizarVuelo(Vuelo vuelo, Itinerario Iti, Promociones promo) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
        
        try {
            ClsItinerario clsItinerario = new ClsItinerario();
            Itinerario itiAnti = new Itinerario();
            Vuelo vueloo = new Vuelo();
            vueloo = SeleccionarVuelo(vuelo.getIdVuelo());
            itiAnti = clsItinerario.SeleccionarIterinario(vueloo.getIdIterinario());
            if (vueloo.getEstado() == 2) {
                    if (itiAnti.getFecha().before(Iti.getFecha())) {
                        vuelo.setEstado(3);
                        CambioEstado(vuelo);
                    }
            } else  if (vueloo.getEstado() == 1) {
                if (itiAnti.getFecha().before(Iti.getFecha())) {
                    vuelo.setEstado(3);
                    CambioEstado(vuelo);
                } else if (Integer.parseInt(itiAnti.getHora()) < Integer.parseInt(Iti.getHora())) {
                    vuelo.setEstado(2);
                    CambioEstado(vuelo);
                } else if (Integer.parseInt(itiAnti.getMinutos()) < Integer.parseInt(Iti.getMinutos())) {
                    vuelo.setEstado(2);
                    CambioEstado(vuelo);
                }
            }
            clsItinerario.ActualizarItinerario(Iti, vuelo);
            ClsPromocion clsPromo = new ClsPromocion();
            clsPromo.ActualizarPromo(promo, vuelo);
            CallableStatement Statement = conexion.prepareCall("call SP_U_Vuelos(?,?,?,?)");
            Statement.setInt("PidCompany", vuelo.getIdCompany());
            Statement.setInt("PidAvion", vuelo.getIdAvion());
            Statement.setInt("PidTiposvuelo", vuelo.getIdTiposVuelo());
            Statement.setInt("PidVuelo", vuelo.getIdVuelo());
            Statement.execute();
            System.out.println("Vuelo Actualizado");
            conexion.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public ArrayList<InnerJoinVuelo> MostrarVuelosOrigen(int idAeropuerto) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
    	
        ArrayList<InnerJoinVuelo> Vuelos = new ArrayList<>();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_S_VuelosOrigen(?)");
            Statement.setInt("PidAeropuerto", idAeropuerto);
            ResultSet resultadoDeConsulta = Statement.executeQuery();
            while (resultadoDeConsulta.next()) {
                InnerJoinVuelo InJoin = new InnerJoinVuelo();
                InJoin.setVuelo(resultadoDeConsulta.getInt("Vuelo"));
                InJoin.setCompany(resultadoDeConsulta.getString("Compania"));
                InJoin.setAeropuertoO(resultadoDeConsulta.getString("Aeropuerto_Origen"));
                InJoin.setAeropuertoD(resultadoDeConsulta.getString("Aeropuerto_Destino"));
                InJoin.setModelo(resultadoDeConsulta.getString("Modelo_Avion"));
                InJoin.setTipo(resultadoDeConsulta.getString("Tipo_de_Vuelo"));
                InJoin.setFecha(resultadoDeConsulta.getDate("Fecha"));
                InJoin.setHora(resultadoDeConsulta.getString("Hora"));
                InJoin.setMinutos(resultadoDeConsulta.getString("Minutos"));
                InJoin.setDescuento(resultadoDeConsulta.getDouble("Promo"));
                InJoin.setFechaFinalDesc(resultadoDeConsulta.getDate("FechaMax"));
                InJoin.setFechaInicioDesc(resultadoDeConsulta.getDate("FechaIni"));
                InJoin.setEstado(resultadoDeConsulta.getInt("Estado"));
                if (InJoin.getEstado() > 0) {
                    Vuelos.add(InJoin);
                }
            }
            conexion.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return Vuelos;
    }

    public void VueloFinalizado(Vuelo vuelo) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_U_VueloFinalizado(?)");
            Statement.setInt("PidVuelo", vuelo.getIdVuelo());
            Statement.execute();
            System.out.println("Vuelo Marcado como Finalizado");
            conexion.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void CambioEstado(Vuelo vuelo) {
    	ConexionBd cn = new ConexionBd();
        Connection conexion = cn.RetornarConexion();
    	
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_U_EstadoVuelo(?,?)");
            Statement.setInt("PidVuelo", vuelo.getIdVuelo());
            Statement.setInt("PEstado", vuelo.getEstado());
            Statement.execute();
            conexion.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    
    
        public Vuelo SeleccionarVuelodeItinerario(int idItinerario) {
        	ConexionBd cn = new ConexionBd();
            Connection conexion = cn.RetornarConexion();
        	
        Vuelo vuelo = new Vuelo();
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_S_VueloItinerario(?)");
            Statement.setInt("PidItinerario", idItinerario);
            ResultSet rs = Statement.executeQuery();
            while (rs.next()) {
                vuelo.setIdVuelo(rs.getInt("idVuelo"));
                vuelo.setIdCompany(rs.getInt("idCompany"));
                vuelo.setIdIterinario(rs.getInt("idItinerario"));
                vuelo.setIdTiposVuelo(rs.getInt("idTiposvuelo"));
                vuelo.setIdAvion(rs.getInt("idAvion"));
                vuelo.setEstado(rs.getInt("estado"));
            }

            conexion.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return vuelo;
    }
	
}
