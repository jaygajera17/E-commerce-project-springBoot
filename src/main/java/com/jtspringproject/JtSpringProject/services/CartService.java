package com.jtspringproject.JtSpringProject.services;

import java.util.List;
import org.springframework.stereotype.Service;
import com.jtspringproject.JtSpringProject.repository.CartRepository;
import com.jtspringproject.JtSpringProject.models.Cart;

@Service
public class CartService {

    private final CartRepository cartRepository;

    public CartService(CartRepository cartRepository) {
        this.cartRepository = cartRepository;
    }

    public Cart addCart(Cart cart) {
        return cartRepository.save(cart);
    }

    public List<Cart> getCarts() {
        return cartRepository.findAll();
    }

    public void updateCart(Cart cart) {
        cartRepository.save(cart);
    }

    public void deleteCart(Cart cart) {
        cartRepository.delete(cart);
    }

    public Cart getCartByUserId(int customerId) {
        return cartRepository.findByCustomer_Id(customerId).orElse(null);
    }
}