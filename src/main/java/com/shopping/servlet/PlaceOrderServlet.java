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

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {
    
    private OrderDAO orderDAO;
    
    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
        System.out.println("PlaceOrderServlet initialized");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("PLACE ORDER REQUEST");
        
        HttpSession session = request.getSession();
        
        // Check if user is logged in
        Customer customer = (Customer) session.getAttribute("customer");
        System.out.println("Customer in session: " + (customer != null ? customer.getEmail() : "NULL"));
        
        if (customer == null) {
            System.out.println("✗ No customer in session - redirecting to login");
            response.sendRedirect("login.jsp?message=Please login to place an order");
            return;
        }
        
        // Get cart from session
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        
        System.out.println("Cart in session: " + (cart != null ? cart.size() + " items" : "NULL"));
        
        if (cart == null || cart.isEmpty()) {
            System.out.println("✗ Cart is empty");
            response.sendRedirect("cart.jsp?error=Your cart is empty");
            return;
        }
        
        try {
            System.out.println("Processing order for customer ID: " + customer.getCustomerId());
            
            // Create Order object
            Order order = new Order();
            order.setCustomerID(customer.getCustomerId());
            order.setStatus("PENDING");
            
            // Calculate total amount
            double totalAmount = cart.values().stream()
                .mapToDouble(CartItem::getSubtotal)
                .sum();
            order.setTotalAmount(totalAmount);
            
            System.out.println("Order total: $" + totalAmount);
            
            // Create order items list
            List<OrderItem> orderItems = new ArrayList<>();
            for (CartItem cartItem : cart.values()) {
                OrderItem orderItem = new OrderItem();
                orderItem.setProductID(cartItem.getProductId());
                orderItem.setQuantity(cartItem.getQuantity());
                orderItem.setPrice(cartItem.getPrice());
                orderItems.add(orderItem);
                
                System.out.println("  - Product ID: " + cartItem.getProductId() + 
                                   ", Qty: " + cartItem.getQuantity() + 
                                   ", Price: $" + cartItem.getPrice());
            }
            
            // Place the order (saves to database)
            int orderId = orderDAO.placeOrder(order, orderItems);
            
            if (orderId > 0) {
                System.out.println("Order placed successfully. Order ID: " + orderId);
                
                // Clear the cart
                session.removeAttribute("cart");
                System.out.println("Cart cleared from session");
                
                // Store order ID for confirmation page
                session.setAttribute("lastOrderId", orderId);
                
                // Redirect to order confirmation page
                response.sendRedirect("order-confirmation.jsp?orderId=" + orderId);
                
            } else {
                System.err.println("Failed to place order - orderDAO returned -1");
                response.sendRedirect("cart.jsp?error=Failed to place order. Please try again.");
            }
            
        } catch (Exception e) {
            System.err.println("Exception in PlaceOrderServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("cart.jsp?error=An error occurred: " + e.getMessage());
        }
        
        System.out.println("END PLACE ORDER");
    }
}