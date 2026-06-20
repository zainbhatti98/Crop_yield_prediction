<%@page import="java.sql.*"%>
<%@page import="db.DBConnection"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Market Rates</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>

        body{
            background: linear-gradient(135deg,#0f3d0f,#2e7d32,#66bb6a);
            font-family: Arial;
            padding:20px;
        }

        .container-box{
            background: rgba(255,255,255,0.95);
            padding:20px;
            border-radius:15px;
            box-shadow:0 10px 25px rgba(0,0,0,0.3);
        }

        h2{
            text-align:center;
            color:#198754;
            margin-bottom:20px;
            font-weight:bold;
        }

        table{
            border-radius:10px;
            overflow:hidden;
        }

        th{
            background:#198754 !important;
            color:white;
        }

        tr:hover{
            background:#f1f1f1;
        }

        .rate{
            font-weight:bold;
            color:#198754;
        }

    </style>
</head>

<body>

<div class="container container-box">

<h2>📊 Market Rates</h2>

<table class="table table-bordered text-center">

<tr>
    <th>Crop Name</th>
    <th>Rate (Per KG)</th>
</tr>

<%
try{

Connection con = DBConnection.getConnection();
PreparedStatement ps = con.prepareStatement("SELECT * FROM crops");
ResultSet rs = ps.executeQuery();

while(rs.next()){

%>

<tr>
    <td><%=rs.getString("crop_name")%></td>
    <td class="rate">₹ <%=rs.getDouble("rate")%></td>
</tr>

<%
}

}catch(Exception e){
out.println(e.getMessage());
}
%>

</table>

</div>

</body>
</html>