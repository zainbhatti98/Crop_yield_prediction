<%@page import="java.sql.*"%>
<%@page import="db.DBConnection"%>
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
    <title>Received Orders</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>

        body{
            background:linear-gradient(135deg,#000,#0f3d0f,#198754);
            min-height:100vh;
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

        h2{
            text-align:center;
            color:#00ff99;
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

        .table tbody tr:hover{
            background:rgba(255,255,255,.08);
        }

        .status{
            padding:6px 12px;
            border-radius:20px;
            font-size:13px;
            font-weight:bold;
        }

        .Pending{ background:#ffc107; color:black; }
        .Accepted{ background:#198754; color:white; }
        .Rejected{ background:#dc3545; color:white; }
        .Delivered{ background:#0d6efd; color:white; }
        .Completed{ background:#20c997; color:white; }

        .btn-accept{
            background:#198754;
            color:white;
            padding:6px 12px;
            border-radius:8px;
            text-decoration:none;
            margin-right:5px;
        }

        .btn-reject{
            background:#dc3545;
            color:white;
            padding:6px 12px;
            border-radius:8px;
            text-decoration:none;
            margin-right:5px;
        }

        .btn-chat{
            background:#0d6efd;
            color:white;
            padding:6px 12px;
            border-radius:8px;
            text-decoration:none;
        }

        .btn-accept:hover,
        .btn-reject:hover,
        .btn-chat:hover{
            opacity:.9;
            color:white;
        }

    </style>
</head>

<body>

<div class="container">

<div class="main-card">

<h2>📦 Received Orders</h2>

<table class="table table-bordered text-center align-middle">

<thead>
<tr>
    <th>Order ID</th>
    <th>Buyer</th>
    <th>Phone</th>
    <th>Address</th>
    <th>Quantity</th>
    <th>Payment</th>
    <th>Status</th>
    <th>Actions</th>
</tr>
</thead>

<tbody>

<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try{

    con = DBConnection.getConnection();

    ps = con.prepareStatement(
        "SELECT * FROM orders WHERE farmer_id=? ORDER BY id DESC"
    );

    ps.setInt(1, farmerId);

    rs = ps.executeQuery();

    boolean found = false;

    while(rs.next()){

        found = true;

        String status = rs.getString("status");
        int orderId = rs.getInt("id");
%>

<tr>

    <td>#<%=orderId%></td>

    <td><%=rs.getString("buyer_name")%></td>
    <td><%=rs.getString("buyer_phone")%></td>
    <td><%=rs.getString("buyer_address")%></td>
    <td><%=rs.getDouble("quantity")%> KG</td>
    <td><%=rs.getString("payment_method")%></td>

    <td>
        <span class="status <%=status%>">
            <%=status%>
        </span>
    </td>

    <td>

    <% if("Pending".equalsIgnoreCase(status)){ %>

        <a class="btn-accept"
           href="${pageContext.request.contextPath}/OrderStatusServlet?id=<%=orderId%>&status=Accepted">
            ✔
        </a>

        <a class="btn-reject"
           href="${pageContext.request.contextPath}/OrderStatusServlet?id=<%=orderId%>&status=Rejected">
            ✖
        </a>

    <% } else if("Accepted".equalsIgnoreCase(status)) { %>

        <a class="btn btn-primary btn-sm"
           href="${pageContext.request.contextPath}/OrderStatusServlet?id=<%=orderId%>&status=Delivered">
            Mark Delivered
        </a>

    <% } else if("Delivered".equalsIgnoreCase(status)) { %>

        <span class="badge bg-info">Waiting Buyer Confirmation</span>

    <% } else if("Completed".equalsIgnoreCase(status)) { %>

        <span class="badge bg-success">Completed</span>

    <% } else { %>

        <span class="badge bg-secondary">Processed</span>

    <% } %>

        <a class="btn-chat"
           href="buyerChat.jsp?buyerId=<%=rs.getInt("buyer_id")%>">
            💬
        </a>

    </td>

</tr>

<%
    }

    if(!found){
%>

<tr>
    <td colspan="8" class="text-center">
        No orders received yet.
    </td>
</tr>

<%
    }

}catch(Exception e){
%>

<tr>
    <td colspan="8" class="text-danger text-center">
        <%=e.getMessage()%>
    </td>
</tr>

<%
}finally{

    try{ if(rs!=null) rs.close(); }catch(Exception ex){}
    try{ if(ps!=null) ps.close(); }catch(Exception ex){}
    try{ if(con!=null) con.close(); }catch(Exception ex){}
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