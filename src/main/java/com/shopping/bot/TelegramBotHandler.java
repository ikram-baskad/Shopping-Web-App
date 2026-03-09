package com.shopping.bot;

import com.pengrad.telegrambot.TelegramBot;
import com.pengrad.telegrambot.UpdatesListener;
import com.pengrad.telegrambot.model.Update;
import com.pengrad.telegrambot.model.request.InlineKeyboardButton;
import com.pengrad.telegrambot.model.request.InlineKeyboardMarkup;
import com.pengrad.telegrambot.model.request.ParseMode;
import com.pengrad.telegrambot.request.SendMessage;
import com.pengrad.telegrambot.response.SendResponse;

public class TelegramBotHandler {
    
    private static final String BOT_TOKEN = "8327377510:AAHUSP72YgnS3fAjdHIWm4fccHm_7WdyotQ";
    
    private TelegramBot bot;
    
    public TelegramBotHandler() {
        bot = new TelegramBot(BOT_TOKEN);
        setupBot();
    }
    
    private void setupBot() {
        bot.setUpdatesListener(updates -> {
            for (Update update : updates) {
                handleUpdate(update);
            }
            return UpdatesListener.CONFIRMED_UPDATES_ALL;
        });
        
        System.out.println(" Telegram Bot is running...");
    }
    
    private void handleUpdate(Update update) {
        // Handle regular messages
        if (update.message() != null && update.message().text() != null) {
            long chatId = update.message().chat().id();
            String messageText = update.message().text();
            String userFirstName = update.message().from().firstName();
            
            handleMessage(chatId, messageText, userFirstName);
        }
        
        // Handle button callbacks
        if (update.callbackQuery() != null) {
            long chatId = update.callbackQuery().message().chat().id();
            String callbackData = update.callbackQuery().data();
            
            handleCallback(chatId, callbackData);
        }
    }
    
    private void handleMessage(long chatId, String message, String userName) {
        String response = "";
        InlineKeyboardMarkup keyboard = null;
        
        // Handle /start command
        if (message.equals("/start")) {
            response = "👋 *Welcome to LuxAura Support, " + userName + "!*\n\n" +
                      "I'm here to help you with:\n" +
                      "💎 Product inquiries\n" +
                      "📦 Order tracking\n" +
                      "🚚 Shipping information\n" +
                      "↩️ Returns & refunds\n\n" +
                      "How can I assist you today?";
            
            keyboard = new InlineKeyboardMarkup(
                new InlineKeyboardButton[]{
                    new InlineKeyboardButton("🛍 View Products").callbackData("products"),
                    new InlineKeyboardButton("📦 Track Order").callbackData("track")
                },
                new InlineKeyboardButton[]{
                    new InlineKeyboardButton("🚚 Shipping Info").callbackData("shipping"),
                    new InlineKeyboardButton("↩️ Returns").callbackData("returns")
                },
                new InlineKeyboardButton[]{
                    new InlineKeyboardButton("💬 Talk to Human").callbackData("human")
                }
            );
        }
        
        // Handle product inquiries
        else if (message.toLowerCase().contains("product") || 
                 message.toLowerCase().contains("catalog") ||
                 message.toLowerCase().contains("jewelry")) {
            response = "💎 *Our Jewelry Collection*\n\n" +
                      "We offer:\n" +
                      "✨ 18k Gold Necklaces - Starting at 450 MAD\n" +
                      "💍 Diamond Rings - Starting at 800 MAD\n" +
                      "👂 Elegant Earrings - Starting at 210 MAD\n" +
                      "⌚ Luxury Watches - Starting at 320 MAD\n\n" +
                      "Visit our website to browse the complete collection!";
            
            keyboard = new InlineKeyboardMarkup(
                new InlineKeyboardButton[]{
                    new InlineKeyboardButton("🌐 Visit Website").url("http://localhost:8080/ShoppingWebsite/products.jsp")
                }
            );
        }
        
        // Handle shipping inquiries
        else if (message.toLowerCase().contains("ship") || 
                 message.toLowerCase().contains("delivery")) {
            response = "🚚 *Shipping Information*\n\n" +
                      "📍 Within Morocco:\n" +
                      "• Standard: 3-5 business days\n" +
                      "• Express: 1-2 business days\n" +
                      "• Free shipping on orders over 500 MAD\n\n" +
                      "🌍 International:\n" +
                      "• 7-14 business days\n" +
                      "• Rates calculated at checkout";
        }
        
        // Handle order tracking
        else if (message.toLowerCase().contains("track") || 
                 message.toLowerCase().contains("order")) {
            response = "📦 *Track Your Order*\n\n" +
                      "To track your order:\n" +
                      "1. Check your email for tracking number\n" +
                      "2. Visit your account dashboard\n" +
                      "3. Or send me your order number\n\n" +
                      "Format: ORDER-12345";
        }
        
        // Handle returns
        else if (message.toLowerCase().contains("return") || 
                 message.toLowerCase().contains("refund")) {
            response = "↩️ *Return Policy*\n\n" +
                      "We accept returns within 30 days:\n" +
                      "✓ Items must be unworn\n" +
                      "✓ Original packaging required\n" +
                      "✓ Receipt or proof of purchase\n\n" +
                      "❌ Custom/engraved items cannot be returned\n\n" +
                      "Need to start a return? Contact our support team!";
        }
        
        // Handle price inquiries
        else if (message.toLowerCase().contains("price") || 
                 message.toLowerCase().contains("cost") ||
                 message.toLowerCase().contains("how much")) {
            response = "💰 *Price Range*\n\n" +
                      "Our jewelry ranges from:\n" +
                      "• Earrings: 150 - 600 MAD\n" +
                      "• Necklaces: 300 - 1200 MAD\n" +
                      "• Rings: 400 - 2000 MAD\n" +
                      "• Watches: 300 - 1500 MAD\n\n" +
                      "Visit our website for exact prices!";
        }
        
        // Handle greetings
        else if (message.toLowerCase().contains("hello") || 
                 message.toLowerCase().contains("hi") ||
                 message.toLowerCase().contains("hey")) {
            response = "Hello " + userName + "! 👋\n\n" +
                      "How can I help you today?\n\n" +
                      "You can ask me about:\n" +
                      "• Products and prices\n" +
                      "• Order tracking\n" +
                      "• Shipping info\n" +
                      "• Returns & refunds";
        }
        
        // Handle thanks
        else if (message.toLowerCase().contains("thank")) {
            response = "You're welcome! 😊\n\n" +
                      "Is there anything else I can help you with?";
        }
        
        // Default response
        else {
            response = "I'm here to help! 🤖\n\n" +
                      "I can assist you with:\n" +
                      "• Product information\n" +
                      "• Order tracking\n" +
                      "• Shipping details\n" +
                      "• Returns & refunds\n\n" +
                      "What would you like to know?";
            
            keyboard = new InlineKeyboardMarkup(
                new InlineKeyboardButton[]{
                    new InlineKeyboardButton("💬 Main Menu").callbackData("menu")
                }
            );
        }
        
        sendMessage(chatId, response, keyboard);
    }
    
