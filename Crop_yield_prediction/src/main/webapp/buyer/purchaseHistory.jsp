<%@page import="java.sql.*,db.DBConnection"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<%
Integer buyerId = (Integer) session.getAttribute("buyerId");
if (buyerId == null) {
    response.sendRedirect("buyerLogin.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Purchase History</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            min-height: 100vh;
            background: linear-gradient(135deg, #000000, #0f3d0f);
            font-family: Arial;
            padding: 30px;
        }

        .container-box {
            background: rgba(255,255,255,0.08);
            border: 1px solid rgba(255,255,255,0.15);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 25px;
            color: white;
            box-shadow: 0 10px 30px rgba(0,0,0,0.6);
        }

        h3 {
            text-align: center;
            color: #00ff99;
            font-weight: bold;
            margin-bottom: 20px;
        }

        table {
            color: white;
            background: rgba(255,255,255,0.05);
            border-radius: 10px;
            overflow: hidden;
        }

        th {
            background: rgba(0,255,153,0.2);
            color: #00ff99;
        }

        td, th {
            vertical-align: middle !important;
        }

        .badge {
            font-size: 12px;
            padding: 6px 10px;
        }

        .back {
            display: inline-block;
            margin-top: 15px;
            color: #00ff99;
            text-decoration: none;
        }
    </style>
</head>

<body>

<div class="container-box">

    <h3>📋 Purchase History</h3>

    <table class="table table-bordered text-center">

        <tr>
            <th>Order</th>
            <th>Crop</th>
            <th>Qty</th>
            <th>Status</th>
            <th>Payment</th>
        </tr>

<%
try {
    Connection con = DBConnection.getConnection();

    PreparedStatement ps = con.prepareStatement(
        "SELECT o.*, c.crop_name " +
        "FROM orders o " +
        "JOIN crops c ON o.crop_id=c.id " +
        "WHERE o.buyer_id=? AND o.status='Completed' " +
        "ORDER BY o.id DESC"
    );

    ps.setInt(1, buyerId);

    ResultSet rs = ps.executeQuery();

    boolean any = false;

    while (rs.next()) {
        any = true;
%>

<tr>
    <td>#<%= rs.getInt("id") %></td>
    <td><%= rs.getString("crop_name") %></td>
    <td><%= rs.getDouble("quantity") %> kg</td>
    <td><span class="badge bg-success">Completed</span></td>
    <td><%= rs.getString("payment_method") %></td>
</tr>

<%
    }

    if (!any) {
%>
<tr>
    <td colspan="5" class="text-muted">No completed purchases yet.</td>
</tr>
<%
    }

    rs.close();
    ps.close();
    con.close();

} catch(Exception e) {
    e.printStackTrace();
}
%>

    </table>

    <a href="dashboard.jsp" class="back">← Back</a>

</div>

</body>
</html>