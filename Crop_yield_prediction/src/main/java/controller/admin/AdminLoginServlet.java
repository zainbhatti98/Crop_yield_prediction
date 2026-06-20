package controller.admin;

import db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import service.AuthService;
import java.io.IOException;
import java.sql.*;

public class AdminLoginServlet extends HttpServlet {
    private final AuthService authService = new AuthService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ctx = request.getContextPath();
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        if (authService.validateAdminLoginInput(username, password) != null) {
            response.sendRedirect(ctx + "/admin/adminLogin.jsp?error=invalid");
            return;
        }
        try (Connection con = DBConnection.getConnection()) {
            if (!authService.isDatabaseReady(con)) {
                response.sendRedirect(ctx + "/admin/adminLogin.jsp?error=db");
                return;
            }
            PreparedStatement ps = con.prepareStatement("SELECT * FROM admin WHERE username=? AND password=?");
            ps.setString(1, username.trim());
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                HttpSession session = request.getSession(true);
                session.setAttribute("adminId", rs.getInt("id"));
                session.setAttribute("adminName", rs.getString("username"));
                response.sendRedirect(ctx + "/admin/dashboard.jsp");
            } else {
                response.sendRedirect(ctx + "/admin/adminLogin.jsp?error=login");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(ctx + "/admin/adminLogin.jsp?error=server");
        }
    }
}
