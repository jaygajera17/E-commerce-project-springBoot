package com.jtspringproject.JtSpringProject.services;

import java.util.List;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import com.jtspringproject.JtSpringProject.repository.UserRepository;
import com.jtspringproject.JtSpringProject.models.User;

@Service
public class UserService {

	private final UserRepository userRepository;
	private final PasswordEncoder passwordEncoder;

	public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
		this.userRepository = userRepository;
		this.passwordEncoder = passwordEncoder;
	}

	public List<User> getUsers() {
		return userRepository.findAll();
	}

	public User addUser(User user) {
		try {
			return userRepository.save(user);
		} catch (DataIntegrityViolationException e) {
			throw new RuntimeException("Add user error: Username or Email already exists.");
		}
	}

	public User checkLogin(String username, String password) {
		User user = userRepository.findByUsername(username).orElse(null);

		if (user != null && passwordEncoder.matches(password, user.getPassword())) {
			return user;
		}
		return new User();
	}

	public boolean checkUserExists(String username) {
		return userRepository.existsByUsername(username);
	}

	public User getUserByUsername(String username) {
		return userRepository.findByUsername(username).orElse(null);
	}

	public User getUserById(int id) {
		return userRepository.findById(id).orElse(null);
	}

	public User registerUser(User user) {
		if (checkUserExists(user.getUsername())) {
			throw new RuntimeException("Username already exists.");
		}

		user.setRole("ROLE_NORMAL");
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		return addUser(user);
	}

	public User updateProfile(int userId, String username, String email, String rawPassword, String address) {
		User user = getUserById(userId);
		if (user == null) {
			throw new RuntimeException("User not found.");
		}

		if (!user.getUsername().equals(username) && checkUserExists(username)) {
			throw new RuntimeException("Username already exists.");
		}

		user.setUsername(username);
		user.setEmail(email);
		user.setAddress(address);

		if (rawPassword != null && !rawPassword.isBlank()) {
			user.setPassword(passwordEncoder.encode(rawPassword));
		}

		return addUser(user);
	}
}
