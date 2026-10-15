package com.example.ecommerce.config;

import com.example.ecommerce.model.Product;
import com.example.ecommerce.repository.ProductRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.math.BigDecimal;

@Configuration
public class DataInitializer {
    @Bean
    CommandLineRunner seedProducts(ProductRepository repository) {
        return args -> {
            if (repository.count() == 0) {
                repository.save(new Product("Wireless Headphones",
                        "Comfortable wireless headphones with clear sound and a long-lasting battery.",
                        new BigDecimal("2499.00"), 15,
                        "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=800&q=80"));
                repository.save(new Product("Smart Watch",
                        "A stylish everyday smartwatch for activity tracking and notifications.",
                        new BigDecimal("3299.00"), 12,
                        "https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=800&q=80"));
                repository.save(new Product("Backpack",
                        "A versatile backpack for college, commuting, and weekend trips.",
                        new BigDecimal("1499.00"), 20,
                        "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=800&q=80"));
                repository.save(new Product("Running Shoes",
                        "Lightweight everyday running shoes with a cushioned sole.",
                        new BigDecimal("2799.00"), 10,
                        "https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=800&q=80"));
            }
        };
    }
}
