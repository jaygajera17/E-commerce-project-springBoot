package com.jtspringproject.JtSpringProject.models;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity(name="Discount")
public class Discount {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public int id;
    public int productid;
    public int oldprice;
    public int newprice;

    public int getProductid() {
        return productid;
    }

    public void setProductid(int productid) {
        this.productid = productid;
    }

    public int getOldprice() {
        return oldprice;
    }

    public void setOldprice(int oldprice) {
        this.oldprice = oldprice;
    }

    public int getNewprice() {
        return newprice;
    }

    public void setNewprice(int newprice) {
        this.newprice = newprice;
    }
}
