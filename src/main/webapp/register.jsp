<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Luxaura | Create Your Account</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-accent: #E0A39A; /* Rose Gold */
            --bg-light: #FBF7F6; /* Champagne */
            --dark-text: #2D2D2D;
            --white: #ffffff;
            --border: #E8E1DF;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-light);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 40px 20px;
            color: var(--dark-text);
        }

        .form-container {
            background: var(--white);
            padding: 45px;
            border-radius: 4px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.05);
            width: 100%;
            max-width: 750px;
            border-top: 6px solid var(--primary-accent);
        }

        h2 {
            font-family: 'Playfair Display', serif;
            text-align: center;
            margin-bottom: 8px;
            font-size: 2.2rem;
            letter-spacing: 1px;
        }

        .subtitle {
            display: block;
            text-align: center;
            font-size: 0.8rem;
            color: #888;
            text-transform: uppercase;
            letter-spacing: 3px;
            margin-bottom: 35px;
        }

        .grid-form {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .full-width {
            grid-column: span 2;
        }

        label {
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #555;
        }

        input, select, textarea {
            padding: 12px;
            border: 1px solid var(--border);
            border-radius: 2px;
            font-size: 0.95rem;
            font-family: 'Inter', sans-serif;
            background: #FAFAFA;
            transition: 0.3s;
        }

        input:focus, textarea:focus {
            outline: none;
            border-color: var(--primary-accent);
            background: var(--white);
            box-shadow: 0 0 10px rgba(224, 163, 154, 0.1);
        }

        .role-selection {
            display: flex;
            gap: 25px;
            margin-top: 5px;
        }

        .role-option {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            text-transform: capitalize;
            font-weight: 400;
            font-size: 0.9rem;
        }

        input[type="radio"] {
            accent-color: var(--primary-accent);
        }

        .submit-btn {
            grid-column: span 2;
            background: var(--dark-text);
            color: var(--white);
            padding: 16px;
            border: none;
            border-radius: 2px;
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            cursor: pointer;
            transition: 0.4s;
            margin-top: 15px;
        }

        .submit-btn:hover {
            background: var(--primary-accent);
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(224, 163, 154, 0.3);
        }

        .register-link {
            text-align: center;
            margin-top: 25px;
            font-size: 0.85rem;
            color: #777;
        }

        .register-link a {
            color: var(--primary-accent);
            text-decoration: none;
            font-weight: 600;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            text-decoration: none;
            color: #bbb;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: 0.3s;
        }

        .back-link:hover {
            color: var(--dark-text);
        }

        /* Alert messages */
        .alert {
            padding: 15px;
            border-radius: 2px;
            margin-bottom: 25px;
            font-size: 0.85rem;
            grid-column: span 2;
            border-left: 4px solid;
        }

        .alert-error {
            background-color: #fff5f5;
            color: #d9534f;
            border-color: #d9534f;
        }

        .alert-success {
            background-color: #f6fff6;
            color: #2e7d32;
            border-color: #2e7d32;
        }

        @media (max-width: 600px) {
            .grid-form { grid-template-columns: 1fr; }
            .full-width { grid-column: span 1; }
            .submit-btn { grid-column: span 1; }
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Luxaura</h2>
    <span class="subtitle">Join Our Exclusive Collection</span>
    
    <form action="register" method="POST" class="grid-form">
        
        <% 
            String errorMessage = (String) request.getAttribute("errorMessage");
            String successMessage = (String) request.getAttribute("successMessage");
            
            if (errorMessage != null) {
        %>
            <div class="alert alert-error"><%= errorMessage %></div>
        <% 
            }
            if (successMessage != null) {
        %>
            <div class="alert alert-success"><%= successMessage %></div>
        <% 
            }
        %>
        
        <div class="form-group">
            <label>First Name</label>
            <input type="text" name="firstName" placeholder="e.g. Elena" required>
        </div>
        <div class="form-group">
            <label>Last Name</label>
            <input type="text" name="lastName" placeholder="e.g. Rossi" required>
        </div>

        <div class="form-group">
            <label>Username</label>
            <input type="text" name="username" placeholder="elena_aura" required>
        </div>
        <div class="form-group">
            <label>Email Address</label>
            <input type="email" name="email" placeholder="elena@example.com" required>
        </div>

        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" placeholder="Min. 8 characters" required>
        </div>
        <div class="form-group">
            <label>Phone Number</label>
            <input type="tel" name="phone" placeholder="+1 555 000 0000" required>
        </div>

        <div class="form-group">
            <label>Country</label>
            <input type="text" name="country" placeholder="Italy" required>
        </div>
        <div class="form-group">
            <label>City</label>
            <input type="text" name="city" placeholder="Milan" required>
        </div>

        <div class="form-group full-width">
            <label>Full Shipping Address</label>
            <textarea name="fullAddress" rows="2" placeholder="Via Montenapoleone, 12, 4th Floor" required></textarea>
        </div>

        <div class="form-group full-width">
            <label>Account Type</label>
            <div class="role-selection">
                <label class="role-option">
                    <input type="radio" name="accountType" value="customer" checked> Customer
                </label>
                <label class="role-option">
                    <input type="radio" name="accountType" value="employee"> Employee
                </label>
            </div>
        </div>

        <button type="submit" class="submit-btn">Create Boutique Account</button>
    </form>
    
    <div class="register-link">
        Already registered? <a href="login.jsp">Sign in here</a>
    </div>
    <a href="home.jsp" class="back-link">Return to Collections</a>
</div>

</body>
</html>