package com.sistemaAeropuerto.Negocio;

import com.sistemaAeropuerto.DAO.ClsUsuario;
import com.sistemaAeropuerto.Entidades.Usuario;

public class ClsLoguin {

ClsUsuario clsusuario = new ClsUsuario();
	
	public int acceso(Usuario user) {
		int acceso = 0;
		if(clsusuario.LoguinUser(user.getNombreUsuario(), user.getPassword())==true) {
			acceso = 1;
		}
		else {
			
		}
		return acceso;
	}
	
	public int tipoacceso(Usuario user) {
		int tipoacceso = 0;
		if(clsusuario.TipoUser(user.getNombreUsuario())==1) {
			tipoacceso = 1;
		}
		else {
			
		}
		return tipoacceso;
	}
	
}
