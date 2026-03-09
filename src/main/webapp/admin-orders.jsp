<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.shopping.model.Employee" %>
<%
    // Check if admin is logged in
    Employee admin = (Employee) session.getAttribute("user");
    String userType = (String) session.getAttribute("userType");
    
    if (admin == null || !"employee".equals(userType)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LuxAura | Orders Management</title>
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    <style>
        :root {
            --bg-dark: #1a1a1a;
            --bg-sidebar: #111111;
            --bg-card: #242424;
            --accent-rose: #E0A39A; 
            --accent-gold: #D4AF37;
            --text-white: #ffffff;
            --text-gray: #b0b0b0;
            --border: #333333;
            --danger: #ff6b6b;
            --input-bg: #2a2a2a;
            --success: #81c784;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Playfair Display', serif; }

        body { background-color: var(--bg-dark); color: var(--text-white); display: flex; height: 100vh; overflow: hidden; }

        .sidebar { width: 260px; background-color: var(--bg-sidebar); border-right: 1px solid var(--border); display: flex; flex-direction: column; padding: 24px; }
        .logo { display: flex; align-items: center; gap: 12px; font-size: 1.2rem; font-weight: bold; color: var(--accent-rose); margin-bottom: 48px; text-transform: uppercase; letter-spacing: 2px; cursor: pointer; }

        .nav-btn {
            width: 100%; padding: 14px 16px; margin-bottom: 8px; background: transparent; border: none; color: var(--text-gray);
            text-align: left; border-radius: 8px; cursor: pointer; display: flex; align-items: center; gap: 12px; transition: 0.3s;
            font-family: 'Inter', sans-serif; text-transform: uppercase; font-size: 0.8rem; letter-spacing: 1px; text-decoration: none;
        }
        .nav-btn.active { background-color: var(--accent-rose); color: #000; font-weight: 600; }
        .nav-btn:hover:not(.active) { color: var(--accent-rose); background: rgba(224, 163, 154, 0.1); }

        /* Admin Profile Section */
        .admin-profile {
            margin-top: auto;
            padding-top: 24px;
            border-top: 1px solid var(--border);
        }

        .profile-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
        }

        .profile-avatar {
            width: 48px;
            height: 48px;
            background: var(--accent-rose);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: #000;
            font-weight: bold;
        }

        .profile-info {
            flex: 1;
        }

        .profile-name {
            font-size: 0.95rem;
            font-weight: 600;
            color: var(--text-white);
            margin-bottom: 2px;
        }

        .profile-role {
            font-size: 0.75rem;
            color: var(--text-gray);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .profile-actions {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .profile-btn {
            width: 100%;
            padding: 10px;
            background: transparent;
            border: 1px solid var(--border);
            color: var(--text-gray);
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .profile-btn:hover {
            border-color: var(--accent-rose);
            color: var(--accent-rose);
        }

        .profile-btn.logout {
            border-color: var(--danger);
            color: var(--danger);
        }

        .profile-btn.logout:hover {
            background: var(--danger);
            color: var(--white);
        }

        .main-content { flex: 1; padding: 40px; overflow-y: auto; }
        
        /* Welcome Banner */
        .welcome-banner {
            background: linear-gradient(135deg, var(--bg-card) 0%, #2a2a2a 100%);
            border: 1px solid var(--accent-rose);
            border-radius: 12px;
            padding: 24px 32px;
            margin-bottom: 32px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .welcome-text h2 {
            font-size: 1.8rem;
            margin-bottom: 8px;
            color: var(--accent-rose);
        }

        .welcome-text p {
            color: var(--text-gray);
            font-size: 0.95rem;
        }

        .welcome-icon {
            font-size: 3rem;
            color: var(--accent-rose);
            opacity: 0.3;
        }

        header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 32px; }
        header h1 { font-weight: 400; letter-spacing: 1px; }

        .primary-btn {
            background-color: var(--accent-rose); color: #000; border: none; padding: 12px 24px; border-radius: 4px;
            font-weight: bold; cursor: pointer; transition: 0.3s; text-transform: uppercase; font-size: 0.8rem;
        }
        .primary-btn:hover { background-color: #d89a8e; }

        .table-wrapper { background-color: var(--bg-card); border-radius: 12px; border: 1px solid var(--border); overflow: hidden; }
        table { width: 100%; border-collapse: collapse; }
        th { background-color: #000; padding: 18px; text-align: left; font-size: 0.7rem; color: var(--accent-rose); text-transform: uppercase; letter-spacing: 1.5px; }
        td { padding: 18px; border-bottom: 1px solid var(--border); vertical-align: middle; font-family: 'Inter', sans-serif; font-size: 0.9rem; }
        
        .status-pill {
            padding: 6px 12px; border-radius: 20px; font-size: 0.75rem; text-transform: uppercase;
            font-weight: 600; letter-spacing: 0.5px; display: inline-block;
        }
        .status-shipped { background: rgba(129, 199, 132, 0.15); color: var(--success); border: 1px solid var(--success); }
        .status-processing { background: rgba(212, 175, 55, 0.15); color: var(--accent-gold); border: 1px solid var(--accent-gold); }
        .status-delivered { background: rgba(224, 163, 154, 0.15); color: var(--accent-rose); border: 1px solid var(--accent-rose); }
        .status-pending { background: rgba(255, 183, 77, 0.15); color: #ffb74d; border: 1px solid #ffb74d; }
        .status-cancelled { background: rgba(255, 107, 107, 0.15); color: var(--danger); border: 1px solid var(--danger); }

        .modal-overlay {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.85);
            display: none; justify-content: center; align-items: center; z-index: 1000; backdrop-filter: blur(8px);
        }
        .modal-content { background: var(--bg-card); padding: 30px; border-radius: 12px; width: 600px; border: 1px solid var(--accent-rose); max-height: 90vh; overflow-y: auto; }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-top: 20px; }
        .form-group { margin-bottom: 15px; }
        .form-group.full { grid-column: span 2; }
        .form-group label { display: block; margin-bottom: 8px; color: var(--accent-rose); font-size: 0.7rem; text-transform: uppercase; font-family: 'Inter', sans-serif; }
        .form-group input, .form-group select {
            width: 100%; padding: 10px; background: var(--input-bg); border: 1px solid var(--border); color: white; border-radius: 4px; outline: none; font-family: 'Inter', sans-serif;
        }
        .form-group input:focus, .form-group select:focus { border-color: var(--accent-rose); }
        .form-group input:disabled { background: #1a1a1a; color: #666; cursor: not-allowed; }

        .action-icon { background: none; border: none; color: var(--text-gray); cursor: pointer; font-size: 1.2rem; margin-right: 8px; transition: 0.2s; }
        .action-icon:hover { color: var(--accent-rose); }

        .alert { padding: 12px; border-radius: 8px; margin-bottom: 20px; font-size: 0.9rem; display: none; }
        .alert.success { background: rgba(129, 199, 132, 0.2); color: var(--success); border: 1px solid var(--success); }
        .alert.error { background: rgba(255, 107, 107, 0.2); color: var(--danger); border: 1px solid var(--danger); }
        
        tbody tr:hover { background-color: rgba(255, 255, 255, 0.02); transition: background 0.3s ease; }
    </style>
</head>
<body>

    <aside class="sidebar">
        <div class="logo" onclick="window.location.href='home.jsp'">
            <i class="ph-fill ph-sketch-logo"></i>
            <span>LuxAura</span>
        </div>
        <nav>
            <a href="admin.jsp" class="nav-btn">
                <i class="ph ph-gem-stone"></i> Inventory
            </a>
            <a href="admin-customers.jsp" class="nav-btn">
                <i class="ph ph-users-three"></i> Clients
            </a>
            <a href="admin-orders.jsp" class="nav-btn active">
                <i class="ph ph-scroll"></i> Orders
            </a>
            <a href="admin-tickets.jsp" class="nav-btn">
			    <i class="ph ph-chats-circle"></i> Support Tickets
			</a>
        </nav>

        <!-- Admin Profile Section -->
        <div class="admin-profile">
            <div class="profile-header">
                <div class="profile-avatar">
                    <%= admin.getFirstName().substring(0, 1).toUpperCase() %>
                </div>
                <div class="profile-info">
                    <div class="profile-name"><%= admin.getFirstName() %> <%= admin.getLastName() %></div>
                    
                </div>
            </div>
            <div class="profile-actions">
                <button class="profile-btn" onclick="openProfileModal()">
                    <i class="ph ph-user-circle"></i> Edit Profile
                </button>
                <button class="profile-btn logout" onclick="logout()">
                    <i class="ph ph-sign-out"></i> Logout
                </button>
            </div>
        </div>
    </aside>

    <main class="main-content">
        <!-- Welcome Banner -->
        <div class="welcome-banner">
            <div class="welcome-text">
                <h2>Welcome back, <%= admin.getFirstName() %>!</h2>
                <p>Manage and track all luxury orders</p>
            </div>
            <div class="welcome-icon">
                <i class="ph-fill ph-scroll"></i>
            </div>
        </div>

        <header>
            <h1>Order Management</h1>
        </header>

        <div id="alert" class="alert"></div>

        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Client</th>
                        <th>Date</th>
                        <th>Total</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="orders-table">
                    <tr><td colspan="6" style="text-align:center; padding: 40px;">Loading orders...</td></tr>
                </tbody>
            </table>
        </div>
    </main>

    <!-- Edit Order Modal -->
    <div class="modal-overlay" id="orderModal">
        <div class="modal-content">
            <h2 id="modal-title" style="color: var(--accent-rose); text-transform: uppercase; margin-bottom: 10px;">Edit Order</h2>
            <form id="orderForm">
                <input type="hidden" id="orderId">
                <div class="form-grid">
                    <div class="form-group">
                        <label>Order ID</label>
                        <input type="text" id="orderIdDisplay" disabled>
                    </div>
                    <div class="form-group">
                        <label>User ID</label>
                        <input type="number" id="orderUserId" disabled>
                    </div>
                    <div class="form-group">
                        <label>Total Amount</label>
                        <input type="number" step="0.01" id="orderTotal" disabled>
                    </div>
                    <div class="form-group">
                        <label>Status *</label>
                        <select id="orderStatus" required>
                            <option value="Pending">Pending</option>
                            <option value="Processing">Processing</option>
                            <option value="Shipped">Shipped</option>
                            <option value="Delivered">Delivered</option>
                            <option value="Cancelled">Cancelled</option>
                        </select>
                    </div>
                </div>
                <div style="display: flex; gap: 10px; margin-top: 20px;">
                    <button type="submit" class="primary-btn" style="flex: 2;">Update Order</button>
                    <button type="button" class="primary-btn" style="background:#444; color:white; flex: 1;" onclick="closeModal()">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Admin Profile Modal -->
    <div class="modal-overlay" id="profileModal">
        <div class="modal-content">
            <h2 style="color: var(--accent-rose); text-transform: uppercase; margin-bottom: 10px;">Admin Profile</h2>
            <form id="profileForm">
                <div class="form-grid">
                    <div class="form-group">
                        <label>First Name *</label>
                        <input type="text" id="profileFirstName" value="<%= admin.getFirstName() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Last Name *</label>
                        <input type="text" id="profileLastName" value="<%= admin.getLastName() %>" required>
                    </div>
                    <div class="form-group full">
                        <label>Email</label>
                        <input type="email" value="<%= admin.getEmail() %>" disabled>
                    </div>
                    <div class="form-group full">
                        <label>Username</label>
                        <input type="text" value="<%= admin.getUsername() %>" disabled>
                    </div>
                    <div class="form-group">
                        <label>Phone</label>
                        <input type="tel" id="profilePhone" value="<%= admin.getPhone() != null ? admin.getPhone() : "" %>">
                    </div>
                    
                </div>
                <div style="display: flex; gap: 10px; margin-top: 20px;">
                    <button type="submit" class="primary-btn" style="flex: 2;">Save Changes</button>
                    <button type="button" class="primary-btn" style="background:#444; color:white; flex: 1;" onclick="closeProfileModal()">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        let orders = [];

        window.onload = function() {
            loadOrders();
        };
     
        function loadOrders() {
            console.log('Loading orders...');
            
            fetch('${pageContext.request.contextPath}/admin/orders')
                .then(response => {
                    console.log('Load response status:', response.status);
                    if (!response.ok) {
                        throw new Error('Failed to load: ' + response.status);
                    }
                    return response.json();
                })
                .then(data => {
                    console.log('Orders loaded:', data);
                    orders = data;
                    renderOrders();
                    console.log('✓ Loaded ' + orders.length + ' orders');
                })
                .catch(error => {
                    console.error('✗ Error loading orders:', error);
                    showAlert('Failed to load orders: ' + error.message, 'error');
                    document.getElementById('orders-table').innerHTML = 
                        '<tr><td colspan="6" style="text-align:center; padding: 40px; color: var(--danger);">Failed to load orders. Please refresh.</td></tr>';
                });
        }

        function renderOrders() {
            const tbody = document.getElementById('orders-table');
            
            if (orders.length === 0) {
                tbody.innerHTML = '<tr><td colspan="6" style="text-align:center; padding: 40px;">No orders found.</td></tr>';
                return;
            }

            let html = '';
            orders.forEach(order => {
                const date = order.orderDate ? new Date(order.orderDate).toLocaleDateString() : 'N/A';
                const statusClass = 'status-' + (order.status || 'pending').toLowerCase();
                const customerName = order.customerName || 'User #' + order.userID;
                
                html += `
                    <tr>
                        <td>\${order.orderID}</td>
                        <td>\${customerName}</td>
                        <td>\${date}</td>
                        <td>$\${(order.totalAmount || 0).toFixed(2)}</td>
                        <td><span class="status-pill \${statusClass}">\${order.status || 'Pending'}</span></td>
                        <td>
                            <button class="action-icon" onclick="openEditModal(\${order.orderID})" title="Edit">
                                <i class="ph ph-pencil"></i>
                            </button>
                            <button class="action-icon" style="color:var(--danger)" onclick="deleteOrder(\${order.orderID})" title="Delete">
                                <i class="ph ph-trash"></i>
                            </button>
                        </td>
                    </tr>
                `;
            });
            tbody.innerHTML = html;
        }

        function openEditModal(orderId) {
            const order = orders.find(o => o.orderID === orderId);
            if (!order) return;

            document.getElementById('modal-title').innerText = 'Edit Order #' + orderId;
            document.getElementById('orderId').value = order.orderID;
            document.getElementById('orderIdDisplay').value = order.orderID;
            document.getElementById('orderUserId').value = order.userID;
            document.getElementById('orderTotal').value = (order.totalAmount || 0).toFixed(2);
            document.getElementById('orderStatus').value = order.status || 'Pending';
            
            document.getElementById('orderModal').style.display = 'flex';
        }

        function closeModal() {
            document.getElementById('orderModal').style.display = 'none';
        }

        document.getElementById('orderForm').onsubmit = function(e) {
            e.preventDefault();
            
            const orderId = document.getElementById('orderId').value;
            
            const orderData = {
                action: 'update',
                orderId: orderId,
                status: document.getElementById('orderStatus').value
            };
            
            const formBody = Object.keys(orderData)
                .map(key => encodeURIComponent(key) + '=' + encodeURIComponent(orderData[key]))
                .join('&');
            
            fetch('${pageContext.request.contextPath}/admin/orders', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: formBody
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showAlert(data.message, 'success');
                    closeModal();
                    loadOrders();
                } else {
                    showAlert(data.error || 'Operation failed', 'error');
                }
            })
            .catch(error => {
                showAlert('Failed to update order: ' + error.message, 'error');
            });
        };

        function deleteOrder(orderId) {
            if (!confirm('Are you sure you want to delete this order?')) return;
            
            fetch('${pageContext.request.contextPath}/admin/orders?orderId=' + orderId, {
                method: 'DELETE'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showAlert('Order deleted successfully', 'success');
                    loadOrders();
                } else {
                    showAlert(data.error || 'Failed to delete order', 'error');
                }
            })
            .catch(error => {
                showAlert('Failed to delete order: ' + error.message, 'error');
            });
        }

        // Profile Functions
        function openProfileModal() {
            document.getElementById('profileModal').style.display = 'flex';
        }

        function closeProfileModal() {
            document.getElementById('profileModal').style.display = 'none';
        }

        document.getElementById('profileForm').onsubmit = function(e) {
            e.preventDefault();
            showAlert('Profile update feature coming soon!', 'success');
            closeProfileModal();
        };

        function logout() {
            if (confirm('Are you sure you want to logout?')) {
                window.location.href = '${pageContext.request.contextPath}/LogoutServlet';
            }
        }

        function showAlert(message, type) {
            const alert = document.getElementById('alert');
            alert.className = 'alert ' + type;
            alert.innerText = message;
            alert.style.display = 'block';
            
            setTimeout(() => {
                alert.style.display = 'none';
            }, 5000);
        }
    </script>
</body>
</html>