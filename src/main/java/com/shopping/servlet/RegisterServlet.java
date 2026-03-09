package com.shopping.servlet;

import com.shopping.dao.CustomerDAO;
import com.shopping.dao.EmployeeDAO;
import com.shopping.model.Customer;
import com.shopping.model.Employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    
    private CustomerDAO customerDAO;
    private EmployeeDAO employeeDAO;
    
    @Override
    public void init() throws ServletException {
    
        customerDAO = new CustomerDAO();
        employeeDAO = new EmployeeDAO();
    }
    
   
     // Handle GET requests - Display registration form
     
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Forward to registration page
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }
    
    
     // Handle POST requests - Process registration form
     
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get form parameters
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String country = request.getParameter("country");
        String city = request.getParameter("city");
        String fullAddress = request.getParameter("fullAddress");
        String accountType = request.getParameter("accountType"); // "customer" or "employee"
        
        // Validation
        if (firstName == null || firstName.trim().isEmpty() ||
            lastName == null || lastName.trim().isEmpty() ||
            username == null || username.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            accountType == null || accountType.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "All required fields must be filled!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Check if account type is customer or employee
        if ("customer".equalsIgnoreCase(accountType)) {
            registerCustomer(request, response, firstName, lastName, username, email, 
                           password, phone, country, city, fullAddress);
        } else if ("employee".equalsIgnoreCase(accountType)) {
            registerEmployee(request, response, firstName, lastName, username, email, 
                           password, phone, country, city, fullAddress);
        } else {
            request.setAttribute("errorMessage", "Invalid account type!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
    
  
    private void registerCustomer(HttpServletRequest request, HttpServletResponse response,
                                  String firstName, String lastName, String username, String email,
                                  String password, String phone, String country, String city,
                                  String fullAddress) throws ServletException, IOException {
        
        // Check if username already exists
        if (customerDAO.usernameExists(username)) {
            request.setAttribute("errorMessage", "Username already exists!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Check if email already exists
        if (customerDAO.emailExists(email)) {
            request.setAttribute("errorMessage", "Email already exists!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Create customer object
        Customer customer = new Customer(username, email, password, firstName, lastName, 
                                        phone, country, city, fullAddress);
        
        // Register customer
        boolean registered = customerDAO.registerCustomer(customer);
        
        if (registered) {
            // Registration successful
            System.out.println("Customer registered successfully: " + username);
            request.setAttribute("successMessage", "Customer registration successful! Please login.");
            response.sendRedirect(request.getContextPath() + "/login.jsp?success=true");
        } else {
            // Registration failed
            System.err.println("Customer registration failed: " + username);
            request.setAttribute("errorMessage", "Registration failed. Please try again.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
    
  
    private void registerEmployee(HttpServletRequest request, HttpServletResponse response,
                                  String firstName, String lastName, String username, String email,
                                  String password, String phone, String country, String city,
                                  String fullAddress) throws ServletException, IOException {
        
        // Check if username already exists
        if (employeeDAO.usernameExists(username)) {
            request.setAttribute("errorMessage", "Username already exists!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Check if email already exists
        if (employeeDAO.emailExists(email)) {
            request.setAttribute("errorMessage", "Email already exists!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Create employee object (NO ROLE)
        Employee employee = new Employee(username, email, password, firstName, lastName, 
                                        phone, country, city, fullAddress);
        
        // Register employee
        boolean registered = employeeDAO.registerEmployee(employee);
        
        if (registered) {
            // Registration successful
            System.out.println("Employee registered successfully: " + username);
            request.setAttribute("successMessage", "Employee registration successful! Please login.");
            response.sendRedirect(request.getContextPath() + "/login.jsp?success=true");
        } else {
            // Registration failed
            System.err.println("Employee registration failed: " + username);
            request.setAttribute("errorMessage", "Registration failed. Please try again.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}