package com.jtspringproject.JtSpringProject.models;

import jakarta.persistence.*;
import lombok.Data;


@Entity(name="PRODUCT")
@Data
public class Product {
	@Id
	@Column(name = "product_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	private String image;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "category_id")
	private Category category;
	
	private int quantity;
	
	private int price;
	
	private int weight;
	
	private String description;


	@ManyToOne
    @JoinColumn(name = "customer_id")
    private User customer;
	
	
}
