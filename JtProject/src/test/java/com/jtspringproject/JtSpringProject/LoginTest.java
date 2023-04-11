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
import org.springframework.ui.Model;
import org.springframework.util.Assert;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.Collection;
import java.util.Map;

@SpringBootTest
public class LoginTest {
  static String BASIC_URL = "http://localhost:8080/";
  @Autowired
  private AdminController adminController;

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
    model = new Model() {
      @Override
      public Model addAttribute(String attributeName, Object attributeValue) {
        return null;
      }

      @Override
      public Model addAttribute(Object attributeValue) {
        return null;
      }

      @Override
      public Model addAllAttributes(Collection<?> attributeValues) {
        return null;
      }

      @Override
      public Model addAllAttributes(Map<String, ?> attributes) {
        return null;
      }

      @Override
      public Model mergeAttributes(Map<String, ?> attributes) {
        return null;
      }

      @Override
      public boolean containsAttribute(String attributeName) {
        return false;
      }

      @Override
      public Object getAttribute(String attributeName) {
        return null;
      }

      @Override
      public Map<String, Object> asMap() {
        return null;
      }
    };
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
    //TODO
  }



  @Test
  public void testUserLogin() {
    //TODO
  }

  @Test
  public void testAdminLogin() {
    //TODO
  }

  @Test
  public void testAdminHome() {
    //TODO
  }

  @Test
  public void testAdminLog() {
    //TODO
  }

  @Test
  public void testAdminLoginWithMoreParams() {
    //TODO
  }
}
