package com.jtspringproject.JtSpringProject;

import com.jtspringproject.JtSpringProject.controller.AdminController;
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

@SpringBootTest
public class LoginTest {
  static String BASIC_URL = "http://localhost:8080/";
  @Autowired
  private AdminController adminController;
  @Autowired
  private UserController userController;

  private Model model;

  // Helper function to connect database and create statement
  private Statement createStmt () throws Exception {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
    Statement stmt = con.createStatement();
    return stmt;
  }

  // ------------- Testing Part ---------------

  @BeforeEach
  public void setUp() {
    model = new ConcurrentModel();
  }

  // Blackbox - returnIndex(): check return url value
  @Test
  public void testReturnIndexURL() {
    Assertions.assertEquals("userLogin", adminController.returnIndex());
  }

  // Blackbox / Whitebox - returnIndex(): check status code
  @Test
  public void testReturnIndexStatus() {
    TestRestTemplate restTemplate = new TestRestTemplate();
    ResponseEntity<String> response = restTemplate.getForEntity(BASIC_URL + "/logout", String.class);
    Assertions.assertEquals(HttpStatus.OK, response.getStatusCode());
  }

  // Blackbox - index(): check return url value when username is empty
  @Test
  public void testIndexURLEmptyUsername() {
    adminController.usernameforclass = "";
    Assertions.assertEquals("userLogin", adminController.index(model));
  }

  // Blackbox - index(): check return url value when username is not empty
  @Test
  public void testIndexURLUniqueUsername() {
    adminController.usernameforclass = "admin";
    Assertions.assertEquals("index", adminController.index(model));
  }

  // Blackbox / Whitebox - index(): check status code
  @Test
  public void testIndexStatus() {
    TestRestTemplate restTemplate = new TestRestTemplate();
    ResponseEntity<String> response = restTemplate.getForEntity(BASIC_URL + "/index", String.class);
    Assertions.assertEquals(HttpStatus.OK, response.getStatusCode());
  }

  // Blackbox - userLog(): check return url value
  @Test
  public void testUserLogURL() {
    Assertions.assertEquals("userLogin", adminController.userlog(model));
  }

  // Blackbox / Whitebox - userLog(): check status code
  @Test
  public void testUserLogStatus() {
    TestRestTemplate restTemplate = new TestRestTemplate();
    ResponseEntity<String> response = restTemplate.getForEntity(BASIC_URL + "/userloginvalidate", String.class);
    Assertions.assertEquals(HttpStatus.OK, response.getStatusCode());
  }

  // Blackbox - userLogin(): check return url value when correct login is provided
  @Test
  public void testUserLoginCorrectCredentialsURL() {
    userController.newUseRegister("user", "123", "user@gmail.com");
    Assertions.assertEquals("redirect:/index", adminController.userlogin("user", "123", model));
  }

  // Blackbox / Whitebox - userLogin(): check usernameforclass matches
  @Test
  public void testUserLoginCorrectCredentialsFieldValues() {
    userController.newUseRegister("user", "123", "user@gmail.com");
    adminController.userlogin("user", "123", model);
    Assertions.assertEquals("user", adminController.usernameforclass);
  }

  // Blackbox / Whitebox - userLogin(): check user exists in db
  @Test
  public void testUserLoginUserExistsTrue() throws SQLException {
    userController.newUseRegister("user", "123", "user@gmail.com");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
    Statement stmt = con.createStatement();
    ResultSet rst = stmt.executeQuery("select * from users where username = '"+ "user" +"' and password = '"+ "123" +"' ;");
    Assertions.assertTrue(rst.next());
  }

  // Blackbox / Whitebox - userLogin(): check if user doesn't exist in db
  @Test
  public void testUserLoginUserExistsFalse() throws SQLException {
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
    Statement stmt = con.createStatement();
    ResultSet rst = stmt.executeQuery("select * from users where username = '"+ "userWrong" +"' and password = '"+ "123" +"' ;");
    Assertions.assertFalse(rst.next());
  }

  // Blackbox - userLogin(): check return url value when incorrect login is provided
  @Test
  public void testUserLoginIncorrectCredentialsURL() {
    Assertions.assertEquals("userLogin", adminController.userlogin("userWrong", "123", model));
  }

  // Blackbox - adminLogin(): check return url value
  @Test
  public void testAdminLoginURL() throws Exception{
    Assertions.assertEquals("adminlogin", adminController.adminlogin(model));
  }

  // Blackbox / Whitebox - adminLogin(): check status code
  @Test
  public void testAdminLoginStatus() {
    TestRestTemplate restTemplate = new TestRestTemplate();
    ResponseEntity<String> response = restTemplate.getForEntity(BASIC_URL + "/admin", String.class);
    Assertions.assertEquals(HttpStatus.OK, response.getStatusCode());
  }

  // Blackbox - adminHome(): check return url value when adminlogcheck = 0
  @Test
  public void testAdminHomeWithAdminLogCheckEquals0URL() {
    adminController.adminlogcheck = 0;
    Assertions.assertEquals("redirect:/admin", adminController.adminHome(model));
  }

  // Blackbox - adminHome(): check return url value when adminlogcheck != 0
  @Test
  public void testAdminHomeWithAdminLogCheckNotEquals0() {
    adminController.adminlogcheck = 1;
    Assertions.assertEquals("adminHome", adminController.adminHome(model));
  }

  // Blackbox - adminHome(): check return url value when adminlogcheck = 0
  @Test
  public void testAdminHomeStatus() {
    adminController.adminlogcheck = 0;
    TestRestTemplate restTemplate = new TestRestTemplate();
    ResponseEntity<String> response = restTemplate.getForEntity(BASIC_URL + "/adminhome", String.class);
    Assertions.assertEquals(HttpStatus.OK, response.getStatusCode());
  }

  // Blackbox - adminlog(): check return url value
  @Test
  public void testAdminLogURL() {
    Assertions.assertEquals("adminlogin", adminController.adminlog(model));
  }

  // Blackbox / Whitebox - adminlog(): check status code
  @Test
  public void testAdminLogStatus() {
    TestRestTemplate restTemplate = new TestRestTemplate();
    ResponseEntity<String> response = restTemplate.getForEntity(BASIC_URL + "/loginvalidate", String.class);
    Assertions.assertEquals(HttpStatus.OK, response.getStatusCode());
  }

  // Blackbox - adminLogin(username, password, model): check return url value for correct login values
  @Test
  public void testAdminLoginCorrectUsernameAndPasswordURL() {
    Assertions.assertEquals("redirect:/adminhome", adminController.adminlogin("admin", "123", model));
  }

  // Blackbox - adminLogin(username, password, model): check adminlogcheck value
  @Test
  public void testAdminLoginCorrectUsernameAndPasswordFieldValue() {
    Assertions.assertEquals(0, adminController.adminlogcheck);
    adminController.adminlogin("admin", "123", model);
    Assertions.assertEquals(1, adminController.adminlogcheck);
  }

  // Blackbox - adminLogin(username, password, model): check return url value for incorrect login values
  @Test
  public void testAdminLoginIncorrectUsernameAndPasswordURL() {
    Assertions.assertEquals("adminlogin", adminController.adminlogin("admin", "1234", model));
  }

  // Blackbox / Whitebox - adminLogin(username, password, model): check status code
  @Test
  public void testAdminLoginValidateStatus() {
    TestRestTemplate restTemplate = new TestRestTemplate();
    ResponseEntity<String> response = restTemplate.getForEntity(BASIC_URL + "loginvalidate", String.class);
    Assertions.assertEquals(HttpStatus.OK, response.getStatusCode());
  }
}
