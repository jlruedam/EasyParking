package Persistencia;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;





/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Jorge Rueda
 */
public class ConexionDB {
    
    private String DB_driver="";
    private String url="";
    private String db="";
    private String host="";
    private String username="";
    private String password="";
    private Connection con=null;
    private Statement stmt=null;
    private PreparedStatement pstmt=null;
    private ResultSet rs=null;
    
    
    public ConexionDB(){
        DB_driver="com.mysql.cj.jdbc.Driver";
        host="localhost:3306";
        db="EasyParking";
        url="jdbc:mysql://"+host+"/"+db;
        username="root";
        password="";
        
        try{
            Class.forName(DB_driver);
 
        }catch(ClassNotFoundException ex){
            Logger.getLogger(ConexionDB.class.getName()).log(Level.SEVERE,null,ex);       
        }
        try{
            con=DriverManager.getConnection(url, username,password);
            con.setTransactionIsolation(8);
            System.out.println("Conectado la Base de datos!");
        }catch (SQLException ex){
            System.out.println("Error en la conexión a la base de datos!");
            Logger.getLogger(ConexionDB.class.getName()).log(Level.SEVERE,null,ex);
            
        }
    }
    public Connection getConnection(){
        return con;
    }
    public void closeConnection(Connection con){
        if(con !=null){
            try{
                con.close();
            }catch (SQLException ex){
                Logger.getLogger(ConexionDB.class.getName()).log(Level.SEVERE,null,ex);
            }
        }
    }
    //Insertar
    public boolean insertarDB(String sentencia){
        try {
            stmt=con.createStatement();
            stmt.execute(sentencia);
        } catch (SQLException | RuntimeException sqlex) {
            System.out.println("Error rutina"+sqlex);
            return false;
        }
        return true;
    }
    //Listar
    public ResultSet consultarDB(String sentencia){
        try {
            stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
            rs=stmt.executeQuery(sentencia);
        } catch (SQLException sqlex) {
            System.out.println("Error en la consulta");
        }
        return rs;
    }
    public boolean borrarDB(String sentencia){
        try {
            stmt=con.createStatement();
            stmt.execute(sentencia);
        } catch (SQLException | RuntimeException sqlex) {
            System.out.println("Error al Eliminar"+sqlex);
            return false;
            
        }
        return true;
    }
    public boolean actualizarDB(String sentencia){
        try {
            stmt=con.createStatement();
            stmt.executeUpdate(sentencia);
        } catch (SQLException | RuntimeException sqlex) {
            System.out.println("Error al Actualizar"+sqlex);
            return false;
        }
        return true;
    }
    //
    public boolean setAutoCommitDB(boolean parametro){
        try {
            con.setAutoCommit(parametro);
        } catch (SQLException sqlex) {
            System.out.println("Error al configurar el autocommit "+sqlex.getMessage());
            return false;
        }
        return true;
    }
    public void cerrarConexion(){
        closeConnection(con);
    }
    public boolean commitDB(){
        try {
            con.commit();
        } catch (SQLException sqlex) {
            System.out.println("Error al hacer el commit"+sqlex.getMessage());
            return false;
        }
        return true;
    }
    public boolean rollbackDB(){
        try {
            con.rollback();
            return true;
            
        } catch (SQLException sqlex) {
            System.out.println("Error al hacer rollback"+sqlex.getMessage());
            return false;
        }
    }
    public static void main(String[] args) {
        ConexionDB b=new ConexionDB();
        b.cerrarConexion();
    }
}
