<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.shopping.model.Customer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <title>Customer Support | LuxAura</title>
    <style>
        :root {
            --primary-accent: #E0A39A;
            --secondary-accent: #D4AF37;
            --bg-light: #FBF7F6;
            --dark-text: #2D2D2D;
            --white: #ffffff;
            --success: #4CAF50;
            --error: #f44336;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Playfair Display', 'Segoe UI', serif;
            background-color: var(--bg-light);
            color: var(--dark-text);
        }

        /* Navigation */
        nav {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 1.2rem 0;
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
            text-decoration: none;
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

        /* Support Container */
        .support-container {
            max-width: 1200px;
            margin: 3rem auto;
            padding: 0 2rem;
        }

        .support-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .support-header h1 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .support-header p {
            font-size: 1.1rem;
            color: #666;
            max-width: 600px;
            margin: 0 auto;
        }

        /* Support Grid */
        .support-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            margin-bottom: 3rem;
        }

        @media (max-width: 768px) {
            .support-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Contact Form */
        .contact-form-section {
            background: var(--white);
            padding: 2.5rem;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }

        .section-title {
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
            color: var(--primary-accent);
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .section-title i {
            font-size: 1.8rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--dark-text);
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 0.9rem;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 1rem;
            font-family: 'Segoe UI', sans-serif;
            transition: all 0.3s;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary-accent);
            box-shadow: 0 0 0 3px rgba(224, 163, 154, 0.1);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 150px;
        }

        .btn {
            padding: 0.9rem 2rem;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 1px;
            border: none;
            font-family: 'Playfair Display', serif;
            width: 100%;
        }

        .btn-primary {
            background: var(--dark-text);
            color: var(--white);
        }

        .btn-primary:hover {
            background: var(--primary-accent);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(224, 163, 154, 0.3);
        }

        /* Alert Messages */
        .alert {
            padding: 1rem 1.5rem;
            border-radius: 6px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border-left: 4px solid var(--success);
        }

        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border-left: 4px solid var(--error);
        }

        .alert i {
            font-size: 1.3rem;
        }

        /* Quick Contact Options */
        .quick-contact-section {
            background: var(--white);
            padding: 2.5rem;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }

        .contact-option {
            padding: 1.5rem;
            margin-bottom: 1rem;
            background: var(--bg-light);
            border-radius: 8px;
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: all 0.3s;
            cursor: pointer;
        }

        .contact-option:hover {
            transform: translateX(5px);
            box-shadow: 0 4px 12px rgba(224, 163, 154, 0.2);
        }

        .contact-icon {
            width: 50px;
            height: 50px;
            background: var(--primary-accent);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            font-size: 1.5rem;
        }

        .contact-info h3 {
            font-size: 1.1rem;
            margin-bottom: 0.3rem;
        }

        .contact-info p {
            color: #666;
            font-size: 0.9rem;
        }

        /* FAQ Section */
        .faq-section {
            background: var(--white);
            padding: 2.5rem;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            grid-column: 1 / -1;
        }

        .faq-item {
            margin-bottom: 1.5rem;
            border-bottom: 1px solid #eee;
            padding-bottom: 1.5rem;
        }

        .faq-item:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .faq-question {
            font-weight: 600;
            font-size: 1.1rem;
            color: var(--dark-text);
            margin-bottom: 0.8rem;
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .faq-question i {
            color: var(--primary-accent);
        }

        .faq-answer {
            color: #666;
            line-height: 1.8;
            padding-left: 2rem;
        }

        /* Chatbot Button */
        .chatbot-button {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 60px;
            height: 60px;
            background: var(--primary-accent);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(224, 163, 154, 0.4);
            transition: all 0.3s;
            z-index: 1000;
        }

        .chatbot-button:hover {
            transform: scale(1.1);
            box-shadow: 0 6px 20px rgba(224, 163, 154, 0.6);
        }

        .chatbot-button i {
            font-size: 1.8rem;
            color: var(--white);
        }

        /* Chatbot Window */
        .chatbot-window {
            position: fixed;
            bottom: 100px;
            right: 30px;
            width: 350px;
            height: 500px;
            background: var(--white);
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.2);
            display: none;
            flex-direction: column;
            z-index: 999;
        }

        .chatbot-window.active {
            display: flex;
        }

        .chatbot-header {
            background: var(--primary-accent);
            color: var(--white);
            padding: 1rem 1.5rem;
            border-radius: 12px 12px 0 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .chatbot-header h3 {
            font-size: 1.1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .chatbot-close {
            background: none;
            border: none;
            color: var(--white);
            font-size: 1.5rem;
            cursor: pointer;
        }

        .chatbot-messages {
            flex: 1;
            padding: 1.5rem;
            overflow-y: auto;
            background: #f9f9f9;
        }

        .chat-message {
            margin-bottom: 1rem;
            display: flex;
            gap: 0.8rem;
        }

        .chat-message.bot {
            justify-content: flex-start;
        }

        .chat-message.user {
            justify-content: flex-end;
        }

        .message-bubble {
            max-width: 70%;
            padding: 0.8rem 1rem;
            border-radius: 12px;
            font-size: 0.9rem;
            line-height: 1.5;
        }

        .chat-message.bot .message-bubble {
            background: var(--white);
            color: var(--dark-text);
        }

        .chat-message.user .message-bubble {
            background: var(--primary-accent);
            color: var(--white);
        }

        .chatbot-input {
            padding: 1rem;
            border-top: 1px solid #eee;
            display: flex;
            gap: 0.5rem;
        }

        .chatbot-input input {
            flex: 1;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 20px;
            font-size: 0.9rem;
        }

        .chatbot-input button {
            width: 40px;
            height: 40px;
            background: var(--primary-accent);
            color: var(--white);
            border: none;
            border-radius: 50%;
            cursor: pointer;
            transition: all 0.3s;
        }

        .chatbot-input button:hover {
            background: var(--dark-text);
        }

        .quick-replies {
            padding: 0 1.5rem 1rem;
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
        }

        .quick-reply-btn {
            padding: 0.5rem 1rem;
            background: var(--bg-light);
            border: 1px solid var(--primary-accent);
            color: var(--dark-text);
            border-radius: 20px;
            font-size: 0.8rem;
            cursor: pointer;
            transition: all 0.3s;
        }

        .quick-reply-btn:hover {
            background: var(--primary-accent);
            color: var(--white);
        }
    </style>
</head>
<body>

    <nav>
        <div class="nav-container">
            <a href="home.jsp" class="logo">Lux<span>Aura</span></a>
            <ul class="nav-links">
                <li><a href="home.jsp">Home</a></li>
                <li><a href="products.jsp">Jewelry</a></li>
                <li><a href="support">Support</a></li>
            </ul>
        </div>
    </nav>

    <div class="support-container">
        
        <!-- Header -->
        <div class="support-header">
            <h1><i class="fas fa-headset"></i> Customer Support</h1>
            <p>We're here to help! Send us a message or chat with our support team.</p>
        </div>

        <%
            Customer customer = (Customer) session.getAttribute("customer");
            String successMessage = (String) request.getAttribute("successMessage");
            String errorMessage = (String) request.getAttribute("errorMessage");
            Boolean clearForm = (Boolean) request.getAttribute("clearForm");
        %>

        <!-- Support Grid -->
        <div class="support-grid">
            
            <!-- Contact Form -->
            <div class="contact-form-section">
                <h2 class="section-title">
                    <i class="fas fa-envelope"></i>
                    Send Us a Message
                </h2>

                <!-- Success/Error Messages -->
                <% if (successMessage != null) { %>
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i>
                        <span><%= successMessage %></span>
                    </div>
                <% } %>

                <% if (errorMessage != null) { %>
                    <div class="alert alert-error">
                        <i class="fas fa-exclamation-circle"></i>
                        <span><%= errorMessage %></span>
                    </div>
                <% } %>

                <form action="support" method="post">
                    <div class="form-group">
                        <label for="name">Your Name *</label>
                        <input type="text" id="name" name="name" 
                               value="<%= clearForm != null && clearForm ? "" : (customer != null ? customer.getFullName() : "") %>" 
                               required>
                    </div>

                    <div class="form-group">
                        <label for="email">Email Address *</label>
                        <input type="email" id="email" name="email" 
                               value="<%= clearForm != null && clearForm ? "" : (customer != null ? customer.getEmail() : "") %>" 
                               required>
                    </div>

                    <div class="form-group">
                        <label for="subject">Subject *</label>
                        <select id="subject" name="subject" required>
                            <option value="">Select a topic...</option>
                            <option value="Product Inquiry">Product Inquiry</option>
                            <option value="Order Status">Order Status</option>
                            <option value="Shipping & Delivery">Shipping & Delivery</option>
                            <option value="Returns & Refunds">Returns & Refunds</option>
                            <option value="Technical Support">Technical Support</option>
                            <option value="Feedback">Feedback</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="message">Message *</label>
                        <textarea id="message" name="message" required 
                                  placeholder="Please describe your question or issue in detail..."><%= clearForm != null && clearForm ? "" : "" %></textarea>
                    </div>

                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-paper-plane"></i> Send Message
                    </button>
                </form>
            </div>

            <!-- Quick Contact Options -->
            <div class="quick-contact-section">
                <h2 class="section-title">
                    <i class="fas fa-comments"></i>
                    Quick Contact
                </h2>

                <div class="contact-option" onclick="openWhatsApp()">
                    <div class="contact-icon">
                        <i class="fab fa-whatsapp"></i>
                    </div>
                    <div class="contact-info">
                        <h3>WhatsApp Support</h3>
                        <p>Chat with us on WhatsApp</p>
                    </div>
                </div>

                <div class="contact-option" onclick="openTelegram()">
                    <div class="contact-icon">
                        <i class="fab fa-telegram"></i>
                    </div>
                    <div class="contact-info">
                        <h3>Telegram Support</h3>
                        <p>Message us on Telegram</p>
                    </div>
                </div>

                <div class="contact-option" onclick="window.location.href='mailto:support@luxaura.com'">
                    <div class="contact-icon">
                        <i class="fas fa-envelope"></i>
                    </div>
                    <div class="contact-info">
                        <h3>Email Support</h3>
                        <p>support@luxaura.com</p>
                    </div>
                </div>

                <div class="contact-option" onclick="window.location.href='tel:+212522000000'">
                    <div class="contact-icon">
                        <i class="fas fa-phone"></i>
                    </div>
                    <div class="contact-info">
                        <h3>Phone Support</h3>
                        <p>+212 522 000 000</p>
                    </div>
                </div>
            </div>

        </div>

        <!-- FAQ Section -->
        <div class="faq-section">
            <h2 class="section-title">
                <i class="fas fa-question-circle"></i>
                Frequently Asked Questions
            </h2>

            <div class="faq-item">
                <div class="faq-question">
                    <i class="fas fa-chevron-right"></i>
                    How long does shipping take?
                </div>
                <div class="faq-answer">
                    Standard shipping typically takes 3-5 business days within Morocco. International shipping may take 7-14 business days depending on the destination.
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question">
                    <i class="fas fa-chevron-right"></i>
                    What is your return policy?
                </div>
                <div class="faq-answer">
                    We offer a 30-day return policy for all unworn items in their original packaging. Custom or engraved items cannot be returned unless defective.
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question">
                    <i class="fas fa-chevron-right"></i>
                    Are your products authentic?
                </div>
                <div class="faq-answer">
                    Yes! All our jewelry pieces come with authenticity certificates. We only source from verified suppliers and our gold/silver items are hallmarked.
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question">
                    <i class="fas fa-chevron-right"></i>
                    How do I track my order?
                </div>
                <div class="faq-answer">
                    Once your order ships, you'll receive a tracking number via email. You can also check your order status in your account dashboard.
                </div>
            </div>
        </div>

    </div>

    <!-- Chatbot Button -->
    <div class="chatbot-button" onclick="toggleChatbot()">
        <i class="fas fa-comment-dots"></i>
    </div>

    <!-- Chatbot Window -->
    <div class="chatbot-window" id="chatbotWindow">
        <div class="chatbot-header">
            <h3><i class="fas fa-robot"></i> LuxAura Assistant</h3>
            <button class="chatbot-close" onclick="toggleChatbot()">
                <i class="fas fa-times"></i>
            </button>
        </div>
        
        <div class="chatbot-messages" id="chatMessages">
            <div class="chat-message bot">
                <div class="message-bubble">
                    Hello! 👋 Welcome to LuxAura. How can I help you today?
                </div>
            </div>
        </div>

        <div class="quick-replies" id="quickReplies">
            <button class="quick-reply-btn" onclick="sendQuickReply('Product catalog')">Product Catalog</button>
            <button class="quick-reply-btn" onclick="sendQuickReply('Shipping info')">Shipping Info</button>
            <button class="quick-reply-btn" onclick="sendQuickReply('Track order')">Track Order</button>
        </div>
        
        <div class="chatbot-input">
            <input type="text" id="chatInput" placeholder="Type your message..." 
                   onkeypress="handleChatKeyPress(event)">
            <button onclick="sendMessage()">
                <i class="fas fa-paper-plane"></i>
            </button>
        </div>
    </div>

    <script>
        // Chatbot Functions
        function toggleChatbot() {
            const chatbot = document.getElementById('chatbotWindow');
            chatbot.classList.toggle('active');
            
            if (chatbot.classList.contains('active')) {
                document.getElementById('chatInput').focus();
            }
        }

        function sendMessage() {
            const input = document.getElementById('chatInput');
            const message = input.value.trim();
            
            if (message) {
                addMessage(message, 'user');
                input.value = '';
                
                // Simulate bot response
                setTimeout(() => {
                    const botResponse = getBotResponse(message);
                    addMessage(botResponse, 'bot');
                }, 1000);
            }
        }

        function sendQuickReply(message) {
            addMessage(message, 'user');
            
            setTimeout(() => {
                const botResponse = getBotResponse(message);
                addMessage(botResponse, 'bot');
            }, 1000);
        }

        function addMessage(text, sender) {
            const messagesDiv = document.getElementById('chatMessages');
            const messageDiv = document.createElement('div');
            messageDiv.className = 'chat-message ' + sender;
            
            const bubble = document.createElement('div');
            bubble.className = 'message-bubble';
            bubble.textContent = text;
            
            messageDiv.appendChild(bubble);
            messagesDiv.appendChild(messageDiv);
            
            // Scroll to bottom
            messagesDiv.scrollTop = messagesDiv.scrollHeight;
        }

        function getBotResponse(message) {
            const lowerMessage = message.toLowerCase();
            
            if (lowerMessage.includes('product') || lowerMessage.includes('catalog')) {
                return 'You can browse our complete jewelry collection at products.jsp. We have necklaces, rings, earrings, and more!';
            } else if (lowerMessage.includes('ship') || lowerMessage.includes('delivery')) {
                return 'We offer free shipping on orders over 500 MAD. Standard delivery takes 3-5 business days within Morocco.';
            } else if (lowerMessage.includes('track') || lowerMessage.includes('order')) {
                return 'You can track your order using the tracking number sent to your email. Or check your account dashboard for order status.';
            } else if (lowerMessage.includes('return') || lowerMessage.includes('refund')) {
                return 'We have a 30-day return policy. Items must be unworn and in original packaging. Would you like to start a return?';
            } else if (lowerMessage.includes('price') || lowerMessage.includes('cost')) {
                return 'Our jewelry ranges from 150 MAD to 2000 MAD. Visit our products page to see specific prices!';
            } else if (lowerMessage.includes('hello') || lowerMessage.includes('hi')) {
                return 'Hello! How can I assist you today? 😊';
            } else if (lowerMessage.includes('thank')) {
                return 'You\'re welcome! Is there anything else I can help you with?';
            } else {
                return 'I\'m here to help! For detailed support, please fill out the contact form or reach us on WhatsApp/Telegram.';
            }
        }

        function handleChatKeyPress(event) {
            if (event.key === 'Enter') {
                sendMessage();
            }
        }

        // Telegram Function - Opens your Telegram bot
        function openTelegram() {
            // IMPORTANT: Replace 'LuxAuraSupport_bot' with YOUR actual bot username from BotFather
            const telegramBotUsername = 'LuxAuraSupport_bot';
            window.open('https://t.me/' + telegramBotUsername, '_blank');
        }

        // WhatsApp Function
        function openWhatsApp() {
            const twilioWhatsAppNumber = '14155238886'; // Twilio sandbox number
            const message = 'Hi LuxAura! I need help.';
            window.open('https://wa.me/' + twilioWhatsAppNumber + '?text=' + encodeURIComponent(message), '_blank');
        }
    </script>

</body>
</html>