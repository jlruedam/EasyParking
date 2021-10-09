/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package logica;

import persistencia.ConexionDB;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Jorge Rueda
 */
public class Vehiculo {
    private String matricula;
    private String modelo;
    private String marca;

    public Vehiculo() {
    }

    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public String getModelo() {
        return modelo;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }
    
    public void cargarDatosVehiculo(String matricula,
                               String modelo,
                               String marca){
        this.matricula= matricula;
        this.modelo=modelo;
        this.marca=marca;  
    }
    //CREATE
    public boolean guardarDatosVehiculo(){
        ConexionDB conexion=new ConexionDB();
        String sentencia="INSERT INTO vehiculo (matricula,"
                +"modelo, marca) VALUES ('"+this.matricula
                +"','"+this.modelo+"','"+this.marca+"')";
        if(conexion.setAutoCommitDB(false)){
            if(conexion.insertarDB(sentencia)){
                conexion.commitDB();
                conexion.cerrarConexion();
                return true;
            }else{
                conexion.rollbackDB();
                conexion.cerrarConexion();
                return false;
            }
        }else{
            conexion.cerrarConexion();
            return false;
        }
    }
    //READ
    public List<Vehiculo> listarVehiculo() throws SQLException{
        ConexionDB conexion=new ConexionDB();
        List<Vehiculo> listaVehiculos=new ArrayList<>();
        String sql="SELECT * FROM vehiculo ORDER BY matricula ASC";
        ResultSet rs=conexion.consultarDB(sql);
        Vehiculo v;
        while(rs.next()){
            v=new Vehiculo();
            v.setMatricula(rs.getString("matricula"));
            v.setModelo(rs.getString("modelo"));
            v.setMarca(rs.getString("marca"));
            listaVehiculos.add(v);
        }
        conexion.cerrarConexion();
        return listaVehiculos;
    }
    //UPDATE
    public boolean actualizarDatosVehiculo() {
        ConexionDB conexion = new ConexionDB();
        String Sentencia = "UPDATE `vehiculo` SET modelo='" + this.modelo + "',marca='" + this.marca+"' WHERE matricula='" + this.matricula + "';";
        /*
        String Sentencia = "UPDATE `contactos` SET nombre='" + this.nombre + "',apellido='" + this.apellido + "',genero='" + this.genero
                + "',tipoIdentificacion='" + this.tipoIdentificacion + "',telefono='" + this.telefono + "',direccion='" + this.direccion + "',correo='" + this.correo
                +  "' WHERE identificacion=" + this.identificacion + ";";
        */
        
        if (conexion.setAutoCommitDB(false)) {
            if (conexion.actualizarDB(Sentencia)) {
                conexion.commitDB();
                conexion.cerrarConexion();
                return true;
            } else {
                conexion.rollbackDB();
                conexion.cerrarConexion();
                return false;
            }
        } else {
            conexion.cerrarConexion();
            return false;
        }
    }
    
    
    
    //DELETE
    public boolean borrarDatosVehiculo(){
        ConexionDB conexion=new ConexionDB();
        String sentencia="DELETE FROM vehiculo WHERE matricula='"+this.matricula+"' ";
        if(conexion.setAutoCommitDB(false)){
            if(conexion.actualizarDB(sentencia)){
                conexion.commitDB();
                conexion.cerrarConexion();
                return true;
            }else{
                conexion.rollbackDB();
                conexion.cerrarConexion();
                return false;
            }
        }else{
            conexion.cerrarConexion();
            return false;
        }
    }
    
    public Vehiculo getVehiculo() throws SQLException {
        ConexionDB conexion = new ConexionDB();
        String sql = "select * from vehiculo where matricula='" + this.matricula + "'";
        ResultSet rs = conexion.consultarDB(sql);
        if (rs.next()) {
            this.matricula = rs.getString("matricula");
            this.modelo = rs.getString("modelo");
            this.marca = rs.getString("marca");
            conexion.cerrarConexion();
            return this;

        } else {
            conexion.cerrarConexion();
            return null;
        }
    
    }
    
    
}
