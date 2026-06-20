package service;

public class SaleRequestService {
    public static final String PENDING = "Pending";
    public static final String APPROVED = "Approved";
    public static final String REJECTED = "Rejected";

    public boolean isValidSaleRequest(int cropId, double quantity, double price) {
        return cropId > 0 && ValidationUtil.isValidQuantity(quantity) && ValidationUtil.isValidPrice(price);
    }
    public boolean canApprove(String status) { return PENDING.equals(status); }
    public boolean canReject(String status) { return PENDING.equals(status); }
    public boolean isVisibleToBuyer(String status) { return APPROVED.equals(status); }
    public String getStatusMessage(String status, int id) {
        return switch (status) {
            case PENDING -> "Sale request #" + id + " is pending admin approval.";
            case APPROVED -> "Sale request #" + id + " approved. Visible to buyers.";
            case REJECTED -> "Sale request #" + id + " was rejected by admin.";
            default -> "Sale request #" + id + " status: " + status;
        };
    }
}
