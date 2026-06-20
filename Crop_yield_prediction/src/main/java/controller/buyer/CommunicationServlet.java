package controller.buyer;

import db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class CommunicationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("buyerId") == null) {
            response.sendRedirect(request.getContextPath() + "/buyer/buyerLogin.jsp");
            return;
        }
        int buyerId = (Integer) session.getAttribute("buyerId");
        int farmerId = Integer.parseInt(request.getParameter("farmerId"));
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO messages(sender_id,sender_type,receiver_id,receiver_type,message) VALUES(?,?,?,?,?)");
            ps.setInt(1, buyerId); ps.setString(2, "Buyer");
            ps.setInt(3, farmerId); ps.setString(4, "Farmer");
            ps.setString(5, request.getParameter("message"));
            ps.executeUpdate();
            response.sendRedirect(request.getContextPath() + "/buyer/communication.jsp?farmerId=" + farmerId);
        } catch (Exception e) { e.printStackTrace(); }
    }
}
