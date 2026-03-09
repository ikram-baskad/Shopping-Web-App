package com.shopping.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    
    @Override
    public void init() throws ServletException {
        System.out.println("LogoutServlet initialized");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            String username = (String) session.getAttribute("username");
            String userType = (String) session.getAttribute("userType");
            
            System.out.println("Logging out user: " + (username != null ? username : "Unknown"));
            System.out.println("  User type: " + (userType != null ? userType : "Unknown"));
            System.out.println("  Session ID: " + session.getId());
            
            session.invalidate(); 
            System.out.println("Session destroyed successfully");
        } else {
            System.out.println("No active session found");
        }
        
        response.sendRedirect(request.getContextPath() + "/home.jsp");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}