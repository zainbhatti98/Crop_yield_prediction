package service;

import model.CropDetail;
import model.CropRecommendation;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import java.util.List;
import static org.junit.jupiter.api.Assertions.*;
public class CropSystemTest {

    private FarmerService farmerService;
    private CropAdvisoryService advisoryService;
    private CropInfoService cropInfoService;
    private OrderStatusService orderStatusService;
    private SaleRequestService saleRequestService;
    private CropService cropService;
    private AuthService authService;

    @BeforeEach
    void setUp() {
        farmerService = new FarmerService();
        advisoryService = new CropAdvisoryService();
        cropInfoService = new CropInfoService();
        orderStatusService = new OrderStatusService();
        saleRequestService = new SaleRequestService();
        cropService = new CropService();
        authService = new AuthService();
    }

    @Test void test01LoginSuccess() {
        assertTrue(farmerService.login("test@gmail.com", "1234"));
        assertTrue(farmerService.login("sara@gmail.com", "123"));
    }

    @Test void test02LoginFail() {
        assertFalse(farmerService.login("wrong@gmail.com", "0000"));
        assertFalse(farmerService.login("bad", "12"));
    }

    @Test void test03RegisterSuccess() {
        assertTrue(farmerService.register("Ali Khan", "ali@gmail.com", "1234"));
        assertTrue(farmerService.validateRegister("Sara", "sara@gmail.com", "1234"));
    }

    @Test void test04RegisterFail() {
        assertFalse(farmerService.register(null, null, null));
        assertFalse(farmerService.validateLogin("x", "1"));
    }

    @Test void test05ValidationUtil() {
        assertTrue(ValidationUtil.isValidEmail("farmer@gmail.com"));
        assertFalse(ValidationUtil.isValidEmail("invalid"));
        assertTrue(ValidationUtil.isValidPassword("abc123"));
        assertFalse(ValidationUtil.isValidPassword("ab"));
        assertTrue(ValidationUtil.isValidName("Ali Khan"));
        assertTrue(ValidationUtil.isValidQuantity(50));
        assertFalse(ValidationUtil.isValidQuantity(-1));
        assertTrue(ValidationUtil.isValidPrice(100));
        assertTrue(ValidationUtil.isValidCropName("Wheat"));
        assertTrue(ValidationUtil.isValidMarketRate(3500));
        assertTrue(ValidationUtil.isValidRating(4));
        assertFalse(ValidationUtil.isValidRating(6));
        assertTrue(ValidationUtil.isValidPhone("03001234567"));
        assertFalse(ValidationUtil.isValidPhone("123"));
    }

    @Test void test06RecommendRice() {
        CropRecommendation result = advisoryService.recommend(28, 80, 200, 6.0);
        assertEquals("Rice", result.getCrop());
        assertTrue(result.getMatchScore() > 0);
        assertNotNull(result.getReason());
    }

    @Test void test07AdvisoryInputAndTop() {
        assertTrue(advisoryService.isValidInput(25, 60, 100, 7));
        assertFalse(advisoryService.isValidInput(100, 60, 100, 7));
        List<CropRecommendation> top = advisoryService.recommendTop(22, 55, 80, 6.5, 5);
        assertEquals(5, top.size());
        CropDetail cotton = cropInfoService.getCropByName("Cotton");
        assertTrue(advisoryService.calculateScore(cotton, 30, 60, 80, 7.0) > 0);
    }

    @Test void test08CropInfoAll() {
        assertEquals(20, cropInfoService.getCropCount());
        CropDetail wheat = cropInfoService.getCropByName("Wheat");
        assertNotNull(wheat);
        assertEquals("Wheat", wheat.getName());
        assertNotNull(wheat.getFertilizers());
        assertNotNull(wheat.getImageUrl());
        assertTrue(cropInfoService.hasCrop("Rice"));
        assertFalse(cropInfoService.hasCrop("Unknown"));
        assertNull(cropInfoService.getCropByName(null));
    }

    @Test void test09OrderTransitions() {
        assertTrue(orderStatusService.canTransition(OrderStatusService.PENDING, OrderStatusService.ACCEPTED));
        assertTrue(orderStatusService.canTransition(OrderStatusService.ACCEPTED, OrderStatusService.DELIVERED));
        assertTrue(orderStatusService.canTransition(OrderStatusService.DELIVERED, OrderStatusService.COMPLETED));
        assertTrue(orderStatusService.canTransition(OrderStatusService.PENDING, OrderStatusService.REJECTED));
        assertFalse(orderStatusService.canTransition(OrderStatusService.PENDING, OrderStatusService.COMPLETED));
        assertFalse(orderStatusService.canTransition("Bad", OrderStatusService.PENDING));
        assertTrue(orderStatusService.isValidStatus(OrderStatusService.ACCEPTED));
        assertFalse(orderStatusService.isValidStatus("Unknown"));
    }

    @Test void test10OrderMessages() {
        assertTrue(orderStatusService.getSystemMessage(OrderStatusService.PENDING, 1).contains("New Order"));
        assertTrue(orderStatusService.getSystemMessage(OrderStatusService.ACCEPTED, 2).contains("Payment Received"));
        assertTrue(orderStatusService.getSystemMessage(OrderStatusService.DELIVERED, 3).contains("Delivered"));
        assertTrue(orderStatusService.getSystemMessage(OrderStatusService.COMPLETED, 4).contains("Completed"));
        assertTrue(orderStatusService.getSystemMessage(OrderStatusService.REJECTED, 5).contains("rejected"));
        assertTrue(orderStatusService.getSystemMessage("Unknown", 6).contains("status updated"));
    }

