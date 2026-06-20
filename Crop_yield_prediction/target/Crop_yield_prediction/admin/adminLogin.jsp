<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>

        body{
            margin:0;
            height:100vh;
            font-family:Arial;

            /* Admin professional background */
            background: url('https://images.pexels.com/photos/3184291/pexels-photo-3184291.jpeg')
            no-repeat center center/cover;

            display:flex;
            align-items:center;
            justify-content:center;
            position:relative;
        }

        /* dark overlay */
        .overlay{
            position:absolute;
            top:0;
            left:0;
            width:100%;
            height:100%;
            background:rgba(0,0,0,0.6);
        }

        .login-box{
            position:relative;
            width:370px;
            background:rgba(255,255,255,0.95);
            padding:30px;
            border-radius:15px;
            box-shadow:0 10px 25px rgba(0,0,0,0.4);
        }

        h2{
            text-align:center;
            color:#0d6efd;
            font-weight:bold;
            margin-bottom:20px;
        }

        input{
            width:100%;
            padding:12px;
            margin-bottom:15px;
            border-radius:10px;
            border:1px solid #ccc;
            outline:none;
        }

        input:focus{
            border-color:#0d6efd;
        }

        .btn-custom{
            width:100%;
            padding:12px;
            background:#0d6efd;
            color:white;
            border:none;
            border-radius:10px;
            font-weight:bold;
            transition:0.3s;
        }

        .btn-custom:hover{
            background:#084298;
            transform:scale(1.03);
        }

        .title-icon{
            font-size:28px;
            margin-bottom:10px;
            display:block;
            text-align:center;
        }

    </style>
</head>

<body>

<div class="overlay"></div>

<div class="login-box">

    <span class="title-icon">?</span>

    <h2>Admin Login</h2>

    <form action="${pageContext.request.contextPath}/AdminLoginServlet" method="post">

        <input type="text" name="username" placeholder="Username" required>

        <input type="password" name="password" placeholder="Password" required>

        <button class="btn-custom">Login</button>

    </form>

</div>

</body>
</html>