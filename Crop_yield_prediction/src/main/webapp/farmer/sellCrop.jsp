<%@page import="java.sql.*,db.DBConnection"%>

<!DOCTYPE html>
<html>
<head>
    <title>Sell Crop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body{
            background: linear-gradient(135deg,#0f3d0f,#2e7d32,#66bb6a);
            font-family: Arial;
        }

        .container-box{
            width:420px;
            margin:auto;
            margin-top:5%;
            background: rgba(255,255,255,0.95);
            padding:25px;
            border-radius:15px;
            box-shadow:0 10px 25px rgba(0,0,0,0.3);
        }

        h2{
            text-align:center;
            color:#198754;
            font-weight:bold;
        }

        input, select{
            width:100%;
            padding:10px;
            margin-top:8px;
            margin-bottom:15px;
            border-radius:8px;
            border:1px solid #ccc;
        }

        .btn-custom{
            width:100%;
            background:#198754;
            color:white;
            padding:12px;
            border:none;
            border-radius:10px;
            font-weight:bold;
        }
    </style>
</head>

<body>

<div class="container-box">

<h2>? Sell Crop</h2>

<form action="${pageContext.request.contextPath}/SellCropServlet" method="post">

    <label>Select Crop</label>
    <select name="cropId" required>
        <%
            try {
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement("SELECT * FROM crops");
                ResultSet rs = ps.executeQuery();

                while(rs.next()){
        %>
        <option value="<%=rs.getInt("id")%>">
            <%=rs.getString("crop_name")%>
        </option>
        <%
                }
            } catch(Exception e){
                out.println(e);
            }
        %>
    </select>

    <label>Quantity (KG)</label>
    <input type="number" name="quantity" min="1" required>

    <label>Price</label>
    <input type="number" name="price" min="1" required>

    <button class="btn-custom">Send Request</button>

</form>

</div>

</body>
</html>