package controller.admin;

import db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import service.ValidationUtil;
import java.io.IOException;
import java.sql.*;

public class RateFarmerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int farmerId = Integer.parseInt(request.getParameter("farmerId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        if (!ValidationUtil.isValidRating(rating)) return;
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement("INSERT INTO ratings(farmer_id,rating,remarks) VALUES(?,?,?)");
            ps.setInt(1, farmerId); ps.setInt(2, rating);
            ps.setString(3, request.getParameter("remarks"));
            ps.executeUpdate();
            response.sendRedirect(request.getContextPath() + "/admin/approvedList.jsp?rated=1");
        } catch (Exception e) { e.printStackTrace(); }
    }
}
