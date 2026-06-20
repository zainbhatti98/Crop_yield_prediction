package model;

public class CropRecommendation {
    private final String crop, reason;
    private final int matchScore;
    public CropRecommendation(String crop, String reason, int matchScore) {
        this.crop = crop; this.reason = reason; this.matchScore = matchScore;
    }
    public String getCrop() { return crop; }
    public String getReason() { return reason; }
    public int getMatchScore() { return matchScore; }
}
