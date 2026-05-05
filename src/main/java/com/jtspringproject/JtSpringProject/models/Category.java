package com.jtspringproject.JtSpringProject.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;

@Entity(name="CATEGORY")
@Data
public class Category {
	@Id
	@Column(name = "category_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	private String name;

	
}
