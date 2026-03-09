package com.jtspringproject.JtSpringProject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.jtspringproject.JtSpringProject.models.Category;
import com.jtspringproject.JtSpringProject.services.categoryService;

@Controller
@RequestMapping("/admin")
public class AdminCategoryController {

	private final categoryService categoryService;

	@Autowired
	public AdminCategoryController(categoryService categoryService) {
		this.categoryService = categoryService;
	}

	@GetMapping("categories")
	public ModelAndView getCategories() {
		ModelAndView mView = new ModelAndView("categories");
		List<Category> categories = this.categoryService.getCategories();
		mView.addObject("categories", categories);
		return mView;
	}

	@PostMapping("/categories")
	public String addCategory(@RequestParam("categoryname") String categoryName) {
		this.categoryService.addCategory(categoryName);
		return "redirect:categories";
	}

	@GetMapping("categories/delete")
	public String removeCategory(@RequestParam("id") int id) {
		this.categoryService.deleteCategory(id);
		return "redirect:/admin/categories";
	}

	@GetMapping("categories/update")
	public String updateCategory(@RequestParam("categoryid") int id, @RequestParam("categoryname") String categoryName) {
		this.categoryService.updateCategory(id, categoryName);
		return "redirect:/admin/categories";
	}
}
