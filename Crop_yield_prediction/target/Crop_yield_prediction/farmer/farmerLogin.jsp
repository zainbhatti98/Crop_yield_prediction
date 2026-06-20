<!DOCTYPE html>
<html>
<head>
    <title>Farmer Login</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #000000, #0f3d0f);
            font-family: Arial;
        }

        .login-card {
            width: 380px;
            padding: 30px;
            border-radius: 20px;
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(12px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.6);
            color: white;
            transition: 0.3s;
        }

        .login-card:hover {
            transform: translateY(-5px);
        }

        h3 {
            text-align: center;
            color: #00ff99;
            margin-bottom: 20px;
            font-weight: bold;
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

        a {
            color: #00ff99;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .alert-custom {
            background: rgba(255,0,0,0.15);
            border: 1px solid rgba(255,0,0,0.3);
            color: #ff6b6b;
            border-radius: 10px;
            font-size: 14px;
        }
    </style>
</head>

<body>

<div class="login-card">

    <h3>? Farmer Login</h3>

    <% if ("db".equals(request.getParameter("error"))) { %>
        <div class="alert alert-custom">
            Database not connected. Start MySQL and import cropyielddb.sql
        </div>
    <% } else if ("login".equals(request.getParameter("error"))) { %>
        <div class="alert alert-custom">
            Invalid email or password
        </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/FarmerLoginServlet" method="post">

        <input type="email" name="email" class="form-control mb-3" placeholder="Enter Email" required>

        <input type="password" name="password" class="form-control mb-3" placeholder="Enter Password" required>

        <button class="btn btn-custom">Login</button>

    </form>

    <p class="text-center mt-3">
        New Farmer? <a href="farmerRegister.jsp">Register</a>
    </p>

</div>

</body>
</html>