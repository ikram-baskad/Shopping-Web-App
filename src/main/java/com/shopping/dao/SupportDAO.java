package com.shopping.dao;

import com.shopping.model.SupportMessage;
import com.shopping.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SupportDAO {
 
    public boolean submitMessage(SupportMessage supportMessage) {
        String sql = "INSERT INTO support_messages (customer_id, customer_name, customer_email, subject, message, status) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            if (supportMessage.getCustomerId() != null) {
                pstmt.setInt(1, supportMessage.getCustomerId());
            } else {
                pstmt.setNull(1, Types.INTEGER);
            }
            
            pstmt.setString(2, supportMessage.getCustomerName());
            pstmt.setString(3, supportMessage.getCustomerEmail());
            pstmt.setString(4, supportMessage.getSubject());
            pstmt.setString(5, supportMessage.getMessage());
            pstmt.setString(6, supportMessage.getStatus());
            
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                System.out.println("Support message submitted from: " + supportMessage.getCustomerEmail());
                return true;
            }
            
        } catch (SQLException e) {
            System.err.println("Error submitting support message: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public List<SupportMessage> getAllMessages() {
        List<SupportMessage> messages = new ArrayList<>();
        String sql = "SELECT * FROM support_messages ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                messages.add(extractMessageFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting all messages: " + e.getMessage());
            e.printStackTrace();
        }
        return messages;
    }
    
     // Get messages by customer ID
    public List<SupportMessage> getMessagesByCustomerId(int customerId) {
        List<SupportMessage> messages = new ArrayList<>();
        String sql = "SELECT * FROM support_messages WHERE customer_id = ? ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, customerId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                messages.add(extractMessageFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting customer messages: " + e.getMessage());
            e.printStackTrace();
        }
        return messages;
    }
    
    
     // Get message by ID
     
    public SupportMessage getMessageById(int messageId) {
        String sql = "SELECT * FROM support_messages WHERE message_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, messageId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractMessageFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting message: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
   
     //Update message status
     
    public boolean updateMessageStatus(int messageId, String status) {
        String sql = "UPDATE support_messages SET status = ? WHERE message_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, status);
            pstmt.setInt(2, messageId);
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating message status: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    
     // Delete message
    
    public boolean deleteMessage(int messageId) {
        String sql = "DELETE FROM support_messages WHERE message_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, messageId);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error deleting message: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
 
    private SupportMessage extractMessageFromResultSet(ResultSet rs) throws SQLException {
        SupportMessage message = new SupportMessage();
        message.setMessageId(rs.getInt("message_id"));
        
        int customerId = rs.getInt("customer_id");
        if (!rs.wasNull()) {
            message.setCustomerId(customerId);
        }
        
        message.setCustomerName(rs.getString("customer_name"));
        message.setCustomerEmail(rs.getString("customer_email"));
        message.setSubject(rs.getString("subject"));
        message.setMessage(rs.getString("message"));
        message.setStatus(rs.getString("status"));
        message.setCreatedAt(rs.getTimestamp("created_at"));
        message.setUpdatedAt(rs.getTimestamp("updated_at"));
        
        return message;
    }
}