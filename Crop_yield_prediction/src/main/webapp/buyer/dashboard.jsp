<!DOCTYPE html>
<%@ page import="java.sql.*,db.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
Integer buyerId = (Integer) session.getAttribute("buyerId");

if (buyerId == null) {
    response.sendRedirect("buyerLogin.jsp");
    return;
}

int notifyCount = 0;

try {
    Connection con = DBConnection.getConnection();

    PreparedStatement ps = con.prepareStatement(
        "SELECT COUNT(*) FROM orders WHERE buyer_id=? AND buyer_seen=0 AND notification IS NOT NULL"
    );

    ps.setInt(1, buyerId);

    ResultSet rs = ps.executeQuery();

    if(rs.next()){
        notifyCount = rs.getInt(1);
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
    <title>Buyer Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #000, #0f3d0f);
            min-height: 100vh;
            font-family: Arial;
            padding: 40px;
        }

        h1 {
            text-align: center;
            color: #00ff99;
            font-weight: bold;
            margin-bottom: 30px;
        }

        /* IMAGE CARD */
        .card-box {
            position: relative;
            height: 220px;
            border-radius: 18px;
            overflow: hidden;
            color: white;
            box-shadow: 0 10px 25px rgba(0,0,0,0.6);
            transition: 0.3s;
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
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.55);
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

        .badge-notify{
            position:absolute;
            top:10px;
            right:10px;
            background:red;
            color:white;
            padding:5px 10px;
            border-radius:50px;
            font-size:12px;
            z-index: 3;
        }

        /* BACKGROUNDS */
        .crops {
            background: url('https://images.unsplash.com/photo-1500595046743-cd271d694d30?auto=format&fit=crop&w=1200') center/cover;
        }

        .orders {
            background: url('https://images.unsplash.com/photo-1580910051074-3eb694886505?auto=format&fit=crop&w=1200') center/cover;
        }

        .history {
            background: url('https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200') center/cover;
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

<h1>🛒 Buyer Dashboard</h1>

<div class="container">

    <% if(notifyCount > 0){ %>
        <div class="alert alert-info text-center">
            🔔 You have <b><%=notifyCount%></b> new update(s) from farmer
        </div>
    <% } %>

    <div class="row g-4 justify-content-center">

        <!-- AVAILABLE CROPS -->
        <div class="col-md-4">
            <div class="card-box crops">
                <div class="content">
                    <h4>🌾 Available Crops</h4>
                    <a href="availableCrops.jsp" class="btn btn-success btn-custom">Open</a>
                </div>
            </div>
        </div>

        <!-- MY ORDERS -->
        <div class="col-md-4">
            <div class="card-box orders">

                <% if(notifyCount > 0){ %>
                    <div class="badge-notify"><%=notifyCount%> New</div>
                <% } %>

                <div class="content">
                    <h4>🛒 My Orders</h4>
                    <a href="myOrders.jsp" class="btn btn-primary btn-custom">Open</a>
                </div>
            </div>
        </div>

        <!-- HISTORY -->
        <div class="col-md-4">
            <div class="card-box history">
                <div class="content">
                    <h4>📜 Purchase History</h4>
                    <a href="purchaseHistory.jsp" class="btn btn-secondary btn-custom">Open</a>
                </div>
            </div>
        </div>

    </div>
</div>
                <a href="<%= request.getContextPath() %>/index.jsp"
   class="logout-btn text-decoration-none">
    🚪 Logout
</a>

</body>
</html>