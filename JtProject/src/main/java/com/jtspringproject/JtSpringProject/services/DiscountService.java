package com.jtspringproject.JtSpringProject.services;

import com.jtspringproject.JtSpringProject.dao.DiscountDao;
import com.jtspringproject.JtSpringProject.dao.productDao;
import com.jtspringproject.JtSpringProject.models.Discount;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DiscountService {
    @Autowired
    productDao productrepo;
    @Autowired
    DiscountDao disrepo;


    public Discount adddiscount(Discount discount){
        disrepo.addDiscount(discount);
        return discount;
    }
    public void deletediscount(int id){
        disrepo.removeDiscount(id);
    }
    public List<Discount> getalldiscount(){
        return disrepo.getalldiscounts();
    }
}
