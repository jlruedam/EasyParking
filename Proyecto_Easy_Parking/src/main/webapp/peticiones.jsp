<%-- 
    Document   : peticiones
    Created on : 27/09/2021, 6:22:17 p. m.
    Author     : Jorge Rueda
--%>


<%@page import="java.util.logging.Logger" %>
<%@page import="java.util.logging.Level" %>
<%@page import="java.sql.SQLException" %>
<%@page import="logica.Vehiculo" %>
<%@page import="com.google.gson.Gson" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.Arrays" %>
<%@page import="java.util.List" %>
<%@page contentType="application/json;charset=iso-8859-1" language="java" pageEncoding="iso-8859-1" session="true"%>

<% 
    //Iniciando respuesta json
    
    String respuesta="{";
    //Lista procesos
    List<String> tareas=Arrays.asList(new String[]{
        "actualizarVehiculo",
        "eliminarVehiculo",
        "listarVehiculos",
        "guardarVehiculo"
    });
    
    String proceso=""+request.getParameter("proceso");
    
    
    //Validación de parámetros utilizados
    if(tareas.contains(proceso)){
        respuesta +="\"ok\":true,";
        //------inicio de los procesos-------------------
        if(proceso.equals("guardarVehiculo")){
            String matricula=request.getParameter("matricula");
            String modelo=request.getParameter("modelo");
            String marca=request.getParameter("marca");
            
            Vehiculo v=new Vehiculo();
            
            v.cargarDatosVehiculo(matricula, modelo, marca);
            
            if(v.guardarDatosVehiculo()){
                respuesta+="\""+proceso+"\":true";
            }else{
                respuesta+="\""+proceso+"\":false";
            }
        }else if (proceso.equals("eliminarVehiculo")){
            Vehiculo v=new Vehiculo();
            
            String matricula=request.getParameter("matricula");
            String modelo=request.getParameter("modelo");
            String marca=request.getParameter("marca");
                
            v.cargarDatosVehiculo(matricula, modelo, marca);
            
            if(v.borrarDatosVehiculo()){
                respuesta+="\""+proceso+"\":true";
            }else{
                respuesta+="\""+proceso+"\":false";
            }
            
        }else if(proceso.equals("listarVehiculos")){
            Vehiculo v=new Vehiculo();
            try{
               List<Vehiculo> lista=v.listarVehiculo();
               respuesta+="\""+proceso+"\":true,\"vehiculos\":"+new Gson().toJson(lista);
            }catch(SQLException ex){
               respuesta+="\""+proceso+"\":true,\"vehiculos\":[]";
               Logger.getLogger(Vehiculo.class.getName()).log(Level.SEVERE, null, ex);
            }
         
        }else if(proceso.equals("actualizarVehiculo")){
        
            String matricula=request.getParameter("matricula");
            String modelo=request.getParameter("modelo");
            String marca=request.getParameter("marca");
            Vehiculo v=new Vehiculo();
            v.cargarDatosVehiculo(matricula, modelo, marca);
            
            if(v.actualizarDatosVehiculo()){
                respuesta+="\""+proceso+"\":true";
            }else{
                respuesta+="\""+proceso+"\":false";
            }
        
        }
       //-----------------------------------------------
    }else{
        respuesta+="\"ok\":false,";
        respuesta+="\"ERROR\":\"INVALID\",";
        respuesta+="\"errorMsg\":\"Lo sentimos, los datos que ha enviado,"
                +"son inválidos. Corrijalos y vuelva a intentar por favor.\"";
    
    }
    
    respuesta +="}";
    response.setContentType("application/json;charset=iso-8859-1");
    out.print(respuesta);

%>


