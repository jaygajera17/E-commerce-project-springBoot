package com.jtspringproject.JtSpringProject.models;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity(name="ORDER")
@Table(name = "ORDERS")
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long orderId;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL)
    private List<CartProduct> orderedProducts;

    @Enumerated(EnumType.STRING)
    private OrderStatus status;

    private LocalDateTime date;
    public Order() {
    }

    public OrderStatus getStatus() {
        return status;
    }

    public void setStatus(OrderStatus status) {
        this.status = status;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<CartProduct> getOrderedProducts() {
        return orderedProducts;
    }

    public void setOrderedProducts(List<CartProduct> orderedProducts) {
        this.orderedProducts = orderedProducts;
    }
}
