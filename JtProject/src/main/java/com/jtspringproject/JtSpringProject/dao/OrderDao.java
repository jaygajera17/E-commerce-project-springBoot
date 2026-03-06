package com.jtspringproject.JtSpringProject.dao;

import com.jtspringproject.JtSpringProject.models.*;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import javax.persistence.LockModeType;
import java.time.LocalDateTime;
import java.util.List;
import static com.jtspringproject.JtSpringProject.models.OrderStatus.Accepted;

@Repository
public class OrderDao {
    @Autowired
    private SessionFactory sessionFactory;
    @Autowired
    private productDao productrepo;

    @Transactional
    public List<Order> getallordersperuser(long userid){
       return sessionFactory.getCurrentSession().createQuery("FROM ORDERS O where O.user.id= :userid",Order.class).
               setParameter("userid",userid)
               .list();
    }
    @Transactional
    public Order getorder(long orderid){
        return sessionFactory.getCurrentSession().createQuery("FROM ORDERS O where O.orderId= :orderid",Order.class).
                setParameter("orderid",orderid).uniqueResult();

    }
    @Transactional
    public List<Order> getallorder() {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "SELECT DISTINCT o FROM ORDER o LEFT JOIN FETCH o.orderedProducts",
                        Order.class
                )
                .list();
    }
    @Transactional
    public void placeOrder(List<CartProduct> cartProducts, long userId) {

        Session session = sessionFactory.getCurrentSession();
        User user = session.get(User.class, userId);

        Order order = new Order();
        order.setUser(user);
        order.setStatus(OrderStatus.ACCEPTED);
        order.setDate(LocalDateTime.now());
        session.save(order);

        for (CartProduct cp : cartProducts) {

            Product product = session.find(
                    Product.class,
                    cp.getProduct().getId(),
                    LockModeType.PESSIMISTIC_WRITE
            );
            int qtyToBuy = cp.getQuantity();
            int currentQty = product.getQuantity();

            if (currentQty < qtyToBuy) {
                throw new RuntimeException("Out of stock: " + product.getName());
            }

            product.setQuantity(currentQty - qtyToBuy);

            cp.setOrder(order);
            session.update(cp);
        }
    }
}
