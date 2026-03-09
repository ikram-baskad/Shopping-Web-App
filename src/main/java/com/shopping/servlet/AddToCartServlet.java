package com.shopping.servlet;

import com.google.gson.Gson;
import com.shopping.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/cart/add")
public class AddToCartServlet extends HttpServlet {
    
    private Gson gson;
    
    @Override
    public void init() throws ServletException {
        gson = new Gson();
        System.out.println("AddToCartServlet initialized");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            // Get parameters
            int productId = Integer.parseInt(request.getParameter("productId"));
            String productName = request.getParameter("productName");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String imageUrl = request.getParameter("imageUrl");
            
            System.out.println("Adding to cart: " + productName + " (qty: " + quantity + ")");
            
            HttpSession session = request.getSession();
            
            @SuppressWarnings("unchecked")
            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
            
            if (cart == null) {
                cart = new HashMap<>();
            }
            
            // Check if product already in cart
            if (cart.containsKey(productId)) {
                // Update quantity
                CartItem existingItem = cart.get(productId);
                existingItem.setQuantity(existingItem.getQuantity() + quantity);
                System.out.println("Updated quantity for: " + productName);
            } else {
                // Add new item
                CartItem newItem = new CartItem(productId, productName, price, quantity, imageUrl);
                cart.put(productId, newItem);
                System.out.println("Added new item: " + productName);
            }
            
            // Save cart back to session
            session.setAttribute("cart", cart);
            
            // Calculate cart totals
            int totalItems = cart.values().stream().mapToInt(CartItem::getQuantity).sum();
            double totalPrice = cart.values().stream().mapToDouble(CartItem::getSubtotal).sum();
            
            // Send response
            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("message", "Added to cart successfully");
            result.put("cartItemCount", totalItems);
            result.put("cartTotal", totalPrice);
            
            response.getWriter().write(gson.toJson(result));
            
            System.out.println("Cart now has " + totalItems + " items, total: $" + totalPrice);
            
        } catch (Exception e) {
            System.err.println("Error adding to cart: " + e.getMessage());
            e.printStackTrace();
            
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("error", "Failed to add to cart: " + e.getMessage());
            
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(gson.toJson(error));
        }
    }
}