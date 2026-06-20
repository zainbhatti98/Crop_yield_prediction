package service;

public class AuthService {
    public String validateFarmerLoginInput(String email, String password) {
        return ValidationUtil.isValidLogin(email, password) ? null : "Invalid email or password format";
    }
    public String validateBuyerLoginInput(String email, String password) {
        return ValidationUtil.isValidLogin(email, password) ? null : "Invalid email or password format";
    }
    public String validateAdminLoginInput(String username, String password) {
        return ValidationUtil.isValidName(username) && ValidationUtil.isValidPassword(password)
                ? null : "Invalid username or password format";
    }
    public boolean isDatabaseReady(java.sql.Connection con) {
        return con != null;
    }
}
