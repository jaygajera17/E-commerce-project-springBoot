package com.jtspringproject.JtSpringProject;

import com.fasterxml.jackson.databind.exc.MismatchedInputException;
import com.jtspringproject.JtSpringProject.controller.AdminController;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.sql.*;

@SpringBootTest
public class CategoryTest {
    static String BASIC_URL = "http://localhost:8080/";
    @Autowired
    private AdminController adminController;

    // Helper function to connect database and create statement
    private Statement createStmt () throws Exception {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
        Statement stmt = con.createStatement();
        return stmt;
    }

    // ------------- Testing Part ---------------

    // Blackbox - getCategory(): check return url value
    @Test
    void testGetCategoryURL() {
        Assertions.assertEquals("categories", adminController.getcategory());
    }

    // Blackbox / Whitebox - getcategory(): check status code
    @Test
    void testGetCategoryStatus() {
        TestRestTemplate restTemplate = new TestRestTemplate();
        ResponseEntity<String> response = restTemplate.getForEntity(BASIC_URL + "/admin/categories", String.class);
        Assertions.assertEquals(HttpStatus.OK, response.getStatusCode());
    }

    // Blackbox - addcategorytodb(): check return url value
    @Test
    void testAddCategoryToDBurl() {
        String catname = "test1";
        String returnStr = adminController.addcategorytodb(catname);
        Assertions.assertEquals("redirect:/admin/categories", returnStr);
    }

    // Whitebox - addcategorytodb(): check database insert
    @Test
    void testAddCategoryToDBdata() throws Exception {
        String catname = "test1";
        Statement stmt = createStmt();
        ResultSet rst = stmt.executeQuery("select * from categories where name = '"+catname+"';");
        Assertions.assertTrue(rst.next());
    }

    // Whitebox - addcategorytodb(): insert duplicate category
    @Test
    void testAddCategoryDup() throws Exception {
        String catname = "test1";
        adminController.addcategorytodb(catname);
        Statement stmt = createStmt();
        ResultSet rst = stmt.executeQuery("select * from categories where name = '"+catname+"';");

        int count = 0;
        while(rst.next()) {
            count++;
        }
        Assertions.assertEquals(2, count);
    }

    // Blackbox - removeCategoryDB(): negative category id  [FAIL]
    @Test
    void testRemoveCategoryDBNeg() {
        int removeId = -1;
        Assertions.assertThrows(MismatchedInputException.class, () -> {adminController.removeCategoryDb(removeId);});
    }

    // Blackbox - removeCategoryDB(): normal, test return url
    @Test
    void testRemoveCategoryDBurl() {
        int removeId = 12;
        String returnStr = adminController.removeCategoryDb(removeId);
        Assertions.assertEquals("redirect:/admin/categories", returnStr);
    }

    // Whitebox - removeCategoryDB(): normal, check database value
    @Test
    void testRemoveCategoryDBdata() throws Exception {
        int removeId = 12;
        Statement stmt = createStmt();
        ResultSet rst = stmt.executeQuery("select * from categories where categoryid = '"+removeId+"';");
        Assertions.assertFalse(rst.next());
    }

    // Whitebox - removeCategoryDB(): not exist
    @Test
    void testRemoveCategoryNotExist() throws Exception {
        int removeId = 12;
        adminController.removeCategoryDb(removeId);
        Statement stmt = createStmt();
        ResultSet rst = stmt.executeQuery("select * from categories where categoryid = '"+removeId+"';");
        Assertions.assertFalse(rst.next());
    }

    // Blackbox - updateCategoryDB(): negative category id  [FAIL]
    @Test
    void testUpdateCategoryDBNeg() {
        int updateId = -1;
        String newName = "category8";
        Assertions.assertThrows(MismatchedInputException.class, () -> {adminController.updateCategoryDb(updateId, newName);});
    }

    // Blackbox - updateCategory(): normal, check return url
    @Test
    void testUpdateCategoryDBurl() {
        int updateId = 8;
        String newName = "category8";
        Assertions.assertEquals("redirect:/admin/categories", adminController.updateCategoryDb(updateId, newName));
    }

    // Whitebox - updateCategory(): check database update
    @Test
    void testUpdateCategoryDB() throws Exception {
        int updateId = 8;
        Statement stmt = createStmt();
        ResultSet rst = stmt.executeQuery("select name from categories where categoryid = '"+updateId+"';");

        String result = "";
        while (rst.next()) {
            result = rst.getString("name");
        }
        Assertions.assertEquals("category8", result);
    }
}
