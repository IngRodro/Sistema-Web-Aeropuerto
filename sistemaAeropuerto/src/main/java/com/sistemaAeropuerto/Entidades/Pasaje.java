package com.sistemaAeropuerto.Entidades;

public class Pasaje {

	private int idPasaje;
    private int idPasajero;
    private int idVuelo;
    private int idClase;
    private int NAsiento;
    private String nombreUsuario;
    private float precionTotal;
    private int NEscala;
	public int getIdPasaje() {
		return idPasaje;
	}
	public void setIdPasaje(int idPasaje) {
		this.idPasaje = idPasaje;
	}
	public int getIdPasajero() {
		return idPasajero;
	}
	public void setIdPasajero(int idPasajero) {
		this.idPasajero = idPasajero;
	}
	public int getIdVuelo() {
		return idVuelo;
	}
	public void setIdVuelo(int idVuelo) {
		this.idVuelo = idVuelo;
	}
	public int getIdClase() {
		return idClase;
	}
	public void setIdClase(int idClase) {
		this.idClase = idClase;
	}
	public int getNAsiento() {
		return NAsiento;
	}
	public void setNAsiento(int nAsiento) {
		NAsiento = nAsiento;
	}
	public String getNombreUsuario() {
		return nombreUsuario;
	}
	public void setNombreUsuario(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario;
	}
	public float getPrecionTotal() {
		return precionTotal;
	}
	public void setPrecionTotal(float precionTotal) {
		this.precionTotal = precionTotal;
	}
	public int getNEscala() {
		return NEscala;
	}
	public void setNEscala(int nEscala) {
		NEscala = nEscala;
	}

	
}
