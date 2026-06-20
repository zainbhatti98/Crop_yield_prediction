<%@page import="java.sql.*,db.DBConnection"%>
<%
Integer farmerId = (Integer) session.getAttribute("farmerId");
if (farmerId == null) {
    response.sendRedirect(request.getContextPath() + "/farmer/farmerLogin.jsp");
    return;
}
String buyerIdStr = request.getParameter("buyerId");
if (buyerIdStr == null || buyerIdStr.trim().isEmpty()) {
    response.sendRedirect("receivedOrders.jsp");
    return;
}
int buyerId = Integer.parseInt(buyerIdStr);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Chat with Buyer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-4 bg-success bg-opacity-10">
<div class="container bg-white p-4 rounded shadow" style="max-width:700px;">
    <h4 class="text-success mb-4">💬 Chat with Buyer</h4>
    <div class="border rounded p-3 mb-3" style="height:300px;overflow-y:auto;background:#f8f9fa;">
        <% try (Connection con = DBConnection.getConnection();
               PreparedStatement ps = con.prepareStatement(
                   "SELECT * FROM messages WHERE (sender_id=? AND receiver_id=?) OR (sender_id=? AND receiver_id=?) ORDER BY send_time");
               ) {
            ps.setInt(1, farmerId); ps.setInt(2, buyerId);
            ps.setInt(3, buyerId); ps.setInt(4, farmerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                boolean mine = farmerId == rs.getInt("sender_id");
        %>
        <div class="mb-2 <%= mine ? "text-end" : "" %>">
            <span class="badge <%= mine ? "bg-success" : "bg-primary" %>"><%= rs.getString("message") %></span>
        </div>
        <% } } catch (Exception e) { %>
        <p class="text-muted">No messages yet.</p>
        <% } %>
    </div>
    <form action="${pageContext.request.contextPath}/BuyerChatServlet" method="post" class="d-flex gap-2">
        <input type="hidden" name="buyerId" value="<%= buyerId %>">
        <input type="text" name="message" class="form-control" placeholder="Type message..." required>
        <button class="btn btn-success">Send</button>
    </form>
    <a href="receivedOrders.jsp" class="btn btn-outline-secondary mt-3">← Back</a>
</div>
</body>
</html>
