<!DOCTYPE html>
<%@ page import="java.sql.*,db.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
Integer farmerId = (Integer) session.getAttribute("farmerId");

if(farmerId == null){
    response.sendRedirect("farmerLogin.jsp");
    return;
}

/* 🔔 NEW ORDERS COUNT */
int newOrders = 0;

try {
    Connection con = DBConnection.getConnection();

    PreparedStatement ps = con.prepareStatement(
        "SELECT COUNT(*) FROM orders WHERE farmer_id=? AND status='Pending'"
    );

    ps.setInt(1, farmerId);

    ResultSet rs = ps.executeQuery();

    if(rs.next()){
        newOrders = rs.getInt(1);
    }

    rs.close();
    ps.close();
    con.close();

} catch(Exception e){
    e.printStackTrace();
}
%>

<html>
<head>
    <title>Farmer Dashboard</title>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>

        body{
            background: linear-gradient(135deg,#0f3d0f,#2e7d32,#66bb6a);
            min-height:100vh;
            font-family: Arial;
            position: relative;
            overflow-x: hidden;
        }

        .bg-shader{
            position: fixed;
            top:0;
            left:0;
            width:100%;
            height:100%;
            background:
                radial-gradient(circle at top left, rgba(255,255,255,0.08), transparent 40%),
                radial-gradient(circle at bottom right, rgba(0,0,0,0.25), transparent 50%);
            z-index: 0;
        }

        .container, .navbar, .footer{
            position: relative;
            z-index: 2;
        }

        .navbar{
            background: rgba(0,0,0,0.25);
            backdrop-filter: blur(12px);
        }

        .navbar-brand{
            color:white !important;
            font-size:22px;
            font-weight:bold;
        }

        .dashboard-title{
            color:white;
            text-align:center;
            margin:30px 0;
            font-weight:bold;
            text-shadow: 0 5px 15px rgba(0,0,0,0.4);
        }

        .card{
            border:none;
            border-radius:18px;
            background: rgba(255,255,255,0.92);
            box-shadow: 0 10px 25px rgba(0,0,0,0.25);
            transition: 0.3s ease;
            position: relative;
        }

        .card:hover{
            transform: translateY(-12px) scale(1.03);
        }

        .icon{
            font-size:52px;
            margin-bottom:10px;
        }

        .btn-custom{
            border-radius:30px;
            font-weight:bold;
        }

        .footer{
            text-align:center;
            color:white;
            margin-top:40px;
            padding:20px;
            opacity:0.9;
        }

        .back-btn{
            position: fixed;
            bottom: 20px;
            left: 20px;
            z-index: 999;
        }

        /* 🔴 NOTIFICATION BADGE */
        .badge-new{
            position:absolute;
            top:10px;
            right:10px;
            background:red;
            color:white;
            padding:5px 10px;
            border-radius:50px;
            font-size:12px;
            font-weight:bold;
        }

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
    text-decoration: none;
    display: inline-block;
}

.logout-btn:hover {
    background: darkred;
    color: white;
}
    </style>
</head>

<body>

<div class="bg-shader"></div>

<nav class="navbar">
    <div class="container">
        <span class="navbar-brand">🌾 Crop Yield Management System</span>
    </div>
</nav>

<div class="container">

    <h1 class="dashboard-title">Farmer Dashboard</h1>

    <% if(newOrders > 0){ %>
        <div class="alert alert-warning text-center">
            🔔 You have <b><%=newOrders%></b> new order(s)!
        </div>
    <% } %>

    <div class="row g-4">

        <div class="col-md-3">
            <div class="card p-4 text-center">
                <i class="fas fa-seedling icon text-success"></i>
                <h5>Crop Info</h5>
                <a href="cropInfo.jsp" class="btn btn-success btn-custom">Open</a>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card p-4 text-center">
                <i class="fas fa-lightbulb icon text-warning"></i>
                <h5>Crop Advisory</h5>
                <a href="cropAdvisory.jsp" class="btn btn-warning btn-custom">Open</a>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card p-4 text-center">
                <i class="fas fa-cloud-sun icon text-primary"></i>
                <h5>Weather</h5>
                <a href="weather.jsp" class="btn btn-primary btn-custom">Open</a>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card p-4 text-center">
                <i class="fas fa-chart-line icon text-danger"></i>
                <h5>Market Rates</h5>
                <a href="marketRates.jsp" class="btn btn-danger btn-custom">Open</a>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card p-4 text-center">
                <i class="fas fa-store icon text-info"></i>
                <h5>Sell Crop</h5>
                <a href="sellCrop.jsp" class="btn btn-info btn-custom">Open</a>
            </div>
        </div>

        <!-- 📦 RECEIVED ORDERS -->
        <div class="col-md-3">
            <div class="card p-4 text-center position-relative">

                <i class="fas fa-cart-shopping icon text-secondary"></i>

                <h5>Received Orders</h5>

                <% if(newOrders > 0){ %>
                    <div class="badge-new"><%=newOrders%> New</div>
                <% } %>

                <a href="receivedOrders.jsp" class="btn btn-secondary btn-custom">
                    Open
                </a>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card p-4 text-center">
                <i class="fas fa-comments icon text-success"></i>
                <h5>Chat With Buyer</h5>
                <a href="buyerChat.jsp" class="btn btn-success btn-custom">Open</a>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card p-4 text-center">
                <i class="fas fa-file-signature icon text-dark"></i>
                <h5>Sale Request</h5>
                <a href="saleRequest.jsp" class="btn btn-dark btn-custom">Open</a>
            </div>
        </div>

    </div>
</div>

<div class="footer">
    © 2026 Crop Yield Management System
</div>

<div class="back-btn">
    <button onclick="history.back()" class="btn btn-dark px-4 shadow">
        <i class="fas fa-arrow-left"></i> Back
    </button>
</div>
                <a href="<%= request.getContextPath() %>/index.jsp"
   class="logout-btn text-decoration-none">
    🚪 Logout
</a>

</body>
</html>