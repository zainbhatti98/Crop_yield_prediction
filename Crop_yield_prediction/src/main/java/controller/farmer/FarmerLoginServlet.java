package controller.farmer;

import db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import service.AuthService;
import java.io.IOException;
import java.sql.*;

public class FarmerLoginServlet extends HttpServlet {
    private final AuthService authService = new AuthService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ctx = request.getContextPath();
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        if (authService.validateFarmerLoginInput(email, password) != null) {
            response.sendRedirect(ctx + "/farmer/farmerLogin.jsp?error=invalid");
            return;
        }
        try (Connection con = DBConnection.getConnection()) {
            if (!authService.isDatabaseReady(con)) {
                response.sendRedirect(ctx + "/farmer/farmerLogin.jsp?error=db");
                return;
            }
            PreparedStatement ps = con.prepareStatement("SELECT * FROM farmers WHERE email=? AND password=?");
            ps.setString(1, email.trim());
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                HttpSession session = request.getSession(true);
                session.setAttribute("farmerId", rs.getInt("id"));
                session.setAttribute("farmerName", rs.getString("name"));
                response.sendRedirect(ctx + "/farmer/dashboard.jsp");
            } else {
                response.sendRedirect(ctx + "/farmer/farmerLogin.jsp?error=login");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(ctx + "/farmer/farmerLogin.jsp?error=server");
        }
    }
}
