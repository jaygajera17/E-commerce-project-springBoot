package com.jtspringproject.JtSpringProject.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.jtspringproject.JtSpringProject.models.Cart;
import com.jtspringproject.JtSpringProject.models.Product;
import com.jtspringproject.JtSpringProject.models.User;
import com.jtspringproject.JtSpringProject.models.CartProduct;
import com.jtspringproject.JtSpringProject.models.CartProductId;
import com.jtspringproject.JtSpringProject.repository.CartProductRepository;
import com.jtspringproject.JtSpringProject.services.CartService;
import com.jtspringproject.JtSpringProject.services.ProductService;
import com.jtspringproject.JtSpringProject.services.UserService;

@Controller
public class UserController {

	// Dependencies marked as final for immutability
	private final UserService userService;
	private final ProductService productService;
	private final CartService cartService;
	private final CartProductRepository cartProductRepository;

	// Professional Constructor Injection
	public UserController(UserService userService, ProductService productService, CartService cartService, CartProductRepository cartProductRepository) {
		this.userService = userService;
		this.productService = productService;
		this.cartService = cartService;
		this.cartProductRepository = cartProductRepository;
	}

	@GetMapping("/register")
	public String registerUser() {
		return "register";
	}

	@GetMapping("/buy")
	public String buy() {
		return "buy";
	}

	@GetMapping("/403")
	public ModelAndView accessDenied() {
		return new ModelAndView("403");
	}

	@GetMapping("/login")
	public ModelAndView userlogin(@RequestParam(required = false) String error) {
		ModelAndView mv = new ModelAndView("userLogin");
		if ("true".equals(error)) {
			mv.addObject("msg", "Invalid username or password. Please try again.");
		}
		return mv;
	}

	@GetMapping("/")
	public ModelAndView indexPage() {
		ModelAndView mView = new ModelAndView("index");
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = (authentication == null || authentication instanceof AnonymousAuthenticationToken)
				? "Guest"
				: authentication.getName();
		mView.addObject("username", username);

		List<Product> products = this.productService.getProducts();
		if (products.isEmpty()) {
			mView.addObject("msg", "No products are available");
		} else {
			mView.addObject("products", products);
		}
		return mView;
	}

	@GetMapping("/user/products")
	public ModelAndView getproduct() {
		ModelAndView mView = new ModelAndView("uproduct");
		List<Product> products = this.productService.getProducts();

		if(products.isEmpty()) {
			mView.addObject("msg","No products are available");
		} else {
			mView.addObject("products", products);
		}
		return mView;
	}

	// Modernized to @PostMapping
	@PostMapping("/newuserregister")
	public ModelAndView newUseRegister(@ModelAttribute User user) {
		try {
			this.userService.registerUser(user);
			ModelAndView mView = new ModelAndView("userLogin");
			mView.addObject("msg", "Account created. Sign in with your new credentials.");
			return mView;
		} catch (RuntimeException ex) {
			ModelAndView mView = new ModelAndView("register");
			mView.addObject("msg", ex.getMessage());
			return mView;
		}
	}

	@GetMapping("/profileDisplay")
	public String profileDisplay(Model model) {
		String username = SecurityContextHolder.getContext().getAuthentication().getName();
		User user = userService.getUserByUsername(username);

		if (user != null) {
			model.addAttribute("userid", user.getId());
			model.addAttribute("username", user.getUsername());
			model.addAttribute("email", user.getEmail());
			model.addAttribute("address", user.getAddress());
			model.addAttribute("formAction", "/updateuser");
			model.addAttribute("backLink", "/");
			model.addAttribute("pageTitle", "Update Profile");
		} else {
			model.addAttribute("msg", "User not found");
		}
		return "updateProfile";
	}

