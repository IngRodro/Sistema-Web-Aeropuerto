package com.sistemaAeropuerto.Entidades;

public class Tipos_vuelo {

	private int idTipos_vuelo;
    private String Tipo;
    private Double PorcentajeDesc;
    
	public int getIdTipos_vuelo() {
		return idTipos_vuelo;
	}
	public void setIdTipos_vuelo(int idTipos_vuelo) {
		this.idTipos_vuelo = idTipos_vuelo;
	}
	public String getTipo() {
		return Tipo;
	}
	public void setTipo(String tipo) {
		Tipo = tipo;
	}
	public Double getPorcentajeDesc() {
		return PorcentajeDesc;
	}
	public void setPorcentajeDesc(Double porcentajeDesc) {
		PorcentajeDesc = porcentajeDesc;
	}
	
}
