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

@WebServlet("/cart/count")
public class CartCountServlet extends HttpServlet {
    
    private Gson gson = new Gson();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        int count = 0;
        
        if (session != null) {
            @SuppressWarnings("unchecked")
            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
            
            if (cart != null) {
                count = cart.values().stream().mapToInt(CartItem::getQuantity).sum();
            }
        }
        
        Map<String, Integer> result = new HashMap<>();
        result.put("count", count);
        
        response.getWriter().write(gson.toJson(result));
    }
}