package com.jtspringproject.JtSpringProject.repository;

import com.jtspringproject.JtSpringProject.models.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Integer> {
}