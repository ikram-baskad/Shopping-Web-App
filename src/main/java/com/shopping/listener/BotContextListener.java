package com.shopping.listener;

import com.shopping.bot.TelegramBotHandler;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class BotContextListener implements ServletContextListener {
    
    private TelegramBotHandler telegramBot;
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("  Starting LuxAura Support Bots...");
        
        try {
            // Start Telegram Bot
            telegramBot = new TelegramBotHandler();
            sce.getServletContext().setAttribute("telegramBot", telegramBot);
            System.out.println(" Telegram Bot started successfully!");
            
        } catch (Exception e) {
            System.err.println(" Failed to start bots: " + e.getMessage());
            e.printStackTrace();
        }
        
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Stopping bots...");
        
        if (telegramBot != null) {
            telegramBot.stop();
        }
        
        System.out.println(" Bots stopped");
    }
}