	@PostMapping("/updateuser")
	public String updateUserProfile(@RequestParam("userid") int userId,
	                                @RequestParam("username") String username,
	                                @RequestParam("email") String email,
	                                @RequestParam(value = "password", required = false) String password,
	                                @RequestParam("address") String address,
	                                Model model) {

		try {
			User updatedUser = userService.updateProfile(userId, username, email, password, address);
			Authentication currentAuth = SecurityContextHolder.getContext().getAuthentication();
			Authentication newAuth = new org.springframework.security.authentication.UsernamePasswordAuthenticationToken(
					updatedUser.getUsername(),
					currentAuth.getCredentials(),
					currentAuth.getAuthorities()
			);
			SecurityContextHolder.getContext().setAuthentication(newAuth);
			return "redirect:/profileDisplay";
		} catch (RuntimeException ex) {
			model.addAttribute("userid", userId);
			model.addAttribute("username", username);
			model.addAttribute("email", email);
			model.addAttribute("address", address);
			model.addAttribute("formAction", "/updateuser");
			model.addAttribute("backLink", "/");
			model.addAttribute("pageTitle", "Update Profile");
			model.addAttribute("msg", ex.getMessage());
			return "updateProfile";
		}
	}

	// FIXED: Uncommented and wired up the Cart endpoint properly
	@GetMapping("/user/cartproducts")
	public ModelAndView getCartDetail() {
		ModelAndView mv = new ModelAndView("cartproduct");
		String username = SecurityContextHolder.getContext().getAuthentication().getName();
		User user = userService.getUserByUsername(username);

		if (user != null) {
			Cart userCart = cartService.getCartByUserId(user.getId());
			if (userCart != null) {
				List<CartProduct> cpList = cartProductRepository.findByCart_Id(userCart.getId());
				List<Product> prods = new ArrayList<>();
				for(CartProduct cp : cpList) prods.add(cp.getProduct());
				mv.addObject("cartProducts", prods);
			}
		}
		return mv;
	}

	@PostMapping("/user/addtocart")
	public String addToCart(@RequestParam("productId") int productId) {
		String username = SecurityContextHolder.getContext().getAuthentication().getName();
		User user = userService.getUserByUsername(username);
		Product product = productService.getProduct(productId);

		if (user == null || product == null) {
			return "redirect:/";
		}

		Cart cart = cartService.getCartByUserId(user.getId());
		if (cart == null) {
			cart = new Cart();
			cart.setCustomer(user);
			cart = cartService.addCart(cart);
		}

		CartProductId cartProductId = new CartProductId(cart.getId(), product.getId());
		if (!cartProductRepository.existsById(cartProductId)) {
			cartProductRepository.save(new CartProduct(cart, product));
		}

		return "redirect:/user/cartproducts";
	}

	@GetMapping("/user/cart/delete")
	public String removeFromCart(@RequestParam("id") int productId) {
		String username = SecurityContextHolder.getContext().getAuthentication().getName();
		User user = userService.getUserByUsername(username);

		if (user != null) {
			Cart cart = cartService.getCartByUserId(user.getId());
			if (cart != null) {
				CartProductId cartProductId = new CartProductId(cart.getId(), productId);
				if (cartProductRepository.existsById(cartProductId)) {
					cartProductRepository.deleteById(cartProductId);
				}
			}
		}
		return "redirect:/user/cartproducts";
	}

	// ==========================================
	// LEARNING & TEST ENDPOINTS
	// ==========================================

	@GetMapping("/test")
	public String Test(Model model) {
		model.addAttribute("author","jay gajera");
		model.addAttribute("id",40);

		List<String> friends = new ArrayList<>();
		friends.add("xyz");
		friends.add("abc");
		model.addAttribute("f", friends);

		return "test";
	}

	@GetMapping("/test2")
	public ModelAndView Test2() {
		ModelAndView mv = new ModelAndView("test2");
		mv.addObject("name","jay gajera 17");
		mv.addObject("id",40);

		List<Integer> list = new ArrayList<>();
		list.add(10);
		list.add(25);
		mv.addObject("marks", list);

		return mv;
	}
}
