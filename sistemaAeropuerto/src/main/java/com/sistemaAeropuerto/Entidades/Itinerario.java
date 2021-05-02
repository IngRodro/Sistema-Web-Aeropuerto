package com.sistemaAeropuerto.Entidades;

import java.util.Date;

public class Itinerario {

	private int idItinerario;
    private int idAeropuertoDestino;
    private int idAeropuertoOrigen;
    private int idEscala;
    private Date fecha;
    private String hora;
    private String minutos;
	public int getIdItinerario() {
		return idItinerario;
	}
	public void setIdItinerario(int idItinerario) {
		this.idItinerario = idItinerario;
	}
	public int getIdAeropuertoDestino() {
		return idAeropuertoDestino;
	}
	public void setIdAeropuertoDestino(int idAeropuertoDestino) {
		this.idAeropuertoDestino = idAeropuertoDestino;
	}
	public int getIdAeropuertoOrigen() {
		return idAeropuertoOrigen;
	}
	public void setIdAeropuertoOrigen(int idAeropuertoOrigen) {
		this.idAeropuertoOrigen = idAeropuertoOrigen;
	}
	public int getIdEscala() {
		return idEscala;
	}
	public void setIdEscala(int idEscala) {
		this.idEscala = idEscala;
	}
	public Date getFecha() {
		return fecha;
	}
	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}
	public String getHora() {
		return hora;
	}
	public void setHora(String hora) {
		this.hora = hora;
	}
	public String getMinutos() {
		return minutos;
	}
	public void setMinutos(String minutos) {
		this.minutos = minutos;
	}
	
}
