<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The Collection | Luxaura</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-accent: #E0A39A;
            --secondary-accent: #D4AF37;
            --bg-light: #FBF7F6;
            --dark-text: #2D2D2D;
            --white: #ffffff;
            --border: #E8E1DF;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
 
        body {
            font-family: 'Inter', sans-serif;
            line-height: 1.6;
            color: var(--dark-text);
            background-color: var(--bg-light);
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

        .nav-links a {
            color: var(--dark-text);
            text-decoration: none;
            margin-left: 25px;
            font-weight: 500;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: color 0.3s;
        }

        .nav-links a:hover { color: var(--primary-accent); }

        .catalog-container {
            max-width: 1200px;
            margin: 4rem auto;
            padding: 0 2rem;
        }

        .section-header {
            text-align: center;
            margin-bottom: 5rem;
        }

        .section-header h2 {
            font-family: 'Playfair Display', serif;
            font-size: 3rem;
            color: var(--dark-text);
            margin-bottom: 15px;
        }

        .section-header p {
            color: #888;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 3px;
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 40px;
        }

        .product-card {
            background: var(--white);
            border-radius: 0;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.03);
            transition: all 0.4s ease;
            display: flex;
            flex-direction: column;
            border: 1px solid var(--border);
        }

        .product-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(224, 163, 154, 0.12);
        }

        .product-image-box {
            height: 350px;
            background: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        .product-image-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.8s ease;
        }

        .product-card:hover .product-image-box img {
            transform: scale(1.1);
        }

        .badge {
            position: absolute;
            top: 20px;
            left: 20px;
            background: var(--primary-accent);
            color: white;
            padding: 6px 15px;
            font-size: 0.7rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            z-index: 2;
        }

        .product-info {
            padding: 30px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            text-align: center;
        }

        .product-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.3rem;
            color: var(--dark-text);
            margin-bottom: 12px;
            font-weight: 700;
        }

        .product-desc {
            font-size: 0.9rem;
            color: #777;
            margin-bottom: 25px;
            line-height: 1.6;
            flex-grow: 1;
        }

        .product-pricing {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
        }

        .price-tag {
            font-size: 1.4rem;
            font-weight: 600;
            color: var(--primary-accent);
        }

        .qty-box {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .qty-box label {
            font-size: 0.75rem;
            text-transform: uppercase;
            color: #999;
        }

        .qty-input {
            width: 50px;
            padding: 5px;
            border: 1px solid var(--border);
            text-align: center;
            font-size: 0.9rem;
        }

        .btn-cart {
            width: 100%;
            padding: 16px;
            background: var(--dark-text);
            color: var(--white);
            border: none;
            font-weight: 600;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-cart:hover {
            background: var(--primary-accent);
        }

        .btn-cart:disabled {
            background: #ccc;
            cursor: not-allowed;
        }

        footer {
            background: var(--dark-text);
            color: #888;
            text-align: center;
            padding: 4rem 0;
            margin-top: 5rem;
        }
        
        footer p {
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .loading {
            text-align: center;
            padding: 100px;
            color: #999;
        }

        .cart-badge {
            background: var(--primary-accent);
            color: white;
            border-radius: 50%;
            padding: 2px 8px;
            font-size: 0.7rem;
            margin-left: 5px;
        }
    </style>
</head>
<body>

    <nav>
        <div class="nav-container">
            <a href="home.jsp" class="logo">LUX<span>AURA</span></a>
            <div class="nav-links">
                <a href="home.jsp">Home</a>
                <a href="products.jsp" style="color:var(--primary-accent);">Collections</a>
                <a href="cart.jsp">
                    <i class="fas fa-shopping-bag"></i> Cart
                    <span id="cart-count" class="cart-badge" style="display:none;">0</span>
                </a>
            </div>
        </div>
    </nav>

    <div class="catalog-container">
        <header class="section-header">
            <h2>The Signature Edit</h2>
            <p>Curated accessories for the modern woman</p>
        </header>

        <div class="product-grid" id="product-grid">
            <div class="loading">
                <i class="fas fa-spinner fa-spin" style="font-size: 2rem; color: var(--primary-accent);"></i>
                <p style="margin-top: 20px;">Loading collection...</p>
            </div>
        </div>
    </div>
    
    <footer>
        <p>&copy; 2026 LUXAURA BOUTIQUE | ELEGANCE DEFINED.</p>
    </footer>

    <script>
        let products = [];

        // Load products when page loads
        window.onload = function() {
            loadProducts();
            updateCartBadge();
        };

        function loadProducts() {
            console.log('Loading products from database...');
            
            fetch('${pageContext.request.contextPath}/products')
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Failed to load products');
                    }
                    return response.json();
                })
                .then(data => {
                    console.log('Products loaded:', data);
                    products = data;
                    renderProducts();
                })
                .catch(error => {
                    console.error('Error loading products:', error);
                    document.getElementById('product-grid').innerHTML = 
                        '<div class="loading"><p style="color: #ff6b6b;">Failed to load products. Please refresh the page.</p></div>';
                });
        }

        function renderProducts() {
            const grid = document.getElementById('product-grid');
            
            if (products.length === 0) {
                grid.innerHTML = '<div class="loading"><p>No products available at the moment.</p></div>';
                return;
            }

            let html = '';
            products.forEach((product, index) => {
                const isLowStock = product.stockQuantity < 5;
                const isOutOfStock = product.stockQuantity === 0;
                
                html += `
                    <div class="product-card">
                        <div class="product-image-box">
                            \${index === 0 ? '<span class="badge">Bestseller</span>' : ''}
                            \${isLowStock && !isOutOfStock ? '<span class="badge" style="background:#ff6b6b;">Limited Stock</span>' : ''}
                            \${isOutOfStock ? '<span class="badge" style="background:#000;">Sold Out</span>' : ''}
                            <img src="\${product.imageUrl || 'images/placeholder.jpg'}" alt="\${product.name}">
                        </div>
                        <div class="product-info">
                            <h3 class="product-title">\${product.name}</h3>
                            <p class="product-desc">\${product.description}</p>
                            <div class="product-pricing">
                                <span class="price-tag">$\${product.price.toFixed(2)}</span>
                                \${!isOutOfStock ? `
                                    <div class="qty-box">
                                        <label>Qty:</label>
                                        <input type="number" id="qty_\${product.productId}" value="1" min="1" max="\${Math.min(5, product.stockQuantity)}" class="qty-input">
                                    </div>
                                ` : '<p style="color:#ff6b6b; font-size:0.8rem;">Currently unavailable</p>'}
                            </div>
                            <button class="btn-cart" 
                                    onclick="addToCart(\${product.productId}, '\${escapeQuotes(product.name)}', \${product.price}, 'qty_\${product.productId}', '\${product.imageUrl || ''}')"
                                    \${isOutOfStock ? 'disabled' : ''}>
                                \${isOutOfStock ? 'Out of Stock' : 'Add to Collection'}
                            </button>
                        </div>
                    </div>
                `;
            });
            
            grid.innerHTML = html;
        }

        function escapeQuotes(str) {
            return str.replace(/'/g, "\\'").replace(/"/g, '\\"');
        }

     
        function addToCart(productId, productName, price, qtyInputId, imageUrl) {
            const quantity = parseInt(document.getElementById(qtyInputId).value);
            
            console.log('Adding to cart:', productName, 'Qty:', quantity);
            
            const formData = new URLSearchParams();
            formData.append('productId', productId);
            formData.append('productName', productName);
            formData.append('price', price);
            formData.append('quantity', quantity);
            formData.append('imageUrl', imageUrl);
            
            fetch('${pageContext.request.contextPath}/cart/add', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    console.log(' Added to cart successfully');
                    
              
                    updateCartBadge();
                    
                    // Show success message - FIXED: Escaped $ signs
                    alert('Added to cart!\n\n' + quantity + ' x ' + productName + '\nTotal: $' + (price * quantity).toFixed(2) + '\n\nCart Total: $' + data.cartTotal.toFixed(2));
                    
                    // Reset quantity to 1
                    document.getElementById(qtyInputId).value = 1;
                } else {
                    alert('Failed to add to cart: ' + data.error);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Failed to add to cart. Please try again.');
            });
        }

        
        
        
        function updateCartBadge() {
            fetch('${pageContext.request.contextPath}/cart/count')
                .then(response => response.json())
                .then(data => {
                    const badge = document.getElementById('cart-count');
                    if (data.count > 0) {
                        badge.textContent = data.count;
                        badge.style.display = 'inline';
                    } else {
                        badge.style.display = 'none';
                    }
                })
                .catch(error => console.error('Error updating cart badge:', error));
        }
    </script>

</body>
</html>