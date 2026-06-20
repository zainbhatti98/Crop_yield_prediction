package controller.buyer;

import db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import service.MessageHelper;
import service.OrderStatusService;
import service.ValidationUtil;
import java.io.IOException;
import java.sql.*;

public class BuyCropServlet extends HttpServlet {
    private final OrderStatusService orderStatusService = new OrderStatusService();
    private final MessageHelper messageHelper = new MessageHelper();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("buyerId") == null) {
            response.sendRedirect(request.getContextPath() + "/buyer/buyerLogin.jsp");
            return;
        }
        int buyerId = (Integer) session.getAttribute("buyerId");
        int requestId = Integer.parseInt(request.getParameter("requestId"));
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        if (!ValidationUtil.isValidName(name) || !ValidationUtil.isValidPhone(phone) || address == null || address.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/buyer/buyCrop.jsp?id=" + requestId + "&error=invalid");
            return;
        }
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM sale_requests WHERE id=? AND status='Approved'");
            ps.setInt(1, requestId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int farmerId = rs.getInt("farmer_id");
                PreparedStatement ps2 = con.prepareStatement(
                        "INSERT INTO orders(buyer_id,farmer_id,crop_id,quantity,payment_method,payment_number,status,buyer_name,buyer_phone,buyer_address) VALUES(?,?,?,?,?,?,?,?,?,?)",
                        Statement.RETURN_GENERATED_KEYS);
                ps2.setInt(1, buyerId); ps2.setInt(2, farmerId);
                ps2.setInt(3, rs.getInt("crop_id")); ps2.setDouble(4, rs.getDouble("quantity"));
                ps2.setString(5, request.getParameter("paymentMethod"));
                ps2.setString(6, request.getParameter("paymentNumber"));
                ps2.setString(7, OrderStatusService.PENDING);
                ps2.setString(8, name); ps2.setString(9, phone); ps2.setString(10, address);
                ps2.executeUpdate();
                ResultSet keys = ps2.getGeneratedKeys();
                int orderId = keys.next() ? keys.getInt(1) : 0;
                messageHelper.sendOrderStatusMessage(orderId, farmerId, buyerId, OrderStatusService.PENDING);
                response.sendRedirect(request.getContextPath() + "/buyer/myOrders.jsp?success=1");
            }
        } catch (Exception e) { e.printStackTrace(); }
    }
}
