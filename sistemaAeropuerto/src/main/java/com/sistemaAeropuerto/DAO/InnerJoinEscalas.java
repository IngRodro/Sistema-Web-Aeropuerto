package com.sistemaAeropuerto.DAO;

import java.util.Date;

public class InnerJoinEscalas {

	int Vuelo;
    String Company;
    String AeropuertoEscala;
    String Tipo;
    Date Fecha;
    String FechaString;
	String hora;
    String minutos;
    Double Descuento;
    Double DescuentoTipo;
    Double Precio;
    int estado;
    Date FechaFinalDesc;
    String FechaFinal;
    Date FechaInicioDesc;
    String FechaInicio;
    int IdAeropuertO;
    int IdTipo;
    int NumeroEscala;
    int idAeropuertoEscala;
    
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
	public int getIdAeropuertO() {
		return IdAeropuertO;
	}
	public void setIdAeropuertO(int idAeropuertO) {
		IdAeropuertO = idAeropuertO;
	}
	public int getIdTipo() {
		return IdTipo;
	}
	public void setIdTipo(int idTipo) {
		IdTipo = idTipo;
	}
	public String getFechaString() {
			return FechaString;
	}
	public void setFechaString(String fechaString) {
	FechaString = fechaString;
	}
	public String getAeropuertoEscala() {
		return AeropuertoEscala;
	}
	public void setAeropuertoEscala(String aeropuertoEscala) {
		AeropuertoEscala = aeropuertoEscala;
	}
	public Double getPrecio() {
		return Precio;
	}
	public void setPrecio(Double precio) {
		Precio = precio;
	}
	public int getNumeroEscala() {
		return NumeroEscala;
	}
	public void setNumeroEscala(int numeroEscala) {
		NumeroEscala = numeroEscala;
	}
	public int getIdAeropuertoEscala() {
		return idAeropuertoEscala;
	}
	public void setIdAeropuertoEscala(int idAeropuertoEscala) {
		this.idAeropuertoEscala = idAeropuertoEscala;
	}
	public String getFechaFinal() {
		return FechaFinal;
	}
	public void setFechaFinal(String fechaFinal) {
		FechaFinal = fechaFinal;
	}
	public String getFechaInicio() {
		return FechaInicio;
	}
	public void setFechaInicio(String fechaInicio) {
		FechaInicio = fechaInicio;
	}
	public Double getDescuentoTipo() {
		return DescuentoTipo;
	}
	public void setDescuentoTipo(Double descuentoTipo) {
		DescuentoTipo = descuentoTipo;
	}
	
}
