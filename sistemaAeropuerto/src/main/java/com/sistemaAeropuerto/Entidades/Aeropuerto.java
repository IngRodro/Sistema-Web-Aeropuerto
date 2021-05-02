package com.sistemaAeropuerto.Entidades;

public class Aeropuerto {

	 private int idAeropuerto;
	    private String nombre;
	    private String pais;
	    private String ciudad;
		public int getIdAeropuerto() {
			return idAeropuerto;
		}
		public void setIdAeropuerto(int idAeropuerto) {
			this.idAeropuerto = idAeropuerto;
		}
		public String getNombre() {
			return nombre;
		}
		public void setNombre(String nombre) {
			this.nombre = nombre;
		}
		public String getPais() {
			return pais;
		}
		public void setPais(String pais) {
			this.pais = pais;
		}
		public String getCiudad() {
			return ciudad;
		}
		public void setCiudad(String ciudad) {
			this.ciudad = ciudad;
		}
	
}
