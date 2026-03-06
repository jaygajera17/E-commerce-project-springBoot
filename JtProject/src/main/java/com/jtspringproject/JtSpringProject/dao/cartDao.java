package com.jtspringproject.JtSpringProject.dao;

import java.util.List;

import com.jtspringproject.JtSpringProject.models.Cart;
import com.jtspringproject.JtSpringProject.models.Category;
import com.jtspringproject.JtSpringProject.models.User;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class cartDao {
    @Autowired
    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sf) {
        this.sessionFactory = sf;
    }

    @Transactional
    public Cart addCart(User user) {
        Cart cart=new Cart();
        cart.setCustomer(user);
        this.sessionFactory.getCurrentSession().save(cart);
        return cart;
    }

    @Transactional
    public Cart getcart(long userid){
        return sessionFactory.getCurrentSession().createQuery("From CART c where c.customer.id= :id",Cart.class)
                .setParameter("id",userid).uniqueResult();
    }
    @Transactional
    public List<Cart> getCarts() {
        return this.sessionFactory.getCurrentSession().createQuery("from CART").list();
    }

//    @Transactional
//    public List<Cart> getCartsByCustomerID(Integer customer_id) {
//        String hql = "from CART where CART.customer_id = :customer_id";
//        return this.sessionFactory.getCurrentSession()
//                .createQuery(hql, Cart.class)
//                .setParameter("customer_id", customer_id)
//                .list();
//    }

    @Transactional
    public void updateCart(Cart cart) {
        this.sessionFactory.getCurrentSession().update(cart);
    }

    @Transactional
    public void deleteCart(Cart cart) {
        this.sessionFactory.getCurrentSession().delete(cart);
    }
}
