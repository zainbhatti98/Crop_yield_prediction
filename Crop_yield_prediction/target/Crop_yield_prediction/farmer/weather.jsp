<!DOCTYPE html>
<html>
<head>
    <title>Weather & Crop Advisory</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>

        body{
            background: linear-gradient(135deg,#1b5e20,#43a047);
            font-family: Arial;
        }

        .box{
            width:420px;
            margin:auto;
            margin-top:8%;
            background: rgba(255,255,255,0.95);
            padding:25px;
            border-radius:15px;
            box-shadow:0 10px 25px rgba(0,0,0,0.3);
            text-align:center;
        }

        h2{
            color:#198754;
            font-weight:bold;
        }

        input{
            width:100%;
            padding:12px;
            margin-top:10px;
            border-radius:10px;
            border:1px solid #ccc;
        }

        button{
            margin-top:10px;
            width:100%;
            padding:12px;
            border:none;
            border-radius:10px;
            background:#198754;
            color:white;
            font-weight:bold;
        }

        button:hover{
            background:#146c43;
        }

    </style>
</head>

<body>

<div class="box">

<h2>?? Weather Advisory</h2>

<form action="${pageContext.request.contextPath}/WeatherServlet" method="post">

    <input type="text" name="city" placeholder="Enter City Name" required>

    <button type="submit">Get Weather</button>

</form>

</div>

</body>
</html>