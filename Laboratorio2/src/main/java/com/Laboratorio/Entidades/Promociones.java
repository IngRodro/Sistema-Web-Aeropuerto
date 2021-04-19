/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.Laboratorio.Entidades;
import java.util.Date;

/**
 *
 */
public class Promociones {
    
    private int idPromociones;
    private Date FechaInicio;
    private Date FechaFinal;
    private Double Descuento;
    private int idVuelo;
    
	public int getIdPromociones() {
		return idPromociones;
	}
	public void setIdPromociones(int idPromociones) {
		this.idPromociones = idPromociones;
	}
	public Date getFechaInicio() {
		return FechaInicio;
	}
	public void setFechaInicio(Date fechaInicio) {
		FechaInicio = fechaInicio;
	}
	public Date getFechaFinal() {
		return FechaFinal;
	}
	public void setFechaFinal(Date fechaFinal) {
		FechaFinal = fechaFinal;
	}
	public Double getDescuento() {
		return Descuento;
	}
	public void setDescuento(Double descuento) {
		Descuento = descuento;
	}
	public int getIdVuelo() {
		return idVuelo;
	}
	public void setIdVuelo(int idVuelo) {
		this.idVuelo = idVuelo;
	}
    
    
}
