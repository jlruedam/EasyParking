<%-- 
    Document   : index
    Created on : 27/09/2021, 6:21:58 p. m.
    Author     : Jorge Rueda
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>JSP Page</title>         
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        Bootstrap core CSS 
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        Angular 
        <script src = "http://ajax.googleapis.com/ajax/libs/angularjs/1.2.15/angular.min.js"></script> 
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
        <script src="angularsrc.js"></script>
        <style>
            /*div {border-style: dotted; }*/
        </style>
    </head>
    <style type="text/css">
        .messages{
            color:#FA787E;
        }
        form.ng-submitted input.ng-invalid{
            border-color:#FA787E;
        }
        form input.ng-invalid.ng.touched{
            border-color:#FA787E;
        }
        
    </style>
           
    <body>
        <div class="container-fluid" ng-app="Proyecto_Easy_Parking" ng-controller="vehiculosController as cv">
            <form name="userForm" novalidate>
                <div class="row">
                    <div class="col-12">
                        <center><h1>EASY PARKING</h1></center>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <h3>INGRESO VEHÍCULOS</h3>
                        <div class="row">
                            
                            <div class="col-6">
                                <label>Matrícula</label>
                                <input name="matricula" class="form-control" type="text"  ng-model="cv.matricula" ng-model-options="{updateOn:'blur'}" required>
                            </div>
                            <div class="col-6">
                                <label>Modelo</label>
                                <input name="modelo" class="form-control" type="text" ng-model="cv.modelo" ng-model-options="{updateOn:'blur'}" required>
                            </div>
                            
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <label>Marca</label>
                                <input name="marca" class="form-control" type="text" ng-model="cv.marca" ng-model-options="{updateOn: 'blur' }" required>
                            </div> 
                        </div>
                        <div><br></div>
                        <h3>SECCIÓN 2</h3>
                        <div class="row">
                            <div class="col-3">
                                <input class="btn btn-success" type="submit" ng-click="cv.guardarVehiculo()" value="Guardar" ng-disabled=""/>
                            </div>
                            <div class="col-3">
                                <button class="btn btn-primary" ng-click="cv.listarVehiculos()">Listar vehículos</button>
                            </div>
                            <div class="col-3">
                                <button class="btn btn-danger" ng-click="cv.eliminarVehiculo()">Eliminar vehículo</button>
                            </div>
                            <div class="col-3">
                                <button class="btn btn-warning" ng-click="cv.actualizarVehiculo()">Actualizar vehículo</button>
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
                                    <th>Matícula</th>
                                    <th>Modelo</th>
                                    <th>Marca</th>
                                </tr>
                            </thead>
                            <tr ng-repeat="vehiculo in cv.vehiculos">
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
        
        angular.module('Proyecto_Easy_Parking',[])
                .controller('vehiculosController',['$scope',function($scope){
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
        var app=angular.module('Proyecto_Easy_Parking',[]);
        app.controller("vehiculosController",['$http',controladorVehiculos]);
        
        function validar(){
            return true;
        }
        
        function controladorVehiculos($http){
            var cv=this;
        
        //Función Listar
        cv.listarVehiculos=function(){
            console.log("sin ingresa algunlar listar");
            var.url="peticiones.jsp";
            var params={
                proceso:"listarVehiculos"
            };
            $http({
                method:'POST',
                url:'peticiones.jsp',
                params:params
            }).then(function(res){
                cv.vehiculos=res.data.Vehiculos;
            });
        };
        //Función guardar
        cv.guardarVehiculo=function(){
            var vehiculo={
                proceso:"guardarVehiculo",
                matricula:cv.matricula,
                modelo:cv.modelo,
                marca:cv.marca
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
        cv.eliminarVehiculo=function(){
            var vehiculo={
                proceso:"eliminarVehiculo",
                matricula:cv.matricula
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
        cv.actualizarVehiculo=function(){
            
            var vehiculo={
                proceso:"actualizarVehiculo",
                matricula:cv.matricula,
                modelo:cv.modelo,
                marca:cv.marca
                
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
</html>
