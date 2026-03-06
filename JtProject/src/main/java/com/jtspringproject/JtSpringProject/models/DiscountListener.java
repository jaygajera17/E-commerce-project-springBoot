package com.jtspringproject.JtSpringProject.models;

import DTO.DiscountPrice;
import com.jtspringproject.JtSpringProject.services.DiscountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

@Component
public class DiscountListener {
    @Autowired
    DiscountService discountService;

    @EventListener
    public ResponseEntity<String> adddiscount(DiscountPrice discountPrice){
        Discount discount=new Discount();
        discount.setProductid(discountPrice.productid);
        discount.setOldprice(discountPrice.oldprice);
        discount.setNewprice(discountPrice.newprice);
        discountService.adddiscount(discount);
        return ResponseEntity.ok("Discount has been saved");
    }
}
