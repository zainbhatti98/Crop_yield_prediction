<%@page import="java.sql.*,db.DBConnection,service.CropService"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Available Crops</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            min-height: 100vh;
            background: linear-gradient(135deg, #000000, #0f3d0f);
            font-family: Arial;
            padding: 30px;
        }

        h3 {
            text-align: center;
            color: #00ff99;
            font-weight: bold;
            margin-bottom: 30px;
        }

        .crop-card {
            background: rgba(255,255,255,0.08);
            border: 1px solid rgba(255,255,255,0.15);
            backdrop-filter: blur(10px);
            color: white;
            border-radius: 20px;
            padding: 20px;
            transition: 0.3s;
            box-shadow: 0 10px 25px rgba(0,0,0,0.5);
            height: 100%;
        }

        .crop-card:hover {
            transform: translateY(-8px);
        }

        .crop-title {
            color: #00ff99;
            font-weight: bold;
            font-size: 18px;
        }

        .price {
            color: #00ff99;
            font-size: 16px;
            font-weight: bold;
        }

        .btn-buy {
            background: #00ff99;
            color: black;
            font-weight: bold;
            border-radius: 10px;
        }

        .btn-buy:hover {
            background: #00cc77;
        }

        .back-btn {
            display: inline-block;
            margin-top: 25px;
            color: #00ff99;
            text-decoration: none;
        }
    </style>
</head>

<body>

<%
CropService cs = new CropService();
%>

<div class="container">

    <h3>🛍️ Available Crops</h3>

    <div class="row g-4">

<%
try {

    Connection con = DBConnection.getConnection();

    PreparedStatement ps = con.prepareStatement(
        "SELECT sr.*, c.crop_name, c.rate AS admin_rate, f.name AS farmer_name " +
        "FROM sale_requests sr " +
        "JOIN crops c ON sr.crop_id = c.id " +
        "JOIN farmers f ON sr.farmer_id = f.id " +
        "WHERE sr.status='Approved'"
    );

    ResultSet rs = ps.executeQuery();

    while (rs.next()) {

        double fp = rs.getDouble("farmer_price");
        double ar = rs.getDouble("admin_rate");
%>

        <div class="col-md-4">

            <div class="crop-card">

                <div class="crop-title">
                    <%= rs.getString("crop_name") %>
                </div>

                <p>👨‍🌾 Farmer: <%= rs.getString("farmer_name") %></p>

                <p>📦 Quantity: <%= rs.getDouble("quantity") %> kg</p>

                <p class="price">
                    💰 <%= cs.formatPrice(cs.getEffectivePrice(fp, ar)) %>
                </p>

                <a href="buyCrop.jsp?id=<%= rs.getInt("id") %>" class="btn btn-buy w-100">
                    Buy Now
                </a>

            </div>

        </div>

<%
    }

    rs.close();
    ps.close();
    con.close();

} catch(Exception e) {
    e.printStackTrace(); // IMPORTANT: show error in console
}
%>

    </div>

    <a href="dashboard.jsp" class="back-btn">← Back</a>

</div>

</body>
</html>