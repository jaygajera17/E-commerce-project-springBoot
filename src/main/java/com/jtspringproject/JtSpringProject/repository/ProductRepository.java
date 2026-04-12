package com.jtspringproject.JtSpringProject.repository;

import com.jtspringproject.JtSpringProject.models.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {
}