package com.jtspringproject.JtSpringProject.repository;

import com.jtspringproject.JtSpringProject.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {

    // Auto-generates: SELECT * FROM CUSTOMER WHERE username = ?
    Optional<User> findByUsername(String username);

    // Auto-generates: SELECT COUNT(*) > 0 FROM CUSTOMER WHERE username = ?
    boolean existsByUsername(String username);
}