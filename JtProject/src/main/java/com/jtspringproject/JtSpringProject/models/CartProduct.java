package com.jtspringproject.JtSpringProject.models;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;


@Entity(name="CART_PRODUCT")
public class CartProduct {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @ManyToOne
    @JoinColumn(name="cart_id")
    private Cart cart;

    @ManyToOne
    @JoinTable(name="product_id")
    private Product product;


    public CartProduct() {
        product = null;
    }
    public CartProduct(Cart cart, Product product) {
        this.cart=cart;
        this.product = product;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}
