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
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    private CustomerDAO customerDAO;
    private EmployeeDAO employeeDAO;
    
    @Override
    public void init() throws ServletException {
        customerDAO = new CustomerDAO();
        employeeDAO = new EmployeeDAO();
        System.out.println("LoginServlet initialized");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String accountType = request.getParameter("accountType");
        
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            accountType == null || accountType.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "All fields are required!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
        if ("customer".equalsIgnoreCase(accountType)) {
            loginCustomer(request, response, username, password);
        } else if ("employee".equalsIgnoreCase(accountType)) {
            loginEmployee(request, response, username, password);
        } else {
            request.setAttribute("errorMessage", "Invalid account type!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
    
    private void loginCustomer(HttpServletRequest request, HttpServletResponse response,
                               String username, String password) throws ServletException, IOException {
        
        Customer customer = customerDAO.validateLogin(username, password);
        
        if (customer != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", customer);
            session.setAttribute("customer", customer);  // For cart compatibility
            session.setAttribute("userType", "customer");
            session.setAttribute("customerId", customer.getCustomerId());
            session.setAttribute("username", customer.getUsername());
            session.setAttribute("fullName", customer.getFullName());
            
            System.out.println("Customer login successful: " + customer.getEmail());
            System.out.println("  Customer ID: " + customer.getCustomerId());
            System.out.println("  Name: " + customer.getFullName());
            System.out.println("  Session ID: " + session.getId());
            
            response.sendRedirect(request.getContextPath() + "/home.jsp");
            
        } else {
            System.out.println("Customer login failed for username: " + username);
            request.setAttribute("errorMessage", "Invalid username or password!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
    
    private void loginEmployee(HttpServletRequest request, HttpServletResponse response,
                               String username, String password) throws ServletException, IOException {
        
        Employee employee = employeeDAO.validateLogin(username, password);
        
        if (employee != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", employee);
            session.setAttribute("userType", "employee");
            session.setAttribute("employeeId", employee.getEmployeeId());
            session.setAttribute("username", employee.getUsername());
            session.setAttribute("fullName", employee.getFullName());
            
            System.out.println("Employee login successful: " + employee.getEmail());
            System.out.println("  Employee ID: " + employee.getEmployeeId());
            System.out.println("  Session ID: " + session.getId());
            
            response.sendRedirect(request.getContextPath() + "/admin.jsp");
            
        } else {
            System.out.println("Employee login failed for username: " + username);
            request.setAttribute("errorMessage", "Invalid username or password!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}