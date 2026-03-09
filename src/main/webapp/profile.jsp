<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.shopping.model.Customer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <title>My Profile | LuxAura</title>
    <style>
        :root {
            --primary-accent: #E0A39A;
            --secondary-accent: #D4AF37;
            --bg-light: #FBF7F6;
            --dark-text: #2D2D2D;
            --white: #ffffff;
            --success: #4CAF50;
            --error: #f44336;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Playfair Display', 'Segoe UI', serif;
            background-color: var(--bg-light);
            color: var(--dark-text);
        }

        /* Navigation */
        nav {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 1.2rem 0;
            border-bottom: 1px solid #eee;
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 2rem;
        }

        .logo {
            font-size: 1.8rem;
            font-weight: 700;
            letter-spacing: 2px;
            color: var(--dark-text);
            text-transform: uppercase;
            text-decoration: none;
        }

        .logo span { color: var(--primary-accent); }

        .nav-links { 
            display: flex; 
            gap: 2rem; 
            list-style: none;
            align-items: center;
        }

        .nav-links a {
            color: var(--dark-text);
            text-decoration: none;
            transition: 0.3s;
            font-weight: 500;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 1px;
        }

        .nav-links a:hover { color: var(--primary-accent); }

        /* Profile Container */
        .profile-container {
            max-width: 900px;
            margin: 3rem auto;
            padding: 0 2rem;
        }

        .profile-header {
            background: var(--white);
            padding: 2.5rem;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            margin-bottom: 2rem;
            text-align: center;
        }

        .profile-icon {
            width: 100px;
            height: 100px;
            background: var(--primary-accent);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 3rem;
            color: var(--white);
        }

        .profile-header h1 {
            font-size: 2rem;
            margin-bottom: 0.5rem;
            letter-spacing: 1px;
        }

        .profile-header p {
            color: #666;
            font-size: 1rem;
        }

        /* Profile Form */
        .profile-form {
            background: var(--white);
            padding: 2.5rem;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }

        .form-section {
            margin-bottom: 2rem;
        }

        .form-section h2 {
            font-size: 1.3rem;
            margin-bottom: 1.5rem;
            color: var(--primary-accent);
            border-bottom: 2px solid var(--bg-light);
            padding-bottom: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--dark-text);
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            padding: 0.9rem;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 1rem;
            font-family: 'Segoe UI', sans-serif;
            transition: all 0.3s;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            outline: none;
            border-color: var(--primary-accent);
            box-shadow: 0 0 0 3px rgba(224, 163, 154, 0.1);
        }

        .form-group input:disabled {
            background-color: #f5f5f5;
            cursor: not-allowed;
            color: #999;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }

        .readonly-field {
            background-color: #f9f9f9;
            color: #666;
        }

        /* Buttons */
        .btn-group {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
            justify-content: flex-end;
        }

        .btn {
            padding: 0.9rem 2rem;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 1px;
            border: none;
            font-family: 'Playfair Display', serif;
        }

        .btn-primary {
            background: var(--dark-text);
            color: var(--white);
        }

        .btn-primary:hover {
            background: var(--primary-accent);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(224, 163, 154, 0.3);
        }

        .btn-secondary {
            background: transparent;
            color: var(--dark-text);
            border: 2px solid var(--dark-text);
        }

        .btn-secondary:hover {
            background: var(--dark-text);
            color: var(--white);
        }

        /* Alert Messages */
        .alert {
            padding: 1rem 1.5rem;
            border-radius: 6px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border-left: 4px solid var(--success);
        }

        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border-left: 4px solid var(--error);
        }

        .alert i {
            font-size: 1.3rem;
        }

        /* Info Box */
        .info-box {
            background: #e3f2fd;
            padding: 1rem;
            border-radius: 6px;
            margin-bottom: 1.5rem;
            border-left: 4px solid #2196F3;
        }

        .info-box p {
            margin: 0;
            color: #0d47a1;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>

    <nav>
        <div class="nav-container">
            <a href="home.jsp" class="logo">Lux<span>Aura</span></a>
            <ul class="nav-links">
                <li><a href="home.jsp">Home</a></li>
                <li><a href="products.jsp">Jewelry</a></li>
                <li><a href="profile">My Profile</a></li>
            </ul>
        </div>
    </nav>

    <div class="profile-container">
        
        <%
            Customer customer = (Customer) request.getAttribute("customer");
            if (customer == null) {
                customer = (Customer) session.getAttribute("customer");
            }
            
            String successMessage = (String) request.getAttribute("successMessage");
            String errorMessage = (String) request.getAttribute("errorMessage");
        %>

        <!-- Profile Header -->
        <div class="profile-header">
            <div class="profile-icon">
                <i class="fas fa-user"></i>
            </div>
            <h1><%= customer.getFirstName() %> <%= customer.getLastName() %></h1>
            <p><%= customer.getEmail() %></p>
        </div>

        <!-- Success/Error Messages -->
        <% if (successMessage != null) { %>
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                <span><%= successMessage %></span>
            </div>
        <% } %>

        <% if (errorMessage != null) { %>
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                <span><%= errorMessage %></span>
            </div>
        <% } %>

        <!-- Profile Form -->
        <form action="profile" method="post" class="profile-form">
            
            <!-- Account Information -->
            <div class="form-section">
                <h2><i class="fas fa-user-circle"></i> Account Information</h2>
                
                <div class="info-box">
                    <p><i class="fas fa-info-circle"></i> Your username and email cannot be changed. Contact support if you need to update them.</p>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" value="<%= customer.getUsername() %>" disabled class="readonly-field">
                    </div>
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input type="email" id="email" value="<%= customer.getEmail() %>" disabled class="readonly-field">
                    </div>
                </div>
            </div>

            <!-- Personal Information -->
            <div class="form-section">
                <h2><i class="fas fa-id-card"></i> Personal Information</h2>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="firstName">First Name *</label>
                        <input type="text" id="firstName" name="firstName" 
                               value="<%= customer.getFirstName() != null ? customer.getFirstName() : "" %>" 
                               required>
                    </div>
                    <div class="form-group">
                        <label for="lastName">Last Name *</label>
                        <input type="text" id="lastName" name="lastName" 
                               value="<%= customer.getLastName() != null ? customer.getLastName() : "" %>" 
                               required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="tel" id="phone" name="phone" 
                               value="<%= customer.getPhone() != null ? customer.getPhone() : "" %>" 
                               placeholder="+212 XXX-XXXXXX">
                    </div>
                </div>
            </div>

            <!-- Address Information -->
            <div class="form-section">
                <h2><i class="fas fa-map-marker-alt"></i> Address Information</h2>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="country">Country</label>
                        <input type="text" id="country" name="country" 
                               value="<%= customer.getCountry() != null ? customer.getCountry() : "" %>" 
                               placeholder="e.g., Morocco">
                    </div>
                    <div class="form-group">
                        <label for="city">City</label>
                        <input type="text" id="city" name="city" 
                               value="<%= customer.getCity() != null ? customer.getCity() : "" %>" 
                               placeholder="e.g., Casablanca">
                    </div>
                </div>

                <div class="form-group">
                    <label for="fullAddress">Full Address</label>
                    <textarea id="fullAddress" name="fullAddress" 
                              placeholder="Street address, building, floor, apartment number"><%= customer.getFullAddress() != null ? customer.getFullAddress() : "" %></textarea>
                </div>

                <div class="form-group">
                    <label for="shippingAddress">Shipping Address (if different)</label>
                    <textarea id="shippingAddress" name="shippingAddress" 
                              placeholder="Leave empty if same as above"><%= customer.getShippingAddress() != null ? customer.getShippingAddress() : "" %></textarea>
                </div>
            </div>

            <!-- Payment Preferences -->
            <div class="form-section">
                <h2><i class="fas fa-credit-card"></i> Payment Preferences</h2>
                
                <div class="form-group">
                    <label for="preferredPaymentMethod">Preferred Payment Method</label>
                    <select id="preferredPaymentMethod" name="preferredPaymentMethod">
                        <option value="" <%= customer.getPreferredPaymentMethod() == null || customer.getPreferredPaymentMethod().isEmpty() ? "selected" : "" %>>Select a payment method</option>
                        <option value="Credit Card" <%= "Credit Card".equals(customer.getPreferredPaymentMethod()) ? "selected" : "" %>>Credit Card</option>
                        <option value="Debit Card" <%= "Debit Card".equals(customer.getPreferredPaymentMethod()) ? "selected" : "" %>>Debit Card</option>
                        <option value="PayPal" <%= "PayPal".equals(customer.getPreferredPaymentMethod()) ? "selected" : "" %>>PayPal</option>
                        <option value="Cash on Delivery" <%= "Cash on Delivery".equals(customer.getPreferredPaymentMethod()) ? "selected" : "" %>>Cash on Delivery</option>
                    </select>
                </div>
            </div>

            <!-- Buttons -->
            <div class="btn-group">
                <button type="button" class="btn btn-secondary" onclick="location.href='home.jsp'">
                    Cancel
                </button>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Save Changes
                </button>
            </div>
        </form>

    </div>

</body>
</html>