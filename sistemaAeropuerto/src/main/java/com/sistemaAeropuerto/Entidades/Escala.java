package com.sistemaAeropuerto.Entidades;

public class Escala extends Aeropuerto{

	private int idEscala;
    private int numeroEscala;
    private int idItinerario;
    private double Precio;
    private int estado;
    
	public int getIdEscala() {
		return idEscala;
	}
	public void setIdEscala(int idEscala) {
		this.idEscala = idEscala;
	}
	public int getNumeroEscala() {
		return numeroEscala;
	}
	public void setNumeroEscala(int numeroEscala) {
		this.numeroEscala = numeroEscala;
	}
	public int getIdItinerario() {
		return idItinerario;
	}
	public void setIdItinerario(int idItinerario) {
		this.idItinerario = idItinerario;
	}
	public double getPrecio() {
		return Precio;
	}
	public void setPrecio(double precio) {
		Precio = precio;
	}
	public int getEstado() {
		return estado;
	}
	public void setEstado(int estado) {
		this.estado = estado;
	}
	
	
}
