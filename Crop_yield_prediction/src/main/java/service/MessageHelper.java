package service;

import db.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class MessageHelper {
    private final OrderStatusService orderStatusService = new OrderStatusService();

    public void sendOrderStatusMessage(int orderId, int farmerId, int buyerId, String newStatus) {
        try {
            Connection con = DBConnection.getConnection();
            if (con == null) return;
            String message = orderStatusService.getSystemMessage(newStatus, orderId);
            insertMessage(con, farmerId, "System", buyerId, "Buyer", message);
            insertMessage(con, buyerId, "System", farmerId, "Farmer", message);
        } catch (Exception e) { e.printStackTrace(); }
    }

    private void insertMessage(Connection con, int senderId, String senderType,
            int receiverId, String receiverType, String message) throws Exception {
        PreparedStatement ps = con.prepareStatement(
                "INSERT INTO messages(sender_id,sender_type,receiver_id,receiver_type,message) VALUES(?,?,?,?,?)");
        ps.setInt(1, senderId); ps.setString(2, senderType);
        ps.setInt(3, receiverId); ps.setString(4, receiverType);
        ps.setString(5, message);
        ps.executeUpdate();
    }
}
