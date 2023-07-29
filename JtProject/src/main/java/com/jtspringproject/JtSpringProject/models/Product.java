package com.jtspringproject.JtSpringProject.models;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

import org.hibernate.procedure.ProcedureCallMemento;

@Entity(name="PRODUCT")
public class Product {
	@Id
	@Column(name = "product_id")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int id;
	
	private String name;
	
	private String image;
	
	private int quantity;
	
	private int price;

	private int pairedProduct;
	 
	/* 
	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "paired_product_id",referencedColumnName = "paired_product_id")
	private Product product;
	*/

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public int getPairedProduct() {
		return pairedProduct;
	}

	public void setPairedProduct(int pairedProduct) {
		this.pairedProduct = pairedProduct;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}
	
	/* 
	@ManyToOne
    @JoinColumn(name = "customer_id")
    private User customer;
	*/

	public void setProductValues(String name, String image, int paired_product, int quantity, int price) {
		this.name = name;
		this.image = image;
		this.pairedProduct = paired_product;
		this.quantity = quantity;
		this.price = price;
	}
	
}
