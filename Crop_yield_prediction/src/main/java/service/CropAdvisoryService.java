package service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import model.CropDetail;
import model.CropRecommendation;

public class CropAdvisoryService {
    private final CropInfoService cropInfoService = new CropInfoService();

    public CropRecommendation recommend(double temperature, double humidity, double rainfall, double ph) {
        CropDetail best = null;
        int bestScore = -1;
        for (CropDetail crop : cropInfoService.getAllCrops()) {
            int score = calculateScore(crop, temperature, humidity, rainfall, ph);
            if (score > bestScore) { bestScore = score; best = crop; }
        }
        String reason = best.getName() + " matches temperature " + temperature + "C, humidity " + humidity
                + "%, rainfall " + rainfall + "mm, pH " + ph + ".";
        return new CropRecommendation(best.getName(), reason, bestScore);
    }

    public List<CropRecommendation> recommendTop(double temperature, double humidity, double rainfall, double ph, int limit) {
        List<CropRecommendation> list = new ArrayList<>();
        for (CropDetail crop : cropInfoService.getAllCrops()) {
            int score = calculateScore(crop, temperature, humidity, rainfall, ph);
            list.add(new CropRecommendation(crop.getName(), crop.getName() + " score " + score, score));
        }
        list.sort(Comparator.comparingInt(CropRecommendation::getMatchScore).reversed());
        return list.subList(0, Math.min(limit, list.size()));
    }

    public int calculateScore(CropDetail crop, double temp, double humidity, double rainfall, double ph) {
        int score = 0;
        if (temp >= crop.getIdealTempMin() && temp <= crop.getIdealTempMax()) score += 30;
        if (humidity >= crop.getIdealHumidityMin() && humidity <= crop.getIdealHumidityMax()) score += 25;
        if (rainfall >= crop.getIdealRainfallMin()) score += 25;
        if (ph >= crop.getIdealPhMin() && ph <= crop.getIdealPhMax()) score += 20;
        return score;
    }

    public boolean isValidInput(double temperature, double humidity, double rainfall, double ph) {
        return temperature >= -10 && temperature <= 55 && humidity >= 0 && humidity <= 100
                && rainfall >= 0 && rainfall <= 5000 && ph >= 0 && ph <= 14;
    }
}
