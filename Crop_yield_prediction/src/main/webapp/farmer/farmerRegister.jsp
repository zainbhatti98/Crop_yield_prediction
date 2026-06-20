<!DOCTYPE html>
<html>
<head>
    <title>Buyer Register</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>

        body{
            margin:0;
            height:100vh;
            background:url('https://images.unsplash.com/photo-1506617420156-8e4536971650?auto=format&fit=crop&w=1400&q=80') no-repeat center center/cover;
            font-family:Arial;
            display:flex;
            align-items:center;
            justify-content:center;
        }

        .overlay{
            position:absolute;
            top:0;
            left:0;
            width:100%;
            height:100%;
            background:rgba(0,0,0,0.6);
        }

        .register-box{
            position:relative;
            width:350px;
            background:rgba(255,255,255,0.95);
            padding:25px;
            border-radius:15px;
            box-shadow:0 10px 25px rgba(0,0,0,0.4);
        }

        h2{
            text-align:center;
            color:#198754;
            font-weight:bold;
            margin-bottom:20px;
        }

        input{
            width:100%;
            padding:12px;
            margin-bottom:15px;
            border-radius:10px;
            border:1px solid #ccc;
        }

        .btn-custom{
            width:100%;
            padding:12px;
            background:#198754;
            color:white;
            border:none;
            border-radius:10px;
            font-weight:bold;
        }

        .btn-custom:hover{
            background:#146c43;
        }

    </style>
</head>

<body>

<div class="overlay"></div>

<div class="register-box">

    <h2>??? Buyer Register</h2>

    <form action="${pageContext.request.contextPath}/BuyerRegisterServlet" method="post">

        <input type="text" name="name" placeholder="Full Name" required>

        <input type="email" name="email" placeholder="Email" required>

        <input type="password" name="password" placeholder="Password" required>

        <button class="btn-custom">Register</button>

    </form>

</div>

</body>
</html>