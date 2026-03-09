<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
<%@ page import="com.shopping.model.Customer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <title>Aura Accents | Fine Jewelry & Accessories</title>
    <style>
        :root {
            --primary-accent: #E0A39A; /* Rose Gold */
            --secondary-accent: #D4AF37; /* Gold */
            --bg-light: #FBF7F6; /* Champagne */
            --dark-text: #2D2D2D;
            --white: #ffffff;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Playfair Display', 'Segoe UI', serif;
            line-height: 1.6;
            color: var(--dark-text);
            background-color: var(--white);
        }

        /* Navigation */
        nav {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 1.2rem 0;
            position: sticky;
            top: 0;
            z-index: 1000;
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

        .nav-actions {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .user-greeting {
            color: var(--dark-text);
            font-size: 0.9rem;
            font-weight: 400;
        }

        .user-greeting strong {
            color: var(--primary-accent);
            font-weight: 600;
        }

        .btn {
            padding: 0.6rem 1.5rem;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
            text-transform: uppercase;
            font-size: 0.8rem;
            text-decoration: none;
            display: inline-block;
            border: none;
        }

        .btn-primary {
            background: var(--dark-text);
            color: var(--white);
        }

        .btn-primary:hover {
            background: var(--primary-accent);
            transform: translateY(-2px);
        }

        .btn-secondary {
            background: transparent;
            color: var(--dark-text);
            border: 1px solid var(--dark-text);
        }

        .btn-secondary:hover {
            background: var(--dark-text);
            color: var(--white);
        }

        .btn-icon {
            background: transparent;
            color: var(--dark-text);
            padding: 0.6rem 1rem;
            font-size: 1.2rem;
            border: 1px solid var(--dark-text);
        }

        .btn-icon:hover {
            background: var(--primary-accent);
            color: var(--white);
            border-color: var(--primary-accent);
        }

        /* Hero Section */
        .hero {
            background: linear-gradient(rgba(0, 0, 0, 0.2), rgba(0, 0, 0, 0.2)), 
                        url('https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?auto=format&fit=crop&w=1500'); 
            background-size: cover;
            background-position: center;
            height: 75vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: var(--white);
        }

        .hero h1 { 
            font-size: 4rem; 
            margin-bottom: 1rem; 
            letter-spacing: 5px; 
            text-shadow: 2px 2px 10px rgba(0,0,0,0.3); 
        }
        
        .hero p { 
            font-size: 1.4rem; 
            margin-bottom: 2rem; 
            font-style: italic; 
        }

        /* About/Services Section */
        .about { 
            max-width: 1200px; 
            margin: 5rem auto; 
            padding: 0 2rem; 
        }
        
        .about h2 { 
            text-align: center; 
            font-size: 2.2rem; 
            margin-bottom: 3rem; 
            text-transform: uppercase; 
            letter-spacing: 2px; 
        }

        .about-content { 
            display: grid; 
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); 
            gap: 2rem; 
        }
        
        .service-card { 
            padding: 3rem 2rem; 
            text-align: center; 
            background: var(--bg-light); 
            border-radius: 8px; 
            transition: 0.4s; 
        }
        
        .service-card:hover { 
            transform: translateY(-5px); 
            box-shadow: 0 15px 30px rgba(224, 163, 154, 0.15); 
        }
        
        .service-icon { 
            font-size: 2.5rem; 
            color: var(--primary-accent); 
            margin-bottom: 1.5rem; 
        }

        /* Featured Accessories Grid */
        .featured { 
            background: #fff; 
            padding: 5rem 2rem; 
        }
        
        .products-grid { 
            max-width: 1200px; 
            margin: 0 auto; 
            display: grid; 
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); 
            gap: 3rem; 
        }
        
        .product-card { 
            background: white; 
            transition: 0.4s; 
        }
        
        .product-image { 
            width: 100%; 
            height: 400px; 
            overflow: hidden; 
            background: #fdfdfd; 
            position: relative; 
        }
        
        .product-image img { 
            width: 100%; 
            height: 100%; 
            object-fit: cover; 
            transition: 0.8s; 
        }
        
        .product-card:hover .product-image img { 
            transform: scale(1.1); 
        }

        .product-info { 
            padding: 1.5rem; 
            text-align: center; 
        }
        
        .product-info h3 { 
            font-size: 1.2rem; 
            letter-spacing: 1px; 
            margin-bottom: 0.5rem; 
        }
        
        .product-price { 
            font-size: 1.3rem; 
            color: var(--primary-accent); 
            font-weight: 600; 
            margin-bottom: 1rem; 
        }
        
        .product-badge {
            position: absolute; 
            top: 15px; 
            right: 15px; 
            background: var(--primary-accent);
            color: white; 
            padding: 0.5rem 1.2rem; 
            font-size: 0.7rem; 
            text-transform: uppercase; 
            z-index: 5;
        }

        /* Footer */
        footer { 
            background: var(--dark-text); 
            color: var(--white); 
            padding: 5rem 2rem 2rem; 
        }
        
        .footer-content { 
            max-width: 1200px; 
            margin: 0 auto; 
            display: grid; 
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); 
            gap: 4rem; 
        }
        
        .footer-section h3 { 
            color: var(--primary-accent); 
            margin-bottom: 2rem; 
            font-size: 1rem; 
            text-transform: uppercase; 
            letter-spacing: 2px; 
        }
        
        .footer-section ul { 
            list-style: none; 
        }
        
        .footer-section ul li { 
            margin-bottom: 0.8rem; 
        }
        
        .footer-section a { 
            color: #bbb; 
            text-decoration: none; 
            font-size: 0.9rem; 
            transition: 0.3s; 
        }
        
        .footer-section a:hover { 
            color: var(--primary-accent); 
            padding-left: 5px; 
        }
        
        .footer-bottom { 
            text-align: center; 
            margin-top: 5rem; 
            padding-top: 2rem; 
            border-top: 1px solid #444; 
            font-size: 0.75rem; 
            color: #777; 
            letter-spacing: 1px; 
        }

        .cart-badge { 
            background: var(--primary-accent); 
            color: white; 
            border-radius: 50%; 
            padding: 0.2rem 0.5rem; 
            font-size: 0.7rem; 
            margin-left: 5px;
        }
    </style>
