package com.jtspringproject.JtSpringProject.services;

import DTO.OrderRequest;
import com.jtspringproject.JtSpringProject.dao.OrderDao;
import com.jtspringproject.JtSpringProject.dao.cartDao;
import com.jtspringproject.JtSpringProject.dao.cartProductDao;
import com.jtspringproject.JtSpringProject.models.Cart;
import com.jtspringproject.JtSpringProject.models.CartProduct;
import com.jtspringproject.JtSpringProject.models.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderService {
    @Autowired
    OrderDao orderrepo;
    @Autowired
    cartProductDao cartproductrepo;
    @Autowired
    cartDao cartrepo;

    public void placeorder(OrderRequest order){
        Cart cart= cartrepo.getcart(order.getUserId());
        List<CartProduct> products=cartproductrepo.getProductByID(cart.getId());
        orderrepo.placeOrder(products, order.getUserId());
    }
    public List<Order> getallorders(){
       return orderrepo.getallorder();
    }
    public List<Order> getordersperuser(long userid){
        return orderrepo.getallordersperuser(userid);
    }
    public Order getorder(long orderid){
        return orderrepo.getorder(orderid);
    }
}
