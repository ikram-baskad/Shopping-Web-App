package com.shopping.test;

import com.shopping.dao.ProductDAO;
import com.shopping.model.Product;
import java.util.Scanner;

public class TestAddProduct {
    
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        ProductDAO productDAO = new ProductDAO();
        
        System.out.println("        ADD NEW PRODUCT                 ");
        
        // Collect product data from console
        System.out.print("Enter Product Title: ");
        String title = scanner.nextLine();
        
        System.out.print("Enter Description: ");
        String description = scanner.nextLine();
        
        System.out.print("Enter Price: ");
        double price = scanner.nextDouble();
        
        System.out.print("Enter Quantity: ");
        int quantity = scanner.nextInt();
        scanner.nextLine(); 
        
        System.out.print("Enter Image URL/Filename: ");
        String imageURL = scanner.nextLine();
        
        System.out.print("Enter Category: ");
        String category = scanner.nextLine();
        
        // Create product object
        Product product = new Product(title, description, price, quantity, imageURL, category);
        
        System.out.println("\n--- Saving Product to Database ---");
        System.out.println("Title: " + title);
        System.out.println("Price: $" + price);
        System.out.println("Category: " + category);
        System.out.println("Quantity: " + quantity);
        
        try {
            // Add product to database
            boolean added = productDAO.addProduct(product);
            
            if (added) {
                System.out.println("\nSUCCESS: Product added to database!");
                System.out.println("\nCheck your 'products' table to see the new product.");
            } else {
                System.err.println("\nFAILED: Could not add product.");
            }
            
        } catch (Exception e) {
            System.err.println("\nERROR: " + e.getMessage());
            e.printStackTrace();
        } finally {
            scanner.close();
        }
    }
}
