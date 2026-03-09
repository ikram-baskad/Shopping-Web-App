package com.shopping.servlet;

import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/tickets")
public class AdminTicketsServlet extends HttpServlet {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/shoppingapp";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        List<Map<String, Object>> tickets = new ArrayList<>();
        
        String query = "SELECT sm.message_id, sm.customer_id, sm.subject, sm.message, " +
                      "sm.status, sm.created_at, sm.updated_at, " +
                      "sm.customer_name, sm.customer_email " +
                      "FROM support_messages sm " +
                      "ORDER BY sm.created_at DESC";
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Map<String, Object> ticket = new HashMap<>();
                ticket.put("message_id", rs.getInt("message_id"));
                ticket.put("customer_id", rs.getInt("customer_id"));
                ticket.put("customer_name", rs.getString("customer_name"));
                ticket.put("customer_email", rs.getString("customer_email"));
                ticket.put("subject", rs.getString("subject"));
                ticket.put("message", rs.getString("message"));
                ticket.put("status", rs.getString("status"));
                ticket.put("created_at", rs.getTimestamp("created_at").toString());
                
                Timestamp updatedAt = rs.getTimestamp("updated_at");
                ticket.put("updated_at", updatedAt != null ? updatedAt.toString() : null);
                
                tickets.add(ticket);
            }
            
            out.print(new Gson().toJson(tickets));
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\":\"Database error: " + e.getMessage() + "\"}");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        String action = request.getParameter("action");
        
        if ("updateStatus".equals(action)) {
            handleStatusUpdate(request, response, out);
        } else {
            out.print("{\"error\":\"Invalid action\"}");
        }
    }
    
    private void handleStatusUpdate(HttpServletRequest request, HttpServletResponse response, PrintWriter out) {
        String ticketIdStr = request.getParameter("ticketId");
        String status = request.getParameter("status");
        
        try {
            int ticketId = Integer.parseInt(ticketIdStr);
            
            String updateQuery = "UPDATE support_messages SET status = ?, updated_at = NOW() WHERE message_id = ?";
            
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement(updateQuery)) {
                
                stmt.setString(1, status);
                stmt.setInt(2, ticketId);
                int rowsAffected = stmt.executeUpdate();
                
                if (rowsAffected > 0) {
                    out.print("{\"success\":true,\"message\":\"Ticket status updated\"}");
                } else {
                    out.print("{\"error\":\"Failed to update ticket status\"}");
                }
                
            } catch (SQLException e) {
                e.printStackTrace();
                out.print("{\"error\":\"Database error: " + e.getMessage() + "\"}");
            }
            
        } catch (NumberFormatException e) {
            out.print("{\"error\":\"Invalid ticket ID\"}");
        }
    }
    
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        String ticketIdStr = request.getParameter("ticketId");
        
        try {
            int ticketId = Integer.parseInt(ticketIdStr);
            
            String deleteQuery = "DELETE FROM support_messages WHERE message_id = ?";
            
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement(deleteQuery)) {
                
                stmt.setInt(1, ticketId);
                int rowsAffected = stmt.executeUpdate();
                
                if (rowsAffected > 0) {
                    out.print("{\"success\":true,\"message\":\"Ticket deleted successfully\"}");
                } else {
                    out.print("{\"error\":\"Ticket not found\"}");
                }
                
            } catch (SQLException e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.print("{\"error\":\"Database error: " + e.getMessage() + "\"}");
            }
            
        } catch (NumberFormatException e) {
            out.print("{\"error\":\"Invalid ticket ID\"}");
        }
    }
}