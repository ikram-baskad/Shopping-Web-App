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
import java.util.HashMap;
import java.util.Map;

@WebServlet("/cart/remove")
public class RemoveFromCartServlet extends HttpServlet {
    
    private Gson gson;
    
    @Override
    public void init() throws ServletException {
        gson = new Gson();
        System.out.println("RemoveFromCartServlet initialized");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            
            System.out.println("Removing product ID: " + productId);
            
            HttpSession session = request.getSession();
            
            @SuppressWarnings("unchecked")
            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
            
            Map<String, Object> result = new HashMap<>();
            
            if (cart != null && cart.containsKey(productId)) {
                CartItem removed = cart.remove(productId);
                session.setAttribute("cart", cart);
                
                // Calculate new totals
                int totalItems = cart.values().stream().mapToInt(CartItem::getQuantity).sum();
                double totalPrice = cart.values().stream().mapToDouble(CartItem::getSubtotal).sum();
                
                result.put("success", true);
                result.put("message", "Item removed successfully");
                result.put("cartItemCount", totalItems);
                result.put("newTotal", totalPrice);
                
                System.out.println("Removed: " + removed.getProductName());
                System.out.println("Cart now has " + totalItems + " items");
            } else {
                result.put("success", false);
                result.put("error", "Item not found in cart");
            }
            
            response.getWriter().write(gson.toJson(result));
            
        } catch (Exception e) {
            System.err.println("Error removing from cart: " + e.getMessage());
            e.printStackTrace();
            
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("error", "Failed to remove item: " + e.getMessage());
            
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(gson.toJson(error));
        }
    }
}