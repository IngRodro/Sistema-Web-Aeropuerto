package com.Laboratorio.Conexion;

import java.sql.Connection;
import java.sql.DriverManager;
public class ConexionBd {
    
    private Connection coonec;
    
    public ConexionBd()
    {
    	
    try{
    	Class.forName("com.mysql.jdbc.Driver");
        coonec = DriverManager.getConnection("jdbc:mysql://localhost/sistemaaeropuerto","root","root");
        System.out.println("CONECTADO A LA BD");
        
    }catch (Exception e)
    {
        System.out.println("ERROR DE CONEXION A LA BD "+ e);
    }
    }
    public Connection RetornarConexion(){   
        return coonec;   
    }
    
}