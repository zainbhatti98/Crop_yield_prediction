package controller.farmer;

import db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import service.MessageHelper;
import service.OrderStatusService;

import java.io.IOException;
import java.sql.*;

public class OrderStatusServlet extends HttpServlet {

    private final OrderStatusService orderStatusService = new OrderStatusService();
    private final MessageHelper messageHelper = new MessageHelper();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");

        try (Connection con = DBConnection.getConnection()) {

            PreparedStatement check = con.prepareStatement(
                    "SELECT status, farmer_id, buyer_id FROM orders WHERE id=?"
            );

            check.setInt(1, id);
            ResultSet rs = check.executeQuery();

            if (rs.next()) {

                if (!orderStatusService.canTransition(rs.getString("status"), status)) {
                    response.sendRedirect(request.getContextPath()
                            + "/farmer/receivedOrders.jsp?error=invalid");
                    return;
                }

                int farmerId = rs.getInt("farmer_id");
                int buyerId = rs.getInt("buyer_id");

                String notification = null;
                String adminStatus = null;

                if ("Accepted".equalsIgnoreCase(status)) {
                    notification = "Your order has been accepted by farmer.";
                    adminStatus = "Processing";
                }
                else if ("Delivered".equalsIgnoreCase(status)) {
                    notification = "Your order has been delivered. Please confirm receipt.";
                    adminStatus = "Delivered";
                }
                else if ("Rejected".equalsIgnoreCase(status)) {
                    notification = "Your order was rejected by farmer.";
                    adminStatus = "Rejected";
                }

                PreparedStatement ps = con.prepareStatement(
                        "UPDATE orders SET status=?, notification=?, buyer_seen=0, admin_status=? WHERE id=?"
                );

                ps.setString(1, status);
                ps.setString(2, notification);
                ps.setString(3, adminStatus);
                ps.setInt(4, id);

                ps.executeUpdate();

                messageHelper.sendOrderStatusMessage(id, farmerId, buyerId, status);
            }

            response.sendRedirect(request.getContextPath()
                    + "/farmer/receivedOrders.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}