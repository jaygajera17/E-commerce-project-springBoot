package com.jtspringproject.JtSpringProject.controller;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.web.servlet.ModelAndView;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import com.jtspringproject.JtSpringProject.services.userService;
import com.jtspringproject.JtSpringProject.services.categoryService;

import com.jtspringproject.JtSpringProject.models.User;


@ExtendWith(MockitoExtension.class)
class AdminControllerTest {

    @Mock
    private userService userService;

    @Mock
    private  categoryService categoryService;

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


    @Test
    public void testRemoveCategoryDb_Success() {
        int categoryId = 5;

        // Mocking behavior of categoryService.deleteCategory
        when(categoryService.deleteCategory(categoryId)).thenReturn(true);

        // Calling the method to be tested
        ModelAndView modelAndView = adminController.removeCategoryDb(categoryId);

        // Verify that the correct ModelAndView is returned
        assertFalse(modelAndView.getModel().containsKey("delete"));
        assertEquals("redirect:/admin/categories", modelAndView.getViewName());


    }

    @Test
    public void testRemoveCategoryDb_Failure() {
        int categoryId = 1;

        // Mocking behavior of categoryService.deleteCategory
        when(categoryService.deleteCategory(categoryId)).thenReturn(false);

        // Calling the method to be tested
        ModelAndView modelAndView = adminController.removeCategoryDb(categoryId);

        // Verify that the correct ModelAndView is returned
        assertTrue(modelAndView.getModel().containsKey("delete"));
        assertEquals("redirect:/admin/categories", modelAndView.getViewName());

    }


}
