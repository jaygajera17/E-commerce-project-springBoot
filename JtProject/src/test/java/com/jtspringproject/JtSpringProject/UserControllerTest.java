package com.jtspringproject.JtSpringProject;

import com.jtspringproject.JtSpringProject.controller.UserController;
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

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

@SpringBootTest
public class UserControllerTest {

    static String BASIC_URL = "http://localhost:8080/";
    @Autowired
    private UserController userController;
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

    // Blackbox - registerUser(): check return value
    @Test
    void testRegisterUser() {
        Assertions.assertEquals("register", userController.registerUser());
    }

    // Whitebox - registerUser(): check status code
    @Test
    void testRegisterUserStatus() {
        TestRestTemplate restTemplate = new TestRestTemplate();
        ResponseEntity<String> response = restTemplate.getForEntity(BASIC_URL + "/register", String.class);
        Assertions.assertEquals(HttpStatus.OK, response.getStatusCode());
    }

    // Blackbox - contact(): check return value
    @Test
    void testContact() {
        Assertions.assertEquals("contact", userController.contact());
    }

    // Whitebox - contact(): check status code
    @Test
    void testContactStatus() {
        TestRestTemplate restTemplate = new TestRestTemplate();
        ResponseEntity<String> response = restTemplate.getForEntity(BASIC_URL + "/contact", String.class);
        Assertions.assertEquals(HttpStatus.OK, response.getStatusCode());
    }

    // Blackbox - buy(): check return value
    @Test
    void testBuy() {
        Assertions.assertEquals("buy", userController.buy());
    }

    // Whitebox - buy(): check status code
    @Test
    void testBuyStatus() {
        TestRestTemplate restTemplate = new TestRestTemplate();
        ResponseEntity<String> response = restTemplate.getForEntity(BASIC_URL + "/buy", String.class);
        Assertions.assertEquals(HttpStatus.OK, response.getStatusCode());
    }

    // Blackbox - getProduct(): check return value
    @Test
    void testGetProduct() {
        Assertions.assertEquals("uproduct", userController.getproduct(model));
    }

    // Whitebox - getProduct(): check status code
    @Test
    void testGetProductStatus() {
        TestRestTemplate restTemplate = new TestRestTemplate();
        ResponseEntity<String> response = restTemplate.getForEntity(BASIC_URL + "/user/products", String.class);
        Assertions.assertEquals(HttpStatus.OK, response.getStatusCode());
    }

    // Blackbox - newUseRegister(): check return value
    @Test
    void testNewUseRegister() {
        Assertions.assertEquals("redirect:/", userController.newUseRegister("jay", "123", "ROLE_USER"));
    }

    // Whitebox - newUseRegister(): check attributes of created user
    @Test
    void testNewUseRegisterData() throws Exception {
        String expectedUsername = "username";
        String expectedPassword = "password";
        String expectedEmail = "email";
        userController.newUseRegister(expectedUsername, expectedPassword, expectedEmail);
        Statement stmt = createStmt();
        ResultSet rst = stmt.executeQuery("select * from users where username = '"+expectedUsername+"';");
        String actualUsername = "";
        String actualPassword = "";
        String actualEmail = "";
        if (rst.next()) {
            actualUsername = rst.getString("username");
            actualPassword = rst.getString("password");
            actualEmail = rst.getString("email");
        }
        assertEquals(expectedUsername, actualUsername);
        assertEquals(expectedPassword, actualPassword);
        assertEquals(expectedEmail, actualEmail);
    }

    // Whitebox - newUseRegister(): check that address is not an initial attribute
    @Test
    void testNewUseRegisterException() throws Exception {
        String expectedUsername = "username";
        String expectedPassword = "password";
        String expectedEmail = "email";
        userController.newUseRegister(expectedUsername, expectedPassword, expectedEmail);
        Statement stmt = createStmt();
        ResultSet rst = stmt.executeQuery("select * from users where username = '"+expectedUsername+"';");
        assertThrows(Exception.class,
                ()->{
                    if (rst.next()) {
                        rst.getString("address");
                    }
                });
    }

    //Whitebox - newUseRegister(): check that duplicate created user throws error
    @Test
    void testNewUseRegisterDuplicateUserCreation() throws Exception {
        String expectedUsername = "username";
        String expectedPassword = "password";
        String expectedEmail = "email";
        userController.newUseRegister(expectedUsername, expectedPassword, expectedEmail);
        assertThrows(Exception.class,
                ()->{
                    userController.newUseRegister(expectedUsername, expectedPassword, expectedEmail);
                });
    }
}