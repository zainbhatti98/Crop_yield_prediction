<!DOCTYPE html>
<html>
<head>
    <title>Buyer Register</title>

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

        .register-card {
            width: 380px;
            padding: 30px;
            border-radius: 20px;
            position: relative;
            overflow: hidden;
            color: white;
            box-shadow: 0 10px 30px rgba(0,0,0,0.7);
        }

        /* BACKGROUND IMAGE */
        .register-card::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('https://images.unsplash.com/photo-1500937386664-56d1dfef3854?auto=format&fit=crop&w=1200') center/cover;
            z-index: 0;
        }

        /* DARK OVERLAY */
        .register-card::after {
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

<div class="register-card">
    <div class="content">

        <h3>? Buyer Register</h3>

        <form action="${pageContext.request.contextPath}/BuyerRegisterServlet" method="post">

            <input name="name" class="form-control mb-3" placeholder="Enter Name" required>

            <input name="email" type="email" class="form-control mb-3" placeholder="Enter Email" required>

            <input name="password" type="password" class="form-control mb-3" placeholder="Enter Password" required>

            <button class="btn btn-custom">Register</button>

        </form>

        <p class="text-center mt-3">
            Already have account? <a href="buyerLogin.jsp">Login</a>
        </p>

    </div>
</div>

</body>
</html>