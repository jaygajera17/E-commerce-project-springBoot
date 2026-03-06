package com.jtspringproject.JtSpringProject.dao;

import com.jtspringproject.JtSpringProject.models.Discount;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public class DiscountDao {
    @Autowired
    SessionFactory session;
    @Transactional
    public Discount addDiscount(Discount discount){
        session.getCurrentSession().save(discount);
        return discount;
    }
    @Transactional
    public void removeDiscount(int productid){
        Discount discount=session.getCurrentSession().createQuery("FROM Discount d where d.productid= :id", Discount.class).
                setParameter("id",productid).uniqueResult();

        session.getCurrentSession().remove(discount);
    }
    @Transactional
    public List<Discount> getalldiscounts(){
        return session.getCurrentSession().createQuery("FROM Discount", Discount.class).list();
    }

}
