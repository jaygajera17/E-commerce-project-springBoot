package com.jtspringproject.JtSpringProject;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.event.annotation.BeforeTestClass;

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

    @Test
    public void testShowCategory() {
        open(BASE_URL + "adminhome");
        $(By.xpath("/html/body/div[2]/div/div[1]/div/div/a")).click();
        assertEquals(BASE_URL + "admin/categories", executeJavaScript("return window.location.href;"));
    }
}
