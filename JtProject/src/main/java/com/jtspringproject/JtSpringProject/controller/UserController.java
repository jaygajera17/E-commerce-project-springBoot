package com.jtspringproject.JtSpringProject.controller;

import DTO.AddToCartRequest;
import DTO.OrderRequest;
import com.jtspringproject.JtSpringProject.models.*;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.jtspringproject.JtSpringProject.services.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class UserController{

	private final UserService userService;
	private final ProductService productService;
	private final LogService logService;
	private final OrderService orderservice;
	private final CartService cartservice;

	@Autowired
	public UserController(UserService userService, ProductService productService,LogService logService,
						  OrderService orderservice, CartService cartservice) {
		this.userService = userService;
		this.productService = productService;
		this.logService=logService;
		this.orderservice=orderservice;
		this.cartservice=cartservice;
	}
	@Autowired
	DiscountService discountService;

	@GetMapping("/logs")
	public List<Logs> getalllogs(){
		return logService.getalllogs();
	}
	@GetMapping("/register")
	public String registerUser()
	{
		return "register";
	}

	@PostMapping("/Placeorder")
	@ResponseBody
	public ResponseEntity<String> placeOrderTest(@RequestBody OrderRequest order) {
		orderservice.placeorder(order);
		return ResponseEntity.ok("Order placed for userId=" + order.getUserId());
	}
    @GetMapping("/allorders")
	public List<Order> getallorders(){
		return this.orderservice.getallorders();
	}
	@GetMapping("/Discounts")
	public List<Discount> getalldiscount(){
		return discountService.getalldiscount();
	}
    @PostMapping("/addtocart")
	@ResponseBody
	public ResponseEntity<String> addtocart(@RequestBody AddToCartRequest req){
		cartservice.addProductToCart(req.getUserId(),req.getProductId());
		return ResponseEntity.ok("Product added to the cart");
	}

	@GetMapping("/login")
	public ModelAndView userlogin(@RequestParam(required = false) String error) {
	    ModelAndView mv = new ModelAndView("userLogin");
	    if ("true".equals(error)) {
	        mv.addObject("msg", "Please enter correct email and password");
	    }
	    return mv;
	}
	@GetMapping("/allusers")
	public List<User> getall(){
		return this.userService.getUsers();
	}

	@GetMapping("/searchproducts")
	@ResponseBody
	public Product getproductbyname(@RequestParam Long userid,@RequestParam String keyword){
		return productService.getProductByName(keyword,userid);
	}

	@GetMapping("/getallcarts")
	public List<Cart> getallcarts(){
		return cartservice.getCarts();
	}
	@GetMapping("/")
	public ModelAndView indexPage()
	{
		ModelAndView mView  = new ModelAndView("index");	
		String username = SecurityContextHolder.getContext().getAuthentication().getName();
		mView.addObject("username", username);
		List<Product> products = this.productService.getProducts();

		if (products.isEmpty()) {
			mView.addObject("msg", "No products are available");
		} else {
			mView.addObject("products", products);
		}
		return mView;
	}
	@GetMapping("/products")
	public List<Product> getallproduct(){
		return this.productService.getProducts();
	}

	@GetMapping("/user/products")
	public ModelAndView getproduct() {

		ModelAndView mView = new ModelAndView("uproduct");

		List<Product> products = this.productService.getProducts();

		if(products.isEmpty()) {
			mView.addObject("msg","No products are available");
		}else {
			mView.addObject("products",products);
		}

		return mView;
	}
   //  /newuser endpoint is made for testing the buying logic
	@PostMapping("/newuser")
	@ResponseBody
	public void adduser(@RequestBody User user){
		this.userService.addUser(user);
		this.cartservice.addCart(user);
	}
	@RequestMapping(value = "newuserregister", method = RequestMethod.POST)
	public ModelAndView newUseRegister(@ModelAttribute User user)
	{
		// Check if username already exists in database
		boolean exists = this.userService.checkUserExists(user.getUsername());

		if(!exists) {
			System.out.println(user.getEmail());
			user.setRole("ROLE_NORMAL");
			this.userService.addUser(user);
            this.cartservice.addCart(user);
			System.out.println("New user created: " + user.getUsername());
			ModelAndView mView = new ModelAndView("userLogin");
			return mView;
		} else {
			System.out.println("New user not created - username taken: " + user.getUsername());
			ModelAndView mView = new ModelAndView("register");
			mView.addObject("msg", user.getUsername() + " is taken. Please choose a different username.");
			return mView;
		}
	}

	@GetMapping("/profileDisplay")
	public String profileDisplay(Model model, HttpServletRequest request) {
		
		String username = SecurityContextHolder.getContext().getAuthentication().getName();
		User user = userService.getUserByUsername(username);
	
		if (user != null) {
			model.addAttribute("userid", user.getId());
			model.addAttribute("username", user.getUsername());
			model.addAttribute("email", user.getEmail());
			model.addAttribute("password", user.getPassword()); 
			model.addAttribute("address", user.getAddress());
	    } else {
	    	model.addAttribute("msg", "User not found");
	    } 

		return "updateProfile";
	}
	

	   //for Learning purpose of model
		@GetMapping("/test")
		public String Test(Model model)
		{
			System.out.println("test page");
			model.addAttribute("author","jay gajera");
			model.addAttribute("id",40);
			
			List<String> friends = new ArrayList<String>();
			model.addAttribute("f",friends);
			friends.add("xyz");
			friends.add("abc");
			
			return "test";
		}
		
		// for learning purpose of model and view ( how data is pass to view)
		
		@GetMapping("/test2")
		public ModelAndView Test2()
		{
			System.out.println("test page");
			//create modelandview object
			ModelAndView mv=new ModelAndView();
			mv.addObject("name","jay gajera 17");
			mv.addObject("id",40);
			mv.setViewName("test2");
			
			List<Integer> list=new ArrayList<Integer>();
			list.add(10);
			list.add(25);
			mv.addObject("marks",list);
			return mv;
			
			
		}


//	@GetMapping("carts")
//	public ModelAndView  getCartDetail()
//	{
//		ModelAndView mv= new ModelAndView();
//		List<Cart>carts = cartService.getCarts();
//	}
	  
}