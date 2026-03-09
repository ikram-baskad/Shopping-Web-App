package com.shopping.model;

import java.sql.Timestamp;


public class Product {
    
    // Private fields (Encapsulation)
    private int productID;
    private String title;
    private String description;
    private double price;
    private int quantity;
    private String imageURL;
    private String category;
    private Timestamp createdAt;
    
    // Default constructor
    public Product() {
    }
    
    public Product(String title, String description, double price, int quantity, 
                   String imageURL, String category) {
        this.title = title;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
        this.imageURL = imageURL;
        this.category = category;
    }
    
    // Full constructor (used when retrieving from database)
    public Product(int productID, String title, String description, double price, 
                   int quantity, String imageURL, String category, Timestamp createdAt) {
        this.productID = productID;
        this.title = title;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
        this.imageURL = imageURL;
        this.category = category;
        this.createdAt = createdAt;
    }
    
    // Getters and Setters
    public int getProductID() {
        return productID;
    }
    
    public void setProductID(int productID) {
        this.productID = productID;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public double getPrice() {
        return price;
    }
    
    public void setPrice(double price) {
        this.price = price;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public String getImageURL() {
        return imageURL;
    }
    
    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }
    
    public String getCategory() {
        return category;
    }
    
    public void setCategory(String category) {
        this.category = category;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    // Business logic methods
    public boolean isInStock() {
        return quantity > 0;
    }
    
    public boolean isLowStock() {
        return quantity > 0 && quantity <= 5;
    }
    
    @Override
    public String toString() {
        return "Product{" +
                "productID=" + productID +
                ", title='" + title + '\'' +
                ", price=" + price +
                ", quantity=" + quantity +
                ", category='" + category + '\'' +
                '}';
    }
}