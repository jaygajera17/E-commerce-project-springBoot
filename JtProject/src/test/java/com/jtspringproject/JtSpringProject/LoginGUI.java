package com.jtspringproject.JtSpringProject;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.springframework.boot.test.context.SpringBootTest;

import static com.codeborne.selenide.Selenide.*;
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
public class LoginGUI {
  static String BASE_URL = "http://localhost:8080/";

  @Test
  public void userLogout() {
    open(BASE_URL);
    $(By.id("username")).sendKeys("user");
    $(By.id("password")).sendKeys("123");
    $(By.xpath("/html/body/div/div/form/input")).click();

    $(By.xpath("/html/body/section/div/nav/div/div/ul/li[3]")).click();
    assertEquals(BASE_URL + "logout", executeJavaScript("return window.location.href;"));
  }

  @Test
  public void adminLogout() {
    open(BASE_URL + "admin");
    $(By.id("username")).sendKeys("admin");
    $(By.id("password")).sendKeys("123");
    $(By.xpath("/html/body/div/div/form/input")).click();

    $(By.xpath("/html/body/nav/div/div/ul/li[2]")).click();
    assertEquals(BASE_URL + "logout", executeJavaScript("return window.location.href;"));
  }
}
