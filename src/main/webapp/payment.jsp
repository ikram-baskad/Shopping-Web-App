<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.shopping.model.Customer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment | Luxaura</title>
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

        .payment-container {
            max-width: 600px;
            margin: 4rem auto;
            padding: 0 2rem;
        }

        .payment-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .payment-header h2 {
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

        .step.completed {
            color: #81c784;
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

        .step.completed .step-number {
            background: #81c784;
            border-color: #81c784;
            color: white;
        }

        .payment-section {
            background: var(--white);
            padding: 40px;
            border-radius: 8px;
            border: 1px solid var(--border);
        }

        .security-badge {
            text-align: center;
            padding: 15px;
            background: #f0f9f0;
            border: 1px solid #81c784;
            border-radius: 4px;
            margin-bottom: 30px;
        }

        .security-badge i {
            color: #81c784;
            font-size: 1.5rem;
            margin-bottom: 10px;
        }

        .security-badge p {
            font-size: 0.85rem;
            color: #666;
        }

        .demo-notice {
            background: #fff3cd;
            border: 1px solid #ffc107;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 30px;
            text-align: center;
        }

        .demo-notice i {
            color: #ffc107;
            margin-right: 10px;
        }

        .demo-notice p {
            font-size: 0.9rem;
            color: #856404;
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

        .form-group input, .form-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid var(--border);
            border-radius: 4px;
            font-family: 'Inter', sans-serif;
            font-size: 0.95rem;
        }

        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: var(--primary-accent);
        }

        .form-row {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 15px;
        }

        .card-logos {
            display: flex;
            gap: 10px;
            margin-top: 10px;
            justify-content: flex-end;
        }

        .card-logos i {
            font-size: 2rem;
            color: #999;
        }

        .btn-pay {
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
            margin-top: 20px;
        }

        .btn-pay:hover {
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

        .helper-text {
            font-size: 0.75rem;
            color: #999;
            margin-top: 5px;
        }
    </style>
</head>
<body>

    <%
        Customer customer = (Customer) session.getAttribute("customer");
        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Store shipping info in session
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String country = request.getParameter("country");
        String notes = request.getParameter("notes");

        session.setAttribute("shippingFullName", fullName);
        session.setAttribute("shippingEmail", email);
        session.setAttribute("shippingPhone", phone);
        session.setAttribute("shippingAddress", address);
        session.setAttribute("shippingCity", city);
        session.setAttribute("shippingCountry", country);
        session.setAttribute("shippingNotes", notes);
    %>

    <nav>
        <div class="nav-container">
            <a href="home.jsp" class="logo">LUX<span>AURA</span></a>
        </div>
    </nav>

    <div class="payment-container">
        <div class="payment-header">
            <h2>Secure Payment</h2>
            <p style="text-transform: uppercase; letter-spacing: 2px; font-size: 0.7rem; color: #aaa;">Complete your purchase</p>
        </div>

        <div class="checkout-steps">
            <div class="step completed">
                <div class="step-number"><i class="fas fa-check"></i></div>
                <span>Order Review</span>
            </div>
            <div class="step active">
                <div class="step-number">2</div>
                <span>Payment</span>
            </div>
            <div class="step">
                <div class="step-number">3</div>
                <span>Confirmation</span>
            </div>
        </div>

        <div class="payment-section">
            <div class="security-badge">
                <i class="fas fa-lock"></i>
                <p><strong>Secure Payment</strong> - Your information is encrypted and secure</p>
            </div>

            <div class="demo-notice">
                <i class="fas fa-info-circle"></i>
                <p><strong>DEMO MODE:</strong> This is a demonstration payment page. No real payment will be processed. Use any test card details.</p>
            </div>

            <form action="ProcessPaymentServlet" method="post" id="paymentForm">
                <div class="form-group">
                    <label>Cardholder Name *</label>
                    <input type="text" name="cardholderName" placeholder="John Doe" required>
                </div>

                <div class="form-group">
                    <label>Card Number *</label>
                    <input type="text" name="cardNumber" placeholder="1234 5678 9012 3456" maxlength="19" required pattern="[0-9 ]+">
                    <div class="card-logos">
                        <i class="fab fa-cc-visa"></i>
                        <i class="fab fa-cc-mastercard"></i>
                        <i class="fab fa-cc-amex"></i>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Expiry Date *</label>
                        <input type="text" name="expiryDate" placeholder="MM/YY" maxlength="5" required pattern="[0-9/]+">
                    </div>
                    <div class="form-group">
                        <label>CVV *</label>
                        <input type="text" name="cvv" placeholder="123" maxlength="4" required pattern="[0-9]+">
                        <p class="helper-text">3 or 4 digits on back of card</p>
                    </div>
                </div>

                <div class="form-group">
                    <label>Billing Address</label>
                    <select name="billingOption" id="billingOption" onchange="toggleBillingAddress()">
                        <option value="same">Same as shipping address</option>
                        <option value="different">Use different billing address</option>
                    </select>
                </div>

                <button type="submit" class="btn-pay">
                    <i class="fas fa-lock"></i> Complete Payment
                </button>

                <center>
                    <a href="checkout.jsp" class="back-link">
                        <i class="fas fa-arrow-left"></i> Back to Checkout
                    </a>
                </center>
            </form>
        </div>
    </div>

    <script>
        // Format card number input
        document.querySelector('input[name="cardNumber"]').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\s/g, '');
            let formattedValue = value.match(/.{1,4}/g)?.join(' ') || value;
            e.target.value = formattedValue;
        });

        // Format expiry date
        document.querySelector('input[name="expiryDate"]').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length >= 2) {
                value = value.substring(0, 2) + '/' + value.substring(2, 4);
            }
            e.target.value = value;
        });
    </script>

</body>
</html>