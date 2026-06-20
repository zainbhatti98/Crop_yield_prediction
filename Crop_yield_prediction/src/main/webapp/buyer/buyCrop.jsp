<%@page import="java.sql.*,db.DBConnection,service.CropService"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<%
String id = request.getParameter("id");
if (id == null) {
    response.sendRedirect("availableCrops.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Buy Crop</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            min-height: 100vh;
            background: linear-gradient(135deg, #000000, #0f3d0f);
            font-family: Arial;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .card-box {
            width: 450px;
            padding: 30px;
            border-radius: 20px;
            background: rgba(255,255,255,0.08);
            border: 1px solid rgba(255,255,255,0.15);
            backdrop-filter: blur(12px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.6);
            color: white;
        }

        h3 {
            text-align: center;
            color: #00ff99;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .form-control {
            background: rgba(255,255,255,0.1);
            border: 1px solid rgba(255,255,255,0.2);
            color: white;
        }

        .form-control::placeholder {
            color: #ccc;
        }

        .form-control:focus {
            background: rgba(255,255,255,0.15);
            border-color: #00ff99;
            box-shadow: none;
            color: white;
        }

        select.form-control {
            color: black;
        }

        .btn-custom {
            background: #00ff99;
            color: black;
            font-weight: bold;
            width: 100%;
            border-radius: 10px;
        }

        .btn-custom:hover {
            background: #00cc77;
        }

        label {
            color: #ccc;
            font-size: 14px;
            margin-bottom: 5px;
        }
    </style>
</head>

<body>

<div class="card-box">

    <h3>🛒 Place Order</h3>

    <form action="${pageContext.request.contextPath}/BuyCropServlet" method="post">

        <!-- hidden crop request id -->
        <input type="hidden" name="requestId" value="<%=id%>">

        <label>Your Name</label>
        <input type="text" name="name" placeholder="Enter your name" class="form-control mb-3" required>

        <label>Phone</label>
        <input type="text" name="phone" placeholder="Enter phone number" class="form-control mb-3" required>

        <label>Address</label>
        <textarea name="address" placeholder="Enter delivery address" class="form-control mb-3" required></textarea>

        <label>Payment Method</label>
        <select name="paymentMethod" class="form-control mb-3">
            <option>Cash On Delivery</option>
            <option>EasyPaisa</option>
            <option>JazzCash</option>
        </select>

        <label>Payment Number (if online)</label>
        <input type="text" name="paymentNumber" placeholder="Optional" class="form-control mb-3">

        <button class="btn btn-custom">Place Order</button>

    </form>

</div>

</body>
</html>