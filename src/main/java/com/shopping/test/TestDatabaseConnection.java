package com.shopping.test;

import com.shopping.util.DatabaseConnection;
import java.sql.Connection;


public class TestDatabaseConnection {
    
    public static void main(String[] args) {
        System.out.println("Testing Database Connection...");
        
        try {
            Connection conn = DatabaseConnection.getConnection();
            
            if (conn != null && !conn.isClosed()) {
                System.out.println("SUCCESS: Database connected!");
                System.out.println("  Connection: " + conn);
                
                System.out.println("\nTesting database query...");
                java.sql.Statement stmt = conn.createStatement();
                java.sql.ResultSet rs = stmt.executeQuery("SELECT DATABASE()");
                
                if (rs.next()) {
                    System.out.println("Current database: " + rs.getString(1));
                }
                
                rs.close();
                stmt.close();
                
                System.out.println("\n ALL TESTS PASSED! ");
                
            } else {
                System.err.println("FAILED: Connection is null or closed");
            }
            
        } catch (Exception e) {
            System.err.println("ERROR: " + e.getMessage());
            System.err.println("\nPossible issues:");
            System.err.println("1. MySQL server is not running");
            System.err.println("2. Database 'shoppingapp' doesn't exist");
            System.err.println("3. Wrong username/password in DatabaseConnection.java");
            System.err.println("4. MySQL JDBC driver not in classpath");
            e.printStackTrace();
        }
        
    }
}