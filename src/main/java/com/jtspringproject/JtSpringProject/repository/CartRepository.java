package com.jtspringproject.JtSpringProject.repository;

import com.jtspringproject.JtSpringProject.models.Cart;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CartRepository extends JpaRepository<Cart, Integer> {
    // Finds a cart linked to a specific customer ID
    Optional<Cart> findByCustomer_Id(int customerId);
}