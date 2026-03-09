<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>TechStore | Order Summary</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --bg-dark: #121212;
            --card-bg: #1e1e1e;
            --accent-gold: #FFB100;
            --text-white: #ffffff;
            --border: #333333;
        }

        body { 
            font-family: 'Segoe UI', sans-serif; 
            background: var(--bg-dark); 
            color: var(--text-white);
            display: flex; 
            justify-content: center; 
            align-items: center; 
            min-height: 100vh; 
            margin: 0; 
        }

        .box { 
            width: 100%;
            max-width: 500px; 
            background: var(--card-bg); 
            padding: 40px; 
            border-radius: 20px; 
            box-shadow: 0 15px 35px rgba(0,0,0,0.5); 
            border: 1px solid var(--border);
        }

        h2 { 
            color: var(--accent-gold); 
            margin-bottom: 10px; 
            display: flex;
            align-items: center;
            gap: 12px;
        }

        p { color: #aaa; margin-bottom: 25px; }

        .summary-item { 
            display: flex; 
            justify-content: space-between; 
            padding: 12px 0; 
            border-bottom: 1px solid var(--border); 
            font-size: 0.95rem;
        }

        .total-section { 
            font-size: 1.5rem; 
            font-weight: bold; 
            color: var(--accent-gold); 
            margin-top: 30px; 
            display: flex;
            justify-content: space-between;
            border-top: 2px solid var(--accent-gold);
            padding-top: 15px;
        }

        .btn { 
            width: 100%; 
            padding: 18px; 
            background: var(--accent-gold); 
            color: #000; 
            border: none; 
            border-radius: 35px; 
            font-weight: bold; 
            font-size: 1rem;
            cursor: pointer; 
            margin-top: 30px; 
            transition: 0.3s;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .btn:hover { 
            background: #e69f00; 
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 177, 0, 0.3);
        }

        .empty-msg {
            text-align: center;
            padding: 20px;
            color: #777;
        }
    </style>
</head>
<body>

    <div class="box">
        <h2><i class="fas fa-receipt"></i> Order Summary</h2>
        <p>Review your items before payment.</p>
        
        <div id="summaryList">
            </div>

        <div class="total-section">
            <span>Total:</span>
            <span id="finalTotal">$0.00</span>
        </div>

        <button class="btn" onclick="goToPayment()">
            Proceed to Payment <i class="fas fa-arrow-right" style="margin-left: 8px;"></i>
        </button>
    </div>

    <script>
        // Use standard quotes and concatenation to avoid JSP/Tomcat errors
        var cartData = localStorage.getItem('cart');
        var cart = [];
        
        if (cartData) {
            cart = JSON.parse(cartData);
        }

        var total = 0;
        var listContainer = document.getElementById('summaryList');
        var htmlContent = "";

        if (cart.length === 0) {
            htmlContent = "<div class='empty-msg'>Your cart is empty</div>";
        } else {
            for (var i = 0; i < cart.length; i++) {
                var item = cart[i];
                var itemTotal = item.price * item.quantity;
                total += itemTotal;

                htmlContent += "<div class='summary-item'>" +
                    "<span>" + item.name + " (x" + item.quantity + ")</span>" +
                    "<span>$" + itemTotal.toFixed(2) + "</span>" +
                "</div>";
            }
        }

        listContainer.innerHTML = htmlContent;
        document.getElementById('finalTotal').innerText = "$" + total.toFixed(2);

        function goToPayment() {
            if (cart.length === 0) {
                alert("Your cart is empty!");
                return;
            }
            window.location.href = 'payment.jsp';
        }
    </script>
</body>
</html>