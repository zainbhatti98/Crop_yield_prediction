package controller.farmer;

import db.DBConnection;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.sql.*;

public class SellCropServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("farmerId") == null) {
            response.sendRedirect("farmer/farmerLogin.jsp");
            return;
        }

        int farmerId = (Integer) session.getAttribute("farmerId");

        // ✅ FIXED: cropId restored
        String cropIdStr = request.getParameter("cropId");
        String qtyStr = request.getParameter("quantity");
        String priceStr = request.getParameter("price");

        if (cropIdStr == null || qtyStr == null || priceStr == null ||
            cropIdStr.isEmpty() || qtyStr.isEmpty() || priceStr.isEmpty()) {
            response.sendRedirect("farmer/sellCrop.jsp?error=missing");
            return;
        }

        try {
            int cropId = Integer.parseInt(cropIdStr);
            double quantity = Double.parseDouble(qtyStr);
            double price = Double.parseDouble(priceStr);

            if (quantity < 1 || price < 1) {
                response.sendRedirect("farmer/sellCrop.jsp?error=invalid");
                return;
            }

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO sale_requests(farmer_id, crop_id, quantity, farmer_price, status) VALUES(?,?,?,?,?)"
            );

            ps.setInt(1, farmerId);
            ps.setInt(2, cropId);
            ps.setDouble(3, quantity);
            ps.setDouble(4, price);
            ps.setString(5, "Pending");

            ps.executeUpdate();

            response.sendRedirect("farmer/saleRequest.jsp?success=1");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("farmer/sellCrop.jsp?error=1");
        }
    }
}