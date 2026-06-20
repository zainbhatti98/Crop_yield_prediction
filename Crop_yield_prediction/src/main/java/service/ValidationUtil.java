package service;

public final class ValidationUtil {
    private ValidationUtil() {}
    public static boolean isValidEmail(String email) {
        return email != null && email.contains("@") && email.contains(".") && email.length() >= 5;
    }
    public static boolean isValidPassword(String password) {
        return password != null && password.length() >= 3;
    }
    public static boolean isValidName(String name) {
        return name != null && name.trim().length() >= 2;
    }
    public static boolean isValidRegistration(String name, String email, String password) {
        return isValidName(name) && isValidEmail(email) && isValidPassword(password);
    }
    public static boolean isValidLogin(String email, String password) {
        return isValidEmail(email) && isValidPassword(password);
    }
    public static boolean isValidQuantity(double quantity) { return quantity > 0; }
    public static boolean isValidPrice(double price) { return price > 0; }
    public static boolean isValidCropName(String cropName) {
        return cropName != null && cropName.trim().length() >= 2;
    }
    public static boolean isValidMarketRate(double rate) { return rate > 0; }
    public static boolean isValidRating(int rating) { return rating >= 1 && rating <= 5; }
    public static boolean isValidPhone(String phone) {
        return phone != null && phone.trim().length() >= 7;
    }
}
