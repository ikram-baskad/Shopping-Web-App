package com.shopping.servlet;

import com.shopping.dao.SupportDAO;
import com.shopping.model.Customer;
import com.shopping.model.SupportMessage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/support")
public class SupportServlet extends HttpServlet {
    
    private SupportDAO supportDAO;
    
    @Override
    public void init() throws ServletException {
        supportDAO = new SupportDAO();
        System.out.println("SupportServlet initialized");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.getRequestDispatcher("/support.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Get form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");
        
        // Validate input
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            subject == null || subject.trim().isEmpty() ||
            message == null || message.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "All fields are required!");
            request.getRequestDispatcher("/support.jsp").forward(request, response);
            return;
        }
        
        // Create support message object
        SupportMessage supportMessage = new SupportMessage();
        supportMessage.setCustomerName(name.trim());
        supportMessage.setCustomerEmail(email.trim());
        supportMessage.setSubject(subject.trim());
        supportMessage.setMessage(message.trim());
        supportMessage.setStatus("pending");
        
        // If user is logged in, add customer ID
        if (session != null && session.getAttribute("customer") != null) {
            Customer customer = (Customer) session.getAttribute("customer");
            supportMessage.setCustomerId(customer.getCustomerId());
        }
        
        // Submit message to database
        boolean submitted = supportDAO.submitMessage(supportMessage);
        
        if (submitted) {
            System.out.println("Support message submitted successfully");
            request.setAttribute("successMessage", 
                "Your message has been sent successfully! Our support team will contact you soon.");
            
            // Clear form fields
            request.setAttribute("clearForm", true);
            
        } else {
            System.out.println("Failed to submit support message");
            request.setAttribute("errorMessage", 
                "Failed to send message. Please try again later.");
        }
        
        request.getRequestDispatcher("/support.jsp").forward(request, response);
    }
}