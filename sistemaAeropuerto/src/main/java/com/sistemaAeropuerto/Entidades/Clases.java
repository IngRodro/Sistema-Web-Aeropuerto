package com.sistemaAeropuerto.Entidades;

public class Clases {

	private int idClase;
    private String nombreClase;
    private int nAsientos;
    private int idAvion;
    private Double porcentajeEPrecio;
    private int estado;
	public int getIdClase() {
		return idClase;
	}
	public void setIdClase(int idClase) {
		this.idClase = idClase;
	}
	public String getNombreClase() {
		return nombreClase;
	}
	public void setNombreClase(String nombreClase) {
		this.nombreClase = nombreClase;
	}
	public int getnAsientos() {
		return nAsientos;
	}
	public void setnAsientos(int nAsientos) {
		this.nAsientos = nAsientos;
	}
	public int getIdAvion() {
		return idAvion;
	}
	public void setIdAvion(int idAvion) {
		this.idAvion = idAvion;
	}
	public Double getPorcentajeEPrecio() {
		return porcentajeEPrecio;
	}
	public void setPorcentajeEPrecio(Double porcentajeEPrecio) {
		this.porcentajeEPrecio = porcentajeEPrecio;
	}
	public int getEstado() {
		return estado;
	}
	public void setEstado(int estado) {
		this.estado = estado;
	}
	
	
}
