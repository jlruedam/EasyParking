/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package logica;

import java.sql.SQLException;
import java.util.Scanner;


/**
 *
 * @author Jorge Rueda
 */
public class Main {
    
    public static void main(String[] args) throws SQLException {
        Scanner entrada=new Scanner(System.in);
        int opcion=5;
        OUTER:
        while (opcion!=0) {
            System.out.println("MENU:"+"\n1- Agregar vehículo"
                    +"\n2- Listar vehículos"
                    +"\n3- Editar vehículo"
                    +"\n4- Eliminar vehículo"
                    +"\n0- Salir"
                    + "\nDigite su opción:");
            opcion=entrada.nextInt();
            
            switch (opcion) {
                case 1://CREATE
                    {
                        Vehiculo v=new Vehiculo();
                        System.out.println("Matricula:");
                        String matricula=entrada.next();
                        System.out.println("Modelo:");
                        String modelo=entrada.next();
                        System.out.println("Marca:");
                        String marca=entrada.next();
                        v.cargarDatosVehiculo(matricula, modelo, marca);
                        v.guardarDatosVehiculo();
                        break;
                    }
                case 2://READ
                    {
                        Vehiculo v=new Vehiculo();
                        System.out.println(v.listarVehiculo());
                        
                        break;
                    }
                case 3://UPDATE
                    {
                        Vehiculo v=new Vehiculo();
                        System.out.println("Matricula:");
                        String matricula=entrada.next();
                        System.out.println("Modelo:");
                        String modelo=entrada.next();
                        System.out.println("Marca:");
                        String marca=entrada.next();
                        v.cargarDatosVehiculo(matricula, modelo, marca);
                        v.actualizarDatosVehiculo();
                        break;
                    }
                    
                case 4:
                    {
                        Vehiculo v=new Vehiculo();
                        System.out.println("Matricula:");
                        String matricula=entrada.next();
                        v.setMatricula(matricula);
                        v.borrarDatosVehiculo();
                        break;
                       
                    }
                case 0:
                    System.out.println("Saliendo");
                    
                    break;
                default:
                    System.out.println("Opcion herrada");
                    break OUTER;
            }
            
        }
            
        }
        
    
}
