<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.shopping.model.Employee" %>
<%
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
    <title>LuxAura | Support Tickets</title>
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    <style>
        :root {
            --bg-dark: #1a1a1a; --bg-sidebar: #111111; --bg-card: #242424;
            --accent-rose: #E0A39A; --accent-gold: #D4AF37;
            --text-white: #ffffff; --text-gray: #b0b0b0; --border: #333333;
            --danger: #ff6b6b; --input-bg: #2a2a2a; --success: #81c784;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Playfair Display', serif; }
        body { background-color: var(--bg-dark); color: var(--text-white); display: flex; height: 100vh; overflow: hidden; }
        .sidebar { width: 260px; background-color: var(--bg-sidebar); border-right: 1px solid var(--border); display: flex; flex-direction: column; padding: 24px; }
        .logo { display: flex; align-items: center; gap: 12px; font-size: 1.2rem; font-weight: bold; color: var(--accent-rose); margin-bottom: 48px; text-transform: uppercase; letter-spacing: 2px; cursor: pointer; }
        .nav-btn { width: 100%; padding: 14px 16px; margin-bottom: 8px; background: transparent; border: none; color: var(--text-gray); text-align: left; border-radius: 8px; cursor: pointer; display: flex; align-items: center; gap: 12px; transition: 0.3s; font-family: 'Inter', sans-serif; text-transform: uppercase; font-size: 0.8rem; letter-spacing: 1px; text-decoration: none; }
        .nav-btn.active { background-color: var(--accent-rose); color: #000; font-weight: 600; }
        .nav-btn:hover:not(.active) { color: var(--accent-rose); background: rgba(224, 163, 154, 0.1); }
        .admin-profile { margin-top: auto; padding-top: 24px; border-top: 1px solid var(--border); }
        .profile-header { display: flex; align-items: center; gap: 12px; margin-bottom: 16px; }
        .profile-avatar { width: 48px; height: 48px; background: var(--accent-rose); border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; color: #000; font-weight: bold; }
        .profile-info { flex: 1; }
        .profile-name { font-size: 0.95rem; font-weight: 600; color: var(--text-white); margin-bottom: 2px; }
        .profile-actions { display: flex; flex-direction: column; gap: 8px; }
        .profile-btn { width: 100%; padding: 10px; background: transparent; border: 1px solid var(--border); color: var(--text-gray); border-radius: 6px; cursor: pointer; font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.5px; transition: 0.3s; display: flex; align-items: center; justify-content: center; gap: 8px; }
        .profile-btn:hover { border-color: var(--accent-rose); color: var(--accent-rose); }
        .profile-btn.logout { border-color: var(--danger); color: var(--danger); }
        .profile-btn.logout:hover { background: var(--danger); color: var(--white); }
        .main-content { flex: 1; padding: 40px; overflow-y: auto; }
        .welcome-banner { background: linear-gradient(135deg, var(--bg-card) 0%, #2a2a2a 100%); border: 1px solid var(--accent-rose); border-radius: 12px; padding: 24px 32px; margin-bottom: 32px; display: flex; justify-content: space-between; align-items: center; }
        .welcome-text h2 { font-size: 1.8rem; margin-bottom: 8px; color: var(--accent-rose); }
        .welcome-text p { color: var(--text-gray); font-size: 0.95rem; }
        .welcome-icon { font-size: 3rem; color: var(--accent-rose); opacity: 0.3; }
        header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 32px; }
        header h1 { font-weight: 400; letter-spacing: 1px; }
        .filter-buttons { display: flex; gap: 10px; }
        .filter-btn { background-color: transparent; color: var(--text-gray); border: 1px solid var(--border); padding: 8px 16px; border-radius: 4px; cursor: pointer; transition: 0.3s; text-transform: uppercase; font-size: 0.75rem; font-weight: 600; letter-spacing: 0.5px; }
        .filter-btn.active { background-color: var(--accent-rose); color: #000; border-color: var(--accent-rose); }
        .filter-btn:hover:not(.active) { border-color: var(--accent-rose); color: var(--accent-rose); }
        .table-wrapper { background-color: var(--bg-card); border-radius: 12px; border: 1px solid var(--border); overflow: hidden; }
        table { width: 100%; border-collapse: collapse; }
        th { background-color: #000; padding: 18px; text-align: left; font-size: 0.7rem; color: var(--accent-rose); text-transform: uppercase; letter-spacing: 1.5px; }
        td { padding: 18px; border-bottom: 1px solid var(--border); vertical-align: middle; font-family: 'Inter', sans-serif; font-size: 0.9rem; }
        .ticket-subject { color: var(--text-white); font-weight: 600; display: block; font-size: 0.95rem; margin-bottom: 4px; }
        .ticket-preview { color: var(--text-gray); font-size: 0.85rem; display: block; max-width: 300px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
        .customer-info { color: var(--text-white); font-weight: 500; }
        .customer-email { color: var(--text-gray); font-size: 0.8rem; display: block; }
        .status-pill { padding: 6px 12px; border-radius: 20px; font-size: 0.75rem; text-transform: uppercase; font-weight: 600; letter-spacing: 0.5px; display: inline-block; }
        .status-pending { background: rgba(255, 183, 77, 0.15); color: #ffb74d; border: 1px solid #ffb74d; }
        .status-resolved { background: rgba(129, 199, 132, 0.15); color: var(--success); border: 1px solid var(--success); }
        .modal-overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.85); display: none; justify-content: center; align-items: center; z-index: 1000; backdrop-filter: blur(8px); }
        .modal-content { background: var(--bg-card); padding: 30px; border-radius: 12px; width: 700px; max-width: 90vw; border: 1px solid var(--accent-rose); max-height: 90vh; overflow-y: auto; }
        .ticket-detail { background: var(--input-bg); padding: 20px; border-radius: 8px; margin-bottom: 20px; border: 1px solid var(--border); }
        .ticket-detail h3 { color: var(--accent-rose); margin-bottom: 12px; font-size: 1.1rem; }
        .ticket-meta { display: grid; grid-template-columns: repeat(2, 1fr); gap: 12px; margin-bottom: 16px; }
        .meta-item { display: flex; flex-direction: column; gap: 4px; }
        .meta-label { color: var(--text-gray); font-size: 0.7rem; text-transform: uppercase; letter-spacing: 0.5px; font-family: 'Inter', sans-serif; }
        .meta-value { color: var(--text-white); font-size: 0.9rem; }
        .ticket-message { background: var(--bg-dark); padding: 16px; border-radius: 6px; color: var(--text-white); line-height: 1.6; font-family: 'Inter', sans-serif; white-space: pre-wrap; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 8px; color: var(--accent-rose); font-size: 0.7rem; text-transform: uppercase; font-family: 'Inter', sans-serif; }
        .form-group select { width: 100%; padding: 12px; background: var(--input-bg); border: 1px solid var(--border); color: white; border-radius: 4px; outline: none; font-family: 'Inter', sans-serif; font-size: 0.9rem; }
        .form-group select:focus { border-color: var(--accent-rose); }
        .action-icon { background: none; border: none; color: var(--text-gray); cursor: pointer; font-size: 1.2rem; margin-right: 8px; transition: 0.2s; }
        .action-icon:hover { color: var(--accent-rose); }
        .alert { padding: 12px; border-radius: 8px; margin-bottom: 20px; font-size: 0.9rem; display: none; }
        .alert.success { background: rgba(129, 199, 132, 0.2); color: var(--success); border: 1px solid var(--success); }
        .alert.error { background: rgba(255, 107, 107, 0.2); color: var(--danger); border: 1px solid var(--danger); }
        tbody tr:hover { background-color: rgba(255, 255, 255, 0.02); transition: background 0.3s ease; cursor: pointer; }
        .primary-btn { background-color: var(--accent-rose); color: #000; border: none; padding: 12px 24px; border-radius: 4px; font-weight: bold; cursor: pointer; transition: 0.3s; text-transform: uppercase; font-size: 0.8rem; }
        .primary-btn:hover { background-color: #d89a8e; }
        .email-display { background: var(--bg-dark); padding: 12px 16px; border-radius: 6px; border: 1px solid var(--accent-rose); margin-top: 15px; }
        .email-display label { display: block; color: var(--accent-rose); font-size: 0.7rem; text-transform: uppercase; margin-bottom: 8px; font-family: 'Inter', sans-serif; }
        .email-display a { color: var(--text-white); text-decoration: none; font-size: 1rem; transition: 0.3s; }
        .email-display a:hover { color: var(--accent-rose); }
    </style>
</head>
<body>
    <aside class="sidebar">
        <div class="logo" onclick="window.location.href='home.jsp'">
            <i class="ph-fill ph-sketch-logo"></i>
            <span>LuxAura</span>
        </div>
        <nav>
            <a href="admin.jsp" class="nav-btn"><i class="ph ph-gem-stone"></i> Inventory</a>
            <a href="admin-customers.jsp" class="nav-btn"><i class="ph ph-users-three"></i> Clients</a>
            <a href="admin-orders.jsp" class="nav-btn"><i class="ph ph-scroll"></i> Orders</a>
            <a href="admin-tickets.jsp" class="nav-btn active"><i class="ph ph-chats-circle"></i> Support Tickets</a>
        </nav>
        <div class="admin-profile">
            <div class="profile-header">
                <div class="profile-avatar"><%= admin.getFirstName().substring(0, 1).toUpperCase() %></div>
                <div class="profile-info">
                    <div class="profile-name"><%= admin.getFirstName() %> <%= admin.getLastName() %></div>
                </div>
            </div>
            <div class="profile-actions">
                <button class="profile-btn logout" onclick="logout()"><i class="ph ph-sign-out"></i> Logout</button>
            </div>
        </div>
    </aside>
    
    <main class="main-content">
        <div class="welcome-banner">
            <div class="welcome-text">
                <h2>Welcome back, <%= admin.getFirstName() %>!</h2>
                <p>Review customer support inquiries and contact information</p>
            </div>
            <div class="welcome-icon"><i class="ph-fill ph-chats-circle"></i></div>
        </div>

        <header>
            <h1>Support Tickets</h1>
            <div class="filter-buttons">
                <button class="filter-btn active" onclick="filterTickets('all')">All</button>
                <button class="filter-btn" onclick="filterTickets('pending')">Pending</button>
                <button class="filter-btn" onclick="filterTickets('resolved')">Resolved</button>
            </div>
        </header>

        <div id="alert" class="alert"></div>

        <div class="table-wrapper">
            <table>
                <thead>
                    <tr><th>ID</th><th>Customer</th><th>Subject</th><th>Message Preview</th><th>Status</th><th>Created</th><th>Actions</th></tr>
                </thead>
                <tbody id="tickets-table">
                    <tr><td colspan="7" style="text-align:center; padding: 40px;">Loading tickets...</td></tr>
                </tbody>
            </table>
        </div>
    </main>

    <div class="modal-overlay" id="ticketModal">
        <div class="modal-content">
            <h2 style="color: var(--accent-rose); text-transform: uppercase; margin-bottom: 20px;">
                <i class="ph ph-chat-circle-dots"></i> Ticket Details
            </h2>
            
            <div class="ticket-detail">
                <h3>Ticket Information</h3>
                <div class="ticket-meta">
                    <div class="meta-item"><span class="meta-label">Ticket ID</span><span class="meta-value" id="detailTicketId">-</span></div>
                    <div class="meta-item"><span class="meta-label">Status</span><span class="meta-value" id="detailStatus">-</span></div>
                    <div class="meta-item"><span class="meta-label">Customer Name</span><span class="meta-value" id="detailCustomerName">-</span></div>
                    <div class="meta-item"><span class="meta-label">Customer Email</span><span class="meta-value" id="detailCustomerEmail">-</span></div>
                    <div class="meta-item"><span class="meta-label">Subject</span><span class="meta-value" id="detailSubject">-</span></div>
                    <div class="meta-item"><span class="meta-label">Created</span><span class="meta-value" id="detailCreated">-</span></div>
                </div>
                <div class="meta-label" style="margin-bottom: 8px;">Customer Message</div>
                <div class="ticket-message" id="detailMessage">-</div>
            </div>

            <div class="email-display">
                <label><i class="ph ph-envelope"></i> Contact Customer</label>
                <a href="#" id="customerEmailLink" target="_blank">-</a>
            </div>

            <form id="statusForm">
                <input type="hidden" id="ticketId">
                <div class="form-group">
                    <label>Update Status</label>
                    <select id="ticketStatus">
                        <option value="pending">Pending</option>
                        <option value="resolved">Resolved</option>
                    </select>
                </div>
                <div style="display: flex; gap: 10px; margin-top: 20px;">
                    <button type="submit" class="primary-btn" style="flex: 2;">Update Status</button>
                    <button type="button" class="primary-btn" style="background:#444; color:white; flex: 1;" onclick="closeModal()">Close</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        let tickets = [];
        let currentFilter = 'all';

        window.onload = () => loadTickets();
     
        function loadTickets() {
            fetch('${pageContext.request.contextPath}/admin/tickets')
                .then(r => r.ok ? r.json() : Promise.reject('Failed'))
                .then(data => { tickets = data; renderTickets(); })
                .catch(e => showAlert('Failed to load tickets: ' + e, 'error'));
        }

        function filterTickets(filter) {
            currentFilter = filter;
            document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
            event.target.classList.add('active');
            renderTickets();
        }

        function renderTickets() {
            const tbody = document.getElementById('tickets-table');
            let filtered = currentFilter === 'all' ? tickets : tickets.filter(t => t.status.toLowerCase() === currentFilter);
            
            if (filtered.length === 0) {
                tbody.innerHTML = '<tr><td colspan="7" style="text-align:center; padding: 40px;">No tickets found.</td></tr>';
                return;
            }

            tbody.innerHTML = filtered.map(t => {
                const date = t.created_at ? new Date(t.created_at).toLocaleString() : 'N/A';
                const statusClass = 'status-' + (t.status || 'pending').toLowerCase();
                const preview = t.message ? t.message.substring(0, 50) + '...' : 'No message';
                
                return `<tr onclick="openTicketModal(${t.message_id})">
                    <td>${t.message_id}</td>
                    <td><span class="customer-info">${t.customer_name}</span><span class="customer-email">${t.customer_email}</span></td>
                    <td><span class="ticket-subject">${t.subject}</span></td>
                    <td><span class="ticket-preview">${preview}</span></td>
                    <td><span class="status-pill ${statusClass}">${t.status}</span></td>
                    <td>${date}</td>
                    <td>
                        <button class="action-icon" onclick="event.stopPropagation(); openTicketModal(${t.message_id})" title="View"><i class="ph ph-eye"></i></button>
                        <button class="action-icon" style="color:var(--danger)" onclick="event.stopPropagation(); deleteTicket(${t.message_id})" title="Delete"><i class="ph ph-trash"></i></button>
                    </td>
                </tr>`;
            }).join('');
        }

        function openTicketModal(ticketId) {
            const t = tickets.find(x => x.message_id === ticketId);
            if (!t) return;

            document.getElementById('detailTicketId').innerText = t.message_id;
            document.getElementById('detailStatus').innerText = t.status;
            document.getElementById('detailCustomerName').innerText = t.customer_name;
            document.getElementById('detailCustomerEmail').innerText = t.customer_email;
            document.getElementById('detailSubject').innerText = t.subject;
            document.getElementById('detailMessage').innerText = t.message;
            document.getElementById('detailCreated').innerText = t.created_at ? new Date(t.created_at).toLocaleString() : 'N/A';
            document.getElementById('ticketId').value = t.message_id;
            document.getElementById('ticketStatus').value = t.status.toLowerCase();
            
            // Set email link
            const emailLink = document.getElementById('customerEmailLink');
            emailLink.href = 'mailto:' + t.customer_email;
            emailLink.innerText = t.customer_email;
            
            document.getElementById('ticketModal').style.display = 'flex';
        }

        function closeModal() {
            document.getElementById('ticketModal').style.display = 'none';
        }

        document.getElementById('statusForm').onsubmit = function(e) {
            e.preventDefault();
            const data = {
                action: 'updateStatus',
                ticketId: document.getElementById('ticketId').value,
                status: document.getElementById('ticketStatus').value
            };
            
            fetch('${pageContext.request.contextPath}/admin/tickets', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: Object.keys(data).map(k => encodeURIComponent(k) + '=' + encodeURIComponent(data[k])).join('&')
            })
            .then(r => r.json())
            .then(d => {
                if (d.success) {
                    showAlert('Status updated successfully!', 'success');
                    closeModal();
                    loadTickets();
                } else {
                    showAlert(d.error || 'Failed to update status', 'error');
                }
            })
            .catch(e => showAlert('Failed: ' + e, 'error'));
        };

        function deleteTicket(id) {
            if (!confirm('Delete this ticket?')) return;
            fetch('${pageContext.request.contextPath}/admin/tickets?ticketId=' + id, {method: 'DELETE'})
                .then(r => r.json())
                .then(d => {
                    showAlert(d.success ? 'Ticket deleted' : d.error, d.success ? 'success' : 'error');
                    if (d.success) loadTickets();
                });
        }

        function logout() {
            if (confirm('Logout?')) window.location.href = '${pageContext.request.contextPath}/LogoutServlet';
        }

        function showAlert(msg, type) {
            const alert = document.getElementById('alert');
            alert.className = 'alert ' + type;
            alert.innerText = msg;
            alert.style.display = 'block';
            setTimeout(() => alert.style.display = 'none', 5000);
        }
    </script>
</body>
</html>