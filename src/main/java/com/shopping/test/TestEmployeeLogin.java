package com.shopping.test;

import com.shopping.dao.EmployeeDAO;
import com.shopping.model.Employee;
import java.util.Scanner;


public class TestEmployeeLogin {
    
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        EmployeeDAO employeeDAO = new EmployeeDAO();
        
        System.out.println("        TECHSTORE EMPLOYEE LOGIN        ");
        
        // 1. Collect Credentials
        System.out.print("Enter Employee Username: ");
        String username = scanner.nextLine();
        
        System.out.print("Enter Password: ");
        String password = scanner.nextLine();
        
        System.out.println("\nAuthenticating Employee...");
        
        try {
            // 2. Call the EmployeeDAO to validate login
            Employee employee = employeeDAO.validateLogin(username, password);
            
            if (employee != null) {
                System.out.println("----------------------------------------");
                System.out.println(" EMPLOYEE LOGIN SUCCESS!");
                System.out.println(" Welcome, " + employee.getFullName());
                System.out.println(" Employee ID: " + employee.getEmployeeId());
                System.out.println(" Email: " + employee.getEmail());
                System.out.println(" Phone: " + employee.getPhone());
                System.out.println(" Location: " + employee.getCity() + ", " + employee.getCountry());
                System.out.println("----------------------------------------");
            } else {
                System.out.println("----------------------------------------");
                System.out.println(" LOGIN FAILED!");
                System.out.println(" Access Denied: Invalid credentials.");
                System.out.println("----------------------------------------");
            }
            
        } catch (Exception e) {
            System.err.println(" ERROR: Could not connect to the database.");
            e.printStackTrace();
        } finally {
            scanner.close();
        }
    }
}