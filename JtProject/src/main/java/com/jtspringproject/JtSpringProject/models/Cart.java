package com.jtspringproject.JtSpringProject.models;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;


@Entity(name="CART")
public class Cart {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @ManyToOne
    @JoinColumn(name="customer_id")
    private User customer;

//    @ManyToMany
//    @JoinTable(
//            joinColumns = @JoinColumn(name = "cart_id"),
//            inverseJoinColumns = @JoinColumn(name = "product_id")
//    )
//    private List<Product> products;


    public Cart() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    public User getCustomer() {
        return customer;
    }

    public void setCustomer(User customer) {
        this.customer = customer;
    }

//    public List<Product> getProducts() {
//        return products;
//    }

//    public List<Product> getProductsByUser(int customer_id ) {
//        List<Product> userProducts = new ArrayList<Product>();
//        for (Product product : products) {
//            if (product.getCustomer().getId() == customer_id) {
//                userProducts.add(product);
//            }
//        }
//        return userProducts;
//    }

//    public void setProducts(List<Product> products) {
//        this.products = products;
//    }

//    public void addProduct(Product product) {
//        products.add(product);
//    }
//
//    public void removeProduct(Product product) {
//        products.remove(product);
//    }
}
