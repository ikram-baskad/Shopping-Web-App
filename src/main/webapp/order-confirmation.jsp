<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.shopping.model.Customer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmed | Luxaura</title>
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

        .confirmation-box {
            background: var(--white);
            padding: 60px 40px;
            border-radius: 12px;
            text-align: center;
            max-width: 500px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.1);
        }

        .success-icon {
            font-size: 4rem;
            color: var(--success);
            margin-bottom: 20px;
            animation: scaleIn 0.5s ease;
        }

        @keyframes scaleIn {
            from { transform: scale(0); }
            to { transform: scale(1); }
        }

        h1 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            margin-bottom: 15px;
        }

        .order-id {
            color: var(--primary-accent);
            font-weight: 600;
            font-size: 1.2rem;
            margin: 20px 0;
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
            margin-top: 30px;
            transition: 0.3s;
        }

        .btn:hover {
            background: var(--primary-accent);
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
    %>

    <div class="confirmation-box">
        <i class="fas fa-check-circle success-icon"></i>
        <h1>Order Confirmed!</h1>
        <p style="color: #888; margin: 15px 0;">Thank you for your purchase, <%= customer.getFirstName() %>!</p>
        <div class="order-id">
            Order #<%= orderId %>
        </div>
        <p style="color: #666; line-height: 1.6;">
            We've received your order and will begin processing it shortly. 
            You'll receive a confirmation email soon.
        </p>
        <a href="products.jsp" class="btn">Continue Shopping</a>
    </div>

</body>
</html>