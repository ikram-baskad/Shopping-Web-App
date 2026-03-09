package com.shopping.test;

import com.shopping.dao.ProductDAO;
import com.shopping.model.Product;
import java.util.List;

public class TestViewProducts {
    
    public static void main(String[] args) {
        ProductDAO productDAO = new ProductDAO();
        
        System.out.println("        ALL PRODUCTS IN DATABASE        ");
        
        try {
            // Get all products
            List<Product> products = productDAO.getAllProducts();
            
            if (products.isEmpty()) {
                System.out.println("\nNo products found in database.");
            } else {
                System.out.println("\nTotal Products: " + products.size());
                System.out.println("----------------------------------------");
                
                for (Product product : products) {
                    System.out.println("\n Product ID: " + product.getProductID());
                    System.out.println("   Title: " + product.getTitle());
                    System.out.println("   Description: " + product.getDescription());
                    System.out.println("   Price: $" + product.getPrice());
                    System.out.println("   Quantity: " + product.getQuantity());
                    System.out.println("   Category: " + product.getCategory());
                    System.out.println("   Image: " + product.getImageURL());
                    System.out.println("   In Stock: " + (product.isInStock() ? "Yes " : "No "));
                    if (product.isLowStock()) {
                        System.out.println("    LOW STOCK WARNING!");
                    }
                    System.out.println("   Created: " + product.getCreatedAt());
                    System.out.println("----------------------------------------");
                }
                
                System.out.println("\n Successfully retrieved all products!");
            }
            
        } catch (Exception e) {
            System.err.println(" ERROR: " + e.getMessage());
            e.printStackTrace();
        }
        
    }
}