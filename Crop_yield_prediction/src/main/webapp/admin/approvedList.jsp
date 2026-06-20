<%@page import="java.sql.*,db.DBConnection"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Approved List</title>

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

        h3, h5 {
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

        .form-control, .form-select {
            background: rgba(255,255,255,0.1);
            border: 1px solid rgba(255,255,255,0.2);
            color: white;
        }

        .form-control::placeholder {
            color: #ccc;
        }

        .form-control:focus, .form-select:focus {
            background: rgba(255,255,255,0.15);
            border-color: #00ff99;
            box-shadow: none;
            color: white;
        }

        .btn-custom {
            border-radius: 10px;
            font-weight: bold;
        }

        .btn-rate {
            background: #ffcc00;
            color: black;
        }

        .btn-rate:hover {
            background: #e6b800;
        }

        .back-btn {
            display: inline-block;
            margin-top: 15px;
            color: #00ff99;
            text-decoration: none;
        }
    </style>
</head>

<body>

<div class="container-box">

    <h3>🌾 Approved Crops</h3>

    <table class="table table-bordered text-center mb-4">

        <tr>
            <th>ID</th>
            <th>Farmer</th>
            <th>Crop</th>
            <th>Qty</th>
            <th>Price</th>
            <th>Status</th>
        </tr>

<%
try {
    Connection con = DBConnection.getConnection();

    PreparedStatement ps = con.prepareStatement(
        "SELECT sr.*, f.name AS farmer_name, c.crop_name " +
        "FROM sale_requests sr " +
        "JOIN farmers f ON sr.farmer_id = f.id " +
        "JOIN crops c ON sr.crop_id = c.id " +
        "WHERE sr.status='Approved'"
    );

    ResultSet rs = ps.executeQuery();

    while (rs.next()) {
%>

<tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("farmer_name") %></td>
    <td><%= rs.getString("crop_name") %></td>
    <td><%= rs.getDouble("quantity") %></td>
    <td>PKR <%= rs.getDouble("farmer_price") %></td>
    <td style="color:#00ff99;font-weight:bold;">Approved</td>
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

    <h5>⭐ Rate Farmer</h5>

    <form action="${pageContext.request.contextPath}/RateFarmerServlet" method="post" class="row g-3">

        <!-- Farmer -->
        <div class="col-md-3">
            <select name="farmerId" class="form-select" required>
                <option value="">Select Farmer</option>

                <%
                try {
                    Connection con = DBConnection.getConnection();
                    PreparedStatement ps = con.prepareStatement("SELECT id,name FROM farmers");
                    ResultSet frs = ps.executeQuery();

                    while (frs.next()) {
                %>

                <option value="<%=frs.getInt("id")%>">
                    <%=frs.getString("name")%>
                </option>

                <%
                    }

                    frs.close();
                    ps.close();
                    con.close();

                } catch(Exception e) {
                    e.printStackTrace();
                }
                %>

            </select>
        </div>

        <!-- Rating -->
        <div class="col-md-2">
            <select name="rating" class="form-select">
                <option value="5">⭐⭐⭐⭐⭐</option>
                <option value="4">⭐⭐⭐⭐</option>
                <option value="3">⭐⭐⭐</option>
                <option value="2">⭐⭐</option>
                <option value="1">⭐</option>
            </select>
        </div>

        <!-- Remarks -->
        <div class="col-md-4">
            <input name="remarks" class="form-control" placeholder="Enter remarks">
        </div>

        <!-- Button -->
        <div class="col-md-3">
            <button class="btn btn-rate btn-custom w-100">Rate Farmer</button>
        </div>

    </form>

    <a href="dashboard.jsp" class="back-btn">← Back to Dashboard</a>

</div>

</body>
</html>