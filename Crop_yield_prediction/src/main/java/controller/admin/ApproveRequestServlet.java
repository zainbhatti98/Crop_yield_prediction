package controller.admin;

import db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import service.SaleRequestService;
import java.io.IOException;
import java.sql.*;

public class ApproveRequestServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String action = request.getParameter("action");
        String status = "approve".equalsIgnoreCase(action) ? SaleRequestService.APPROVED : SaleRequestService.REJECTED;
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement("UPDATE sale_requests SET status=? WHERE id=? AND status=?");
            ps.setString(1, status); ps.setInt(2, id); ps.setString(3, SaleRequestService.PENDING);
            ps.executeUpdate();
            response.sendRedirect(request.getContextPath() + "/admin/farmerRequests.jsp");
        } catch (Exception e) { e.printStackTrace(); }
    }
}
