package com.jtspringproject.JtSpringProject.models;
import java.util.List;

import jakarta.persistence.*;
import lombok.Data;


@Entity(name="CUSTOMER")
@Table
@Data
public class User {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	@Column(unique = true)
	private String username;
	
	private String email;
	
	private String password;
	
	private String role;
	
	private String address;

	
	 

}
