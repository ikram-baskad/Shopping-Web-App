package com.shopping.test;

import com.shopping.dao.EmployeeDAO;
import com.shopping.model.Employee;
import java.util.Scanner;


public class TestEmployeeRegistration {
    
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        EmployeeDAO employeeDAO = new EmployeeDAO();
        
        System.out.println("   ENTER EMPLOYEE REGISTRATION DATA     ");
        
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
        
        Employee testEmployee = new Employee(
            username, email, password, firstName, lastName, 
            phone, country, city, address
        );
        
        System.out.println("\n--- Starting Database Registration ---");
        try {
            if (employeeDAO.usernameExists(testEmployee.getUsername())) {
                System.out.println(" FAIL: Username '" + username + "' is already taken!");
                return;
            }
            
            System.out.print("Registering " + testEmployee.getFullName() + "...");
            boolean registered = employeeDAO.registerEmployee(testEmployee);
            
            if (registered) {
                System.out.println(" SUCCESS!");
                
                System.out.println("\n--- Verification: Testing Login ---");
                System.out.print("Confirm Password to Login: ");
                String loginPass = scanner.nextLine();
                
                Employee loggedIn = employeeDAO.validateLogin(username, loginPass);
                
                if (loggedIn != null) {
                    System.out.println(" Login PASS: Welcome " + loggedIn.getFullName());
                    System.out.println(" Employee ID: " + loggedIn.getEmployeeId());
                    System.out.println(" Email: " + loggedIn.getEmail());
                } else {
                    System.out.println(" Login FAIL: Incorrect password or database error.");
                }
                
            } else {
                System.err.println(" FAILED: Could not save employee to database.");
            }
            
        } catch (Exception e) {
            System.err.println(" ERROR: " + e.getMessage());
            e.printStackTrace();
        } finally {
            scanner.close();
        }
    }
}