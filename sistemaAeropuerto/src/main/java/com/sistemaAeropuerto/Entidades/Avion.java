package com.sistemaAeropuerto.Entidades;

public class Avion {

	  private int idAvion;
	    private String modeloAvion;
	    private int capacidad;
	    String estado;
	    
		public int getIdAvion() {
			return idAvion;
		}
		public void setIdAvion(int idAvion) {
			this.idAvion = idAvion;
		}
		public String getModeloAvion() {
			return modeloAvion;
		}
		public void setModeloAvion(String modeloAvion) {
			this.modeloAvion = modeloAvion;
		}
		public int getCapacidad() {
			return capacidad;
		}
		public void setCapacidad(int capacidad) {
			this.capacidad = capacidad;
		}
		public String getEstado() {
			return estado;
		}
		public void setEstado(String estado) {
			this.estado = estado;
		}
	
}
