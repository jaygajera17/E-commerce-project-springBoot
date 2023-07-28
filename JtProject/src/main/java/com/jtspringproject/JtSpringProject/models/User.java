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

@Entity(name = "CUSTOMER")
@Table
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;

	private String username;

	private String email;

	private String password;

	private String role;

	private double accumalatedPurchases = 0.0;

	private String customBasket;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public double getAccumalatedPurchases() {
		return this.accumalatedPurchases;
	}

	public void resetAccumalatedPurchases() {
		this.accumalatedPurchases = 0.0;
	}

	public void updateAccumalatedPurchases(double new_purchase) {
		this.accumalatedPurchases = this.accumalatedPurchases + new_purchase;
	}

	public String getCustomBasket() {
		return this.customBasket;
	}

	public void setCustomeBasket(String customBasketJSON) {
		this.customBasket = customBasketJSON;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", email=" + email + ", password=" + password + ", role="
				+ role + ", accumalated purchases=" + accumalatedPurchases + "]";
	}

}
