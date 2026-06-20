package controller.farmer;

import db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class FarmerRegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement("INSERT INTO farmers(name,email,password) VALUES(?,?,?)");
            ps.setString(1, request.getParameter("name"));
            ps.setString(2, request.getParameter("email"));
            ps.setString(3, request.getParameter("password"));
            ps.executeUpdate();
            response.sendRedirect(request.getContextPath() + "/farmer/farmerLogin.jsp");
        } catch (Exception e) { e.printStackTrace(); }
    }
}