    private void handleCallback(long chatId, String callbackData) {
        String response = "";
        InlineKeyboardMarkup keyboard = null;
        
        switch (callbackData) {
            case "products":
                response = "💎 *Browse Our Collection*\n\n" +
                          "Visit our website to see all products:\n" +
                          "🌐 http://localhost:8080/ShoppingWebsite/products.jsp\n\n" +
                          "Or tell me what you're looking for!";
                break;
                
            case "track":
                response = "📦 *Order Tracking*\n\n" +
                          "Please send me your order number.\n" +
                          "Format: ORDER-12345";
                break;
                
            case "shipping":
                response = "🚚 *Shipping Information*\n\n" +
                          "Morocco: 3-5 days (Free over 500 MAD)\n" +
                          "International: 7-14 days\n\n" +
                          "Need more details? Just ask!";
                break;
                
            case "returns":
                response = "↩️ *30-Day Return Policy*\n\n" +
                          "Items must be:\n" +
                          "✓ Unworn and unused\n" +
                          "✓ In original packaging\n\n" +
                          "Want to start a return? Let me know!";
                break;
                
            case "human":
                response = "📞 *Connect with Our Team*\n\n" +
                          "For personalized assistance:\n\n" +
                          "📧 Email: support@luxaura.com\n" +
                          "📱 Phone: +212 522 000 000\n" +
                          "💬 Website: Fill our contact form\n\n" +
                          "We typically respond within 2 hours!";
                break;
                
            case "menu":
                response = "📋 *Main Menu*\n\n" +
                          "What can I help you with?";
                
                keyboard = new InlineKeyboardMarkup(
                    new InlineKeyboardButton[]{
                        new InlineKeyboardButton("🛍 Products").callbackData("products"),
                        new InlineKeyboardButton("📦 Track").callbackData("track")
                    },
                    new InlineKeyboardButton[]{
                        new InlineKeyboardButton("🚚 Shipping").callbackData("shipping"),
                        new InlineKeyboardButton("↩️ Returns").callbackData("returns")
                    }
                );
                break;
        }
        
        sendMessage(chatId, response, keyboard);
    }
    
    private void sendMessage(long chatId, String text, InlineKeyboardMarkup keyboard) {
        SendMessage message = new SendMessage(chatId, text)
                .parseMode(ParseMode.Markdown);
        
        if (keyboard != null) {
            message.replyMarkup(keyboard);
        }
        
        SendResponse response = bot.execute(message);
        
        if (!response.isOk()) {
            System.err.println("Failed to send message: " + response.description());
        }
    }
    
    public void stop() {
        bot.removeGetUpdatesListener();
        System.out.println(" Telegram Bot stopped");
    }
}