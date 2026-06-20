package service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import model.CropDetail;
import model.CropRecommendation;

public class CropInfoService {
    private static final List<CropDetail> CROPS = buildCrops();

    private static List<CropDetail> buildCrops() {
        List<CropDetail> list = new ArrayList<>();
        list.add(new CropDetail("Wheat", "bi-flower1", "https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?w=400", "Urea, DAP, Potash", "Prevent rust disease", "450-650 mm", "120-150 Days", 15, 25, 40, 70, 50, 6.0, 7.5));
        list.add(new CropDetail("Rice", "bi-droplet", "https://images.unsplash.com/photo-1586201375761-83865001e31c?w=400", "NPK, Zinc", "Control blast", "1000-1500 mm", "110-140 Days", 25, 35, 70, 90, 150, 5.5, 6.5));
        list.add(new CropDetail("Maize", "bi-tree", "https://images.unsplash.com/photo-1551752496-b0970c0a0c0e?w=400", "Urea, DAP", "Stem borer control", "500-800 mm", "90-110 Days", 20, 30, 50, 75, 60, 5.8, 7.0));
        list.add(new CropDetail("Cotton", "bi-circle-half", "https://images.unsplash.com/photo-1625246333195-78d9c38ad449?w=400", "Nitrogen, Phosphorus", "Bollworm control", "600-900 mm", "150-180 Days", 25, 35, 50, 70, 50, 6.0, 8.0));
        list.add(new CropDetail("Sugarcane", "bi-water", "https://images.unsplash.com/photo-1587735243615-c03a25a1e5c2?w=400", "NPK, Manure", "Red rot control", "1500-2500 mm", "10-12 Months", 26, 32, 65, 85, 100, 6.0, 7.5));
        list.add(new CropDetail("Barley", "bi-grain", "https://images.unsplash.com/photo-1516684669130-eeeec3ee3a0e?w=400", "Nitrogen", "Powdery mildew", "400-500 mm", "100-120 Days", 12, 22, 40, 65, 40, 6.0, 8.0));
        list.add(new CropDetail("Millet", "bi-sun", "https://images.unsplash.com/photo-1601493700631-2b16ec8b4714?w=400", "Urea", "Downy mildew", "400-600 mm", "70-90 Days", 25, 35, 40, 60, 40, 5.5, 7.0));
        list.add(new CropDetail("Soybean", "bi-egg", "https://images.unsplash.com/photo-1593111775530-7b95a3b3e3a5?w=400", "Rhizobium", "Rust control", "600-800 mm", "90-120 Days", 20, 30, 60, 80, 60, 6.0, 7.0));
        list.add(new CropDetail("Potato", "bi-circle", "https://images.unsplash.com/photo-1518977676601-b53f82aba655?w=400", "NPK", "Late blight", "500-700 mm", "90-120 Days", 15, 25, 60, 80, 50, 5.0, 6.5));
        list.add(new CropDetail("Tomato", "bi-apple", "https://images.unsplash.com/photo-1546094096-0df4bcaaa337?w=400", "NPK", "Early blight", "400-600 mm", "70-90 Days", 18, 28, 55, 75, 50, 6.0, 7.0));
        list.add(new CropDetail("Onion", "bi-layers", "https://images.unsplash.com/photo-1518977956812-cd3dbadaef31?w=400", "NPK, Sulphur", "Purple blotch", "350-550 mm", "90-120 Days", 13, 25, 50, 70, 40, 6.0, 7.0));
        list.add(new CropDetail("Chilli", "bi-fire", "https://images.unsplash.com/photo-1563565375-f3fdfdbefa83?w=400", "NPK", "Anthracnose", "600-800 mm", "120-150 Days", 20, 30, 50, 70, 60, 6.0, 7.0));
        list.add(new CropDetail("Mustard", "bi-flower2", "https://images.unsplash.com/photo-1490759847864-5c6d7de0b733?w=400", "Nitrogen", "White rust", "400-600 mm", "110-130 Days", 10, 25, 40, 65, 40, 6.0, 7.5));
        list.add(new CropDetail("Groundnut", "bi-nut", "https://images.unsplash.com/photo-1601493700631-2b16ec8b4714?w=400", "Gypsum", "Leaf spot", "500-700 mm", "120-140 Days", 25, 35, 50, 70, 50, 6.0, 7.0));
        list.add(new CropDetail("Sunflower", "bi-brightness-high", "https://images.unsplash.com/photo-1597848212624-a19eb35e2651?w=400", "NPK", "Head rot", "500-700 mm", "90-110 Days", 20, 30, 45, 65, 50, 6.0, 7.5));
        list.add(new CropDetail("Banana", "bi-moon", "https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=400", "Potash", "Panama disease", "1200-2200 mm", "9-12 Months", 25, 35, 70, 85, 120, 6.0, 7.5));
        list.add(new CropDetail("Mango", "bi-tree-fill", "https://images.unsplash.com/photo-1553279778-0225cd92bb95?w=400", "NPK", "Anthracnose", "750-2500 mm", "3-5 Years", 24, 35, 50, 80, 75, 5.5, 7.5));
        list.add(new CropDetail("Lentil", "bi-circle-square", "https://images.unsplash.com/photo-1586201375761-83865001e31c?w=400", "Phosphorus", "Wilt control", "350-500 mm", "110-130 Days", 15, 25, 40, 60, 30, 6.0, 7.5));
        list.add(new CropDetail("Chickpea", "bi-heart", "https://images.unsplash.com/photo-1516684669130-eeeec3ee3a0e?w=400", "Phosphorus", "Blight control", "400-600 mm", "100-120 Days", 15, 28, 40, 65, 40, 6.0, 7.5));
        list.add(new CropDetail("Sesame", "bi-stars", "https://images.unsplash.com/photo-1601493700631-2b16ec8b4714?w=400", "Nitrogen", "Leaf spot", "400-600 mm", "90-110 Days", 25, 35, 45, 65, 40, 5.5, 8.0));
        return Collections.unmodifiableList(list);
    }

    public List<CropDetail> getAllCrops() { return CROPS; }
    public int getCropCount() { return CROPS.size(); }
    public CropDetail getCropByName(String name) {
        if (name == null) return null;
        for (CropDetail c : CROPS) if (c.getName().equalsIgnoreCase(name.trim())) return c;
        return null;
    }
    public boolean hasCrop(String name) { return getCropByName(name) != null; }
}
