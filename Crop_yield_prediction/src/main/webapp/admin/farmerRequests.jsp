<%@page import="java.sql.*,db.DBConnection"%>
 <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html>
<head>
    <title>Farmer Requests</title>

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

        .btn-custom {
            border-radius: 8px;
            font-weight: bold;
        }

        .btn-approve {
            background: #00ff99;
            color: black;
        }

        .btn-reject {
            background: #ff4d4d;
            color: white;
        }

        .status-pending {
            color: orange;
            font-weight: bold;
        }

        .status-approved {
            color: #00ff99;
            font-weight: bold;
        }

        .status-rejected {
            color: #ff4d4d;
            font-weight: bold;
        }

        a.back {
            display: inline-block;
            margin-top: 15px;
            color: #00ff99;
            text-decoration: none;
        }
    </style>
</head>

<body>

<div class="container-box">

    <h3>🌾 Farmer Sale Requests</h3>

    <table class="table table-bordered text-center">

        <tr>
            <th>ID</th>
            <th>Farmer</th>
            <th>Crop</th>
            <th>Qty</th>
            <th>Price</th>
            <th>Status</th>
            <th>Action</th>
        </tr>

<%
try {
    Connection con = DBConnection.getConnection();

    PreparedStatement ps = con.prepareStatement(
        "SELECT sr.*, f.name AS farmer_name, c.crop_name " +
        "FROM sale_requests sr " +
        "JOIN farmers f ON sr.farmer_id = f.id " +
        "JOIN crops c ON sr.crop_id = c.id " +
        "ORDER BY sr.id DESC"
    );

    ResultSet rs = ps.executeQuery();

    while (rs.next()) {

        String st = rs.getString("status");
%>

<tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("farmer_name") %></td>
    <td><%= rs.getString("crop_name") %></td>
    <td><%= rs.getDouble("quantity") %></td>
    <td>PKR <%= rs.getDouble("farmer_price") %></td>

    <td>
        <% if ("Pending".equals(st)) { %>
            <span class="status-pending"><%= st %></span>
        <% } else if ("Approved".equals(st)) { %>
            <span class="status-approved"><%= st %></span>
        <% } else { %>
            <span class="status-rejected"><%= st %></span>
        <% } %>
    </td>

    <td>
        <% if ("Pending".equals(st)) { %>

            <a href="${pageContext.request.contextPath}/ApproveRequestServlet?id=<%=rs.getInt("id")%>&action=approve"
               class="btn btn-approve btn-sm btn-custom">
               Approve
            </a>

            <a href="${pageContext.request.contextPath}/ApproveRequestServlet?id=<%=rs.getInt("id")%>&action=reject"
               class="btn btn-reject btn-sm btn-custom">
               Reject
            </a>

        <% } else { %>
            <span class="text-muted">No Action</span>
        <% } %>
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