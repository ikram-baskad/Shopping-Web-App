package com.shopping.servlet;

import com.shopping.dao.OrderDAO;
import com.shopping.model.CartItem;
import com.shopping.model.Order;
import com.shopping.model.OrderItem;
import com.shopping.model.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet("/ProcessPaymentServlet")
public class ProcessPaymentServlet extends HttpServlet {
    
    private OrderDAO orderDAO;
    
    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
        System.out.println("ProcessPaymentServlet initialized");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("PROCESS PAYMENT REQUEST");
        
        HttpSession session = request.getSession();
        
        // Get customer
        Customer customer = (Customer) session.getAttribute("customer");
        if (customer == null) {
            System.out.println("No customer in session");
            response.sendRedirect("login.jsp?message=Please login to complete payment");
            return;
        }
        
        // Get cart
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        
        if (cart == null || cart.isEmpty()) {
            System.out.println("Cart is empty");
            response.sendRedirect("cart.jsp?error=Your cart is empty");
            return;
        }
        
        // Get payment details 
        String cardholderName = request.getParameter("cardholderName");
        String cardNumber = request.getParameter("cardNumber");
        String expiryDate = request.getParameter("expiryDate");
        String cvv = request.getParameter("cvv");
        
        System.out.println("Payment details received (DEMO):");
        System.out.println("  Cardholder: " + cardholderName);
        System.out.println("  Card: **** **** **** " + cardNumber.substring(Math.max(0, cardNumber.length() - 4)));
        
        // Simulate payment validation
        try {
            Thread.sleep(1500); 
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        
        try {
            System.out.println("Processing order for customer ID: " + customer.getCustomerId());
            
            // Create Order object
            Order order = new Order();
            order.setCustomerID(customer.getCustomerId());
            order.setStatus("PENDING");
            
            // Calculate total
            double totalAmount = cart.values().stream()
                .mapToDouble(CartItem::getSubtotal)
                .sum();
            order.setTotalAmount(totalAmount);
            
            System.out.println("Order total: $" + totalAmount);
            
            // Create order items
            List<OrderItem> orderItems = new ArrayList<>();
            for (CartItem cartItem : cart.values()) {
                OrderItem orderItem = new OrderItem();
                orderItem.setProductID(cartItem.getProductId());
                orderItem.setQuantity(cartItem.getQuantity());
                orderItem.setPrice(cartItem.getPrice());
                orderItems.add(orderItem);
            }
            
            // Place order
            int orderId = orderDAO.placeOrder(order, orderItems);
            
            if (orderId > 0) {
                System.out.println("Order placed successfully. Order ID: " + orderId);
                
                // Clear cart
                session.removeAttribute("cart");
                
                // Store order ID
                session.setAttribute("lastOrderId", orderId);
                
                // Redirect to success page
                response.sendRedirect("payment-success.jsp?orderId=" + orderId);
                
            } else {
                System.err.println("Failed to place order");
                response.sendRedirect("payment.jsp?error=Payment processed but order failed. Please contact support.");
            }
            
        } catch (Exception e) {
            System.err.println("Error processing payment: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("payment.jsp?error=An error occurred. Please try again.");
        }
        
        System.out.println("END PROCESS PAYMENT");
    }
}