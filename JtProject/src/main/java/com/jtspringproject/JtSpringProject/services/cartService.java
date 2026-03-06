package com.jtspringproject.JtSpringProject.services;

import com.jtspringproject.JtSpringProject.dao.cartDao;
import com.jtspringproject.JtSpringProject.dao.cartProductDao;
import com.jtspringproject.JtSpringProject.dao.productDao;
import com.jtspringproject.JtSpringProject.models.*;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartService {
    @Autowired
    public cartDao cartDao;
    @Autowired
    public cartProductDao cartproductrepo;
    @Autowired
    public productDao productrepo;

    public Cart addCart(User user) {
        return cartDao.addCart(user);
    }

    //    public Cart getCart(int id)
//    {
//        return cartDao.getCart(id);
//    }
    public List<Cart> getCarts() {
        return this.cartDao.getCarts();
    }

    public void updateCart(Cart cart) {
        cartDao.updateCart(cart);
    }

    public void deleteCart(Cart cart) {
        cartDao.deleteCart(cart);
    }

    public Cart getcart(int id){
        return cartDao.getcart(id);
    }

    public void addProductToCart(int userId, int productId) {

        Cart cart = cartDao.getcart(userId);
        Product product = productrepo.getProduct(productId); // or productDao

        if (cart == null || product == null) {
            throw new RuntimeException("Cart or Product not found");
        }

        CartProduct cartProduct =
                cartproductrepo.findByCartAndProduct(cart.getId(), productId);

        if (cartProduct == null) {
            CartProduct cp = new CartProduct();
            cp.setId(new CartProductId(cart.getId(), productId));
            cp.setCart(cart);
            cp.setProduct(product);
            cp.setQuantity(1);

            cartproductrepo.addCartProduct(cp);
        } else {
            cartProduct.setQuantity(cartProduct.getQuantity() + 1);
            cartproductrepo.updateCartProduct(cartProduct);
        }
    }
//    pubiic List<Cart> getCartByUserId(int customer_id){
//        return cartDao.getCartsByCustomerID(customer_id);
//    }


}