    @Test void test11OrderActions() {
        assertEquals("Accept or Reject", orderStatusService.getNextActionForFarmer(OrderStatusService.PENDING));
        assertEquals("Mark Delivered", orderStatusService.getNextActionForFarmer(OrderStatusService.ACCEPTED));
        assertEquals("Waiting for buyer confirmation", orderStatusService.getNextActionForFarmer(OrderStatusService.DELIVERED));
        assertEquals("Completed", orderStatusService.getNextActionForFarmer(OrderStatusService.COMPLETED));
        assertEquals("No action", orderStatusService.getNextActionForFarmer("Unknown"));
        assertEquals("Confirm Received", orderStatusService.getNextActionForBuyer(OrderStatusService.DELIVERED));
        assertEquals("Completed", orderStatusService.getNextActionForBuyer(OrderStatusService.COMPLETED));
        assertEquals("Track order", orderStatusService.getNextActionForBuyer(OrderStatusService.PENDING));
    }

    @Test void test12SaleRequestValidation() {
        assertTrue(saleRequestService.isValidSaleRequest(1, 100, 3500));
        assertFalse(saleRequestService.isValidSaleRequest(0, -5, 0));
        assertTrue(saleRequestService.canApprove(SaleRequestService.PENDING));
        assertFalse(saleRequestService.canApprove(SaleRequestService.APPROVED));
        assertTrue(saleRequestService.canReject(SaleRequestService.PENDING));
        assertFalse(saleRequestService.canReject(SaleRequestService.APPROVED));
    }

    @Test void test13SaleRequestMessages() {
        assertTrue(saleRequestService.getStatusMessage(SaleRequestService.PENDING, 1).contains("pending"));
        assertTrue(saleRequestService.getStatusMessage(SaleRequestService.APPROVED, 2).contains("approved"));
        assertTrue(saleRequestService.getStatusMessage(SaleRequestService.REJECTED, 3).contains("rejected"));
        assertTrue(saleRequestService.isVisibleToBuyer(SaleRequestService.APPROVED));
        assertFalse(saleRequestService.isVisibleToBuyer(SaleRequestService.PENDING));
    }

    @Test void test14CropService() {
        assertTrue(cropService.validateAddCrop("Tomato", 2500));
        assertFalse(cropService.validateAddCrop("", -100));
        assertTrue(cropService.validateUpdateCrop(1, "Wheat", 3500));
        assertFalse(cropService.validateUpdateCrop(0, "", -1));
        assertTrue(cropService.validateDeleteCrop(5));
        assertFalse(cropService.validateDeleteCrop(0));
        assertEquals(3600, cropService.getEffectivePrice(3600, 3500));
        assertEquals(3500, cropService.getEffectivePrice(0, 3500));
        assertEquals("PKR 3500 / kg", cropService.formatPrice(3500));
    }

    @Test void test15AuthService() {
        assertNull(authService.validateFarmerLoginInput("farmer@gmail.com", "1234"));
        assertNotNull(authService.validateFarmerLoginInput("bad", "1"));
        assertNull(authService.validateBuyerLoginInput("buyer@gmail.com", "pass"));
        assertNotNull(authService.validateBuyerLoginInput("", ""));
        assertNull(authService.validateAdminLoginInput("admin", "admin123"));
        assertNotNull(authService.validateAdminLoginInput("a", "1"));
        assertFalse(authService.isDatabaseReady(null));
    }

    @Test void test16CropDetailGetters() {
        CropDetail crop = cropInfoService.getCropByName("Maize");
        assertNotNull(crop.getIcon());
        assertNotNull(crop.getHarvestTime());
        assertNotNull(crop.getDiseaseControl());
        assertNotNull(crop.getWaterRequirement());
        assertTrue(crop.getIdealTempMin() < crop.getIdealTempMax());
        assertTrue(crop.getIdealPhMin() <= crop.getIdealPhMax());
    }

    @Test void test17CropRecommendationGetters() {
        CropRecommendation rec = advisoryService.recommend(20, 50, 60, 6.5);
        assertNotNull(rec.getCrop());
        assertNotNull(rec.getReason());
        assertTrue(rec.getMatchScore() >= 0);
    }

    @Test void test18DbConnectionConfig() {
        assertTrue(db.DBConnection.isConfigured());
    }

    @Test void test19FarmerServiceValidation() {
        assertTrue(farmerService.validateLogin("user@gmail.com", "123"));
        assertFalse(farmerService.validateLogin("x", "1"));
    }

    @Test void test20RegistrationValidation() {
        assertTrue(ValidationUtil.isValidRegistration("Ali", "ali@gmail.com", "1234"));
        assertFalse(ValidationUtil.isValidRegistration("", "bad", "1"));
        assertTrue(ValidationUtil.isValidLogin("user@gmail.com", "123"));
        assertFalse(ValidationUtil.isValidLogin("x", "ab"));
    }
}
