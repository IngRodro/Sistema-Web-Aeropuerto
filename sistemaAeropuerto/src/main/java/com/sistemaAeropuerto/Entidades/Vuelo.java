package com.sistemaAeropuerto.Entidades;

public class Vuelo {

	private int idVuelo;
    private int idCompany;
    private int idIterinario;
    private int idAvion;
    private int idTiposVuelo;
    private int Estado;
    
	public int getIdVuelo() {
		return idVuelo;
	}
	public void setIdVuelo(int idVuelo) {
		this.idVuelo = idVuelo;
	}
	public int getIdCompany() {
		return idCompany;
	}
	public void setIdCompany(int idCompany) {
		this.idCompany = idCompany;
	}
	public int getIdIterinario() {
		return idIterinario;
	}
	public void setIdIterinario(int idIterinario) {
		this.idIterinario = idIterinario;
	}
	public int getIdAvion() {
		return idAvion;
	}
	public void setIdAvion(int idAvion) {
		this.idAvion = idAvion;
	}
	public int getIdTiposVuelo() {
		return idTiposVuelo;
	}
	public void setIdTiposVuelo(int idTiposVuelo) {
		this.idTiposVuelo = idTiposVuelo;
	}
	public int getEstado() {
		return Estado;
	}
	public void setEstado(int estado) {
		Estado = estado;
	}
	
}
