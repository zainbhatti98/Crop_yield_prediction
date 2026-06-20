package model;

public class CropDetail {
    private final String name, icon, imageUrl, fertilizers, diseaseControl, waterRequirement, harvestTime;
    private final double idealTempMin, idealTempMax, idealHumidityMin, idealHumidityMax, idealRainfallMin, idealPhMin, idealPhMax;

    public CropDetail(String name, String icon, String imageUrl, String fertilizers, String diseaseControl,
            String waterRequirement, String harvestTime, double idealTempMin, double idealTempMax,
            double idealHumidityMin, double idealHumidityMax, double idealRainfallMin, double idealPhMin, double idealPhMax) {
        this.name = name; this.icon = icon; this.imageUrl = imageUrl;
        this.fertilizers = fertilizers; this.diseaseControl = diseaseControl;
        this.waterRequirement = waterRequirement; this.harvestTime = harvestTime;
        this.idealTempMin = idealTempMin; this.idealTempMax = idealTempMax;
        this.idealHumidityMin = idealHumidityMin; this.idealHumidityMax = idealHumidityMax;
        this.idealRainfallMin = idealRainfallMin; this.idealPhMin = idealPhMin; this.idealPhMax = idealPhMax;
    }
    public String getName() { return name; }
    public String getIcon() { return icon; }
    public String getImageUrl() { return imageUrl; }
    public String getFertilizers() { return fertilizers; }
    public String getDiseaseControl() { return diseaseControl; }
    public String getWaterRequirement() { return waterRequirement; }
    public String getHarvestTime() { return harvestTime; }
    public double getIdealTempMin() { return idealTempMin; }
    public double getIdealTempMax() { return idealTempMax; }
    public double getIdealHumidityMin() { return idealHumidityMin; }
    public double getIdealHumidityMax() { return idealHumidityMax; }
    public double getIdealRainfallMin() { return idealRainfallMin; }
    public double getIdealPhMin() { return idealPhMin; }
    public double getIdealPhMax() { return idealPhMax; }
}
