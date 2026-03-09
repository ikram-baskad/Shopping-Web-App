package com.shopping.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.shopping.dao.CustomerDAO;
import com.shopping.model.Customer;

import jakarta.servlet.ServletException;  // ← CHANGED
import jakarta.servlet.annotation.WebServlet;  // ← CHANGED
import jakarta.servlet.http.HttpServlet;  // ← CHANGED
import jakarta.servlet.http.HttpServletRequest;  // ← CHANGED
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {
    
    private CustomerDAO customerDAO;
    private Gson gson;
    
    @Override
    public void init() throws ServletException {
        customerDAO = new CustomerDAO();
        gson = new Gson();
        System.out.println(" AdminUserServlet initialized");
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("GET /admin/users - Loading all customers");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            List<Customer> customers = customerDAO.getAllCustomers();
            
            List<Map<String, Object>> customerList = new ArrayList<>();
            for (Customer customer : customers) {
                Map<String, Object> customerMap = new HashMap<>();
                customerMap.put("userID", customer.getCustomerId());
                customerMap.put("firstName", customer.getFirstName());
                customerMap.put("lastName", customer.getLastName());
                customerMap.put("email", customer.getEmail());
                customerMap.put("password", customer.getPassword());
                customerMap.put("phone", customer.getPhone());
                String address = buildFullAddress(customer);
                customerMap.put("address", address);
                customerMap.put("createdAt", customer.getCreatedAt());
                
                customerList.add(customerMap);
            }
            
            String json = gson.toJson(customerList);
            
            PrintWriter out = response.getWriter();
            out.print(json);
            out.flush();
            
            System.out.println("Returned " + customerList.size() + " customers");
            
        } catch (Exception e) {
            System.err.println("Error loading customers: " + e.getMessage());
            e.printStackTrace();
            
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JsonObject error = new JsonObject();
            error.addProperty("success", false);
            error.addProperty("error", "Failed to load customers: " + e.getMessage());
            response.getWriter().print(gson.toJson(error));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        System.out.println("POST /admin/users - Action: " + action);
        
        try {
            if ("add".equals(action)) {
                handleAddCustomer(request, response);
            } else if ("update".equals(action)) {
                handleUpdateCustomer(request, response);
            } else {
                sendError(response, "Invalid action: " + action);
            }
        } catch (Exception e) {
            System.err.println("Error in POST: " + e.getMessage());
            e.printStackTrace();
            sendError(response, "Operation failed: " + e.getMessage());
        }
    }
  
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String userIdParam = request.getParameter("userId");
        System.out.println("DELETE /admin/users - userId: " + userIdParam);
        
        try {
            if (userIdParam == null || userIdParam.isEmpty()) {
                sendError(response, "Missing userId parameter");
                return;
            }
            
            int userId = Integer.parseInt(userIdParam);
            boolean deleted = customerDAO.deleteCustomer(userId);
            
            JsonObject result = new JsonObject();
            result.addProperty("success", deleted);
            
            if (deleted) {
                result.addProperty("message", "Customer deleted successfully");
                System.out.println("Deleted customer ID: " + userId);
            } else {
                result.addProperty("error", "Failed to delete customer");
                System.err.println("Failed to delete customer ID: " + userId);
            }
            
            response.getWriter().print(gson.toJson(result));
            
        } catch (NumberFormatException e) {
            sendError(response, "Invalid userId format");
        } catch (Exception e) {
            System.err.println("Error deleting customer: " + e.getMessage());
            e.printStackTrace();
            sendError(response, "Failed to delete customer: " + e.getMessage());
        }
    }
    
    private void handleAddCustomer(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        System.out.println("Adding customer: " + firstName + " " + lastName + " (" + email + ")");
        
        // Validation
        if (firstName == null || lastName == null || email == null || password == null ||
            firstName.isEmpty() || lastName.isEmpty() || email.isEmpty() || password.isEmpty()) {
            sendError(response, "Missing required fields");
            return;
        }
        
        // Check if email already exists
        if (customerDAO.emailExists(email)) {
            sendError(response, "Email already exists");
            return;
        }
        
        // Create username from email (before @ symbol)
        String username = email.split("@")[0];
        
        // Check if username exists, if so append number
        String finalUsername = username;
        int counter = 1;
        while (customerDAO.usernameExists(finalUsername)) {
            finalUsername = username + counter;
            counter++;
        }
        
        // Create new customer
        Customer customer = new Customer();
        customer.setUsername(finalUsername);
        customer.setEmail(email);
        customer.setPassword(password); 
        customer.setFirstName(firstName);
        customer.setLastName(lastName);
        customer.setPhone(phone != null ? phone : "");
        customer.setFullAddress(address != null ? address : "");
        customer.setCountry(""); 
        customer.setCity("");
        
        boolean success = customerDAO.registerCustomer(customer);
        
        JsonObject result = new JsonObject();
        result.addProperty("success", success);
        
        if (success) {
            result.addProperty("message", "Customer added successfully");
            System.out.println("Customer added: " + finalUsername);
        } else {
            result.addProperty("error", "Failed to add customer");
            System.err.println("Failed to add customer");
        }
        
        response.getWriter().print(gson.toJson(result));
    }
 
    private void handleUpdateCustomer(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        String userIdParam = request.getParameter("userId");
        
        if (userIdParam == null || userIdParam.isEmpty()) {
            sendError(response, "Missing userId parameter");
            return;
        }
        
        try {
            int userId = Integer.parseInt(userIdParam);
            System.out.println("Updating customer ID: " + userId);
            
            // Get existing customer
            Customer customer = customerDAO.getCustomerById(userId);
            if (customer == null) {
                sendError(response, "Customer not found");
                return;
            }
            
            // Update fields
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String password = request.getParameter("password");
            
            if (firstName != null && !firstName.isEmpty()) {
                customer.setFirstName(firstName);
            }
            if (lastName != null && !lastName.isEmpty()) {
                customer.setLastName(lastName);
            }
            if (phone != null) {
                customer.setPhone(phone);
            }
            if (address != null) {
                customer.setFullAddress(address);
            }
            if (password != null && !password.isEmpty()) {
                customer.setPassword(password);
            }
            
            boolean success = customerDAO.updateCustomer(customer);
            
            JsonObject result = new JsonObject();
            result.addProperty("success", success);
            
            if (success) {
                result.addProperty("message", "Customer updated successfully");
                System.out.println("Customer updated: " + userId);
            } else {
                result.addProperty("error", "Failed to update customer");
                System.err.println("Failed to update customer: " + userId);
            }
            
            response.getWriter().print(gson.toJson(result));
            
        } catch (NumberFormatException e) {
            sendError(response, "Invalid userId format");
        }
    }
    
     //Send error response
     
    private void sendError(HttpServletResponse response, String message) throws IOException {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        JsonObject error = new JsonObject();
        error.addProperty("success", false);
        error.addProperty("error", message);
        response.getWriter().print(gson.toJson(error));
    }
    

    private String buildFullAddress(Customer customer) {
        StringBuilder address = new StringBuilder();
        
        if (customer.getFullAddress() != null && !customer.getFullAddress().isEmpty()) {
            address.append(customer.getFullAddress());
        }
        if (customer.getCity() != null && !customer.getCity().isEmpty()) {
            if (address.length() > 0) address.append(", ");
            address.append(customer.getCity());
        }
        if (customer.getCountry() != null && !customer.getCountry().isEmpty()) {
            if (address.length() > 0) address.append(", ");
            address.append(customer.getCountry());
        }
        
        return address.length() > 0 ? address.toString() : "N/A";
    }
}