package com.shopping.servlet;

import com.google.gson.Gson;
import com.shopping.dao.OrderDAO;
import com.shopping.dao.CustomerDAO;
import com.shopping.model.Order;
import com.shopping.model.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@WebServlet("/TrackOrderServlet")
public class TrackOrderServlet extends HttpServlet {
    
    private OrderDAO orderDAO;
    private CustomerDAO customerDAO;
    private Gson gson;
    
    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
        customerDAO = new CustomerDAO();
        gson = new Gson();
        System.out.println("✓ TrackOrderServlet initialized");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String orderIdParam = request.getParameter("orderId");
        String email = request.getParameter("email");
        
        System.out.println("TRACK ORDER REQUEST");
        System.out.println("Order ID: " + orderIdParam);
        System.out.println("Email: " + email);
        
        Map<String, Object> result = new HashMap<>();
        
        // Validate input
        if (orderIdParam == null || orderIdParam.isEmpty() || email == null || email.isEmpty()) {
            System.out.println("Missing parameters");
            result.put("success", false);
            result.put("error", "Please provide both Order ID and Email");
            response.getWriter().write(gson.toJson(result));
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdParam);
            System.out.println("Parsed Order ID: " + orderId);
            
            // Get order from database
            Order order = orderDAO.getOrderById(orderId);
            
            if (order == null) {
                System.out.println("Order not found: " + orderId);
                result.put("success", false);
                result.put("error", "Order #" + orderId + " not found. Please check your Order ID.");
                response.getWriter().write(gson.toJson(result));
                return;
            }
            
            System.out.println("Order found - Customer ID: " + order.getCustomerID());
            
            // Get customer to verify email
            Customer customer = customerDAO.getCustomerById(order.getCustomerID());
            
            if (customer == null) {
                System.out.println("Customer not found for ID: " + order.getCustomerID());
                result.put("success", false);
                result.put("error", "Customer information not found.");
                response.getWriter().write(gson.toJson(result));
                return;
            }
            
            System.out.println("Customer email: " + customer.getEmail());
            System.out.println("Provided email: " + email);
            
            if (!customer.getEmail().equalsIgnoreCase(email.trim())) {
                System.out.println("Email mismatch for order " + orderId);
                result.put("success", false);
                result.put("error", "Email does not match the order. Please check your details.");
                response.getWriter().write(gson.toJson(result));
                return;
            }
            
            Timestamp orderDate = order.getOrderDate();
            if (orderDate == null) {
                System.out.println("✗ Order date is null");
                orderDate = new Timestamp(System.currentTimeMillis()); 
            }
            
            System.out.println("Order date: " + orderDate);
            
            // Calculate days since order was placed
            long daysSinceOrder = calculateDaysSince(orderDate);
            System.out.println("Days since order: " + daysSinceOrder);
            
            // Determine status based on days
            String status = determineStatus(daysSinceOrder);
            System.out.println("Status: " + status);
            
            // Build response
            result.put("success", true);
            result.put("orderId", order.getOrderID());
            result.put("orderDate", orderDate.toString());
            result.put("customerName", customer.getFirstName() + " " + customer.getLastName());
            result.put("totalAmount", order.getTotalAmount());
            result.put("daysSinceOrder", daysSinceOrder);
            result.put("status", status);
            
            String jsonResponse = gson.toJson(result);
            System.out.println("Response: " + jsonResponse);
            response.getWriter().write(jsonResponse);
            
            System.out.println("Tracking successful");
            
        } catch (NumberFormatException e) {
            System.err.println("Invalid order ID format: " + orderIdParam);
            e.printStackTrace();
            result.put("success", false);
            result.put("error", "Invalid Order ID format");
            response.getWriter().write(gson.toJson(result));
        } catch (Exception e) {
            System.err.println("Error tracking order: " + e.getMessage());
            e.printStackTrace();
            result.put("success", false);
            result.put("error", "An error occurred: " + e.getMessage());
            response.getWriter().write(gson.toJson(result));
        }
        
        System.out.println("END TRACK ORDER");
    }
   
    private long calculateDaysSince(Timestamp orderDate) {
        long currentTime = System.currentTimeMillis();
        long orderTime = orderDate.getTime();
        long diffInMillis = currentTime - orderTime;
        
        // Convert to days
        long days = TimeUnit.MILLISECONDS.toDays(diffInMillis);
        
        return days;
    }
    
    
     //Determine order status based on days since order
     
    private String determineStatus(long daysSince) {
        if (daysSince < 1) {
            return "Prepared";
        } else if (daysSince >= 1 && daysSince < 2) {
            return "In Preparation";
        } else {
            return "Shipped";
        }
    }
}