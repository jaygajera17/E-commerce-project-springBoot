package com.jtspringproject.JtSpringProject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.jtspringproject.JtSpringProject.models.Category;
import com.jtspringproject.JtSpringProject.models.Product;
import com.jtspringproject.JtSpringProject.services.categoryService;
import com.jtspringproject.JtSpringProject.services.productService;

@Controller
@RequestMapping("/admin")
public class AdminProductController {

	private final productService productService;
	private final categoryService categoryService;

	@Autowired
	public AdminProductController(productService productService, categoryService categoryService) {
		this.productService = productService;
		this.categoryService = categoryService;
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
	public ModelAndView addProductForm() {
		ModelAndView mView = new ModelAndView("productsAdd");
		List<Category> categories = this.categoryService.getCategories();
		mView.addObject("categories", categories);
		return mView;
	}

	@RequestMapping(value = "products/add", method = RequestMethod.POST)
	public String addProduct(@RequestParam("name") String name, @RequestParam("categoryid") int categoryId,
			@RequestParam("price") int price, @RequestParam("weight") int weight, @RequestParam("quantity") int quantity,
			@RequestParam("description") String description, @RequestParam("productImage") String productImage) {
		Category category = this.categoryService.getCategory(categoryId);
		Product product = new Product();
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

	@GetMapping("products/update/{id}")
	public ModelAndView updateProductForm(@PathVariable("id") int id) {
		ModelAndView mView = new ModelAndView("productsUpdate");
		Product product = this.productService.getProduct(id);
		List<Category> categories = this.categoryService.getCategories();
		mView.addObject("categories", categories);
		mView.addObject("product", product);
		return mView;
	}

	@RequestMapping(value = "products/update/{id}", method = RequestMethod.POST)
	public String updateProduct(@PathVariable("id") int id, @RequestParam("name") String name,
			@RequestParam("categoryid") int categoryId, @RequestParam("price") int price,
			@RequestParam("weight") int weight, @RequestParam("quantity") int quantity,
			@RequestParam("description") String description,
			@RequestParam(value = "productImage", required = false) String productImage) {
		Product product = this.productService.getProduct(id);
		product.setName(name);
		product.setCategory(this.categoryService.getCategory(categoryId));
		product.setPrice(price);
		product.setWeight(weight);
		product.setQuantity(quantity);
		product.setDescription(description);
		if (productImage != null && !productImage.trim().isEmpty()) {
			product.setImage(productImage);
		}
		this.productService.updateProduct(id, product);
		return "redirect:/admin/products";
	}

	@GetMapping("products/delete")
	public String removeProduct(@RequestParam("id") int id) {
		this.productService.deleteProduct(id);
		return "redirect:/admin/products";
	}

	@PostMapping("products")
	public String postProduct() {
		return "redirect:/admin/categories";
	}
}
