package com.jtspringproject.JtSpringProject.dao;

import java.util.List;

import com.jtspringproject.JtSpringProject.models.Cart;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface cartDao {

    @Transactional
    public Cart addCart(Cart cart);

    @Transactional
    public List<Cart> getCarts();

//    @Transactional
//    public List<Cart> getCartsByCustomerID(Integer customer_id) {
//        String hql = "from CART where CART.customer_id = :customer_id";
//        return this.sessionFactory.getCurrentSession()
//                .createQuery(hql, Cart.class)
//                .setParameter("customer_id", customer_id)
//                .list();
//    }

    @Transactional
    public void updateCart(Cart cart);

    @Transactional
    public void deleteCart(Cart cart);
}
