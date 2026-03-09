package com.jtspringproject.JtSpringProject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.jtspringproject.JtSpringProject.models.User;
import com.jtspringproject.JtSpringProject.services.userService;

@Controller
@RequestMapping("/admin")
public class AdminCustomerController {

	private final userService userService;

	@Autowired
	public AdminCustomerController(userService userService) {
		this.userService = userService;
	}

	@GetMapping("customers")
	public ModelAndView getCustomers() {
		ModelAndView mView = new ModelAndView("displayCustomers");
		List<User> users = this.userService.getUsers();
		mView.addObject("customers", users);
		return mView;
	}

	@GetMapping("customers/delete")
	public String deleteCustomer(@RequestParam("id") int id) {
		this.userService.deleteUser(id);
		return "redirect:/admin/customers";
	}

	@GetMapping("customers/toggleActive")
	public String toggleCustomerActive(@RequestParam("id") int id) {
		this.userService.toggleUserActive(id);
		return "redirect:/admin/customers";
	}
}
