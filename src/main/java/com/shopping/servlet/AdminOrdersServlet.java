package com.shopping.servlet;

import com.shopping.dao.OrderDAO;
import com.shopping.dao.CustomerDAO;
import com.shopping.model.Order;
import com.shopping.model.Customer;
import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/orders")
public class AdminOrdersServlet extends HttpServlet {
    
    private OrderDAO orderDAO;
    private CustomerDAO customerDAO;
    private Gson gson;
    
    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
        customerDAO = new CustomerDAO();
        gson = new Gson();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            List<Order> orders = orderDAO.getAllOrders();
            List<Map<String, Object>> ordersJson = new ArrayList<>();
            
            for (Order order : orders) {
                Map<String, Object> orderMap = new HashMap<>();
                
                Customer customer = customerDAO.getCustomerById(order.getCustomerID());
                String customerName = (customer != null) ? customer.getFullName() : "User #" + order.getCustomerID();

                orderMap.put("orderID", order.getOrderID());
                orderMap.put("customerName", customerName);
                orderMap.put("totalAmount", order.getTotalAmount());
                orderMap.put("status", order.getStatus());
                orderMap.put("orderDate", order.getCreatedAt() != null ? order.getCreatedAt().toString() : null);
                
                ordersJson.add(orderMap);
            }
            
            out.print(gson.toJson(ordersJson));
            
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Database error: " + e.getMessage());
            out.print(gson.toJson(error));
            e.printStackTrace();
        }
    }
}