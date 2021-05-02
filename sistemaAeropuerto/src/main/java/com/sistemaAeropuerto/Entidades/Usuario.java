package com.sistemaAeropuerto.Entidades;

public class Usuario {

	 private String nombreUsuario;
	    private String nombres;
	    private String apellidos;
	    private int Edad;
	    private String telefono;
	    private String password;
	    private int TipoUser;
	    
		public String getNombreUsuario() {
			return nombreUsuario;
		}
		public void setNombreUsuario(String nombreUsuario) {
			this.nombreUsuario = nombreUsuario;
		}
		public String getNombres() {
			return nombres;
		}
		public void setNombres(String nombres) {
			this.nombres = nombres;
		}
		public String getApellidos() {
			return apellidos;
		}
		public void setApellidos(String apellidos) {
			this.apellidos = apellidos;
		}
		public int getEdad() {
			return Edad;
		}
		public void setEdad(int edad) {
			Edad = edad;
		}
		public String getTelefono() {
			return telefono;
		}
		public void setTelefono(String telefono) {
			this.telefono = telefono;
		}
		public String getPassword() {
			return password;
		}
		public void setPassword(String password) {
			this.password = password;
		}
		public int getTipoUser() {
			return TipoUser;
		}
		public void setTipoUser(int tipoUser) {
			TipoUser = tipoUser;
		}
	
}
