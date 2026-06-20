<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Crop Yield Prediction System</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #000;
            font-family: Arial;
        }

        .container-box {
            display: flex;
            gap: 25px;
            flex-wrap: wrap;
            justify-content: center;
        }

        .role-card {
            width: 300px;
            height: 380px;
            border-radius: 20px;
            color: white;
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.7);
            transition: 0.4s;
        }

        .role-card:hover {
            transform: translateY(-10px);
        }

        /* DARK OVERLAY */
        .role-card::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.6);
        }

        .card-content {
            position: relative;
            z-index: 2;
        }

        h1 {
            text-align: center;
            color: #00ff99;
            margin-bottom: 40px;
            font-weight: bold;
        }

        .sub-text {
            text-align: center;
            color: #bbb;
            margin-bottom: 30px;
        }

        .btn-custom {
            width: 100%;
            margin-top: 10px;
            border-radius: 10px;
            font-weight: bold;
        }

        /* BACKGROUND IMAGES */
        .admin {
            background: url('https://images.unsplash.com/photo-1553877522-43269d4ea984?auto=format&fit=crop&w=800') center/cover;
        }

        .farmer {
            background: url('https://images.unsplash.com/photo-1500937386664-56d1dfef3854?auto=format&fit=crop&w=800') center/cover;
        }

        .buyer {
            background: url('https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800') center/cover;
        }

    </style>
</head>

<body>

<div>
    <h1>🌾 Crop Yield Prediction System</h1>
    <p class="sub-text">Choose your role to continue</p>

    <div class="container-box">

        <!-- Admin -->
        <div class="role-card admin">
            <div class="card-content">
                <h2>Admin</h2>
                <p>Manage system & users</p>
                <a href="admin/adminLogin.jsp" class="btn btn-primary btn-custom">Login</a>
            </div>
        </div>

        <!-- Farmer -->
        <div class="role-card farmer">
            <div class="card-content">
                <h2>Farmer</h2>
                <p>Predict crop yield</p>
                <a href="farmer/farmerLogin.jsp" class="btn btn-success btn-custom">Login</a>
                <a href="farmer/farmerRegister.jsp" class="btn btn-success btn-custom">Register</a>
            </div>
        </div>

        <!-- Buyer -->
        <div class="role-card buyer">
            <div class="card-content">
                <h2>Buyer</h2>
                <p>Buy fresh crops</p>
                <a href="buyer/buyerLogin.jsp" class="btn btn-warning btn-custom">Login</a>
                <a href="buyer/buyerRegister.jsp" class="btn btn-warning btn-custom">Register</a>
            </div>
        </div>

    </div>
</div>

</body>
</html>