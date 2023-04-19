package com.jtspringproject.JtSpringProject;

import com.fasterxml.jackson.databind.exc.MismatchedInputException;
import com.jtspringproject.JtSpringProject.controller.AdminController;
import static org.junit.jupiter.api.Assertions.*;

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

    // Blackbox - updateproducttodb - check return url
    @Test
    void testUpdateProductToDbURL() {
        int updateProductId = 16;
        String newName = "mango";
        int newPrice = 10;
        int newWeight = 100;
        int newQuantity = 20;
        String newDescripton = "This is a mango";
        String newImage = "1.jpg";

        assertEquals("redirect:/admin/products",
                adminController.updateproducttodb(updateProductId, newName, newPrice, newWeight, newQuantity, newDescripton, newImage));
    }

    // Whitebox - updateproducttodb - check database info
    @Test
    void testUpdateProductToDbData() throws Exception {
        int updateProductId = 16;
        String newName = "mango111";
        int newPrice = 30;
        int newWeight = 80;
        int newQuantity = 10;
        String newDescripton = "This is a mango111";
        String newImage = "1.jpg";
        adminController.updateproducttodb(updateProductId, newName, newPrice, newWeight, newQuantity, newDescripton, newImage);

        Statement stmt = createStmt();
        ResultSet rst = stmt.executeQuery("select * from products where id = '"+updateProductId+"';");

        adminController.updateproduct(updateProductId, model);

        String pname = "", pdescription = "", pimage = "", pcategoryName = "";
        int pprice = 0, pweight = 0, pquantity = 0;

        if (rst.next()) {
            pname = rst.getString(2);
            pimage = rst.getString(3);
            pquantity = rst.getInt(5);
            pprice =  rst.getInt(6);
            pweight =  rst.getInt(7);
            pdescription = rst.getString(8);
        }

        assertEquals(newName, pname);
        assertEquals(newImage, pimage);
        assertEquals(newQuantity, pquantity);
        assertEquals(newPrice, pprice);
        assertEquals(newWeight, pweight);
        assertEquals(newDescripton, pdescription);
    }

    // Blackbox - removeProductDb - check return url
    @Test
    void testRemoveProductDbURL() {
        int removeId = 16;
        assertEquals("redirect:/admin/products", adminController.removeProductDb(removeId));
    }

    // Blackbox - removeProductDb - check return url when removeId not exist
    @Test
    void testRemoveProductDbIdNotExist() {
        int removeId = 16;
        assertEquals("redirect:/admin/products", adminController.removeProductDb(removeId));
    }

    // Blackbox - removeProductDb: negative category id  [FAIL]
    @Test
    void testRemoveCategoryDBNeg() {
        int removeId = -1;
        Assertions.assertThrows(MismatchedInputException.class, () -> {adminController.removeProductDb(removeId);});
    }

    // Whitebox - removeProductDb - check database update
    @Test
    void testRemoveProductDbData() throws Exception {
        int removeId = 15;
        adminController.removeProductDb(removeId);
        Statement stmt = createStmt();
        ResultSet rst = stmt.executeQuery("select * from products where id = '"+removeId+"';");
        assertFalse(rst.next());
    }

    // Blackbox - postproduct: check return url
    @Test
    void testPostProductURL() {
        assertEquals("redirect:/admin/categories", adminController.postproduct());
    }

    // Blackbox / Whitebox - postproduct: check status code
    @Test
    void testPostProductStatus() {
        TestRestTemplate restTemplate = new TestRestTemplate();
        ResponseEntity<String> response = restTemplate.getForEntity(BASIC_URL + "/admin/products", String.class);
        assertEquals(HttpStatus.OK, response.getStatusCode());
    }

    // Blackbox - addproducttodb: check return url
    @Test
    void testAddProductToDbURL() {
        String name = "steam game";
        String catid = "test1";
        int price = 60;
        int weight = 10;
        int quantity = 999;
        String descripton = "New image added";
        String image = "2.jpg";

        assertEquals("redirect:/admin/products", adminController.addproducttodb(name, catid, price, weight, quantity, descripton, image));
    }

    // Whitebox - addproducttodb: check database update
    @Test
    void testAddProductToDbData() throws Exception {
        String name = "steam game 111";
        String catid = "test1";
        int price = 30;
        int weight = 30;
        int quantity = 1111;
        String descripton = "This is a popular steam game";
        String image = "1.jpg";

        adminController.addproducttodb(name, catid, price, weight, quantity, descripton, image);

        Statement stmt = createStmt();
        ResultSet rst = stmt.executeQuery("select * from products where name = '"+name+"';");

        String name1 = "", catname = "";
        int catid1 = 0, price1 = 0, weight1 = 0, quantity1 = 0;
        String descripton1 = "", image1 = "";

        if (rst.next()) {
            name1 = rst.getString("name");
            catid1 = rst.getInt("categoryid");
            image1 = rst.getString("image");
            quantity1 = rst.getInt("quantity");
            price1 = rst.getInt("price");
            weight1 = rst.getInt("weight");
            descripton1 = rst.getString("description");
        }

        Statement stmt1 = createStmt();
        ResultSet rst1 = stmt1.executeQuery("select * from categories where categoryid = '"+catid1+"';");
        if (rst1.next()) {
            catname = rst1.getString("name");
        }
        assertEquals(name, name1);
        assertEquals(catid, catname);
        assertEquals(image, image1);
        assertEquals(quantity, quantity1);
        assertEquals(price, price1);
        assertEquals(weight, weight1);
        assertEquals(descripton, descripton1);
    }

}
