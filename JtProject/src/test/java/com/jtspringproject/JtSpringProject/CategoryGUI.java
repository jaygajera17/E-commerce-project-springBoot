package com.jtspringproject.JtSpringProject;
import static com.codeborne.selenide.CollectionCondition.*;
import static com.codeborne.selenide.Condition.*;

import com.codeborne.selenide.Condition;
import com.codeborne.selenide.SelenideElement;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.springframework.boot.test.context.SpringBootTest;

import java.sql.*;

import static com.codeborne.selenide.Selenide.*;
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
public class CategoryGUI {
    static String BASE_URL = "http://localhost:8080/";

    @BeforeAll
    public static void login() {
        open(BASE_URL + "admin");
        $(By.id("username")).sendKeys("admin");
        $(By.id("password")).sendKeys("123");
        $(By.xpath("/html/body/div/div/form/input")).click();
    }

    // Helper function to return row number in category table
    private int countCategory() throws Exception {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
        Statement stmt = con.createStatement();
        ResultSet rst = stmt.executeQuery("select * from categories;");
        int count = 0;
        while(rst.next()) {
            count++;
        }
        return count;
    }

    // Test show category route from admin control panel
    @Test
    public void testShowCategoryRoute() {
        open(BASE_URL + "adminhome");
        $(By.xpath("/html/body/div[2]/div/div[1]/div/div/a")).click();
        assertEquals(BASE_URL + "admin/categories", executeJavaScript("return window.location.href;"));
    }

    // Test show category table attributes and action names
    @Test
    public void testShowCategoryTableStructure() {
        open(BASE_URL + "admin/categories");
        $$("thead tr th").shouldHave(texts("SN", "Category Name", "Delete", "Update"));
    }

    // Test show category table element size match with database
    @Test
    public void testShowCategoryTableSize() throws Exception {
        open(BASE_URL + "admin/categories");
        $$("tbody tr").filter(visible).shouldHave(size(countCategory()));
    }

    // Test 'add category' button press, show a new form; click close btn, form invisible
    @Test
    public void testAddCategoryButtonPrompt() {
        open(BASE_URL + "admin/categories");
        $(By.xpath("/html/body/div/button")).click();
        SelenideElement form = $(By.xpath("//*[@id=\"exampleModalCenter\"]/div/div/form"));
        form.shouldBe(visible);
        $(By.xpath("//*[@id=\"exampleModalCenter\"]/div/div/form/div[3]/button")).click();
        form.shouldNotBe(visible);
    }

    // Test add form mandatory field attribute 'required'
    @Test
    public void testAddCategoryEntryAttribute() {
        open(BASE_URL + "admin/categories");
        $(By.xpath("/html/body/div/button")).click();
        $(By.id("name")).shouldHave(Condition.attribute("required"));
        //$(By.xpath("//*[@id=\"exampleModalCenter\"]/div/div/form/div[3]/input")).click();
        //$(By.id("name")).shouldHave(text("Please fill out this field."));
    }

    // Test table row number and data after adding
    @Test
    public void testAddCategoryRowAndData() throws Exception {
        int count = countCategory();
        open(BASE_URL + "admin/categories");
        $(By.xpath("/html/body/div/button")).click();
        $(By.id("name")).sendKeys("newCategory");
        $(By.xpath("//*[@id=\"exampleModalCenter\"]/div/div/form/div[3]/input")).click();
        $$("tbody tr").filter(visible).shouldHave(size(count + 1));
        $$("tbody tr:nth-child(" + (count+1) + ")  td:nth-child(2)").shouldHave(texts("newCategory"));
    }

    // Test table row number after deleting
    @Test
    public void testRemoveCategoryRow() throws Exception {
        int count = countCategory();
        open(BASE_URL + "admin/categories");
        $(By.xpath("/html/body/div/table/tbody/tr[5]/td[3]/form/input[2]")).click();
        $$("tbody tr").filter(visible).shouldHave(size(count - 1));
    }

    // Test update btn form prompted (show and close form)
    @Test
    public void testUpdateBtnShowAndCloseForm() {
        open(BASE_URL + "admin/categories");
        $(By.xpath("/html/body/div/table/tbody/tr[2]/td[4]/form/button")).click();
        SelenideElement form = $(By.xpath("//*[@id=\"exampleModalCenter2\"]/div/div"));
        form.shouldBe(visible);
        $(By.xpath("//*[@id=\"exampleModalCenter2\"]/div/div/div[3]/button[1]")).click();
        form.shouldNotBe(visible);
    }

    // Test update category - check if original data is showed on form (1st element)
    @Test
    public void testUpdateCategoryOriginalData() {
        int elemId = 1;
        open(BASE_URL + "admin/categories");
        String SN = $(By.xpath("/html/body/div/table/tbody/tr[" + elemId + "]/td[1]")).getText();
        String categoryName = $(By.xpath("/html/body/div/table/tbody/tr[" + elemId + "]/td[2]")).getText();

        $(By.xpath("/html/body/div/table/tbody/tr[" + elemId + "]/td[4]/form/button")).click();
        assertEquals(SN, $(By.id("categoryid")).getValue());
        assertEquals(categoryName, $(By.id("categoryname")).getValue());
    }

    // Test update category - check updated value
    @Test
    public void testUpdateCategoryNewValue() {
        int elemId = 1;
        String newCategory = "category8";
        open(BASE_URL + "admin/categories");
        $(By.xpath("/html/body/div/table/tbody/tr[" + elemId + "]/td[4]/form/button")).click();
        $(By.id("categoryname")).clear();
        $(By.id("categoryname")).sendKeys(newCategory);
        $(By.xpath("//*[@id=\"exampleModalCenter2\"]/div/div/div[3]/button[2]")).submit();
        String updatedValue = $(By.xpath("/html/body/div/table/tbody/tr[" + elemId + "]/td[2]")).getText();
        assertEquals(newCategory, updatedValue);
    }
}
