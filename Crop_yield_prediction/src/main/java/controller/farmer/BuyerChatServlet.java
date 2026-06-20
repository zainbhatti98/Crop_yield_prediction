package controller.farmer;

import db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class BuyerChatServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("farmerId") == null) {
            response.sendRedirect(request.getContextPath() + "/farmer/farmerLogin.jsp");
            return;
        }
        int farmerId = (Integer) session.getAttribute("farmerId");
        int buyerId = Integer.parseInt(request.getParameter("buyerId"));
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO messages(sender_id,sender_type,receiver_id,receiver_type,message) VALUES(?,?,?,?,?)");
            ps.setInt(1, farmerId); ps.setString(2, "Farmer");
            ps.setInt(3, buyerId); ps.setString(4, "Buyer");
            ps.setString(5, request.getParameter("message"));
            ps.executeUpdate();
            response.sendRedirect(request.getContextPath() + "/farmer/buyerChat.jsp?buyerId=" + buyerId);
        } catch (Exception e) { e.printStackTrace(); }
    }
}
