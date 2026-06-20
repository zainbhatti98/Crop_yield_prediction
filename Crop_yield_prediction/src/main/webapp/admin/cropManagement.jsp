<%@page import="java.sql.*,db.DBConnection"%>
 <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html>
<head>
    <title>Crop Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="p-4">

<div class="container bg-white p-4 rounded shadow">

    <h3 class="text-success">Crop Management (Add / Update / Delete)</h3>

    <!-- ADD CROP -->
    <form action="${pageContext.request.contextPath}/CropManagementServlet" method="post" class="row g-2 mb-4">

        <input type="hidden" name="action" value="add">

        <div class="col-md-4">
            <input name="cropName" class="form-control" placeholder="Crop Name" required>
        </div>

        <div class="col-md-4">
            <input name="marketRate" type="number" class="form-control" placeholder="Rate" required>
        </div>

        <div class="col-md-4">
            <button class="btn btn-success w-100">Add Crop</button>
        </div>

    </form>

    <!-- TABLE -->
    <table class="table table-bordered">

        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Rate</th>
            <th>Update</th>
            <th>Delete</th>
        </tr>

<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    con = DBConnection.getConnection();
    ps = con.prepareStatement("SELECT * FROM crops");
    rs = ps.executeQuery();

    while (rs.next()) {
%>

<tr>
    <td><%= rs.getInt("id") %></td>

    <!-- UPDATE FORM -->
    <td>
        <form action="${pageContext.request.contextPath}/CropManagementServlet" method="post" class="d-flex gap-1">

            <input type="hidden" name="action" value="update">
            <input type="hidden" name="cropId" value="<%= rs.getInt("id") %>">

            <input name="cropName"
                   value="<%= rs.getString("crop_name") %>"
                   class="form-control form-control-sm" required>
    </td>

    <td>
        <input name="marketRate"
               type="number"
               value="<%= rs.getDouble("rate") %>"
               class="form-control form-control-sm" required>
    </td>

    <td>
        <button class="btn btn-warning btn-sm">Update</button>
        </form>
    </td>

    <!-- DELETE FORM -->
    <td>
        <form action="${pageContext.request.contextPath}/CropManagementServlet" method="post">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="cropId" value="<%= rs.getInt("id") %>">
            <button class="btn btn-danger btn-sm">Delete</button>
        </form>
    </td>

</tr>

<%
    }

} catch(Exception e) {
    e.printStackTrace();
} finally {
    try { if (rs != null) rs.close(); } catch(Exception e) {}
    try { if (ps != null) ps.close(); } catch(Exception e) {}
    try { if (con != null) con.close(); } catch(Exception e) {}
}
%>

    </table>

    <a href="dashboard.jsp" class="btn btn-success">← Back</a>

</div>

</body>
</html>