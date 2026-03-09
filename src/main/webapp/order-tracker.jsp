<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Track Your Order | Luxaura</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-accent: #E0A39A;
            --bg-light: #FBF7F6;
            --dark-text: #2D2D2D;
            --white: #ffffff;
            --border: #E8E1DF;
            --success: #81c784;
            --warning: #ffc107;
            --info: #64b5f6;
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

        .tracker-container {
            max-width: 800px;
            margin: 4rem auto;
            padding: 0 2rem;
        }

        .tracker-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .tracker-header h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            margin-bottom: 10px;
        }

        .tracker-header p {
            color: #888;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .search-section {
            background: var(--white);
            padding: 40px;
            border-radius: 12px;
            border: 1px solid var(--border);
            margin-bottom: 30px;
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

        .form-group input {
            width: 100%;
            padding: 14px;
            border: 1px solid var(--border);
            border-radius: 4px;
            font-family: 'Inter', sans-serif;
            font-size: 1rem;
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--primary-accent);
        }

        .btn-track {
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
            margin-top: 10px;
        }

        .btn-track:hover {
            background: var(--primary-accent);
        }

        .result-section {
            background: var(--white);
            padding: 40px;
            border-radius: 12px;
            border: 1px solid var(--border);
            display: none;
        }

        .result-section.show {
            display: block;
            animation: fadeIn 0.5s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .order-info {
            border-bottom: 2px solid var(--border);
            padding-bottom: 20px;
            margin-bottom: 30px;
        }

        .order-info h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            margin-bottom: 15px;
        }

        .order-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-top: 20px;
        }

        .detail-item {
            padding: 15px;
            background: var(--bg-light);
            border-radius: 4px;
        }

        .detail-label {
            font-size: 0.75rem;
            color: #666;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 5px;
        }

        .detail-value {
            font-size: 1rem;
            font-weight: 600;
            color: var(--dark-text);
        }

        .status-timeline {
            margin: 40px 0;
        }

        .timeline-item {
            display: flex;
            align-items: flex-start;
            gap: 20px;
            margin-bottom: 30px;
            position: relative;
        }

        .timeline-item:not(:last-child)::after {
            content: '';
            position: absolute;
            left: 19px;
            top: 40px;
            width: 2px;
            height: calc(100% + 10px);
            background: var(--border);
        }

        .timeline-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            font-size: 1.2rem;
            z-index: 1;
            background: var(--white);
            border: 3px solid var(--border);
            color: #999;
        }

        .timeline-item.active .timeline-icon {
            background: var(--primary-accent);
            border-color: var(--primary-accent);
            color: white;
        }

        .timeline-item.completed .timeline-icon {
            background: var(--success);
            border-color: var(--success);
            color: white;
        }

        .timeline-item.active::after {
            background: var(--primary-accent);
        }

        .timeline-content {
            flex: 1;
            padding-top: 5px;
        }

        .timeline-title {
            font-weight: 600;
            font-size: 1.1rem;
            margin-bottom: 5px;
            color: var(--dark-text);
        }

        .timeline-item.active .timeline-title {
            color: var(--primary-accent);
        }

        .timeline-item.completed .timeline-title {
            color: var(--success);
        }

        .timeline-date {
            font-size: 0.85rem;
            color: #666;
        }

        .timeline-description {
            font-size: 0.9rem;
            color: #888;
            margin-top: 8px;
        }

        .status-badge {
            display: inline-block;
            padding: 8px 20px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .status-prepared {
            background: #fff3cd;
            color: #856404;
        }

        .status-preparation {
            background: #cfe2ff;
            color: #084298;
        }

        .status-shipped {
            background: #d1e7dd;
            color: #0f5132;
        }

        .alert {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: none;
        }

        .alert.show {
            display: block;
        }

        .alert.error {
            background: #f8d7da;
            color: #842029;
            border: 1px solid #f5c2c7;
        }

        .alert i {
            margin-right: 10px;
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
    </style>
</head>
<body>

    <nav>
        <div class="nav-container">
            <a href="home.jsp" class="logo">LUX<span>AURA</span></a>
        </div>
    </nav>

    <div class="tracker-container">
        <div class="tracker-header">
            <h2>Track Your Order</h2>
            <p>Enter your order details to track your shipment</p>
        </div>

        <!-- Search Form -->
        <div class="search-section">
            <form id="trackingForm">
                <div class="form-group">
                    <label>Order ID *</label>
                    <input type="number" id="orderId" name="orderId" placeholder="Enter your order number" required>
                </div>

                <div class="form-group">
                    <label>Email Address *</label>
                    <input type="email" id="email" name="email" placeholder="Enter your email address" required>
                </div>

                <button type="submit" class="btn-track">
                    <i class="fas fa-search"></i> Track Order
                </button>
            </form>
        </div>

        <!-- Alert Message -->
        <div id="alertMessage" class="alert error">
            <i class="fas fa-exclamation-circle"></i>
            <span id="alertText"></span>
        </div>

        <!-- Results Section -->
        <div id="resultSection" class="result-section">
            <div class="order-info">
                <h3>Order #<span id="displayOrderId"></span></h3>
                <span id="statusBadge" class="status-badge"></span>

                <div class="order-details">
                    <div class="detail-item">
                        <div class="detail-label">Order Date</div>
                        <div class="detail-value" id="orderDate"></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Customer</div>
                        <div class="detail-value" id="customerName"></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Total Amount</div>
                        <div class="detail-value" id="totalAmount"></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Days Since Order</div>
                        <div class="detail-value" id="daysSince"></div>
                    </div>
                </div>
            </div>

            <!-- Timeline -->
            <div class="status-timeline" id="timeline">
                <!-- Timeline will be populated by JavaScript -->
            </div>

            <center>
                <a href="home.jsp" class="back-link">
                    <i class="fas fa-arrow-left"></i> Back to Home
                </a>
            </center>
        </div>
    </div>

    <script>
        document.getElementById('trackingForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const orderId = document.getElementById('orderId').value;
            const email = document.getElementById('email').value;
            
            console.log('Tracking order:', orderId, 'for email:', email);
            
            // Hide previous results and alerts
            document.getElementById('resultSection').classList.remove('show');
            document.getElementById('alertMessage').classList.remove('show');
            
            // Send request to servlet
            fetch('TrackOrderServlet?orderId=' + orderId + '&email=' + encodeURIComponent(email))
                .then(response => response.json())
                .then(data => {
                    console.log('Response:', data);
                    
                    if (data.success) {
                        displayOrderTracking(data);
                    } else {
                        showAlert(data.error || 'Order not found. Please check your details.');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showAlert('Failed to track order. Please try again.');
                });
        });

        function displayOrderTracking(data) {
            // Populate order details
            document.getElementById('displayOrderId').textContent = data.orderId;
            document.getElementById('orderDate').textContent = formatDate(data.orderDate);
            document.getElementById('customerName').textContent = data.customerName;
            document.getElementById('totalAmount').textContent = '$' + parseFloat(data.totalAmount).toFixed(2);
            document.getElementById('daysSince').textContent = data.daysSinceOrder + ' day(s)';
            
            // Set status badge
            const statusBadge = document.getElementById('statusBadge');
            statusBadge.textContent = data.status;
            statusBadge.className = 'status-badge status-' + data.status.toLowerCase().replace(' ', '-');
            
            // Build timeline
            buildTimeline(data.status, data.orderDate, data.daysSinceOrder);
            
            // Show results
            document.getElementById('resultSection').classList.add('show');
        }

        function buildTimeline(status, orderDate, daysSince) {
            const timeline = document.getElementById('timeline');
            const orderDateObj = new Date(orderDate);
            
            let timelineHTML = '';
            
            // Step 1: Prepared (< 1 day)
            const step1Class = daysSince < 1 ? 'active' : 'completed';
            const step1Date = formatDate(orderDate);
            timelineHTML += `
                <div class="timeline-item ${step1Class}">
                    <div class="timeline-icon">
                        <i class="fas fa-check"></i>
                    </div>
                    <div class="timeline-content">
                        <div class="timeline-title">Prepared</div>
                        <div class="timeline-date">${step1Date}</div>
                        <div class="timeline-description">Your order has been received and confirmed.</div>
                    </div>
                </div>
            `;
            
            // Step 2: In Preparation (1-2 days)
            const step2Class = daysSince >= 1 && daysSince < 2 ? 'active' : daysSince >= 2 ? 'completed' : '';
            const step2Date = daysSince >= 1 ? formatDate(addDays(orderDateObj, 1)) : 'Pending';
            timelineHTML += `
                <div class="timeline-item ${step2Class}">
                    <div class="timeline-icon">
                        <i class="fas fa-box"></i>
                    </div>
                    <div class="timeline-content">
                        <div class="timeline-title">In Preparation</div>
                        <div class="timeline-date">${step2Date}</div>
                        <div class="timeline-description">Your order is being carefully prepared for shipment.</div>
                    </div>
                </div>
            `;
            
            // Step 3: Shipped (> 2 days)
            const step3Class = daysSince >= 2 ? 'active' : '';
            const step3Date = daysSince >= 2 ? formatDate(addDays(orderDateObj, 2)) : 'Pending';
            timelineHTML += `
                <div class="timeline-item ${step3Class}">
                    <div class="timeline-icon">
                        <i class="fas fa-shipping-fast"></i>
                    </div>
                    <div class="timeline-content">
                        <div class="timeline-title">Shipped</div>
                        <div class="timeline-date">${step3Date}</div>
                        <div class="timeline-description">Your order has been shipped and is on its way to you.</div>
                    </div>
                </div>
            `;
            
            timeline.innerHTML = timelineHTML;
        }

        function showAlert(message) {
            document.getElementById('alertText').textContent = message;
            document.getElementById('alertMessage').classList.add('show');
        }

        function formatDate(dateString) {
            if (!dateString || dateString === 'Pending') return dateString;
            const date = new Date(dateString);
            const options = { year: 'numeric', month: 'long', day: 'numeric', hour: '2-digit', minute: '2-digit' };
            return date.toLocaleDateString('en-US', options);
        }

        function addDays(date, days) {
            const result = new Date(date);
            result.setDate(result.getDate() + days);
            return result;
        }
    </script>

</body>
</html>