<%-- 
    Document   : index
    Created on : 8/10/2021, 1:14:46 p. m.
    Author     : Jorge Rueda
--%>

<%-- 
    Document   : index2
    Created on : 8/10/2021, 12:55:42 p. m.
    Author     : Jorge Rueda
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<HTML>
    <head>
        <title>JSP Page</title>         
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        
        <script src = "http://ajax.googleapis.com/ajax/libs/angularjs/1.2.15/angular.min.js"></script>  
        
    </head>
    <style>
        h3 {
            font-family: sans-serif;
            background-color: #000814;
            color:#ffd60a;
            border-radius: 10px;
            text-align: center;
        }
        
        body {
            background-color: #ffffff;
        }
        .messages {
            color: #FA787E;
        }
        form.ng-submitted input.ng-invalid{
            border-color: #FA787E;
        }
        form input.ng-invalid.ng-touched {
            border-color: #FA787E;
        }
    </style>
    <body>
        <div class="container-fluid" ng-app="EasyParking2" ng-controller="vehiculosControl as vc">
            <form name="userForm" novalidate>
                <div class="row">
                    <div class="col-12">
                        <center><h1><img <img src="./assets/LogoEP.png"/></h1></center>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <h3>INGRESO VEHÍCULOS</h3>
                        <div class="row">
                            
                            <div class="col-6">
                                <label>Matrícula</label>
                                <input name="matricula" class="form-control" type="text"  ng-model="vc.matricula" ng-model-options="{updateOn:'blur'}" required/>
                            </div>
                            <div class="col-6">
                                <label>Modelo</label>
                                <input name="modelo" class="form-control" type="text" ng-model="vc.modelo" ng-model-options="{updateOn:'blur'}" required/>
                            </div>   
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <label>Marca</label>
                                <input name="marca" class="form-control" type="text" ng-model="vc.marca" ng-model-options="{updateOn: 'blur' }" required/>
                            </div> 
                        </div>
                        <div><br/></div>
                        
                        <div class="row">
                            <div class="col-3">
                                <input class="btn btn-success" type="submit" ng-click="vc.guardarVehiculo()" value="Guardar" ng-disabled=""/>
                            </div>
                            <div class="col-3">
                                <button class="btn btn-primary" ng-click="vc.listarVehiculos()">Listar vehículos</button>
                            </div>
                            <div class="col-3">
                                <button class="btn btn-danger" ng-click="vc.eliminarVehiculo()">Eliminar vehículo</button>
                            </div>
                            <div class="col-3">
                                <button class="btn btn-warning" ng-click="vc.actualizarVehiculo()">Actualizar vehículo</button>
                            </div>         
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12 table-responsive-xl">
                        <h3>SECCIÓN 3</h3>
                        
                        <table class="table table-striped table hover">
                            <thead class="thead-dark">
                                <tr>
                                    <th>Matrícula</th>
                                    <th>Modelo</th>
                                    <th>Marca</th>
                                </tr>
                            </thead>
                            <tr ng-repeat="vehiculo in vc.Vehiculos">
                                <td>{{vehiculo.matricula}}</td>
                                <td>{{vehiculo.modelo}}</td>
                                <td>{{vehiculo.marca}}</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </form>
        </div> 
    </body>
    <script>
        //código Angular
        
        angular.module('EasyParking2',[])
                .controller('vehiculosControl',['$scope',function($scope){
                        $scope.user={};
                
                        $scope.update=function(){
                            console.log($scope.user);
                        };
                        
                        $scope.reset=function(form){
                            $scope.user={};
                            if(form){
                                form.$setPristine();
                                form.$setUntouched();
                            }
                            
                        };
                        $scope.reset();
                }]);
        var app=angular.module('EasyParking2',[]);
        app.controller("vehiculosControl",['$http',controladorVehiculos]);
        
        function validar(){
            return true;
        }
        
        function controladorVehiculos($http){
            var vc=this;
        
        //Función Listar
        vc.listarVehiculos=function(){
            console.log("sin ingresa algunlar listar");
            var url="peticiones.jsp";
            var params={
                proceso:"listarVehiculos"
            };
            $http({
                method:'POST',
                url:'peticiones.jsp',
                params:params
            }).then(function(res){
                vc.Vehiculos=res.data.Vehiculos;
            });
        };
        //Función guardar
        vc.guardarVehiculo=function(){
            var vehiculo={
                proceso:"guardarVehiculo",
                matricula:vc.matricula,
                modelo:vc.modelo,
                marca:vc.marca
            };
            $http({
                method:'POST',
                url:'peticiones.jsp',
                params:vehiculo                
            }).then(function(res){
               if(res.data.ok === true){
                   if(res.data[vehiculo.proceso]===true){
                       alert("Guardado con éxito");
                   }else{
                       alert("Por favor verifique sus datos");
                   }
               } else{
                   alert(res.data.errorMsg);
               }
            });
        };
        //Función eliminar
        vc.eliminarVehiculo=function(){
            var vehiculo={
                proceso:"eliminarVehiculo",
                matricula:vc.matricula
            };
            $http({
                method:'POST',
                url:'peticiones.jsp',
                params:vehiculo
            }).then(function (res){
                if(res.data.ok===true){
                    if(res.data[vehiculo.proceso]===true){
                        alert("Eliminado con éxito");
                    }else{
                        alert("Por favor verifique sus datos");
                    }
                }else{
                    alert(res.data.errorMsg);
                }
            });
        };
        //Función editar-actualizar
        vc.actualizarVehiculo=function(){
            
            var vehiculo={
                proceso:"actualizarVehiculo",
                matricula:vc.matricula,
                modelo:vc.modelo,
                marca:vc.marca
                
            };
            $http({
                method:'POST',
                url:'peticiones.jsp',
                params:vehiculo
            }).then(function (res){
               if(res.data.ok===true){
                   if(res.data[vehiculo.proceso]===true){
                       alert("Vehiculo actualizado con éxito");
                   }else{
                       alert("Por favor verifique sus datos");
                   }
               }else{
                   alert(res.data.errorMsg);
               }
            });
            
        };
    }       
        
        
    </script>
</HTML>


