<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Luxaura | Boutique Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-accent: #E0A39A; /* Rose Gold */
            --secondary-accent: #D4AF37; /* Gold */
            --bg-light: #FBF7F6; /* Champagne */
            --dark-text: #2D2D2D;
            --white: #ffffff;
            --error: #d9534f;
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
            color: var(--dark-text);
        }

        .login-container {
            background: var(--white);
            padding: 3.5rem 3rem;
            border-radius: 4px; /* Sharp edges for luxury look */
            box-shadow: 0 20px 50px rgba(0,0,0,0.05);
            width: 100%;
            max-width: 420px;
            text-align: center;
            border-top: 6px solid var(--primary-accent);
        }

        .login-container h2 {
            font-family: 'Playfair Display', serif;
            margin-bottom: 0.5rem;
            font-size: 2.4rem;
            font-weight: 700;
            letter-spacing: 2px;
            color: var(--dark-text);
        }

        .subtitle {
            font-size: 0.8rem;
            color: #888;
            text-transform: uppercase;
            letter-spacing: 3px;
            margin-bottom: 2.5rem;
            display: block;
        }

        .form-group {
            margin-bottom: 1.5rem;
            text-align: left;
            position: relative;
        }

        label {
            display: block;
            margin-bottom: 0.6rem;
            font-weight: 600;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #555;
        }

        .input-wrapper {
            position: relative;
        }

        .input-wrapper i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary-accent);
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 0.9rem 1rem 0.9rem 2.8rem;
            border: 1px solid #e1e1e1;
            border-radius: 2px;
            font-size: 0.95rem;
            transition: all 0.3s;
            font-family: 'Inter', sans-serif;
        }

        input:focus {
            outline: none;
            border-color: var(--primary-accent);
            box-shadow: 0 0 10px rgba(224, 163, 154, 0.1);
        }

        /* Account Type Styling */
        .account-type {
            display: flex;
            gap: 25px;
            justify-content: center;
            margin-top: 0.5rem;
            padding: 10px 0;
        }

        .account-type label {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            font-weight: 400;
            text-transform: capitalize;
            letter-spacing: 0;
            font-size: 0.9rem;
        }

        .account-type input[type="radio"] {
            accent-color: var(--primary-accent);
            cursor: pointer;
        }

        .btn-login {
            width: 100%;
            padding: 1.1rem;
            border: none;
            background: var(--dark-text);
            color: var(--white);
            font-size: 0.9rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 2px;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 1.5rem;
        }

        .btn-login:hover {
            background: var(--primary-accent);
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(224, 163, 154, 0.3);
        }

        .register-link {
            margin-top: 2rem;
            color: #777;
            font-size: 0.85rem;
        }

        .register-link a {
            color: var(--primary-accent);
            text-decoration: none;
            font-weight: 600;
            border-bottom: 1px solid transparent;
            transition: 0.3s;
        }

        .register-link a:hover {
            border-bottom-color: var(--primary-accent);
        }

        .back-home {
            display: inline-block;
            margin-top: 2.5rem;
            color: #bbb;
            text-decoration: none;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: 0.3s;
        }

        .back-home:hover {
            color: var(--dark-text);
        }

        /* Alert messages */
        .alert {
            padding: 12px;
            border-radius: 2px;
            margin-bottom: 20px;
            font-size: 0.85rem;
            text-align: left;
            border-left: 4px solid;
        }

        .alert-error {
            background-color: #fff5f5;
            color: var(--error);
            border-color: var(--error);
        }

        .alert-success {
            background-color: #f6fff6;
            color: #2e7d32;
            border-color: #2e7d32;
        }
    </style>
</head>
<body>

    <div class="login-container">
        <h2>Luxaura</h2>
        <span class="subtitle">Client Boutique Login</span>
        
        <% 
            String errorMessage = (String) request.getAttribute("errorMessage");
            String successParam = request.getParameter("success");
            
            if (errorMessage != null) {
        %>
            <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> <%= errorMessage %></div>
        <% 
            }
            if ("true".equals(successParam)) {
        %>
            <div class="alert alert-success"><i class="fas fa-check-circle"></i> Welcome to Luxaura. Please login.</div>
        <% 
            }
        %>
        
        <form action="login" method="POST">
            <div class="form-group">
                <label for="username">Username</label>
                <div class="input-wrapper">
                    <i class="fas fa-user"></i>
                    <input type="text" id="username" name="username" placeholder="Enter your username" required>
                </div>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <div class="input-wrapper">
                    <i class="fas fa-lock"></i>
                    <input type="password" id="password" name="password" placeholder="Enter your password" required>
                </div>
            </div>

            <div class="form-group">
                <label>Account Selection</label>
                <div class="account-type">
                    <label>
                        <input type="radio" name="accountType" value="customer" checked> Customer
                    </label>
                    <label>
                        <input type="radio" name="accountType" value="employee"> Employee
                    </label>
                </div>
            </div>

            <button type="submit" class="btn-login">Sign In</button>
        </form>

        <div class="register-link">
            New to the boutique? <a href="register.jsp">Create Account</a>
        </div>

        <a href="home.jsp" class="back-home"><i class="fas fa-arrow-left"></i> Return to Collections</a>
    </div>

</body>
</html>