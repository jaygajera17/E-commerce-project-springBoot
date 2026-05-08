package com.jtspringproject.JtSpringProject.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.jtspringproject.JtSpringProject.dao.userDao;
import com.jtspringproject.JtSpringProject.models.User;

@Service
public class userService {
	private final userDao userDao;
	private final PasswordEncoder passwordEncoder;

	@Autowired
	public userService(userDao userDao, @Lazy PasswordEncoder passwordEncoder) {
		this.userDao = userDao;
		this.passwordEncoder = passwordEncoder;
	}

	public List<User> getUsers() {
		return this.userDao.getAllUser();
	}

	public User addUser(User user) {
		try {
			if (user.getPassword() != null && !isPasswordEncoded(user.getPassword())) {
				user.setPassword(passwordEncoder.encode(user.getPassword()));
			}
			return this.userDao.saveUser(user);
		} catch (DataIntegrityViolationException e) {
			throw new IllegalStateException("Unable to create user due to data integrity constraints.", e);
		}
	}

	public boolean checkUserExists(String username) {
		return this.userDao.userExists(username);
	}

	public User getUserByUsername(String username) {
		User user = userDao.getUserByUsername(username);
		if (user != null && user.getPassword() != null && !isPasswordEncoded(user.getPassword())) {
			// Migrate legacy plain-text passwords to BCrypt when the user is loaded.
			user.setPassword(passwordEncoder.encode(user.getPassword()));
			userDao.saveUser(user);
		}
		return user;
	}

	public User getUserById(int id) {
		return this.userDao.getUserById(id);
	}

	public User updateUserProfile(int userId, String username, String email, String password, String address) {
		User existingUser = this.userDao.getUserById(userId);
		if (existingUser == null) {
			return null;
		}

		existingUser.setUsername(username);
		existingUser.setEmail(email);
		existingUser.setAddress(address);

		if (password != null && !password.trim().isEmpty()) {
			existingUser.setPassword(isPasswordEncoded(password) ? password : passwordEncoder.encode(password));
		}

		return this.userDao.saveUser(existingUser);
	}

	private boolean isPasswordEncoded(String password) {
		return password != null
				&& (password.startsWith("$2a$") || password.startsWith("$2b$") || password.startsWith("$2y$"));
	}
}
