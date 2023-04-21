package com.jtspringproject.JtSpringProject;

import com.codeborne.selenide.Condition;
import com.codeborne.selenide.SelenideElement;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.File;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import static com.codeborne.selenide.CollectionCondition.size;
import static com.codeborne.selenide.CollectionCondition.texts;
import static com.codeborne.selenide.Condition.readonly;
import static com.codeborne.selenide.Condition.visible;
import static com.codeborne.selenide.Selenide.*;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

@SpringBootTest
public class ProductGUI {
    static String BASE_URL = "http://localhost:8080/";

    @BeforeAll
    public static void login() {
        open(BASE_URL + "admin");
        $(By.id("username")).sendKeys("admin");
        $(By.id("password")).sendKeys("123");
        $(By.xpath("/html/body/div/div/form/input")).click();
    }

    // Helper function to return row number in product table
    private int countProduct() throws Exception {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
        Statement stmt = con.createStatement();
        ResultSet rst = stmt.executeQuery("select * from products;");
        int count = 0;
        while(rst.next()) {
            count++;
        }
        return count;
    }

    // Test show product route from admin control panel
    @Test
    public void testShowProductRoute() {
        open(BASE_URL + "adminhome");
        $(By.xpath("/html/body/div[2]/div/div[2]/div/div/a")).click();
        assertEquals(BASE_URL + "admin/products", executeJavaScript("return window.location.href;"));
    }

    // Test show product table attributes and action names
    @Test
    public void testShowProductTableStructure() {
        open(BASE_URL + "admin/products");
        $$("tbody:nth-child(1) tr").shouldHave(texts("Serial No. Product Name Category Preview Quantity Price Weight Descrption Delete Update"));
    }

    // Test show product table element size match with database
    @Test
    public void testShowCategoryTableSize() throws Exception {
        open(BASE_URL + "admin/products");
        $$("tbody:nth-child(2) tr").filter(visible).shouldHave(size(countProduct()));
    }

    // Test 'add product' button press, route to adding page, with read-only product id
    @Test
    public void testAddProductButtonRoute() throws Exception {
        open(BASE_URL + "admin/products");
        $(By.xpath("/html/body/div/a")).click();
        assertEquals(BASE_URL + "admin/products/add", executeJavaScript("return window.location.href;"));

        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
        Statement stmt = con.createStatement();
        ResultSet rst = stmt.executeQuery("select max(id) as id from products;");
        int count = 0;
        if (rst.next()) count = rst.getInt("id");

        SelenideElement id = $(By.xpath("/html/body/div/form/div/div[1]/div[1]/input"));
        // String v = id.getValue().toString();
        assertTrue(id.getValue().equals(Integer.toString(count + 1)));
        id.shouldBe(readonly);
    }

    // Test add product form field attribute 'required'
    @Test
    public void testAddProductEntryAttribute() {
        open(BASE_URL + "admin/products");
        $(By.xpath("/html/body/div/a")).click();
        $(By.name("name")).shouldHave(Condition.attribute("required"));
        $(By.name("categoryid")).shouldHave(Condition.attribute("required"));
        $(By.name("price")).shouldHave(Condition.attribute("required"));
        $(By.name("weight")).shouldHave(Condition.attribute("required"));
        $(By.name("quantity")).shouldHave(Condition.attribute("required"));
        $(By.name("description")).shouldNotHave(Condition.attribute("required"));
        $(By.name("productImage")).shouldNotHave(Condition.attribute("required"));
    }

    // Test table row number and data after adding a product
    @Test
    public void testAddProductRowAndData() throws Exception {
        int count = countProduct();
        open(BASE_URL + "admin/products");
        $(By.xpath("/html/body/div/a")).click();

        SelenideElement name = $(By.name("name"));
        SelenideElement category = $(By.name("categoryid"));
        SelenideElement price = $(By.name("price"));
        SelenideElement weight = $(By.name("weight"));
        SelenideElement quantity = $(By.name("quantity"));
        SelenideElement description = $(By.name("description"));

        // Data here
        name.sendKeys("iphone");
        //category.selectOptionByValue("test1");
        price.sendKeys("1000");
        weight.sendKeys("5");
        quantity.sendKeys("1");
        description.sendKeys("This is an iPhone 14 pro max.");
        String path = "src/main/webapp/WEB-INF/Product Images/iphone.JPG";
        String imageName = "iphone.JPG";
        $(By.name("productImage")).uploadFile(new File(path));

        $(By.xpath("/html/body/div/form/div/div[2]/input[2]")).click();

        assertEquals(count + 1, countProduct());  // check new row num
        // check data
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
        Statement stmt = con.createStatement();
        ResultSet rst = stmt.executeQuery("select * from products where id = '"+count+"';");
        if (rst.next()) {
            assertEquals("iphone", name.getValue());
            assertEquals("category8", category.getValue());
            assertEquals("1000", price.getValue());
            assertEquals("5", weight.getValue());
            assertEquals("1", quantity.getValue());
            assertEquals("This is an iPhone 14 pro max.", description.getValue());
            assertEquals(imageName, rst.getString("image"));
        }
    }

