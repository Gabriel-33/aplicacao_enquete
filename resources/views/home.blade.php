<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>
    <!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
</head>
<style>
    body {
      margin: 0;
      font-family: "Lato", sans-serif;
      background-color: #D3D3D3;
    }

    .sidebar {
      margin: 0;
      padding: 0;
      width: 200px;
      background-color: #f1f1f1;
      position: fixed;
      height: 100%;
      overflow: auto;
    }

    .sidebar a {
      display: block;
      color: black;
      padding: 16px;
      text-decoration: none;
    }
     
    .sidebar a.active {
      background-color: #04AA6D;
      color: white;
    }

    .sidebar a:hover:not(.active) {
      background-color: #555;
      color: white;
    }

    div.content {
      margin-left: 200px;
      padding: 1px 16px;
      height:300px;
    }

    @media screen and (max-width: 700px) {
      .sidebar {
        width: 100%;
        height: auto;
        position: relative;
      }
      .sidebar a {float: left;}
      div.content {margin-left: 0;}
    }

    @media screen and (max-width: 400px) {
      .sidebar a {
        text-align: center;
        float: none;
      }
    }
</style>
<body>
    <div id="app">
        <div class="sidebar">
            <center><h5>SIGNO-WEB</h5></center>
            <a v-bind:class="{ active: opc == 'cadastrar_enquete'}" href="#home" @click.prevent v-on:click="chamar_opc('cadastrar_enquete')">Nova enquete</a>
            <a v-bind:class="{ active: opc == 'visualizar_enquetes'}" href="#home" @click.prevent v-on:click="chamar_opc('visualizar_enquetes')">Ver enquetes cadastradas</a>
            <a href="#contact">Contact</a>
            <a href="#about">About</a>
        </div>
        <div class="content">
            <enquete-component v-show="opc == 'cadastrar_enquete'" style="margin-top: 150px;"></enquete-component>
            <listar-enquete-component v-show="opc == 'visualizar_enquetes'" style="margin-top: 100px;"></listar-enquete-component>
        </div>
    </div>
</body>
<script type="text/javascript" src="{{asset('js/app.js')}}"></script>
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>

</html>