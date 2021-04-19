package com.Laboratorio.Negocio;

import com.Laboratorio.Entidades.Usuario;
import com.Laboratorio.DAO.ClsUsuario;

public class clsLoguin {
	
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
