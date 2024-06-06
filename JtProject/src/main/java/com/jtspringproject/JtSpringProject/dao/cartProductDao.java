package com.jtspringproject.JtSpringProject.dao;

import com.jtspringproject.JtSpringProject.models.Cart;
import com.jtspringproject.JtSpringProject.models.CartProduct;
import com.jtspringproject.JtSpringProject.models.Product;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public class cartProductDao {
    @Autowired
    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sf) {
        this.sessionFactory = sf;
    }

    @Transactional
    public CartProduct addCartProduct(CartProduct cartProduct) {
        this.sessionFactory.getCurrentSession().save(cartProduct);
        return cartProduct;
    }

    @Transactional
    public List<CartProduct> getCartProducts() {
        return this.sessionFactory.getCurrentSession().createQuery("from CART_PRODUCT ").list();
    }

    @Transactional
    public List<Product> getProductByCartID(Integer cart_id) {
        String sql = "SELECT product_id FROM cart_product WHERE cart_id = :cart_id";
        List<Integer> productIds = this.sessionFactory.getCurrentSession()
                .createNativeQuery(sql)
                .setParameter("cart_id", cart_id)
                .list();

        sql = "SELECT * FROM product WHERE id IN (:product_ids)";
        return this.sessionFactory.getCurrentSession()
                .createNativeQuery(sql, Product.class)
                .setParameterList("product_ids", productIds)
                .list();
    }

    @Transactional
    public void updateCartProduct(CartProduct cartProduct) {
        this.sessionFactory.getCurrentSession().update(cartProduct);
    }

    @Transactional
    public void deleteCartProduct(CartProduct cartProduct) {
        this.sessionFactory.getCurrentSession().delete(cartProduct);
    }
}
