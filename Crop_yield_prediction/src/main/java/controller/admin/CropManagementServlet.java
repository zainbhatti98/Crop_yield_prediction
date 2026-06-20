package controller.admin;

import db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import service.CropService;
import java.io.IOException;
import java.sql.*;

public class CropManagementServlet extends HttpServlet {
    private final CropService cropService = new CropService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "add";
        try (Connection con = DBConnection.getConnection()) {
            switch (action) {
                case "add" -> {
                    String name = request.getParameter("cropName");
                    double rate = Double.parseDouble(request.getParameter("marketRate"));
                    if (!cropService.validateAddCrop(name, rate)) break;
                    PreparedStatement ps = con.prepareStatement("INSERT INTO crops(crop_name,rate) VALUES(?,?)");
                    ps.setString(1, name.trim()); ps.setDouble(2, rate); ps.executeUpdate();
                }
                case "update" -> {
                    int id = Integer.parseInt(request.getParameter("cropId"));
                    String name = request.getParameter("cropName");
                    double rate = Double.parseDouble(request.getParameter("marketRate"));
                    if (!cropService.validateUpdateCrop(id, name, rate)) break;
                    PreparedStatement ps = con.prepareStatement("UPDATE crops SET crop_name=?,rate=? WHERE id=?");
                    ps.setString(1, name.trim()); ps.setDouble(2, rate); ps.setInt(3, id); ps.executeUpdate();
                }
                case "delete" -> {
                    int id = Integer.parseInt(request.getParameter("cropId"));
                    if (!cropService.validateDeleteCrop(id)) break;
                    PreparedStatement ps = con.prepareStatement("DELETE FROM crops WHERE id=?");
                    ps.setInt(1, id); ps.executeUpdate();
                }
            }
            response.sendRedirect(request.getContextPath() + "/admin/cropManagement.jsp?success=1");
        } catch (Exception e) { e.printStackTrace(); }
    }
}
