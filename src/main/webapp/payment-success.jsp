<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.shopping.model.Customer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Successful | Luxaura</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-accent: #E0A39A;
            --bg-light: #FBF7F6;
            --dark-text: #2D2D2D;
            --white: #ffffff;
            --success: #81c784;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-light);
            color: var(--dark-text);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .success-box {
            background: var(--white);
            padding: 60px 50px;
            border-radius: 12px;
            text-align: center;
            max-width: 600px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.1);
            border: 2px solid var(--success);
        }

        .success-icon {
            width: 80px;
            height: 80px;
            background: var(--success);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 30px;
            animation: scaleIn 0.5s ease;
        }

        .success-icon i {
            font-size: 3rem;
            color: white;
        }

        @keyframes scaleIn {
            from { transform: scale(0); }
            to { transform: scale(1); }
        }

        h1 {
            font-family: 'Playfair Display', serif;
            font-size: 2.2rem;
            margin-bottom: 15px;
            color: var(--success);
        }

        .order-id {
            color: var(--primary-accent);
            font-weight: 600;
            font-size: 1.1rem;
            margin: 20px 0;
        }

        .message-box {
            background: #f0f9f0;
            padding: 25px;
            border-radius: 8px;
            margin: 30px 0;
            border-left: 4px solid var(--success);
        }

        .message-box p {
            line-height: 1.8;
            color: #2d5016;
            font-size: 1rem;
        }

        .message-box strong {
            color: var(--dark-text);
            font-size: 1.1rem;
        }

        .shipping-info {
            text-align: left;
            background: var(--bg-light);
            padding: 20px;
            border-radius: 8px;
            margin: 25px 0;
        }

        .shipping-info h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1.2rem;
            margin-bottom: 15px;
            color: var(--dark-text);
        }

        .shipping-info p {
            margin: 8px 0;
            font-size: 0.95rem;
            color: #666;
        }

        .shipping-info strong {
            color: var(--dark-text);
        }

        .btn {
            display: inline-block;
            padding: 15px 40px;
            background: var(--dark-text);
            color: var(--white);
            text-decoration: none;
            text-transform: uppercase;
            letter-spacing: 2px;
            font-weight: 600;
            margin: 15px 10px;
            transition: 0.3s;
            border-radius: 4px;
            font-size: 0.85rem;
        }

        .btn:hover {
            background: var(--primary-accent);
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

        .icon-row {
            display: flex;
            justify-content: center;
            gap: 40px;
            margin: 30px 0;
        }

        .info-item {
            text-align: center;
        }

        .info-item i {
            font-size: 2rem;
            color: var(--primary-accent);
            margin-bottom: 10px;
        }

        .info-item p {
            font-size: 0.85rem;
            color: #666;
        }
    </style>
</head>
<body>

    <%
        String orderId = request.getParameter("orderId");
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (orderId == null || customer == null) {
            response.sendRedirect("products.jsp");
            return;
        }

        // Get shipping info from session
        String fullName = (String) session.getAttribute("shippingFullName");
        String address = (String) session.getAttribute("shippingAddress");
        String city = (String) session.getAttribute("shippingCity");
        String country = (String) session.getAttribute("shippingCountry");
    %>

    <div class="success-box">
        <div class="success-icon">
            <i class="fas fa-check"></i>
        </div>
        
        <h1>Payment Successful!</h1>
        <p style="color: #888; font-size: 1.05rem;">Thank you for your purchase, <%= customer.getFirstName() %>!</p>
        
        <div class="order-id">
            Order #<%= orderId %>
        </div>

        <div class="message-box">
            <p>
                <strong><i class="fas fa-shipping-fast"></i> Your order will be shipped in 2 working days.</strong>
            </p>
            <p style="margin-top: 15px;">
                We've received your order and payment has been confirmed. 
                Your items will be carefully packaged and dispatched within 2 business days.
                You'll receive a tracking number via email once your order ships.
            </p>
        </div>

        <div class="shipping-info">
            <h3><i class="fas fa-map-marker-alt"></i> Shipping To:</h3>
            <p><strong>Name:</strong> <%= fullName != null ? fullName : customer.getFirstName() + " " + customer.getLastName() %></p>
            <p><strong>Address:</strong> <%= address != null ? address : customer.getFullAddress() %></p>
            <p><strong>City:</strong> <%= city != null ? city : customer.getCity() %></p>
            <p><strong>Country:</strong> <%= country != null ? country : customer.getCountry() %></p>
        </div>

        <div class="icon-row">
            <div class="info-item">
                <i class="fas fa-box"></i>
                <p>Order<br>Confirmed</p>
            </div>
            <div class="info-item">
                <i class="fas fa-truck"></i>
                <p>Ships in<br>2 Days</p>
            </div>
            <div class="info-item">
                <i class="fas fa-envelope"></i>
                <p>Email<br>Sent</p>
            </div>
        </div>

        <div style="margin-top: 40px;">
        		<a href="order-tracker.jsp" class="btn">Track Order</a>
            <a href="products.jsp" class="btn">Continue Shopping</a>
            <a href="home.jsp" class="btn btn-secondary">Back to Home</a>
        </div>

        <p style="margin-top: 30px; font-size: 0.85rem; color: #999;">
            Questions? Contact us at <a href="support.jsp" style="color: var(--primary-accent); text-decoration: none;">Support</a>
        </p>
    </div>

</body>
</html>