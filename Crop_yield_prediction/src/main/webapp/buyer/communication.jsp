<%@page import="java.sql.*,db.DBConnection"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<%
Integer buyerId = (Integer) session.getAttribute("buyerId");
if (buyerId == null) {
    response.sendRedirect(request.getContextPath() + "/buyer/buyerLogin.jsp");
    return;
}

String farmerIdStr = request.getParameter("farmerId");
if (farmerIdStr == null) {
    response.sendRedirect("myOrders.jsp");
    return;
}

int farmerId = Integer.parseInt(farmerIdStr);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Chat</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            min-height: 100vh;
            background: linear-gradient(135deg, #000000, #0f3d0f);
            font-family: Arial;
            padding: 30px;
        }

        .chat-box {
            max-width: 700px;
            margin: auto;
            background: rgba(255,255,255,0.08);
            border: 1px solid rgba(255,255,255,0.15);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 20px;
            color: white;
            box-shadow: 0 10px 30px rgba(0,0,0,0.6);
        }

        h4 {
            text-align: center;
            color: #00ff99;
            margin-bottom: 15px;
        }

        .messages {
            height: 300px;
            overflow-y: auto;
            background: rgba(0,0,0,0.2);
            padding: 10px;
            border-radius: 10px;
        }

        .msg {
            margin: 5px 0;
        }

        .me {
            text-align: right;
        }

        .me span {
            background: #00ff99;
            color: black;
            padding: 8px 12px;
            border-radius: 15px;
            display: inline-block;
        }

        .other span {
            background: #444;
            padding: 8px 12px;
            border-radius: 15px;
            display: inline-block;
        }

        .input-box {
            margin-top: 15px;
            display: flex;
            gap: 10px;
        }

        .form-control {
            background: rgba(255,255,255,0.1);
            color: white;
            border: 1px solid rgba(255,255,255,0.2);
        }

        .form-control::placeholder {
            color: #ccc;
        }

        .btn-send {
            background: #00ff99;
            font-weight: bold;
            border-radius: 10px;
        }

        .btn-send:hover {
            background: #00cc77;
        }
    </style>
</head>

<body>

<div class="chat-box">

    <h4>💬 Chat with Farmer</h4>

    <div class="messages">

<%
try {
    Connection con = DBConnection.getConnection();

    PreparedStatement ps = con.prepareStatement(
        "SELECT * FROM messages " +
        "WHERE (sender_id=? AND receiver_id=?) OR (sender_id=? AND receiver_id=?) " +
        "ORDER BY send_time"
    );

    ps.setInt(1, buyerId);
    ps.setInt(2, farmerId);
    ps.setInt(3, farmerId);
    ps.setInt(4, buyerId);

    ResultSet rs = ps.executeQuery();

    boolean hasMsg = false;

    while (rs.next()) {
        hasMsg = true;

        boolean mine = buyerId == rs.getInt("sender_id");
%>

        <div class="msg <%= mine ? "me" : "other" %>">
            <span><%= rs.getString("message") %></span>
        </div>

<%
    }

    if (!hasMsg) {
%>
        <p class="text-muted text-center">No messages yet</p>
<%
    }

    rs.close();
    ps.close();
    con.close();

} catch(Exception e) {
    e.printStackTrace();
}
%>

    </div>

    <form action="${pageContext.request.contextPath}/CommunicationServlet" method="post" class="input-box">

        <input type="hidden" name="farmerId" value="<%= farmerId %>">

        <input type="text" name="message" class="form-control" placeholder="Type message..." required>

        <button class="btn btn-send">Send</button>

    </form>

    <a href="myOrders.jsp" class="d-block mt-3 text-center text-success">← Back</a>

</div>

</body>
</html>