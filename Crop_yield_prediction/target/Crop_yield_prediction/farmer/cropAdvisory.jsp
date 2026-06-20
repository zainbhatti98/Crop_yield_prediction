<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
<meta charset="UTF-8">
<title>Crop Advisory</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body{
    background: linear-gradient(135deg,#0f3d0f,#2e7d32,#66bb6a);
    min-height:100vh;
    font-family: Arial;
}

.bg-shader{
    position: fixed;
    top:0;left:0;
    width:100%;height:100%;
    background: radial-gradient(circle at top left, rgba(255,255,255,0.1), transparent 40%),
                radial-gradient(circle at bottom right, rgba(0,0,0,0.2), transparent 50%);
}

.container-box{
    width: 420px;
    margin: auto;
    margin-top: 5%;
    background: rgba(255,255,255,0.95);
    padding: 25px;
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.3);
    position: relative;
}

h2{
    text-align:center;
    color:#198754;
    font-weight:bold;
}

.field{
    margin-bottom:18px;
}

input[type=number]{
    width:100%;
    padding:10px;
    border-radius:8px;
    border:1px solid #ccc;
}

.btn-group-custom{
    display:flex;
    gap:10px;
    margin-top:5px;
}

.btn-custom{
    flex:1;
}

.submit-btn{
    width:100%;
    background:#198754;
    color:white;
    border:none;
    padding:12px;
    border-radius:10px;
    font-weight:bold;
    transition:0.3s;
}

.submit-btn:hover{
    transform:scale(1.03);
    background:#146c43;
}

</style>

<script>

function change(id,val){
    let x = document.getElementById(id);
    x.value = parseInt(x.value || 0) + val;
}

</script>

</head>

<body>

<div class="bg-shader"></div>

<div class="container-box">

<h2>🌾 Crop Advisory</h2>

<form action="cropRecommendation.jsp" method="post">

<div class="field">
<label>Temperature (°C)</label>
<input type="number" id="temp" name="temperature" value="25">
<div class="btn-group-custom">
<button type="button" class="btn btn-success btn-custom" onclick="change('temp',-1)">-</button>
<button type="button" class="btn btn-success btn-custom" onclick="change('temp',1)">+</button>
</div>
</div>

<div class="field">
<label>Humidity (%)</label>
<input type="number" id="humidity" name="humidity" value="60">
<div class="btn-group-custom">
<button type="button" class="btn btn-success btn-custom" onclick="change('humidity',-1)">-</button>
<button type="button" class="btn btn-success btn-custom" onclick="change('humidity',1)">+</button>
</div>
</div>

<div class="field">
<label>Rainfall (mm)</label>
<input type="number" id="rainfall" name="rainfall" value="100">
<div class="btn-group-custom">
<button type="button" class="btn btn-success btn-custom" onclick="change('rainfall',-5)">-</button>
<button type="button" class="btn btn-success btn-custom" onclick="change('rainfall',5)">+</button>
</div>
</div>

<div class="field">
<label>Soil pH</label>
<input type="number" id="ph" name="ph" value="7">
<div class="btn-group-custom">
<button type="button" class="btn btn-success btn-custom" onclick="change('ph',-1)">-</button>
<button type="button" class="btn btn-success btn-custom" onclick="change('ph',1)">+</button>
</div>
</div>

<button class="submit-btn">🌱 Predict Crop</button>

</form>

</div>

</body>
</html>