package com.jtspringproject.JtSpringProject.controller;

import java.util.List;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.jtspringproject.JtSpringProject.models.Category;
import com.jtspringproject.JtSpringProject.models.Product;
import com.jtspringproject.JtSpringProject.models.User;
import com.jtspringproject.JtSpringProject.services.CategoryService;
import com.jtspringproject.JtSpringProject.services.ProductService;
import com.jtspringproject.JtSpringProject.services.UserService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	private final UserService userService;
	private final CategoryService categoryService;
	private final ProductService productService;

	// Professional Constructor Injection
	public AdminController(UserService userService, CategoryService categoryService, ProductService productService) {
		this.userService = userService;
		this.categoryService = categoryService;
		this.productService = productService;
	}

	// ==========================================
	// DASHBOARD & AUTHENTICATION
	// ==========================================

	@GetMapping(value = {"/index", "/", "/Dashboard"})
	public ModelAndView adminHome() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		ModelAndView mv = new ModelAndView("adminHome");
		mv.addObject("admin", authentication.getName());
		return mv;
	}

	@GetMapping("/login")
	public ModelAndView adminlogin(@RequestParam(required = false) String error) {
		ModelAndView mv = new ModelAndView("adminlogin");
		if ("true".equals(error)) {
			mv.addObject("msg", "Invalid username or password. Please try again.");
		}
		return mv;
	}

	@GetMapping("/profileDisplay")
	public String profileDisplay(Model model) {
		String username = SecurityContextHolder.getContext().getAuthentication().getName();

		// FIXED: Replaced raw JDBC with Service call
		User user = userService.getUserByUsername(username);

		if (user != null) {
			model.addAttribute("userid", user.getId());
			model.addAttribute("username", user.getUsername());
			model.addAttribute("email", user.getEmail());
			model.addAttribute("address", user.getAddress());
			model.addAttribute("formAction", "/admin/updateuser");
			model.addAttribute("backLink", "/admin/");
			model.addAttribute("pageTitle", "Admin Profile");
		}
		return "updateProfile";
	}

	@PostMapping("/updateuser")
	public String updateUserProfile(@RequestParam("userid") int userid,
	                                @RequestParam("username") String username,
	                                @RequestParam("email") String email,
	                                @RequestParam(value = "password", required = false) String password,
	                                @RequestParam("address") String address,
	                                Model model) {

		try {
			User updatedUser = userService.updateProfile(userid, username, email, password, address);
			Authentication currentAuth = SecurityContextHolder.getContext().getAuthentication();
			Authentication newAuth = new UsernamePasswordAuthenticationToken(
					updatedUser.getUsername(),
					currentAuth.getCredentials(),
					currentAuth.getAuthorities()
			);
			SecurityContextHolder.getContext().setAuthentication(newAuth);
			return "redirect:/admin/profileDisplay";
		} catch (RuntimeException ex) {
			model.addAttribute("userid", userid);
			model.addAttribute("username", username);
			model.addAttribute("email", email);
			model.addAttribute("address", address);
			model.addAttribute("formAction", "/admin/updateuser");
			model.addAttribute("backLink", "/admin/");
			model.addAttribute("pageTitle", "Admin Profile");
			model.addAttribute("msg", ex.getMessage());
			return "updateProfile";
		}
	}

	// ==========================================
	// CATEGORY MANAGEMENT
	// ==========================================

	@GetMapping("/categories")
	public ModelAndView getcategory() {
		ModelAndView mView = new ModelAndView("categories");
		mView.addObject("categories", this.categoryService.getCategories());
		return mView;
	}

	@PostMapping("/categories")
	public String addCategory(@RequestParam("categoryname") String categoryName) {
		this.categoryService.addCategory(categoryName);
		return "redirect:/admin/categories";
	}

	@GetMapping("/categories/delete")
	public String removeCategoryDb(@RequestParam("id") int id) {
		this.categoryService.deleteCategory(id);
		return "redirect:/admin/categories";
	}

	@GetMapping("/categories/update")
	public String updateCategory(@RequestParam("categoryid") int id, @RequestParam("categoryname") String categoryName) {
		this.categoryService.updateCategory(id, categoryName);
		return "redirect:/admin/categories";
	}

	// ==========================================
	// PRODUCT MANAGEMENT
	// ==========================================

	@GetMapping("/products")
	public ModelAndView getproduct() {
		ModelAndView mView = new ModelAndView("products");
		List<Product> products = this.productService.getProducts();

		if (products.isEmpty()) {
			mView.addObject("msg", "No products are available");
		} else {
			mView.addObject("products", products);
		}
		return mView;
	}

	@GetMapping("/products/add")
	public ModelAndView addProductForm() {
		ModelAndView mView = new ModelAndView("productsAdd");
		mView.addObject("categories", this.categoryService.getCategories());
		return mView;
	}

	@PostMapping("/products/add")
	public String addProduct(@RequestParam("name") String name,
	                         @RequestParam("categoryid") int categoryId,
	                         @RequestParam("price") int price,
	                         @RequestParam("weight") int weight,
	                         @RequestParam("quantity") int quantity,
	                         @RequestParam("description") String description,
	                         @RequestParam("productImage") String productImage) {

		Category category = this.categoryService.getCategory(categoryId);
		Product product = new Product();
		// FIXED: Removed the buggy product.setId(categoryId)
		product.setName(name);
		product.setCategory(category);
		product.setDescription(description);
		product.setPrice(price);
		product.setImage(productImage);
		product.setWeight(weight);
		product.setQuantity(quantity);

		this.productService.addProduct(product);
		return "redirect:/admin/products";
	}

	@GetMapping("/products/update/{id}")
	public ModelAndView updateproductForm(@PathVariable("id") int id) {
		ModelAndView mView = new ModelAndView("productsUpdate");
		mView.addObject("categories", this.categoryService.getCategories());
		mView.addObject("product", this.productService.getProduct(id));
		return mView;
	}

	@PostMapping("/products/update/{id}")
	public String updateProduct(@PathVariable("id") int id,
	                            @RequestParam("name") String name,
	                            @RequestParam("categoryid") int categoryId,
	                            @RequestParam("price") int price,
	                            @RequestParam("weight") int weight,
	                            @RequestParam("quantity") int quantity,
	                            @RequestParam("description") String description,
	                            @RequestParam(value = "productImage", required = false) String productImage) {

		Product product = this.productService.getProduct(id);

		if (product != null) {
			product.setName(name);
			product.setCategory(this.categoryService.getCategory(categoryId));
			product.setPrice(price);
			product.setWeight(weight);
			product.setQuantity(quantity);
			product.setDescription(description);

			// FIXED: Only update image if a new one is provided
			if (productImage != null && !productImage.trim().isEmpty()) {
				product.setImage(productImage);
			}

			this.productService.updateProduct(id, product);
		}
		return "redirect:/admin/products";
	}

	@GetMapping("/products/delete")
	public String removeProduct(@RequestParam("id") int id) {
		this.productService.deleteProduct(id);
		return "redirect:/admin/products";
	}

	// ==========================================
	// CUSTOMER MANAGEMENT
	// ==========================================

	@GetMapping("/customers")
	public ModelAndView getCustomerDetail() {
		ModelAndView mView = new ModelAndView("displayCustomers");
		mView.addObject("customers", this.userService.getUsers());
		return mView;
	}
}
