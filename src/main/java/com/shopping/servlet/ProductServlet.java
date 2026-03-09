package com.shopping.servlet;

import com.google.gson.Gson;
import com.shopping.dao.ProductDAO;
import com.shopping.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    
    private ProductDAO productDAO;
    private Gson gson;
    
    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
        gson = new Gson();
        System.out.println(" ProductServlet initialized");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("GET /products - Loading all products");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            List<Product> products = productDAO.getAllProducts();
      
            List<Map<String, Object>> productList = new ArrayList<>();
            for (Product product : products) {
                Map<String, Object> productMap = new HashMap<>();
                productMap.put("productId", product.getProductID());
                productMap.put("name", product.getTitle());
                productMap.put("description", product.getDescription());
                productMap.put("price", product.getPrice());
                productMap.put("stockQuantity", product.getQuantity());
                productMap.put("category", product.getCategory());
                productMap.put("imageUrl", product.getImageURL());
                productMap.put("createdAt", product.getCreatedAt());
                
                productList.add(productMap);
            }
            
            String json = gson.toJson(productList);
            response.getWriter().write(json);
            
            System.out.println(" Returned " + productList.size() + " products");
            
        } catch (Exception e) {
            System.err.println(" Error loading products: " + e.getMessage());
            e.printStackTrace();
            
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("error", "Failed to load products: " + e.getMessage());
            response.getWriter().write(gson.toJson(error));
        }
    }
}
