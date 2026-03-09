package com.shopping.dao;

import com.shopping.model.Order;
import com.shopping.model.OrderItem;
import com.shopping.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
  
    public int placeOrder(Order order, List<OrderItem> orderItems) {
        Connection conn = null;
        PreparedStatement pstmtOrder = null;
        PreparedStatement pstmtOrderItem = null;
        PreparedStatement pstmtProduct = null;
        ResultSet generatedKeys = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false); 
            
            System.out.println("Starting order placement transaction...");
            
            String sqlOrder = "INSERT INTO orders (customerID, totalPrice, status) VALUES (?, ?, ?)";
            
            pstmtOrder = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
            pstmtOrder.setInt(1, order.getCustomerID());
            pstmtOrder.setDouble(2, order.getTotalAmount());
            pstmtOrder.setString(3, order.getStatus());
            
            int rowsAffected = pstmtOrder.executeUpdate();
            
            if (rowsAffected == 0) {
                conn.rollback();
                System.err.println("Failed to insert order");
                return -1;
            }
            
            generatedKeys = pstmtOrder.getGeneratedKeys();
            int orderId = -1;
            if (generatedKeys.next()) {
                orderId = generatedKeys.getInt(1);
                System.out.println("Order created with ID: " + orderId);
            } else {
                conn.rollback();
                System.err.println("Failed to get generated order ID");
                return -1;
            }
            
            String sqlOrderItem = "INSERT INTO orderitem (orderID, product_name, totalPrice, quantity) VALUES (?, ?, ?, ?)";
            pstmtOrderItem = conn.prepareStatement(sqlOrderItem);
            
            String sqlProduct = "SELECT title FROM products WHERE productID = ?";
            pstmtProduct = conn.prepareStatement(sqlProduct);
            
            for (OrderItem item : orderItems) {
                // Get product name
                pstmtProduct.setInt(1, item.getProductID());
                ResultSet rsProduct = pstmtProduct.executeQuery();
                
                String productName = "Unknown Product";
                if (rsProduct.next()) {
                    productName = rsProduct.getString("title");
                }
                rsProduct.close();
                
                // Insert order item
                pstmtOrderItem.setInt(1, orderId);
                pstmtOrderItem.setString(2, productName);
                pstmtOrderItem.setDouble(3, item.getPrice());
                pstmtOrderItem.setInt(4, item.getQuantity());
                pstmtOrderItem.addBatch();
                
                System.out.println("  - Added item: " + productName + " (qty: " + item.getQuantity() + ", price: $" + item.getPrice() + ")");
            }
            
            pstmtOrderItem.executeBatch();
            
            // Commit transaction
            conn.commit();
            System.out.println(" Order placed successfully: Order ID = " + orderId);
            
            return orderId;
            
        } catch (SQLException e) {
            System.err.println("Error placing order: " + e.getMessage());
            e.printStackTrace();
            
            if (conn != null) {
                try {
                    conn.rollback();
                    System.out.println("Transaction rolled back");
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return -1;
            
        } finally {
            try {
                if (generatedKeys != null) generatedKeys.close();
                if (pstmtProduct != null) pstmtProduct.close();
                if (pstmtOrderItem != null) pstmtOrderItem.close();
                if (pstmtOrder != null) pstmtOrder.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    public Order getOrderById(int orderID) {
        String sql = "SELECT * FROM orders WHERE orderID = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, orderID);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractOrderFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting order: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    
     //Get all orders for a customer
    
    public List<Order> getOrdersByCustomerId(int customerID) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE customerID = ? ORDER BY datePlaced DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, customerID);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                orders.add(extractOrderFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting orders: " + e.getMessage());
            e.printStackTrace();
        }
        return orders;
    }
    
     // Get order items for an order
     
    public List<OrderItem> getOrderItems(int orderID) {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT * FROM orderitem WHERE orderID = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, orderID);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setOrderItemID(rs.getInt("orderItemID"));
                item.setOrderID(rs.getInt("orderID"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getDouble("totalPrice"));
                items.add(item);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting order items: " + e.getMessage());
            e.printStackTrace();
        }
        return items;
    }
    
     // Get all orders (for admin)
   
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders ORDER BY datePlaced DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                orders.add(extractOrderFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting all orders: " + e.getMessage());
            e.printStackTrace();
        }
        return orders;
    }
    
     // Update order status
    public boolean updateOrderStatus(int orderID, String status) {
        String sql = "UPDATE orders SET status = ? WHERE orderID = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, status);
            pstmt.setInt(2, orderID);
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating order status: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    private Order extractOrderFromResultSet(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setOrderID(rs.getInt("orderID"));
        order.setCustomerID(rs.getInt("customerID"));
        order.setOrderDate(rs.getTimestamp("datePlaced"));
        order.setTotalAmount(rs.getDouble("totalPrice"));
        order.setStatus(rs.getString("status"));
        return order;
    }
}