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

  @Test
  public void userLoginSuccess() {
    open(BASE_URL);
    $(By.id("username")).sendKeys("user");
    $(By.id("password")).sendKeys("123");
    $(By.xpath("/html/body/div/div/form/input")).click();

    assertEquals("Welcome user", $(By.xpath("/html/body/section/div/nav/div/div/h4")).getText());
    assert($(By.xpath("/html/body/section/div/nav/div/div/h4")).isDisplayed());
  }

  @Test
  public void userLoginFailIncorrectPassword() {
    open(BASE_URL);
    $(By.id("username")).sendKeys("user");
    $(By.id("password")).sendKeys("1234");
    $(By.xpath("/html/body/div/div/form/input")).click();

    assertEquals("Invalid Username or Password", $(By.xpath("/html/body/div/div/form/h3")).getText());
    assert($(By.xpath("/html/body/div/div/form/h3")).isDisplayed());
  }

  @Test
  public void adminLoginSuccess() {
    open(BASE_URL + "admin");
    $(By.id("username")).sendKeys("admin");
    $(By.id("password")).sendKeys("123");
    $(By.xpath("/html/body/div/div/form/input")).click();

    assertEquals("Welcome Back, Admin", $(By.xpath("/html/body/div/h1")).getText());
    assert($(By.xpath("/html/body/div/h1")).isDisplayed());
  }

  @Test
  public void adminLoginFailIncorrectPassword() {
    open(BASE_URL + "admin");
    $(By.id("username")).sendKeys("admin");
    $(By.id("password")).sendKeys("1234");
    $(By.xpath("/html/body/div/div/form/input")).click();

    assertEquals("Invalid Username or Password", $(By.xpath("/html/body/div/div/form/h3")).getText());
    assert($(By.xpath("/html/body/div/div/form/h3")).isDisplayed());
  }

  @Test
  public void registerHereNavigatesToRegisterEndpoint() {
    open(BASE_URL);
    $(By.xpath("/html/body/div/div/form/span/a")).click();

    assertEquals(BASE_URL + "register", executeJavaScript("return window.location.href;"));
  }

  @Test
  public void productDisplayedOnHomePage() {
    open(BASE_URL);
    $(By.id("username")).sendKeys("user");
    $(By.id("password")).sendKeys("123");
    $(By.xpath("/html/body/div/div/form/input")).click();

    assertEquals("Burger", $(By.xpath("/html/body/section/div/div/div/div/div/div/div/div/div/div/div[2]/div[2]/h2")).getText());
    assert($(By.xpath("/html/body/section/div/div/div/div/div/div/div/div/div/div/div[2]/div[2]/h2")).isDisplayed());
  }

  @Test
  public void productChangesWhenArrayKeyPressed() throws InterruptedException {
    open(BASE_URL);
    $(By.id("username")).sendKeys("user");
    $(By.id("password")).sendKeys("123");
    $(By.xpath("/html/body/div/div/form/input")).click();

    assert($(By.xpath("/html/body/section/div/div/div/div/div/div/div/div/div/div/div[2]/div[2]/h2")).isDisplayed());

    $(By.xpath("/html/body/section/div/div/div/div/div/div/div/a[2]")).click();

    Thread.sleep(1000);
    assertFalse($(By.xpath("/html/body/section/div/div/div/div/div/div/div/div/div/div/div[2]/div[2]/h2")).isDisplayed());
    assert($(By.xpath("/html/body/section/div/div/div/div/div/div/div/div[2]/div/div/div[2]/div[2]/h2")).isDisplayed());
  }

  @Test
  public void productCarouselChangesAfterSomeTime() throws InterruptedException {
    open(BASE_URL);
    $(By.id("username")).sendKeys("user");
    $(By.id("password")).sendKeys("123");
    $(By.xpath("/html/body/div/div/form/input")).click();

    assert($(By.xpath("/html/body/section/div/div/div/div/div/div/div/div/div/div/div[2]/div[2]/h2")).isDisplayed());

    Thread.sleep(11000);
    assertFalse($(By.xpath("/html/body/section/div/div/div/div/div/div/div/div/div/div/div[2]/div[2]/h2")).isDisplayed());
    assert($(By.xpath("/html/body/section/div/div/div/div/div/div/div/div[2]/div/div/div[2]/div[2]/h2")).isDisplayed());
  }


}
