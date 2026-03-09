package com.shopping.test;

import com.shopping.dao.CustomerDAO;
import com.shopping.model.Customer;
import java.util.Scanner;


public class TestCustomerLogin {
    
    public static void main(String[] args) {
        // Initialize Scanner for console input and the DAO
        Scanner scanner = new Scanner(System.in);
        CustomerDAO customerDAO = new CustomerDAO();

        System.out.println("        TECHSTORE CONSOLE LOGIN         ");
        
        System.out.print("Enter Username: ");
        String username = scanner.nextLine();

        System.out.print("Enter Password: ");
        String password = scanner.nextLine();

        System.out.println("\nConnecting to database...");

        try {
            Customer customer = customerDAO.validateLogin(username, password);
            
            if (customer != null) {
                System.out.println("----------------------------------------");
                System.out.println(" LOGIN SUCCESS!");
                System.out.println(" Welcome, " + customer.getFullName());
                System.out.println(" Email: " + customer.getEmail());
                System.out.println("----------------------------------------");
            } else {
                System.out.println("----------------------------------------");
                System.out.println(" LOGIN FAILED!");
                System.out.println(" Invalid username or password.");
                System.out.println("----------------------------------------");
            }
            
        } catch (Exception e) {
            System.err.println(" ERROR: An unexpected error occurred.");
            e.printStackTrace();
        } finally {
            scanner.close();
        }
    }
}