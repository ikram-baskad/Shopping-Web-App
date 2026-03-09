package com.shopping.test;

import com.shopping.dao.CustomerDAO;
import com.shopping.model.Customer;

import java.util.List;

public class TestViewCustomers {
    
    public static void main(String[] args) {
        System.out.println("=".repeat(60));
        System.out.println("TESTING: View All Customers");
        System.out.println("=".repeat(60));
        
        CustomerDAO customerDAO = new CustomerDAO();
        
        try {
            System.out.println("\n[TEST 1] Fetching all customers...");
            List<Customer> customers = customerDAO.getAllCustomers();
            
            if (customers.isEmpty()) {
                System.out.println("No customers found in database");
                System.out.println("Add some customers first using TestCustomerRegistration.java");
                return;
            }
            
            System.out.println("Found " + customers.size() + " customer(s)");
            System.out.println("\n" + "=".repeat(60));
            System.out.println("CUSTOMER LIST:");
            System.out.println("=".repeat(60));
            
            // Display each customer
            for (int i = 0; i < customers.size(); i++) {
                Customer c = customers.get(i);
                System.out.println("\n[Customer #" + (i + 1) + "]");
                System.out.println("  ID:         " + c.getCustomerId());
                System.out.println("  Username:   " + c.getUsername());
                System.out.println("  Name:       " + c.getFirstName() + " " + c.getLastName());
                System.out.println("  Email:      " + c.getEmail());
                System.out.println("  Phone:      " + (c.getPhone() != null ? c.getPhone() : "N/A"));
                System.out.println("  Address:    " + (c.getFullAddress() != null ? c.getFullAddress() : "N/A"));
                System.out.println("  City:       " + (c.getCity() != null ? c.getCity() : "N/A"));
                System.out.println("  Country:    " + (c.getCountry() != null ? c.getCountry() : "N/A"));
                System.out.println("  Created:    " + c.getCreatedAt());
                System.out.println("-".repeat(60));
            }
            
            // Test 2: Get specific customer by ID
            if (!customers.isEmpty()) {
                System.out.println("\n[TEST 2] Fetching first customer by ID...");
                int testId = customers.get(0).getCustomerId();
                Customer customer = customerDAO.getCustomerById(testId);
                
                if (customer != null) {
                    System.out.println("Successfully retrieved customer: " + customer.getFullName());
                } else {
                    System.out.println("Failed to retrieve customer by ID");
                }
            }
            
            // Test 3: Check if email exists
            if (!customers.isEmpty()) {
                System.out.println("\n[TEST 3] Checking if email exists...");
                String testEmail = customers.get(0).getEmail();
                boolean exists = customerDAO.emailExists(testEmail);
                System.out.println("Email '" + testEmail + "' exists: " + exists);
            }
            
            System.out.println("\n" + "=".repeat(60));
            System.out.println("ALL TESTS COMPLETED SUCCESSFULLY!");
            System.out.println("=".repeat(60));
            
        } catch (Exception e) {
            System.err.println("\n ERROR: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
