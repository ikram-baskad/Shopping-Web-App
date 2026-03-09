package com.shopping.test;

import com.shopping.dao.CustomerDAO;
import com.shopping.model.Customer;
import java.util.Scanner;

public class TestCustomerRegistration {
    
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        CustomerDAO customerDAO = new CustomerDAO();

        System.out.println("   ENTER CUSTOMER REGISTRATION DATA     ");
        
        // Collecting data from the console
        System.out.print("Enter Username: ");
        String username = scanner.nextLine();

        System.out.print("Enter Email: ");
        String email = scanner.nextLine();

        System.out.print("Enter Password: ");
        String password = scanner.nextLine();

        System.out.print("Enter First Name: ");
        String firstName = scanner.nextLine();

        System.out.print("Enter Last Name: ");
        String lastName = scanner.nextLine();

        System.out.print("Enter Phone: ");
        String phone = scanner.nextLine();

        System.out.print("Enter Country: ");
        String country = scanner.nextLine();

        System.out.print("Enter City: ");
        String city = scanner.nextLine();

        System.out.print("Enter Full Address: ");
        String address = scanner.nextLine();

        Customer testCustomer = new Customer(
            username, email, password, firstName, lastName, 
            phone, country, city, address
        );
        
        System.out.println("\n--- Starting Database Tests ---");

        try {
            System.out.print("[Test 1] Checking username...");
            if (!customerDAO.usernameExists(testCustomer.getUsername())) {
                System.out.println("Available");
            } else {
                System.out.println("Already exists!");
                return; 
            }
            
            System.out.print("[Test 2] Registering customer...");
            boolean registered = customerDAO.registerCustomer(testCustomer);
            
            if (registered) {
                System.out.println(" SUCCESS!");
                
                System.out.println("\n--- Testing Login with your credentials ---");
                System.out.print("Confirm Password to Login: ");
                String loginPass = scanner.nextLine();
                
                Customer loggedIn = customerDAO.validateLogin(username, loginPass);
                
                if (loggedIn != null) {
                    System.out.println("Login PASS: Welcome " + loggedIn.getFullName());
                } else {
                    System.out.println("Login FAIL: Incorrect password.");
                }
                
            } else {
                System.err.println("FAILED: Database error during registration.");
            }
            
        } catch (Exception e) {
            System.err.println("ERROR: " + e.getMessage());
            e.printStackTrace();
        } finally {
            scanner.close(); 
        }
    }
}