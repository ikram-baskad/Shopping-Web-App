<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="com.shopping.model.CartItem" %>
<%@ page import="com.shopping.model.Customer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout | Luxaura</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-accent: #E0A39A;
            --bg-light: #FBF7F6;
            --dark-text: #2D2D2D;
            --white: #ffffff;
            --border: #E8E1DF;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
 
        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-light);
            color: var(--dark-text);
            line-height: 1.6;
        }

        nav {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 1.2rem 0;
            position: sticky;
            top: 0;
            z-index: 1000;
            border-bottom: 1px solid var(--border);
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
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--dark-text);
            text-decoration: none;
            letter-spacing: 2px;
            text-transform: uppercase;
        }
        .logo span { color: var(--primary-accent); }

        .checkout-container {
            max-width: 1000px;
            margin: 4rem auto;
            padding: 0 2rem;
        }

        .checkout-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .checkout-header h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            margin-bottom: 10px;
        }

        .checkout-steps {
            display: flex;
            justify-content: center;
            gap: 40px;
            margin-bottom: 40px;
        }

        .step {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #999;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .step.active {
            color: var(--primary-accent);
            font-weight: 600;
        }

        .step-number {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            border: 2px solid #999;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
        }

        .step.active .step-number {
            background: var(--primary-accent);
            border-color: var(--primary-accent);
            color: white;
        }

        .checkout-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
        }

        .checkout-section {
            background: var(--white);
            padding: 30px;
            border-radius: 8px;
            border: 1px solid var(--border);
        }

        .section-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            margin-bottom: 20px;
            color: var(--dark-text);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--dark-text);
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 600;
        }

        .form-group input, .form-group textarea, .form-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid var(--border);
            border-radius: 4px;
            font-family: 'Inter', sans-serif;
            font-size: 0.95rem;
        }

        .form-group input:focus, .form-group textarea:focus, .form-group select:focus {
            outline: none;
            border-color: var(--primary-accent);
        }

        .order-summary {
            background: var(--bg-light);
            padding: 20px;
            border-radius: 4px;
            margin-bottom: 20px;
        }

        .order-item {
            display: flex;
            justify-content: space-between;
            padding: 15px 0;
            border-bottom: 1px solid var(--border);
        }

        .order-item:last-child {
            border-bottom: none;
        }

        .item-details {
            flex: 1;
        }

        .item-name {
            font-weight: 600;
            margin-bottom: 5px;
        }

        .item-qty {
            font-size: 0.85rem;
            color: #666;
        }

        .item-price {
            font-weight: 600;
            color: var(--primary-accent);
        }

        .total-row {
            display: flex;
            justify-content: space-between;
            padding: 20px 0;
            border-top: 2px solid var(--dark-text);
            margin-top: 20px;
            font-family: 'Playfair Display', serif;
        }

        .total-label {
            font-size: 1.2rem;
            font-weight: 600;
        }

        .total-amount {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-accent);
        }

        .btn-checkout {
            width: 100%;
            padding: 18px;
            background: var(--dark-text);
            color: var(--white);
            border: none;
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            cursor: pointer;
            transition: 0.3s;
            border-radius: 4px;
        }

        .btn-checkout:hover {
            background: var(--primary-accent);
        }

        .back-link {
            color: var(--primary-accent);
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 600;
            display: inline-block;
            margin-top: 20px;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        .info-text {
            font-size: 0.85rem;
            color: #666;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

    <%
        // Check if user is logged in
        Customer customer = (Customer) session.getAttribute("customer");
        if (customer == null) {
            response.sendRedirect("login.jsp?message=Please login to checkout");
            return;
        }

        // Get cart from session
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp?error=Your cart is empty");
            return;
        }

        double grandTotal = cart.values().stream().mapToDouble(CartItem::getSubtotal).sum();
    %>

    <nav>
        <div class="nav-container">
            <a href="home.jsp" class="logo">LUX<span>AURA</span></a>
        </div>
    </nav>

    <div class="checkout-container">
        <div class="checkout-header">
            <h2>Checkout</h2>
            <p style="text-transform: uppercase; letter-spacing: 2px; font-size: 0.7rem; color: #aaa;">Complete your order</p>
        </div>

        <div class="checkout-steps">
            <div class="step active">
                <div class="step-number">1</div>
                <span>Order Review</span>
            </div>
            <div class="step">
                <div class="step-number">2</div>
                <span>Payment</span>
            </div>
            <div class="step">
                <div class="step-number">3</div>
                <span>Confirmation</span>
            </div>
        </div>

        <form action="payment.jsp" method="post" id="checkoutForm">
            <div class="checkout-grid">
                
                <!-- Shipping Information -->
                <div class="checkout-section">
                    <h3 class="section-title">Shipping Information</h3>
                    <p class="info-text">Please verify your shipping details</p>
                    
                    <div class="form-group">
                        <label>Full Name *</label>
                        <input type="text" name="fullName" value="<%= customer.getFirstName() %> <%= customer.getLastName() %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Email *</label>
                        <input type="email" name="email" value="<%= customer.getEmail() %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Phone *</label>
                        <input type="tel" name="phone" value="<%= customer.getPhone() != null ? customer.getPhone() : "" %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Shipping Address *</label>
                        <textarea name="address" rows="3" required><%= customer.getFullAddress() != null ? customer.getFullAddress() : "" %></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label>City *</label>
                        <input type="text" name="city" value="<%= customer.getCity() != null ? customer.getCity() : "" %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Country *</label>
                        <input type="text" name="country" value="<%= customer.getCountry() != null ? customer.getCountry() : "" %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Additional Notes</label>
                        <textarea name="notes" rows="2" placeholder="Delivery instructions, etc."></textarea>
                    </div>
                </div>

                <!-- Order Summary -->
                <div class="checkout-section">
                    <h3 class="section-title">Order Summary</h3>
                    
                    <div class="order-summary">
                        <%
                            for (CartItem item : cart.values()) {
                        %>
                            <div class="order-item">
                                <div class="item-details">
                                    <div class="item-name"><%= item.getProductName() %></div>
                                    <div class="item-qty">Quantity: <%= item.getQuantity() %></div>
                                </div>
                                <div class="item-price">$<%= String.format("%.2f", item.getSubtotal()) %></div>
                            </div>
                        <%
                            }
                        %>
                        
                        <div class="total-row">
                            <div class="total-label">Total</div>
                            <div class="total-amount">$<%= String.format("%.2f", grandTotal) %></div>
                        </div>
                    </div>

                    <button type="submit" class="btn-checkout">
                        Proceed to Payment
                    </button>

                    <a href="cart.jsp" class="back-link">
                        <i class="fas fa-arrow-left"></i> Back to Cart
                    </a>
                </div>

            </div>
        </form>
    </div>

</body>
</html>