package com.shopping.servlet;

import com.shopping.dao.CustomerDAO;
import com.shopping.model.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    
    private CustomerDAO customerDAO;
    
    @Override
    public void init() throws ServletException {
        customerDAO = new CustomerDAO();
        System.out.println("✓ ProfileServlet initialized");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in
        if (session == null || session.getAttribute("customer") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // Get customer from session
        Customer customer = (Customer) session.getAttribute("customer");
        
        // Reload customer data from database to ensure it's up-to-date
        Customer freshCustomer = customerDAO.getCustomerById(customer.getCustomerId());
        
        if (freshCustomer != null) {
            // Update session with fresh data
            session.setAttribute("customer", freshCustomer);
            request.setAttribute("customer", freshCustomer);
        }
        
        // Forward to profile page
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in
        if (session == null || session.getAttribute("customer") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        Customer customer = (Customer) session.getAttribute("customer");
        
        // Get updated information from form
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");
        String country = request.getParameter("country");
        String city = request.getParameter("city");
        String fullAddress = request.getParameter("fullAddress");
        String shippingAddress = request.getParameter("shippingAddress");
        String preferredPaymentMethod = request.getParameter("preferredPaymentMethod");
        
        // Validate input
        if (firstName == null || firstName.trim().isEmpty() ||
            lastName == null || lastName.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "First name and last name are required!");
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
            return;
        }
        
        // Update customer object
        customer.setFirstName(firstName.trim());
        customer.setLastName(lastName.trim());
        customer.setPhone(phone != null ? phone.trim() : "");
        customer.setCountry(country != null ? country.trim() : "");
        customer.setCity(city != null ? city.trim() : "");
        customer.setFullAddress(fullAddress != null ? fullAddress.trim() : "");
        customer.setShippingAddress(shippingAddress != null ? shippingAddress.trim() : "");
        customer.setPreferredPaymentMethod(preferredPaymentMethod != null ? preferredPaymentMethod.trim() : "");
        
        // Update in database
        boolean updated = customerDAO.updateCustomer(customer);
        
        if (updated) {
            // Update session
            session.setAttribute("customer", customer);
            session.setAttribute("fullName", customer.getFullName());
            
            System.out.println("Profile updated successfully for: " + customer.getEmail());
            
            request.setAttribute("successMessage", "Profile updated successfully!");
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
            
        } else {
            System.out.println("Failed to update profile for: " + customer.getEmail());
            
            request.setAttribute("errorMessage", "Failed to update profile. Please try again.");
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
        }
    }
}