package service;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class OrderStatusService {
    public static final String PENDING = "Pending";
    public static final String ACCEPTED = "Accepted";
    public static final String DELIVERED = "Delivered";
    public static final String COMPLETED = "Completed";
    public static final String REJECTED = "Rejected";

    private static final Set<String> VALID = new HashSet<>(
            Arrays.asList(PENDING, ACCEPTED, DELIVERED, COMPLETED, REJECTED));

    public boolean isValidStatus(String status) {
        return status != null && VALID.contains(status);
    }

    public boolean canTransition(String current, String next) {
        if (!isValidStatus(current) || !isValidStatus(next)) return false;
        if (PENDING.equals(current)) return ACCEPTED.equals(next) || REJECTED.equals(next);
        if (ACCEPTED.equals(current)) return DELIVERED.equals(next);
        if (DELIVERED.equals(current)) return COMPLETED.equals(next);
        return false;
    }

    public String getSystemMessage(String status, int orderId) {
        return switch (status) {
            case PENDING -> "New Order #" + orderId + " received from buyer.";
            case ACCEPTED -> "Order #" + orderId + ": Payment Received. Please prepare delivery.";
            case DELIVERED -> "Order #" + orderId + ": Order Delivered. Awaiting buyer confirmation.";
            case COMPLETED -> "Order #" + orderId + ": Order Completed successfully.";
            case REJECTED -> "Order #" + orderId + " has been rejected.";
            default -> "Order #" + orderId + " status updated to " + status;
        };
    }

    public String getNextActionForFarmer(String status) {
        if (PENDING.equals(status)) return "Accept or Reject";
        if (ACCEPTED.equals(status)) return "Mark Delivered";
        if (DELIVERED.equals(status)) return "Waiting for buyer confirmation";
        if (COMPLETED.equals(status)) return "Completed";
        return "No action";
    }

    public String getNextActionForBuyer(String status) {
        if (DELIVERED.equals(status)) return "Confirm Received";
        if (COMPLETED.equals(status)) return "Completed";
        return "Track order";
    }
}
