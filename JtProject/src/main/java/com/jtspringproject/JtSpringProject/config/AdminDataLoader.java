package com.jtspringproject.JtSpringProject.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.jtspringproject.JtSpringProject.models.User;
import com.jtspringproject.JtSpringProject.services.userService;

@Component
public class AdminDataLoader implements CommandLineRunner {

    private final userService userService;
    private final PasswordEncoder passwordEncoder;

    public AdminDataLoader(userService userService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public void run(String... args) {
        try {
            User admin = userService.getUserByUsername("admin");
            if (admin != null && !passwordEncoder.matches("123", admin.getPassword())) {
                admin.setPassword(passwordEncoder.encode("123"));
                admin.setActive(true);
                userService.updateUser(admin);
                System.out.println(">>> Admin password updated. Login with admin/123");
            }
        } catch (Exception e) {
            System.err.println("AdminDataLoader: " + e.getMessage());
        }
    }
}
