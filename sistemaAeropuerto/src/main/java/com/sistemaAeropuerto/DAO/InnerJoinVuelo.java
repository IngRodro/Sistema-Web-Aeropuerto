package com.sistemaAeropuerto.DAO;

import java.util.Date;

public class InnerJoinVuelo {

	int Vuelo;
    String Company;
    String AeropuertoO;
    String AeropuertoD;
    String Modelo;
    String Tipo;
    Date Fecha;
    String hora;
    String minutos;
    Double Descuento;
    int estado;
    Date FechaFinalDesc;
    Date FechaInicioDesc;
    
	public int getVuelo() {
		return Vuelo;
	}
	public void setVuelo(int vuelo) {
		Vuelo = vuelo;
	}
	public String getCompany() {
		return Company;
	}
	public void setCompany(String company) {
		Company = company;
	}
	public String getAeropuertoO() {
		return AeropuertoO;
	}
	public void setAeropuertoO(String aeropuertoO) {
		AeropuertoO = aeropuertoO;
	}
	public String getAeropuertoD() {
		return AeropuertoD;
	}
	public void setAeropuertoD(String aeropuertoD) {
		AeropuertoD = aeropuertoD;
	}
	public String getModelo() {
		return Modelo;
	}
	public void setModelo(String modelo) {
		Modelo = modelo;
	}
	public String getTipo() {
		return Tipo;
	}
	public void setTipo(String tipo) {
		Tipo = tipo;
	}
	public Date getFecha() {
		return Fecha;
	}
	public void setFecha(Date fecha) {
		Fecha = fecha;
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
	public Double getDescuento() {
		return Descuento;
	}
	public void setDescuento(Double descuento) {
		Descuento = descuento;
	}
	public int getEstado() {
		return estado;
	}
	public void setEstado(int estado) {
		this.estado = estado;
	}
	public Date getFechaFinalDesc() {
		return FechaFinalDesc;
	}
	public void setFechaFinalDesc(Date fechaFinalDesc) {
		FechaFinalDesc = fechaFinalDesc;
	}
	public Date getFechaInicioDesc() {
		return FechaInicioDesc;
	}
	public void setFechaInicioDesc(Date fechaInicioDesc) {
		FechaInicioDesc = fechaInicioDesc;
	}
	
}
