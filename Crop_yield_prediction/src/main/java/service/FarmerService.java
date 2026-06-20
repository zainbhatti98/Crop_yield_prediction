package service;

public class FarmerService {
    public boolean validateLogin(String email, String password) {
        return ValidationUtil.isValidLogin(email, password);
    }
    public boolean validateRegister(String name, String email, String password) {
        return ValidationUtil.isValidRegistration(name, email, password);
    }
    public boolean login(String email, String password) {
        if (!validateLogin(email, password)) return false;
        return ("sara@gmail.com".equalsIgnoreCase(email) && "123".equals(password))
                || ("test@gmail.com".equalsIgnoreCase(email) && "1234".equals(password));
    }
    public boolean register(String name, String email, String password) {
        return validateRegister(name, email, password);
    }
}
