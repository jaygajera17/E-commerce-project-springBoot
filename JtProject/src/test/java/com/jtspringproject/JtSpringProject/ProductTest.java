package com.jtspringproject.JtSpringProject;

import com.jtspringproject.JtSpringProject.controller.AdminController;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.ConcurrentModel;
import org.springframework.ui.Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;


@SpringBootTest
public class ProductTest {
    static String BASIC_URL = "http://localhost:8080/";
    @Autowired
    private AdminController adminController;

    private Model model;

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

    // ------------- Testing Part ---------------

    // Blackbox - getproduct() - check return url
    @Test
    void testGetProductURL() {
        assertEquals("products", adminController.getproduct(model));
    }

    // Blackbox / Whitebox - getproduct(): check status code
    @Test
    void testGetProductStatus() {
        TestRestTemplate restTemplate = new TestRestTemplate();
        ResponseEntity<String> response = restTemplate.getForEntity(BASIC_URL + "/admin/products", String.class);
        assertEquals(HttpStatus.OK, response.getStatusCode());
    }

    // Blackbox - addproduct() - check return url
    @Test
    void testAddProductURL() {
        assertEquals("productsAdd", adminController.addproduct(model));
    }

    // Blackbox / Whitebox - addproduct(): check status code
    @Test
    void testAddProductStatus() {
        TestRestTemplate restTemplate = new TestRestTemplate();
        ResponseEntity<String> response = restTemplate.getForEntity(BASIC_URL + "/admin/products/add", String.class);
        assertEquals(HttpStatus.OK, response.getStatusCode());
    }

    // Blackbox - updateproduct() - check return url
    @Test
    void testUpdateProductURL() {
        int updateProductId = 14;
        assertEquals("productsUpdate", adminController.updateproduct(updateProductId, model));
    }

    // Whitebox - updateproduct() - check specific model attribute (same as db)
    @Test
    void testUpdateProductAttribute() throws Exception {
        int updateProductId = 14;
        Statement stmt = createStmt();
        ResultSet rst = stmt.executeQuery("select * from products where id = '"+updateProductId+"';");

        adminController.updateproduct(updateProductId, model);

        String pname = "", pdescription = "", pimage = "", pcategoryName = "";
        int pid = 0, pprice = 0, pweight = 0, pquantity = 0, pcategory = 0;

        if (rst.next()) {
            pid = rst.getInt(1);
            pname = rst.getString(2);
            pimage = rst.getString(3);
            pcategory = rst.getInt(4);
            pquantity = rst.getInt(5);
            pprice =  rst.getInt(6);
            pweight =  rst.getInt(7);
            pdescription = rst.getString(8);
        }

        Statement stmt1 = createStmt();
        ResultSet rst1 = stmt1.executeQuery("select * from categories where categoryid = '"+pcategory+"';");
        if (rst1.next()) {
            pcategoryName = rst1.getString(2);
        }

        assertEquals(pid, model.getAttribute("pid"));
        assertEquals(pname, model.getAttribute("pname"));
        assertEquals(pimage, model.getAttribute("pimage"));
        assertEquals(pcategoryName, model.getAttribute("pcategory"));
        assertEquals(pquantity, model.getAttribute("pquantity"));
        assertEquals(pprice, model.getAttribute("pprice"));
        assertEquals(pweight, model.getAttribute("pweight"));
        assertEquals(pdescription, model.getAttribute("pdescription"));
    }
}
