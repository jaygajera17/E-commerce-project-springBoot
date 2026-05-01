package com.jtspringproject.JtSpringProject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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
import com.jtspringproject.JtSpringProject.services.categoryService;
import com.jtspringproject.JtSpringProject.services.productService;
import com.jtspringproject.JtSpringProject.services.userService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	private final userService userService;
	private final categoryService categoryService;
	private final productService productService;
	private static final String REDIRECT_ADMIN_PRODUCTS = "redirect:/admin/products";
	private static final String REDIRECT_ADMIN_CATEGORIES = "redirect:/admin/categories";
	private static final String VIEW_CATEGORIES = "categories";

	@Autowired
	public AdminController(userService userService, categoryService categoryService, productService productService) {
		this.userService = userService;
		this.categoryService = categoryService;
		this.productService = productService;
	}

	@GetMapping("/index")
	public String index(Model model) {
		String username = SecurityContextHolder.getContext().getAuthentication().getName();
		model.addAttribute("username", username);
		return "index";
	}

	@GetMapping("login")
	public ModelAndView adminLogin(@RequestParam(required = false) String error) {
		ModelAndView mv = new ModelAndView("adminlogin");
		if ("true".equals(error)) {
			mv.addObject("msg", "Invalid username or password. Please try again.");
		}
		return mv;
	}

	@GetMapping(value = { "/", "Dashboard" })
	public ModelAndView adminHome() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		ModelAndView mv = new ModelAndView("adminHome");
		mv.addObject("admin", authentication.getName());
		return mv;
	}

	@GetMapping("categories")
	public ModelAndView getCategories() {
		ModelAndView mView = new ModelAndView(VIEW_CATEGORIES);
		List<Category> categories = this.categoryService.getCategories();
		mView.addObject(VIEW_CATEGORIES, categories);
		return mView;
	}

	@PostMapping("/categories")
	public String addCategory(@RequestParam("categoryname") String categoryName) {
		this.categoryService.addCategory(categoryName);
		return REDIRECT_ADMIN_CATEGORIES;
	}

	@PostMapping("categories/delete")
	public String deleteCategory(@RequestParam("id") int id) {
		this.categoryService.deleteCategory(id);
		return REDIRECT_ADMIN_PRODUCTS;
	}

	@PostMapping("categories/update")
	public String updateCategory(@RequestParam("categoryid") int id,
			@RequestParam("categoryname") String categoryname) {
		this.categoryService.updateCategory(id, categoryname);
		return REDIRECT_ADMIN_CATEGORIES;
	}

	@GetMapping("products")
	public ModelAndView getProducts() {
		ModelAndView mView = new ModelAndView("products");

		List<Product> products = this.productService.getProducts();

		if (products.isEmpty()) {
			mView.addObject("msg", "No products are available");
		} else {
			mView.addObject("products", products);
		}
		return mView;
	}

	@GetMapping("products/add")
	public ModelAndView addProduct() {
		ModelAndView mView = new ModelAndView("productsAdd");
		List<Category> categories = this.categoryService.getCategories();
		mView.addObject(VIEW_CATEGORIES, categories);
		return mView;
	}

	@PostMapping("products/add")
	public String addProduct(@RequestParam("name") String name, @RequestParam("categoryid") int categoryId,
			@RequestParam("price") int price, @RequestParam("weight") int weight,
			@RequestParam("quantity") int quantity, @RequestParam("description") String description,
			@RequestParam("productImage") String productImage) {
		Product product = buildProduct(name, categoryId, price, weight, quantity, description, productImage);
		this.productService.addProduct(product);
		return REDIRECT_ADMIN_PRODUCTS;
	}

	@GetMapping("products/update/{id}")
	public ModelAndView getUpdateProductPage(@PathVariable("id") int id) {

		ModelAndView mView = new ModelAndView("productsUpdate");
		Product product = this.productService.getProduct(id);
		List<Category> categories = this.categoryService.getCategories();

		mView.addObject(VIEW_CATEGORIES, categories);
		mView.addObject("product", product);
		return mView;
	}

	@PostMapping("products/update/{id}")
	public String updateProduct(@PathVariable("id") int id, @RequestParam("name") String name,
			@RequestParam("categoryid") int categoryId, @RequestParam("price") int price,
			@RequestParam("weight") int weight, @RequestParam("quantity") int quantity,
			@RequestParam("description") String description, @RequestParam("productImage") String productImage) {
		Product product = buildProduct(name, categoryId, price, weight, quantity, description, productImage);
		this.productService.updateProduct(id, product);
		return REDIRECT_ADMIN_PRODUCTS;
	}

	@PostMapping("products/delete")
	public String removeProduct(@RequestParam("id") int id) {
		this.productService.deleteProduct(id);
		return REDIRECT_ADMIN_PRODUCTS;
	}

	@PostMapping("products")
	public String redirectProductsPost() {
		return REDIRECT_ADMIN_CATEGORIES;
	}

	@GetMapping("customers")
	public ModelAndView getCustomerDetail() {
		ModelAndView mView = new ModelAndView("displayCustomers");
		List<User> users = this.userService.getUsers();
		mView.addObject("customers", users);
		return mView;
	}

	@GetMapping("profileDisplay")
	public String profileDisplay(Model model) {
		String username = SecurityContextHolder.getContext().getAuthentication().getName();
		User user = this.userService.getUserByUsername(username);

		if (user != null) {
			model.addAttribute("userid", user.getId());
			model.addAttribute("username", user.getUsername());
			model.addAttribute("email", user.getEmail());
			model.addAttribute("password", "");
			model.addAttribute("address", user.getAddress());
		} else {
			model.addAttribute("msg", "User not found");
		}
		return "updateProfile";
	}

	@PostMapping("updateuser")
	public String updateUserProfile(@RequestParam("userid") int userid, @RequestParam("username") String username,
			@RequestParam("email") String email, @RequestParam("password") String password,
			@RequestParam("address") String address) {
		User updatedUser = this.userService.updateUserProfile(userid, username, email, password, address);
		if (updatedUser != null) {
			refreshAuthenticatedPrincipal(username);
		}
		return "redirect:index";
	}

	private void refreshAuthenticatedPrincipal(String username) {
		Authentication currentAuthentication = SecurityContextHolder.getContext().getAuthentication();
		Authentication newAuthentication = new UsernamePasswordAuthenticationToken(
				username,
				currentAuthentication.getCredentials(),
				currentAuthentication.getAuthorities());
		SecurityContextHolder.getContext().setAuthentication(newAuthentication);
	}

	private Product buildProduct(String name, int categoryId, int price, int weight, int quantity,
			String description, String productImage) {
		Category category = this.categoryService.getCategory(categoryId);
		Product product = new Product();
		product.setName(name);
		product.setCategory(category);
		product.setDescription(description);
		product.setPrice(price);
		product.setImage(productImage);
		product.setWeight(weight);
		product.setQuantity(quantity);
		return product;
	}

}
