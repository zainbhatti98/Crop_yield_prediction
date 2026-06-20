<!DOCTYPE html>
<html>
     <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<head>
    <title>Admin Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            min-height: 100vh;
            background: linear-gradient(135deg, #000000, #0f3d0f);
            font-family: Arial;
            padding: 40px;
        }

        h1 {
            text-align: center;
            color: #00ff99;
            font-weight: bold;
            margin-bottom: 40px;
        }

        .card-box {
            position: relative;
            height: 220px;
            border-radius: 20px;
            overflow: hidden;
            color: white;
            box-shadow: 0 10px 30px rgba(0,0,0,0.6);
            transition: 0.4s;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }

        .card-box:hover {
            transform: translateY(-10px);
        }

        /* DARK OVERLAY */
        .card-box::after {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.6);
        }

        .content {
            position: relative;
            z-index: 2;
        }

        .btn-custom {
            margin-top: 10px;
            border-radius: 10px;
            font-weight: bold;
        }

        /* CARD IMAGES */
        .crop {
            background: url('https://images.unsplash.com/photo-1500595046743-cd271d694d30?auto=format&fit=crop&w=1200') center/cover;
        }

        .farmer {
            background: url('https://images.unsplash.com/photo-1602526211290-3b8c7d3b8f78?auto=format&fit=crop&w=1200') center/cover;
        }

        .approved {
            background: url('https://images.unsplash.com/photo-1521737604893-d14cc237f11d?auto=format&fit=crop&w=1200') center/cover;
        }

        /* LOGOUT BUTTON */
        .logout-btn {
            position: fixed;
            bottom: 30px;
            left: 50%;
            transform: translateX(-50%);
            padding: 12px 30px;
            border-radius: 30px;
            background: red;
            color: white;
            font-weight: bold;
            border: none;
        }

        .logout-btn:hover {
            background: darkred;
        }

    </style>
</head>

<body>

<h1>🌾 Admin Dashboard</h1>

<div class="container">
    <div class="row g-4 justify-content-center">

        <!-- Crop Management -->
        <div class="col-md-4">
            <div class="card-box crop">
                <div class="content">
                    <h4>Crop Management</h4>
                    <a href="cropManagement.jsp" class="btn btn-success btn-custom">Open</a>
                </div>
            </div>
        </div>

        <!-- Farmer Requests -->
        <div class="col-md-4">
            <div class="card-box farmer">
                <div class="content">
                    <h4>Farmer Requests</h4>
                    <a href="farmerRequests.jsp" class="btn btn-warning btn-custom">Open</a>
                </div>
            </div>
        </div>

        <!-- Approved List -->
        <div class="col-md-4">
            <div class="card-box approved">
                <div class="content">
                    <h4>Approved List</h4>
                    <a href="approvedList.jsp" class="btn btn-primary btn-custom">Open</a>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- LOGOUT -->
<form action="logoutServlet" method="post">
    <button class="logout-btn">🚪 Logout</button>
</form>

</body>
</html>