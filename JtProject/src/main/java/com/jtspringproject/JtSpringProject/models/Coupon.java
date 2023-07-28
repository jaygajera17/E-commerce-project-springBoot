package com.jtspringproject.JtSpringProject.models;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity(name = "COUPON")
@Table
public class Coupon {
    @Id
	@Column(name = "coupon_id")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int id;
	 
	/* 
	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "customer_id",referencedColumnName = "customer_id")
	private Product product;
	*/
	private int customerId;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}
}
