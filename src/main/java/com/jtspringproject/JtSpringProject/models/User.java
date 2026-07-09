package com.jtspringproject.JtSpringProject.models;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity(name = "CUSTOMER")
@Table
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(unique = true)
	private String username;

	@Column(nullable = false,updatable = false)
	private LocalDateTime createdAt;

	@PrePersist
	protected void onCreate(){
		createdAt = LocalDateTime.now();
	}

	private String email;

	private String password;

	private String role;

	private String address;

	@Column(length=20)
	private String phoneNumber;

	public enum PhoneValidation{
		NOT_VERIFIED,
		VERIFIED,
		PENDING
	}

	@Enumerated(EnumType.STRING)
	private PhoneValidation phoneValidation;

	public enum Badge{
		NONE,
		BRONZE,
		SILVER,
		GOLD,
		PLATINUM
	}

	@Enumerated(EnumType.STRING)
	private Badge badge;



	private int loyaltyPoints;

	public enum sellerVerificationStatus{
		PENDING,
		VERIFIED,
		REJECTED
	}

	@Enumerated(EnumType.STRING)
	private sellerVerificationStatus sellerVerificationStatus;

	public Badge getBadge() {
		return badge;
	}

	public void setBadge(Badge badge) {
		this.badge = badge;
	}

	public int getLoyaltyPoints() {
		return loyaltyPoints;
	}

	public void setLoyaltyPoints(int loyaltyPoints) {
		this.loyaltyPoints = loyaltyPoints;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public PhoneValidation getPhoneValidation() {
		return phoneValidation;
	}

	public void setPhoneValidation(PhoneValidation phoneValidation) {
		this.phoneValidation = phoneValidation;
	}

	public sellerVerificationStatus getSellerVerificationStatus() {
		return sellerVerificationStatus;
	}

	public void setSellerVerificationStatus(sellerVerificationStatus sellerVerificationStatus) {
		this.sellerVerificationStatus = sellerVerificationStatus;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

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

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

}
