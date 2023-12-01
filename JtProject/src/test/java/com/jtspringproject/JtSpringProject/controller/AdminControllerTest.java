package com.jtspringproject.JtSpringProject.controller;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.web.servlet.ModelAndView;

import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import com.jtspringproject.JtSpringProject.services.userService;

import com.jtspringproject.JtSpringProject.models.User;


@ExtendWith(MockitoExtension.class)
class AdminControllerTest {

    @Mock
    private userService userService;

    @InjectMocks
    private AdminController adminController;

    @Test
    public void testAdminLoginValidUser() {

        User mockUser = mock(User.class);

        // Mocking the behavior of userService.checkLogin
        when(userService.checkLogin(anyString(), anyString())).thenReturn(mockUser);

        // Mocking the behavior of the returned user
        when(mockUser.getRole()).thenReturn("ROLE_ADMIN");

        // Calling the method under test
        ModelAndView result = adminController.adminlogin("admin", "123");


        // Asserting the view name
        assertEquals("adminHome", result.getViewName());
    }

    @Test
    public void test1AdminLoginValidUser() {

        User mockUser = mock(User.class);

        // Mocking the behavior of userService.checkLogin
        when(userService.checkLogin(anyString(), anyString())).thenReturn(mockUser);

        // Mocking the behavior of the returned user
        when(mockUser.getRole()).thenReturn("ROLE_NORMAL");

        // Calling the method under test
        ModelAndView result = adminController.adminlogin("admin1", "123");


        // Asserting the view name
        assertEquals("adminlogin", result.getViewName());
    }

    @Test
    public void test2AdminLoginValidUser() {

        User mockUser = mock(User.class);

        // Mocking the behavior of userService.checkLogin
        when(userService.checkLogin(anyString(), anyString())).thenReturn(mockUser);

        // Mocking the behavior of the returned user
        when(mockUser.getRole()).thenReturn(null);

        // Calling the method under test
        ModelAndView result = adminController.adminlogin("admin", "125");


        // Asserting the view name
        assertEquals("adminlogin", result.getViewName());
    }


}
