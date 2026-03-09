package com.shopping.servlet;

import com.shopping.dao.ProductDAO;
import com.shopping.model.Product;
import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;


@WebServlet("/admin/products")
public class AdminProductServlet extends HttpServlet {
    
    private ProductDAO productDAO;
    private Gson gson;
    
    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
        gson = new Gson();
    }
  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            List<Product> products = productDAO.getAllProducts();
            String json = gson.toJson(products);
            
            PrintWriter out = response.getWriter();
            out.print(json);
            out.flush();
            
            System.out.println("Retrieved " + products.size() + " products");
            
        } catch (Exception e) {
            System.err.println("Error retrieving products: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("{\"error\": \"Failed to retrieve products\"}");
        }
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addProduct(request, response);
        } else if ("update".equals(action)) {
            updateProduct(request, response);
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"error\": \"Invalid action\"}");
        }
    }
    
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            String productIdStr = request.getParameter("productId");
            
            if (productIdStr == null || productIdStr.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().print("{\"error\": \"Product ID is required\"}");
                return;
            }
            
            int productId = Integer.parseInt(productIdStr);
            boolean deleted = productDAO.deleteProduct(productId);
            
            if (deleted) {
                System.out.println("✓ Product deleted: ID " + productId);
                response.getWriter().print("{\"success\": true, \"message\": \"Product deleted\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().print("{\"error\": \"Product not found\"}");
            }
            
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"error\": \"Invalid product ID\"}");
        } catch (Exception e) {
            System.err.println("✗ Error deleting product: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("{\"error\": \"Failed to delete product\"}");
        }
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        try {
            // Get form parameters
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String priceStr = request.getParameter("price");
            String quantityStr = request.getParameter("quantity");
            String imageURL = request.getParameter("imageURL");
            String category = request.getParameter("category");
            
            // Validation
            if (title == null || title.trim().isEmpty() ||
                priceStr == null || quantityStr == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().print("{\"error\": \"Required fields missing\"}");
                return;
            }
            
            // Parse numbers
            double price = Double.parseDouble(priceStr);
            int quantity = Integer.parseInt(quantityStr);
            
            // Create product
            Product product = new Product(title, description, price, quantity, imageURL, category);
            
            // Add to database
            boolean added = productDAO.addProduct(product);
            
            if (added) {
                System.out.println("Product added: " + title);
                response.getWriter().print("{\"success\": true, \"message\": \"Product added successfully\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().print("{\"error\": \"Failed to add product\"}");
            }
            
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"error\": \"Invalid price or quantity format\"}");
        } catch (Exception e) {
            System.err.println("Error adding product: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("{\"error\": \"Failed to add product\"}");
        }
    }
    
    
     // Update existing product
     
    private void updateProduct(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        try {
            // Get product ID
            String productIdStr = request.getParameter("productId");
            if (productIdStr == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().print("{\"error\": \"Product ID required\"}");
                return;
            }
            
            int productId = Integer.parseInt(productIdStr);
            
            // Get form parameters
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String priceStr = request.getParameter("price");
            String quantityStr = request.getParameter("quantity");
            String imageURL = request.getParameter("imageURL");
            String category = request.getParameter("category");
            
            // Parse numbers
            double price = Double.parseDouble(priceStr);
            int quantity = Integer.parseInt(quantityStr);
            
            // Create product with ID
            Product product = new Product(productId, title, description, price, quantity, 
                                         imageURL, category, null);
            
            // Update in database
            boolean updated = productDAO.updateProduct(product);
            
            if (updated) {
                System.out.println("Product updated: " + title);
                response.getWriter().print("{\"success\": true, \"message\": \"Product updated successfully\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().print("{\"error\": \"Product not found\"}");
            }
            
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"error\": \"Invalid number format\"}");
        } catch (Exception e) {
            System.err.println("Error updating product: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("{\"error\": \"Failed to update product\"}");
        }
    }
}