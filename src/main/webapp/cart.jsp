<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="com.shopping.model.CartItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Boutique Bag | Luxaura</title>
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

        .cart-container {
            max-width: 1000px;
            margin: 4rem auto;
            padding: 0 2rem;
        }

        .cart-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .cart-header h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            margin-bottom: 10px;
        }

        .cart-table {
            width: 100%;
            border-collapse: collapse;
            background: var(--white);
            box-shadow: 0 10px 30px rgba(0,0,0,0.03);
            border: 1px solid var(--border);
        }

        .cart-table th {
            background: #fdfdfd;
            padding: 20px;
            text-align: left;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 1px;
            border-bottom: 1px solid var(--border);
        }

        .cart-table td {
            padding: 25px 20px;
            border-bottom: 1px solid var(--border);
            vertical-align: middle;
        }

        .product-name {
            font-family: 'Playfair Display', serif;
            font-weight: 700;
            font-size: 1.1rem;
            color: var(--dark-text);
        }

        .price-tag { 
            color: var(--primary-accent); 
            font-weight: 600;
            font-size: 1.1rem;
        }

        .qty-controls {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .qty-btn {
            width: 30px;
            height: 30px;
            border: 1px solid var(--border);
            background: var(--white);
            cursor: pointer;
            font-size: 1rem;
            transition: 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .qty-btn:hover {
            background: var(--primary-accent);
            color: var(--white);
            border-color: var(--primary-accent);
        }

        .qty-btn:disabled {
            opacity: 0.3;
            cursor: not-allowed;
        }

        .qty-input {
            width: 60px;
            text-align: center;
            padding: 5px;
            border: 1px solid var(--border);
            background: var(--bg-light);
            font-weight: 600;
            font-size: 1rem;
        }

        .qty-input:focus {
            outline: none;
            border-color: var(--primary-accent);
        }

        .cart-summary {
            margin-top: 30px;
            background: var(--white);
            padding: 30px;
            border: 1px solid var(--border);
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 40px;
        }

        .grand-total-label {
            text-transform: uppercase;
            font-size: 0.8rem;
            letter-spacing: 2px;
            color: #888;
        }

        .grand-total-value {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            font-weight: 700;
            color: var(--dark-text);
        }

        .btn-order {
            padding: 18px 45px;
            background: var(--dark-text);
            color: var(--white);
            border: none;
            text-transform: uppercase;
            letter-spacing: 2px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-order:hover {
            background: var(--primary-accent);
        }

        .empty-msg {
            text-align: center;
            padding: 100px 0;
        }

        .empty-msg i { 
            font-size: 4rem;
            color: var(--border); 
            margin-bottom: 20px; 
        }
        
        .back-link {
            color: var(--primary-accent);
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        .btn-remove {
            background: none;
            border: none;
            color: #ff6b6b;
            cursor: pointer;
            font-size: 1.2rem;
            transition: 0.3s;
            padding: 5px 10px;
        }

        .btn-remove:hover {
            color: #ff0000;
            transform: scale(1.2);
        }

        .product-img-small {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 4px;
            border: 1px solid var(--border);
            margin-right: 15px;
        }

        .product-cell {
            display: flex;
            align-items: center;
        }

        .btn-save-cart {
            padding: 12px 30px;
            background: var(--primary-accent);
            color: var(--white);
            border: none;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s;
            font-size: 0.85rem;
        }

        .btn-save-cart:hover {
            background: var(--dark-text);
        }

        .cart-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
        }

        .save-status {
            padding: 8px 16px;
            border-radius: 4px;
            font-size: 0.9rem;
            display: none;
        }

        .save-status.success {
            background: #d4edda;
            color: #155724;
            display: inline-block;
        }

        .save-status.error {
            background: #f8d7da;
            color: #721c24;
            display: inline-block;
        }
    </style>
</head>
<body>

    <nav>
        <div class="nav-container">
            <a href="home.jsp" class="logo">LUX<span>AURA</span></a>
        </div>
    </nav>

    <div class="cart-container">
        <div class="cart-header">
            <h2>Your Selection</h2>
            <p style="text-transform: uppercase; letter-spacing: 2px; font-size: 0.7rem; color: #aaa;">Review your curated pieces</p>
        </div>

        <%
            // Get cart from session
            @SuppressWarnings("unchecked")
            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
            
            double grandTotal = 0.0;
            
            if (cart == null || cart.isEmpty()) {
        %>
                <div class="empty-msg">
                    <i class="fas fa-shopping-bag"></i>
                    <h3 style="margin-bottom: 15px; font-family: 'Playfair Display', serif;">Your bag is empty</h3>
                    <p style="color: #999; margin-bottom: 30px;">Discover our curated collection</p>
                    <a href="products.jsp" class="back-link" style="font-size: 1rem;">
                        <i class="fas fa-arrow-left"></i> Browse Collection
                    </a>
                </div>
        <%
            } else {
        %>
            <table class="cart-table">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Unit Price</th>
                        <th>Quantity</th>
                        <th>Subtotal</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (CartItem item : cart.values()) {
                            double subtotal = item.getSubtotal();
                            grandTotal += subtotal;
                    %>
                        <tr id="cart-row-<%= item.getProductId() %>">
                            <td>
                                <div class="product-cell">
                                    <% if (item.getImageUrl() != null && !item.getImageUrl().isEmpty()) { %>
                                        <img src="<%= item.getImageUrl() %>" alt="<%= item.getProductName() %>" class="product-img-small">
                                    <% } %>
                                    <span class="product-name"><%= item.getProductName() %></span>
                                </div>
                            </td>
                            <td><span class="price-tag">$<%= String.format("%.2f", item.getPrice()) %></span></td>
                            <td>
                                <div class="qty-controls">
                                    <button class="qty-btn" onclick="updateQuantity(<%= item.getProductId() %>, -1)">
                                        <i class="fas fa-minus"></i>
                                    </button>
                                    <input type="number" 
                                           class="qty-input" 
                                           id="qty-<%= item.getProductId() %>" 
                                           value="<%= item.getQuantity() %>" 
                                           min="1" 
                                           max="99"
                                           onchange="updateQuantityDirect(<%= item.getProductId() %>, this.value)"
                                           data-price="<%= item.getPrice() %>">
                                    <button class="qty-btn" onclick="updateQuantity(<%= item.getProductId() %>, 1)">
                                        <i class="fas fa-plus"></i>
                                    </button>
                                </div>
                            </td>
                            <td><span class="price-tag subtotal-<%= item.getProductId() %>">$<%= String.format("%.2f", subtotal) %></span></td>
                            <td>
                                <button class="btn-remove" onclick="removeFromCart(<%= item.getProductId() %>)" title="Remove item">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

            <div class="cart-summary">
                <div>
                    <div class="grand-total-label">Grand Total</div>
                    <div class="grand-total-value" id="grand-total">$<%= String.format("%.2f", grandTotal) %></div>
                </div>
                <button class="btn-order" onclick="location.href='checkout.jsp'">Proceed to Checkout</button>
            </div>
            
            <div class="cart-actions">
                <a href="products.jsp" class="back-link"><i class="fas fa-arrow-left"></i> Continue Browsing</a>
                <div>
                    <span class="save-status" id="save-status"></span>
                    <button class="btn-save-cart" onclick="saveCartToDatabase()">
                        <i class="fas fa-save"></i> Save Cart
                    </button>
                </div>
            </div>
        <%
            }
        %>
    </div>

    <script>
        function updateQuantity(productId, change) {
            const input = document.getElementById('qty-' + productId);
            let newQty = parseInt(input.value) + change;
            
            if (newQty < 1) newQty = 1;
            if (newQty > 99) newQty = 99;
            
            input.value = newQty;
            updateCartItem(productId, newQty);
        }

        function updateQuantityDirect(productId, value) {
            let newQty = parseInt(value);
            
            if (isNaN(newQty) || newQty < 1) {
                newQty = 1;
            }
            if (newQty > 99) {
                newQty = 99;
            }
            
            document.getElementById('qty-' + productId).value = newQty;
            updateCartItem(productId, newQty);
        }

        function updateCartItem(productId, quantity) {
            fetch('${pageContext.request.contextPath}/cart/update', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'productId=' + productId + '&quantity=' + quantity
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Update subtotal for this item
                    const input = document.getElementById('qty-' + productId);
                    const price = parseFloat(input.dataset.price);
                    const subtotal = price * quantity;
                    
                    const subtotalElement = document.querySelector('.subtotal-' + productId);
                    if (subtotalElement) {
                        subtotalElement.textContent = '$' + subtotal.toFixed(2);
                    }

                    // Update grand total
                    const totalElement = document.getElementById('grand-total');
                    if (totalElement && data.newTotal !== undefined) {
                        totalElement.textContent = '$' + data.newTotal.toFixed(2);
                    }
                } else {
                    alert('Failed to update quantity: ' + data.error);
                    location.reload();
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Failed to update quantity. Please try again.');
            });
        }

        function removeFromCart(productId) {
            if (!confirm('Remove this item from your cart?')) {
                return;
            }

            fetch('${pageContext.request.contextPath}/cart/remove?productId=' + productId, {
                method: 'POST'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    const row = document.getElementById('cart-row-' + productId);
                    if (row) {
                        row.remove();
                    }

                    const totalElement = document.getElementById('grand-total');
                    if (totalElement) {
                        totalElement.textContent = '$' + data.newTotal.toFixed(2);
                    }

                    if (data.cartItemCount === 0) {
                        location.reload();
                    }
                } else {
                    alert('Failed to remove item: ' + data.error);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Failed to remove item. Please try again.');
            });
        }

        function saveCartToDatabase() {
            const statusElement = document.getElementById('save-status');
            statusElement.textContent = 'Saving...';
            statusElement.className = 'save-status';
            statusElement.style.display = 'inline-block';

            fetch('${pageContext.request.contextPath}/cart/save', {
                method: 'POST'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    statusElement.textContent = '✓ Cart saved successfully!';
                    statusElement.className = 'save-status success';
                    setTimeout(() => {
                        statusElement.style.display = 'none';
                    }, 3000);
                } else {
                    statusElement.textContent = '✗ Failed to save cart: ' + data.error;
                    statusElement.className = 'save-status error';
                }
            })
            .catch(error => {
                console.error('Error:', error);
                statusElement.textContent = '✗ Failed to save cart. Please try again.';
                statusElement.className = 'save-status error';
            });
        }
    </script>

</body>
</html>