<%@page import="java.sql.*,db.DBConnection,service.OrderStatusService"%>
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
    <title>My Orders</title>

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
            background: rgba(255,255,255,0.05);
            color: white;
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

        .status {
            font-weight: bold;
        }

        .pending { color: orange; }
        .approved { color: #00ff99; }
        .delivered { color: #00ccff; }

        .btn-chat {
            border-radius: 8px;
            font-weight: bold;
        }

        .btn-confirm {
            background: #00ff99;
            color: black;
            font-weight: bold;
            border-radius: 8px;
        }

        .btn-confirm:hover {
            background: #00cc77;
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

    <h3>📦 My Orders</h3>

    <table class="table table-bordered text-center">

        <tr>
            <th>ID</th>
            <th>Crop</th>
            <th>Qty</th>
            <th>Status</th>
            <th>Action</th>
        </tr>

<%
try {
    Connection con = DBConnection.getConnection();

    PreparedStatement ps = con.prepareStatement(
        "SELECT o.*, c.crop_name " +
        "FROM orders o " +
        "JOIN crops c ON o.crop_id = c.id " +
        "WHERE o.buyer_id = ? " +
        "ORDER BY o.id DESC"
    );

    ps.setInt(1, buyerId);

    ResultSet rs = ps.executeQuery();

    while (rs.next()) {

        String st = rs.getString("status");
        int oid = rs.getInt("id");
        int fid = rs.getInt("farmer_id");
%>

<tr>
    <td><%= oid %></td>
    <td><%= rs.getString("crop_name") %></td>
    <td><%= rs.getDouble("quantity") %></td>

    <td>
        <% if ("Pending".equalsIgnoreCase(st)) { %>
            <span class="status pending"><%= st %></span>

        <% } else if ("Delivered".equalsIgnoreCase(st)) { %>
            <span class="status delivered"><%= st %></span>

        <% } else if ("Completed".equalsIgnoreCase(st)) { %>
            <span class="status approved">Completed</span>

        <% } else { %>
            <span class="status approved"><%= st %></span>
        <% } %>
    </td>

    <td>

        <% if ("Delivered".equalsIgnoreCase(st)) { %>

            <a href="${pageContext.request.contextPath}/ConfirmReceiveServlet?id=<%=oid%>"
               class="btn btn-confirm btn-sm">
                Confirm Received
            </a>

        <% } else if ("Completed".equalsIgnoreCase(st)) { %>

            <span class="badge bg-success">Order Completed</span>

        <% } %>

        <a href="communication.jsp?farmerId=<%=fid%>"
           class="btn btn-outline-info btn-sm btn-chat">
            Chat
        </a>

    </td>

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

    <a href="dashboard.jsp" class="back">← Back to Dashboard</a>

</div>

</body>
</html>