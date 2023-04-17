package com.jtspringproject.JtSpringProject;

import com.jtspringproject.JtSpringProject.controller.AdminController;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.ConcurrentModel;
import org.springframework.ui.Model;

import java.sql.*;

@SpringBootTest
public class AdminControllerTest {

    static String BASIC_URL = "http://localhost:8080/";
    @Autowired
    private AdminController adminController;
    private Model model;

    //Helper function to initialize model
    @BeforeEach
    private void setModel() {
        model = new ConcurrentModel();
    }

    // Helper function to connect database and create statement
    private Statement createStmt () throws Exception {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
        Statement stmt = con.createStatement();
        return stmt;
    }

    // Blackbox - getCustomerDetail(): check return value
    @Test
    void testGetCustomerDetail() {
        Assertions.assertEquals("displayCustomers", adminController.getCustomerDetail());
    }

    // Whitebox - getCustomerDetail(): check status code
    @Test
    void testGetCustomerDetailStatus() {
        TestRestTemplate restTemplate = new TestRestTemplate();
        ResponseEntity<String> response = restTemplate.getForEntity(BASIC_URL + "/admin/customers", String.class);
        Assertions.assertEquals(HttpStatus.OK, response.getStatusCode());
    }

    //Blackbox - profileDisplay(): check return value
    @Test
    void testProfileDisplay() {
        Assertions.assertEquals("updateProfile", adminController.profileDisplay(model));
    }

    // Whitebox - profileDisplay(): check status code
    @Test
    void testProfileDisplayStatus() {
        TestRestTemplate restTemplate = new TestRestTemplate();
        ResponseEntity<String> response = restTemplate.getForEntity(BASIC_URL + "/profileDisplay", String.class);
        Assertions.assertEquals(HttpStatus.OK, response.getStatusCode());
    }

    //Blackbox - updateUserProfile(): check return value
    @Test
    void testUpdateUserProfile() {
        Assertions.assertEquals("redirect:/index", adminController.updateUserProfile(1, "jay", "123", "ROLE_USER", "1"));
    }
}