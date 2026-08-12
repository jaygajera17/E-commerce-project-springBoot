package com.jtspringproject.JtSpringProject.controller;

import com.jtspringproject.JtSpringProject.models.Product;
import com.jtspringproject.JtSpringProject.models.User;
import com.jtspringproject.JtSpringProject.services.productService;
import com.jtspringproject.JtSpringProject.services.userService;

import java.nio.file.AccessDeniedException;
import java.util.List;
import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UserController {

	private final userService userService;
	private final productService productService;

	@Autowired
	public UserController(userService userService, productService productService) {
		this.userService = userService;
		this.productService = productService;
	}

	@GetMapping("/register")
	public String registerUser() {
		return "register";
	}

	@GetMapping("/buy")
	public String buy() {
		return "buy";
	}

	@GetMapping("/login")
	public ModelAndView userLogin(@RequestParam(required = false) String error) {
		ModelAndView mv = new ModelAndView("userLogin");

		if ("true".equals(error)) {
			mv.addObject("msg", "Please enter correct email and password");
		}

		return mv;
	}

	@GetMapping("/")
	public ModelAndView indexPage() {
		ModelAndView mView = new ModelAndView("index");

		String username = SecurityContextHolder
				.getContext()
				.getAuthentication()
				.getName();

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
	public ModelAndView getProducts() {
		ModelAndView mView = new ModelAndView("uproduct");

		List<Product> products = this.productService.getProducts();

		if (products.isEmpty()) {
			mView.addObject("msg", "No products are available");
		} else {
			mView.addObject("products", products);
		}

		return mView;
	}

	@PostMapping("newuserregister")
	public ModelAndView registerNewUser(@ModelAttribute User user) {

		boolean exists = this.userService.checkUserExists(user.getUsername());

		if (!exists) {
			user.setRole("ROLE_NORMAL");
			this.userService.addUser(user);

			return new ModelAndView("userLogin");
		}

		ModelAndView mView = new ModelAndView("register");
		mView.addObject(
				"msg",
				user.getUsername() + " is taken. Please choose a different username."
		);

		return mView;
	}

	@GetMapping("/profileDisplay")
	public String profileDisplay(Model model) {

		String username = SecurityContextHolder
				.getContext()
				.getAuthentication()
				.getName();

		User user = userService.getUserByUsername(username);

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

	@PostMapping("/updateuser")
	public String updateUserProfile(
			@RequestParam("userid") int userid,
			@RequestParam("username") String username,
			@RequestParam("email") String email,
			@RequestParam("password") String password,
			@RequestParam("address") String address,
			Principal principal) throws AccessDeniedException {

		User updatedUser = this.userService.updateUserProfile(
				userid,
				principal.getName(),
				username,
				email,
				password,
				address
		);

		if (updatedUser != null) {
			refreshAuthenticatedPrincipal(username);
		}

		return "redirect:/";
	}

	private void refreshAuthenticatedPrincipal(String username) {

		Authentication currentAuthentication =
				SecurityContextHolder.getContext().getAuthentication();

		Authentication newAuthentication =
				new UsernamePasswordAuthenticationToken(
						username,
						currentAuthentication.getCredentials(),
						currentAuthentication.getAuthorities()
				);

		SecurityContextHolder.getContext()
				.setAuthentication(newAuthentication);
	}
}