    // Test table row number after deleting (assume delete last one)
    @Test
    public void testRemoveCategoryRow() throws Exception {
        int count = countProduct();
        open(BASE_URL + "admin/products");

        $(By.xpath("/html/body/div/table/tbody[2]/tr[" + count + "]/td[9]/form/input[2]")).click();
        $$("tbody:nth-child(2) tr").filter(visible).shouldHave(size(count - 1));
    }

    // Test update button and corresponding route with product id (last one)
    @Test
    public void testUpdateProductRoute() throws Exception {
        int count = countProduct();
        open(BASE_URL + "admin/products");
        $(By.xpath("/html/body/div/table/tbody[2]/tr[" + count + "]/td[10]/form/input[2]")).click();

        // get product id
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
        Statement stmt = con.createStatement();
        ResultSet rst = stmt.executeQuery("select max(id) as id from products;");
        int id = 0;
        if (rst.next()) id = rst.getInt("id");

        assertEquals(BASE_URL + "admin/products/update?pid=" + id, executeJavaScript("return window.location.href;"));
        // assertEquals(Integer.toString(id), $(By.name("id")).getValue());
    }

    // Test update product form attributes
    @Test
    public void testUpdateProductFormAttribute() throws Exception {
        int count = countProduct();
        open(BASE_URL + "admin/products");
        $(By.xpath("/html/body/div/table/tbody[2]/tr[" + count + "]/td[10]/form/input[2]")).click();

        $(By.name("id")).shouldBe(readonly);
        $(By.name("categoryid")).shouldBe(readonly);

        $(By.name("name")).shouldNotBe(readonly);
        $(By.name("price")).shouldNotBe(readonly);
        $(By.name("weight")).shouldNotBe(readonly);
        $(By.name("quantity")).shouldNotBe(readonly);
        $(By.name("description")).shouldNotBe(readonly);
    }

    // Test update category - check if original data is showed on form (last element)
    // BUG: original description is not show in page
    @Test
    public void testUpdateProductOriginalData() throws Exception {
        int count = countProduct();
        open(BASE_URL + "admin/products");
        $(By.xpath("/html/body/div/table/tbody[2]/tr[" + count + "]/td[10]/form/input[2]")).click();

        SelenideElement name = $(By.name("name"));
        SelenideElement category = $(By.name("categoryid"));
        SelenideElement price = $(By.name("price"));
        SelenideElement weight = $(By.name("weight"));
        SelenideElement quantity = $(By.name("quantity"));
        SelenideElement description = $(By.name("description"));

        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
        Statement stmt = con.createStatement();
        ResultSet rst = stmt.executeQuery("select * from products where id = (select max(id) from products);");

        String catId = "";
        if (rst.next()) {
            catId = rst.getString("categoryid");
            assertEquals(rst.getString("name"), name.getValue());
            assertEquals(rst.getString("price"), price.getValue());
            assertEquals(rst.getString("weight"), weight.getValue());
            assertEquals(rst.getString("quantity"), quantity.getValue());
            assertEquals(rst.getString("description"), description.getValue());
        }
        Statement stmt1 = con.createStatement();
        ResultSet rst1 = stmt1.executeQuery("select name from categories where categoryid = '"+catId+"';");
        if (rst1.next()) {
            assertEquals(rst1.getString("name"), category.getValue());
        }
    }

    // Test update product - check updated value
    @Test
    public void testUpdateProductValue() throws Exception {
        int count = countProduct();
        open(BASE_URL + "admin/products");
        $(By.xpath("/html/body/div/table/tbody[2]/tr[" + count + "]/td[10]/form/input[2]")).click();

        SelenideElement name = $(By.name("name"));
        SelenideElement price = $(By.name("price"));
        SelenideElement description = $(By.name("description"));

        // update operation
        name.clear();
        name.sendKeys("updatedName");
        price.clear();
        price.sendKeys("123");
        description.clear();
        description.sendKeys("This is updated description");
        $(By.xpath("/html/body/div/form/div/div[2]/input[2]")).click();

        // check routing to product page
        assertEquals(BASE_URL + "admin/products", executeJavaScript("return window.location.href;"));

        // check if updated
        assertEquals("updatedName", $(By.xpath("/html/body/div/table/tbody[2]/tr[ " + count + " ]/td[2]")).getText());
        assertEquals("S 123", $(By.xpath("/html/body/div/table/tbody[2]/tr[ " + count + " ]/td[6]")).getText());
        assertEquals("This is updated description", $(By.xpath("/html/body/div/table/tbody[2]/tr[ " + count + " ]/td[8]")).getText());
    }
}