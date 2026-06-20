<%@page import="java.sql.*,db.DBConnection"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<%
Integer farmerId = (Integer) session.getAttribute("farmerId");

if(farmerId == null){
    response.sendRedirect("farmerLogin.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Sale Requests</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body{
            margin:0;
            min-height:100vh;
            background:linear-gradient(135deg,#000,#0f3d0f);
            padding:30px;
            font-family:Arial,sans-serif;
        }

        .main-card{
            background:rgba(255,255,255,0.08);
            backdrop-filter:blur(10px);
            border:1px solid rgba(255,255,255,0.15);
            border-radius:20px;
            padding:25px;
            color:white;
            box-shadow:0 10px 30px rgba(0,0,0,.5);
        }

        h3{
            color:#00ff99;
            text-align:center;
            margin-bottom:25px;
            font-weight:bold;
        }

        .table{
            color:white;
        }

        .table thead{
            background:rgba(0,255,153,.15);
        }

        .table th{
            color:#00ff99;
        }

        .badge-pending{
            background:#ffc107;
            color:black;
        }

        .badge-approved{
            background:#198754;
        }

        .badge-rejected{
            background:#dc3545;
        }
    </style>
</head>

<body>

<div class="container">

    <div class="main-card">

        <h3>🌾 My Sale Requests</h3>

        <% if("1".equals(request.getParameter("success"))){ %>
            <div class="alert alert-success">
                Request sent to admin successfully!
            </div>
        <% } %>

        <table class="table table-bordered table-hover text-center align-middle">

            <thead>
                <tr>
                    <th>ID</th>
                    <th>Crop</th>
                    <th>Quantity (KG)</th>
                    <th>Price</th>
                    <th>Status</th>
                </tr>
            </thead>

            <tbody>

            <%
            try{
                Connection con = DBConnection.getConnection();

                PreparedStatement ps = con.prepareStatement(
                    "SELECT sr.*, c.crop_name " +
                    "FROM sale_requests sr " +
                    "JOIN crops c ON sr.crop_id=c.id " +
                    "WHERE sr.farmer_id=? " +
                    "ORDER BY sr.id DESC"
                );

                ps.setInt(1, farmerId);

                ResultSet rs = ps.executeQuery();

                boolean found = false;

                while(rs.next()){
                    found = true;

                    String status = rs.getString("status");
            %>

                <tr>
                    <td><%= rs.getInt("id") %></td>

                    <td><%= rs.getString("crop_name") %></td>

                    <td><%= rs.getDouble("quantity") %></td>

                    <td>
                        PKR <%= rs.getDouble("farmer_price") %>
                    </td>

                    <td>

                    <%
                    if("Approved".equalsIgnoreCase(status)){
                    %>
                        <span class="badge badge-approved">
                            Approved
                        </span>

                    <%
                    }else if("Rejected".equalsIgnoreCase(status)){
                    %>

                        <span class="badge badge-rejected">
                            Rejected
                        </span>

                    <%
                    }else{
                    %>

                        <span class="badge badge-pending">
                            Pending
                        </span>

                    <%
                    }
                    %>

                    </td>

                </tr>

            <%
                }

                if(!found){
            %>

                <tr>
                    <td colspan="5">
                        No sale requests found.
                    </td>
                </tr>

            <%
                }

                rs.close();
                ps.close();
                con.close();

            }catch(Exception e){
            %>

                <tr>
                    <td colspan="5" class="text-danger">
                        <%= e.getMessage() %>
                    </td>
                </tr>

            <%
            }
            %>

            </tbody>

        </table>

        <div class="text-center mt-3">
            <a href="dashboard.jsp" class="btn btn-success">
                ← Back to Dashboard
            </a>
        </div>

    </div>

</div>

</body>
</html>