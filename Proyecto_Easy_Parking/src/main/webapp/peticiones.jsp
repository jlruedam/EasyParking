<%-- 
    Document   : peticiones
    Created on : 27/09/2021, 6:22:17 p. m.
    Author     : Jorge Rueda
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.logging.Logger" %>
<%@page import="java.util.logging.Level" %>
<%@page import="java.sql.SQLException" %>
<%@page import="logica.Contacto" %>
<%@page import="com.google.gson.Gson" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.Arrays" %>
<%@page import="java.util.List" %>
<%@page contentType="application/json;charset=iso-8859-1" pageEncoding="UTF-8"%>

<% 
    //Iniciando respuesta json
    String respuesta="{";
    //Lista procesos
    List<String> tareas=Arrays.asList(new String[]{
        "actualizarContacto",
        "eliminarContacto",
        "listarContacto",
        "guardarContacto",
    });
    
    String proceso=""+request.getParameter("Proceso");
    Contacto c= new Contacto();
    
    //Validación de parámetros utilizados
    if(tareas.contains(proceso)){
        
        //------inicio de los procesos-------------------
        
        //-----------------------------------------------
    }else{
        respuesta+="\"ok\":false,";
        respuesta+="\"ERROR\":\"INVALIDO\",";
        respuesta+="\
    
    }
    
    respuesta +="}";
    response.setContentType)("application/json;charset=iso-8859-1");
    out.print(respuesta);

%>


