package service;

public class CropService {
    public boolean validateAddCrop(String cropName, double marketRate) {
        return ValidationUtil.isValidCropName(cropName) && ValidationUtil.isValidMarketRate(marketRate);
    }
    public boolean validateUpdateCrop(int cropId, String cropName, double marketRate) {
        return cropId > 0 && ValidationUtil.isValidCropName(cropName) && ValidationUtil.isValidMarketRate(marketRate);
    }
    public boolean validateDeleteCrop(int cropId) { return cropId > 0; }
    public double getEffectivePrice(double farmerPrice, double adminRate) {
        return farmerPrice > 0 ? farmerPrice : adminRate;
    }
    public String formatPrice(double price) {
        return String.format("PKR %.0f / kg", price);
    }
}
