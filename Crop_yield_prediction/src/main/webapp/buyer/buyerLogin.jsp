<!DOCTYPE html>
<html>
<head>
    <title>Buyer Login</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #000;
            font-family: Arial;
        }

        .login-card {
            width: 380px;
            padding: 30px;
            border-radius: 20px;
            position: relative;
            overflow: hidden;
            color: white;
            box-shadow: 0 10px 30px rgba(0,0,0,0.7);
        }

        /* BACKGROUND IMAGE */
        .login-card::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background:  url('https://images.unsplash.com/photo-1500937386664-56d1dfef3854?auto=format&fit=crop&w=1200') center/cover;
            z-index: 0;
        }

        /* DARK OVERLAY */
        .login-card::after {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.65);
            z-index: 1;
        }

        .content {
            position: relative;
            z-index: 2;
        }

        h2 {
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

        .btn-custom {
            width: 100%;
            background: #00ff99;
            color: black;
            font-weight: bold;
            border-radius: 10px;
        }

        .btn-custom:hover {
            background: #00cc77;
        }

        a {
            color: #00ff99;
        }
    </style>
</head>

<body>

<div class="login-card">
    <div class="content">

        <h2>? Buyer Login</h2>

        <form action="${pageContext.request.contextPath}/BuyerLoginServlet" method="post">

            <input type="email" name="email" class="form-control mb-3" placeholder="Email" required>

            <input type="password" name="password" class="form-control mb-3" placeholder="Password" required>

            <button class="btn btn-custom">Login</button>

        </form>

        <p class="text-center mt-3">
            New Buyer? <a href="buyerRegister.jsp">Register</a>
        </p>

    </div>
</div>

</body>
</html>