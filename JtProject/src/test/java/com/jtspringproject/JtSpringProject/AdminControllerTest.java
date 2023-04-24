package com.jtspringproject.JtSpringProject;

import com.jtspringproject.JtSpringProject.controller.AdminController;
import com.jtspringproject.JtSpringProject.controller.UserController;
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
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
public class AdminControllerTest {

    static String BASIC_URL = "http://localhost:8080/";
    @Autowired
    private AdminController adminController;

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

    // Blackbox - getCustomerDetail(): check return value
    @Test
    void testGetCustomerDetail() {
        assertEquals("displayCustomers", adminController.getCustomerDetail());
    }

    // Blackbox / Whitebox - getCustomerDetail(): check status code
    @Test
    void testGetCustomerDetailStatus() {
        TestRestTemplate restTemplate = new TestRestTemplate();
        ResponseEntity<String> response = restTemplate.getForEntity(BASIC_URL + "/admin/customers", String.class);
        assertEquals(HttpStatus.OK, response.getStatusCode());
    }

    //Blackbox - profileDisplay(): check return value
    @Test
    void testProfileDisplay() {
        assertEquals("updateProfile", adminController.profileDisplay(model));
    }

    // Blackbox / Whitebox - profileDisplay(): check status code
    @Test
    void testProfileDisplayStatus() {
        TestRestTemplate restTemplate = new TestRestTemplate();
        ResponseEntity<String> response = restTemplate.getForEntity(BASIC_URL + "/profileDisplay", String.class);
        assertEquals(HttpStatus.OK, response.getStatusCode());
    }

    // Blackbox / Whitebox - profileDisplay(): check model username attribute
    @Test
    void testProfileDisplayDataUsername() throws Exception {
        String expectedUsername = "username";
        String expectedPassword = "password";
        String expectedEmail = "email";
        userController.newUseRegister(expectedUsername, expectedPassword, expectedEmail);
        adminController.usernameforclass = expectedUsername;
        adminController.profileDisplay(model);
        String actualUsername = model.getAttribute("username").toString();
        assertEquals(expectedUsername, actualUsername);
    }

    // Blackbox / Whitebox - profileDisplay(): check model password attribute
    @Test
    void testProfileDisplayDataPassword() throws Exception {
        String expectedUsername = "username";
        String expectedPassword = "password";
        String expectedEmail = "email";
        userController.newUseRegister(expectedUsername, expectedPassword, expectedEmail);
        adminController.usernameforclass = expectedUsername;
        adminController.profileDisplay(model);
        String actualPassword = model.getAttribute("password").toString();
        assertEquals(expectedPassword, actualPassword);
    }

    // Blackbox / Whitebox - profileDisplay(): check model email attribute
    @Test
    void testProfileDisplayDataEmail() throws Exception {
        String expectedUsername = "username";
        String expectedPassword = "password";
        String expectedEmail = "email";
        userController.newUseRegister(expectedUsername, expectedPassword, expectedEmail);
        adminController.usernameforclass = expectedUsername;
        adminController.profileDisplay(model);
        String actualEmail = model.getAttribute("email").toString();
        assertEquals(expectedEmail, actualEmail);
    }

    //Blackbox - updateUserProfile(): check return value
    @Test
    void testUpdateUserProfile() {
        assertEquals("redirect:/index", adminController.updateUserProfile(1, "username", "email", "password", "1"));
    }

    // Blackbox - updateUserProfile(): check updated username
    @Test
    void testUpdateUserProfileDataUsername() throws Exception {
        String expectedUsername = "username";
        String expectedEmail = "email";
        String expectedPassword = "password";
        String expectedAddress = "address";
        String originalUsername = "jay";
        Statement stmt = createStmt();
        ResultSet rst = stmt.executeQuery("select * from users where username = '"+originalUsername+"';");
        int uid = -1;
        if (rst.next()) {
            uid = rst.getInt(1); //index of uid is 1
        }
        adminController.updateUserProfile(uid, expectedUsername, expectedEmail, expectedPassword, expectedAddress);
        String actualUsername = rst.getString("username");
        assertEquals(expectedUsername, actualUsername);
    }

    // Whitebox - updateUserProfile(): check uid of updated profile
    @Test
    void testUpdateUserProfileDataUid() throws Exception {
        String expectedUsername = "username";
        String expectedEmail = "email";
        String expectedPassword = "password";
        String expectedAddress = "address";
        String originalUsername = "jay";
        Statement stmt = createStmt();
        ResultSet rst = stmt.executeQuery("select * from users where username = '"+originalUsername+"';");
        int uid = -1;
        if (rst.next()) {
            uid = rst.getInt(1); //index of uid is 1
        }
        adminController.updateUserProfile(uid, expectedUsername, expectedEmail, expectedPassword, expectedAddress);
        rst = stmt.executeQuery("select * from users where username = '"+expectedUsername+"';");
        int actualUid = -1;
        if (rst.next()) {
            actualUid = rst.getInt(1); //index of uid is 1
        }
        assertEquals(uid, actualUid);
    }

    // Blackbox - updateUserProfile(): check update profile with uid = 0
    @Test
    void testUpdateUserProfileValidUidZero() throws Exception {
        int uid = 0; //invalid uid
        String expectedUsername = "username";
        String expectedEmail = "email";
        String expectedPassword = "password";
        String expectedAddress = "address";
        assertDoesNotThrow(
                ()->{
                    adminController.updateUserProfile(uid, expectedUsername, expectedEmail, expectedPassword, expectedAddress);
                });
    }

    // Blackbox - updateUserProfile(): check update profile with uid = 1
    @Test
    void testUpdateUserProfileValidUidOne() throws Exception {
        int uid = 1; //invalid uid
        String expectedUsername = "username";
        String expectedEmail = "email";
        String expectedPassword = "password";
        String expectedAddress = "address";
        assertDoesNotThrow(
                ()->{
                    adminController.updateUserProfile(uid, expectedUsername, expectedEmail, expectedPassword, expectedAddress);
                });
    }

    // Blackbox - updateUserProfile(): check update profile with uid = -1
    @Test
    void testUpdateUserProfileInvalidUidNegative() throws Exception {
        int uid = -1; //invalid uid
        String expectedUsername = "username";
        String expectedEmail = "email";
        String expectedPassword = "password";
        String expectedAddress = "address";
        assertThrows(Exception.class,
                ()->{
                    adminController.updateUserProfile(uid, expectedUsername, expectedEmail, expectedPassword, expectedAddress);
                });
    }

    // Blackbox - updateUserProfile(): check update profile with uid = Integer.MAX_VALUE
    @Test
    void testUpdateUserProfileInvalidUidInfinity() throws Exception {
        int uid = Integer.MAX_VALUE; //invalid uid
        String expectedUsername = "username";
        String expectedEmail = "email";
        String expectedPassword = "password";
        String expectedAddress = "address";
        assertThrows(Exception.class,
                ()->{
                    adminController.updateUserProfile(uid, expectedUsername, expectedEmail, expectedPassword, expectedAddress);
                });
    }

    // Whitebox - updateUserProfile(): check update profile throws no exception
    @Test
    void testUpdateUserProfileNoException() throws Exception {
        int uid = 1;
        assertDoesNotThrow(
                ()->{
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
                    PreparedStatement pst = con.prepareStatement("update users set username= ?,email = ?,password= ?, address= ? where uid = ?;");
                    pst.setString(1, "username");
                    pst.setString(2, "email");
                    pst.setString(3, "password");
                    pst.setString(4, "address");
                    pst.setInt(5, uid);
                    pst.executeUpdate();
                });
    }
}