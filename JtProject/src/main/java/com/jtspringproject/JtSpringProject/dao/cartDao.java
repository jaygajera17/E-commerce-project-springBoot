package com.jtspringproject.JtSpringProject.dao;
import java.util.List;

import com.jtspringproject.JtSpringProject.models.Cart;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface cartDao {

    public void setSessionFactory(SessionFactory sf);

    @Transactional
    public Cart addCart(Cart cart);

    @Transactional
    public List<Cart> getCarts();

    @Transactional
    public void updateCart(Cart cart);

    @Transactional
    public void deleteCart(Cart cart);
}