</head>
<body>

    <nav>
        <div class="nav-container">
            <div class="logo">Lux<span>Aura</span></div>
            <ul class="nav-links">
                <li><a href="home.jsp">Home</a></li>
                <li><a href="products.jsp">Jewelry</a></li>
                <li><a href="#about">Our Story</a></li>
                <li><a href="support">Support</a></li>
                <a href="order-tracker.jsp">Track Order</a>
            </ul>
            
            <%
                Customer loggedInCustomer = (Customer) session.getAttribute("customer");
                if (loggedInCustomer != null) {
            %>
                <!-- User IS logged in -->
                <div class="nav-actions">
                    <span class="user-greeting">
                        Hello, <strong><%= loggedInCustomer.getFirstName() %></strong>
                    </span>
                    <button class="btn btn-icon" onclick="location.href='profile'" title="My Profile">
                        <i class="fas fa-user"></i>
                    </button>
                    <button class="btn btn-icon" onclick="location.href='cart.jsp'" title="Shopping Cart">
                        <i class="fas fa-shopping-bag"></i><span class="cart-badge" id="cartCount">0</span>
                    </button>
                    <button class="btn btn-secondary" onclick="location.href='LogoutServlet'">
                        Logout
                    </button>
                </div>
            <%
                } else {
            %>
                <!-- User is NOT logged in -->
                <div class="nav-actions">
                    <button class="btn btn-secondary" onclick="location.href='login.jsp'">Sign In</button>
                    <button class="btn btn-secondary" onclick="location.href='register.jsp'">Sign Up</button>
                    <button class="btn btn-primary" onclick="location.href='cart.jsp'">
                        <i class="fas fa-shopping-bag"></i><span class="cart-badge" id="cartCount">0</span>
                    </button>
                </div>
            <%
                }
            %>
        </div>
    </nav>

    <section class="hero">
        <div class="hero-content">
            <h1>Elevate Your Aura</h1>
            <p>Fine jewelry & curated accessories for the modern woman</p>
            <button class="btn btn-primary" onclick="location.href='products.jsp'">Explore Collection</button>
        </div>
    </section>

    <section class="about" id="about">
        <h2>The Art of Adornment</h2>
        <div class="about-content">
            <div class="service-card">
                <div class="service-icon"><i class="fas fa-gem"></i></div>
                <h3>Fine Craftsmanship</h3>
                <p>Pieces forged in 18k gold and sterling silver, designed to be passed down.</p>
            </div>
            <div class="service-card">
                <div class="service-icon"><i class="fas fa-magic"></i></div>
                <h3>Timeless Design</h3>
                <p>Beyond trends. We focus on classic silhouettes that enhance your natural glow.</p>
            </div>
            <div class="service-card">
                <div class="service-icon"><i class="fas fa-shield-heart"></i></div>
                <h3>Care & Warranty</h3>
                <p>Every piece includes a lifetime cleaning service and authenticity certification.</p>
            </div>
        </div>
    </section>

    <section class="featured">
        <h2 style="text-align:center; margin-bottom:4rem; text-transform:uppercase; letter-spacing:3px; font-weight:400;">Essential Accessories</h2>
        <div class="products-grid">
            
            <div class="product-card">
                <div class="product-image">
                    <span class="product-badge">New Arrival</span>
                    <img src="images/less.jpg" alt="Gold Necklace">
                </div>
                <div class="product-info">
                    <h3>Gold Necklace</h3>
                    <p>Stellar Link Necklace 18k gold chain</p>
                    <div class="product-price">$450.00</div>
                    <button class="btn btn-primary" style="width:100%" onclick="location.href='products.jsp'">View Collection</button>
                </div>
            </div>

            <div class="product-card">
                <div class="product-image">
                    <span class="product-badge">Best Seller</span>
                    <img src="images/mvn.jpg" alt="Rose Gold Watch">
                </div>
                <div class="product-info">
                    <h3>Horizon Mesh Watch</h3>
                    <p>Minimalist face with Milanese strap</p>
                    <div class="product-price">$210.00</div>
                    <button class="btn btn-primary" style="width:100%" onclick="location.href='products.jsp'">View Collection</button>
                </div>
            </div>

            <div class="product-card">
                <div class="product-image">
                    <img src="https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?auto=format&fit=crop&w=500" alt="Gold Necklace">
                </div>
                <div class="product-info">
                    <h3>Celestial Chain</h3>
                    <p>18k Solid Gold delicate layering chain</p>
                    <div class="product-price">$320.00</div>
                    <button class="btn btn-primary" style="width:100%" onclick="location.href='products.jsp'">View Collection</button>
                </div>
            </div>

        </div>
    </section>

    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h3>LuxAura</h3>
                <p>A boutique destination for those who appreciate the finer details of personal style.</p>
            </div>
            <div class="footer-section">
                <h3>Collections</h3>
                <ul>
                    <li><a href="#">Necklaces & Charms</a></li>
                    <li><a href="#">Rings & Bands</a></li>
                    <li><a href="#">Earrings</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Concierge</h3>
                <ul>
                    <li><a href="#">Shipping & Returns</a></li>
                    <li><a href="#">Sizing Guide</a></li>
                    <li><a href="#">Jewelry Care</a></li>
                    <li><a href="#">Contact Support</a></li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2026 Aura Accents | Defined by Elegance.</p>
        </div>
    </footer>

    <script>
        // Update cart count from session
        function updateCartCount() {
            fetch('${pageContext.request.contextPath}/cart/count')
                .then(response => response.json())
                .then(data => {
                    const badge = document.getElementById('cartCount');
                    if (data.count > 0) {
                        badge.textContent = data.count;
                        badge.style.display = 'inline';
                    } else {
                        badge.textContent = '0';
                    }
                })
                .catch(error => console.error('Error updating cart count:', error));
        }
        
        // Update cart count on page load
        window.onload = function() {
            updateCartCount();
        };
    </script>
</body>
</html>