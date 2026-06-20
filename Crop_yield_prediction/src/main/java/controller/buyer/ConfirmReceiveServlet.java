package controller.buyer;

import db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import service.MessageHelper;
import service.OrderStatusService;

import java.io.IOException;
import java.sql.*;

public class ConfirmReceiveServlet extends HttpServlet {

    private final OrderStatusService orderStatusService = new OrderStatusService();
    private final MessageHelper messageHelper = new MessageHelper();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("buyerId") == null) {
            response.sendRedirect(request.getContextPath() + "/buyer/buyerLogin.jsp");
            return;
        }

        int orderId = Integer.parseInt(request.getParameter("id"));
        int buyerId = (Integer) session.getAttribute("buyerId");

        try (Connection con = DBConnection.getConnection()) {

            PreparedStatement check = con.prepareStatement(
                    "SELECT status, farmer_id FROM orders WHERE id=? AND buyer_id=?"
            );

            check.setInt(1, orderId);
            check.setInt(2, buyerId);

            ResultSet rs = check.executeQuery();

            if (rs.next()
                    && orderStatusService.canTransition(
                            rs.getString("status"),
                            OrderStatusService.COMPLETED
                    )) {

                int farmerId = rs.getInt("farmer_id");

                PreparedStatement ps = con.prepareStatement(
                        "UPDATE orders SET status=?, buyer_confirmed=1, admin_status='Completed', notification=? WHERE id=?"
                );

                ps.setString(1, OrderStatusService.COMPLETED);
                ps.setString(2, "Order completed successfully. Thank you for purchase.");
                ps.setInt(3, orderId);

                ps.executeUpdate();

                messageHelper.sendOrderStatusMessage(
                        orderId,
                        farmerId,
                        buyerId,
                        OrderStatusService.COMPLETED
                );
            }

            response.sendRedirect(request.getContextPath()
                    + "/buyer/myOrders.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}