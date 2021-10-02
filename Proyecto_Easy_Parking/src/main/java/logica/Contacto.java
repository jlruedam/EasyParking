/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package logica;

import Persistencia.ConexionDB;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Jorge Rueda
 */
public class Contacto {
    
    //Declarar atributos
    private int identificacion;
    private String nombre;
    private String apellido;
    private String genero;
    private String tipoIdentificacion;
    private String telefono;
    private String direccion;
    private String correo;

    public Contacto() {
    }

    public int getIdentificacion() {
        return identificacion;
    }

    public void setIdentificacion(int identificacion) {
        this.identificacion = identificacion;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public String getTipoIdentificacion() {
        return tipoIdentificacion;
    }

    public void setTipoIdentificacion(String tipoIdentificacion) {
        this.tipoIdentificacion = tipoIdentificacion;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }
    
    public void llenarContacto(int identificacion,
                               String nombre,
                               String apellido,
                               String genero,
                               String tipoIdentificacion,
                               String telefono,
                               String direccion,
                               String correo){
        this.identificacion= identificacion;
        this.nombre=nombre;
        this.apellido=apellido;
        this.genero=genero;
        this.tipoIdentificacion=tipoIdentificacion;
        this.telefono=telefono;
        this.direccion=direccion;
        this.correo=correo;
        
    }
    
    //Metodos del CRUD
    public boolean guardarContacto(){
        ConexionDB conexion=new ConexionDB();
        String sentencia="INSERT INTO contactos (identificacion,"
                +"nombre, apellido,genero,tipoIdentificacion, telefono,"
                +"direccion,correo) VALUES ('"+this.identificacion
                +"','"+this.apellido+"','"+this.genero+"','"
                +this.tipoIdentificacion+"','"+this.telefono+"','"
                +this.direccion+"','"+this.correo+")";
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
    
    public boolean borrarContacto(){
        ConexionDB conexion=new ConexionDB();
        String sentencia="DELETE FROM contactos WHERE identificacion='"+this.identificacion+"' ";
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
    
    //public boolean actualizarContacto(){
    //    ConexionDB conexion=new ConexionDB();
    //    String sentencia="UPDATE contactos SET nombre='"+this.nombre+"','"+this.apellido'";
    //}
    public List<Contacto> listarContactos() throws SQLException{
        ConexionDB conexion=new ConexionDB();
        List<Contacto> listaContactos=new ArrayList<>();
        String sql="SELECT * FROM contactos ORDER BY identificacion ASC";
        ResultSet rs=conexion.consultarDB(sql);
        Contacto c;
        while(rs.next()){
            c=new Contacto();
            c.setIdentificacion(rs.getInt("identificacion"));
            c.setNombre(rs.getString("nombre"));
            c.setApellido(rs.getString("apellido"));
            c.setGenero(rs.getString("genero"));
            c.setTipoIdentificacion(rs.getString("tipoIdentificacion"));
            c.setTelefono(rs.getString("telefono"));
            c.setDireccion(rs.getString("direccion"));
            c.setCorreo(rs.getString("correo"));
            listaContactos.add(c);
        }
        conexion.cerrarConexion();
        return listaContactos;
    }

    @Override
    public String toString() {
        return "Contacto{" + "identificacion=" + identificacion + ", nombre=" + nombre + ", apellido=" + apellido + ", genero=" + genero + ", tipoIdentificacion=" + tipoIdentificacion + ", telefono=" + telefono + ", direccion=" + direccion + ", correo=" + correo + '}';
    }
    
}
