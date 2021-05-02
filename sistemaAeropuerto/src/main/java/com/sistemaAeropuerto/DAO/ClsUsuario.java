package com.sistemaAeropuerto.DAO;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.swing.JOptionPane;

import com.sistemaAeropuerto.Conexion.ConexionBd;
import com.sistemaAeropuerto.Entidades.Usuario;

public class ClsUsuario {

	ConexionBd cn = new ConexionBd();
    Connection conexion = cn.RetornarConexion();

    public boolean LoguinUser(String usuario, String Pass) {
        ArrayList<Usuario> ListaUser = new ArrayList<>();
        ArrayList<Usuario> ListarContra = new ArrayList<>();
        try {
            CallableStatement st = conexion.prepareCall("call SP_S_LOGUINUSUARIO(?,?)");

            st.setString("pUsuario", usuario);
            st.setString("pPass", Pass);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Usuario user = new Usuario();
                user.setNombreUsuario(rs.getNString("nombreUsuario"));
                user.setPassword(rs.getNString("Password"));
                ListaUser.add(user);
            }
            String usuariodebasedatos = null;
            String passdebasededatos = null;
            for (var iterador : ListaUser) {
                usuariodebasedatos = iterador.getNombreUsuario();
                passdebasededatos = iterador.getPassword();

            }

            CallableStatement st2 = conexion.prepareCall("call SP_S_CRIPSHA2(?)");
            st2.setString("PcripPass", Pass);
            ResultSet rs2 = st2.executeQuery();
            while (rs2.next()) {
                Usuario usercrip = new Usuario();

                usercrip.setPassword(rs2.getNString("crip"));
                ListarContra.add(usercrip);
            }

            String passcrip = null;
            for (var iterador : ListarContra) {

                passcrip = iterador.getPassword();

                Pass = passcrip;

            }

            if (usuariodebasedatos != null && passdebasededatos != null) {
                if (usuariodebasedatos.equals(usuario) && passdebasededatos.equals(Pass)) {
                    return true;
                }
            }
            conexion.close();

        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
        return false;
    }

    public void AgregarUsuario(Usuario user) {
        try {
            CallableStatement Statement = conexion.prepareCall("call SP_I_Usuario(?,?,?,?,?,?,?)");
            Statement.setString("pNombreUsuario", user.getNombreUsuario());
            Statement.setString("pNombres", user.getNombres());
            Statement.setString("pApellidos", user.getApellidos());
            Statement.setString("pTelefono", user.getTelefono());
            Statement.setInt("pEdad", user.getEdad());
            Statement.setString("pPassword", user.getPassword());
            Statement.setInt("pTipoUser", user.getTipoUser());
            Statement.execute();
            JOptionPane.showMessageDialog(null, "Usuario Registrado con Exito");
            conexion.close();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }

    }

    public int TipoUser(String usuario) {
        int Tipo;
        Usuario user = new Usuario();
        try {
            CallableStatement Statement = conexion.prepareCall("Call SP_S_1Usuario(?)");
            Statement.setString("PnombreUsuario", usuario);
            ResultSet rs = Statement.executeQuery();
            while (rs.next()) {
            user.setTipoUser(rs.getInt("TipoUsuario"));
            }
        } catch (Exception e) {
        }
        Tipo = user.getTipoUser();
        return Tipo;

    }
    
    public boolean ComprobarExistencia(String usuario) {
        boolean Existencia = false;
        try {
            CallableStatement Statement = conexion.prepareCall("Call SP_S_1Usuario(?)");
            Statement.setString("PnombreUsuario", usuario);
            ResultSet rs = Statement.executeQuery();
            while (rs.next()) {
                Existencia = true;
            }
        } catch (Exception e) {
        }
        
        return Existencia;

    }
    
}
