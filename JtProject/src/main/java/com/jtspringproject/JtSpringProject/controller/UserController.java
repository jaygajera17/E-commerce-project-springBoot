package com.jtspringproject.JtSpringProject.controller;

import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import  org.apache.logging.log4j.LogManager;

@Controller
public class UserController {
    private static final Logger logger = LogManager.getLogger(UserController.class);
    @Value("${datasource.password}")
    private String password;
    @GetMapping("/register")
    public String registerUser() {
        return "register";
    }

    @GetMapping("/contact")
    public String contact() {
        return "contact";
    }

    @GetMapping("/buy")
    public String buy() {
        return "buy";
    }

    @GetMapping("/user/products")
    public String getproduct(Model model) {
        return "uproduct";
    }

    @PostMapping(value = "newuserregister")
    public String newUseRegister(@RequestParam("username") String username, @RequestParam("password") String password, @RequestParam("email") String email) {
        try {
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/springproject", "postgres",password );
            PreparedStatement pst = con.prepareStatement("insert into users(username,password,email) values(?,?,?);");
            pst.setString(1, username);
            pst.setString(2, password);
            pst.setString(3, email);
            int i = pst.executeUpdate();
            logger.debug("data base updated %d" , i);

        } catch (Exception e) {
            logger.debug("data base updated throws exception");
        }
        return "redirect:/";
    }
}
