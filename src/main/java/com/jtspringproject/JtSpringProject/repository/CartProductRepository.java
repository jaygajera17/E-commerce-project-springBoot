package com.jtspringproject.JtSpringProject.repository;

import com.jtspringproject.JtSpringProject.models.CartProduct;
import com.jtspringproject.JtSpringProject.models.CartProductId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CartProductRepository extends JpaRepository<CartProduct, CartProductId> {

    // Auto-generates the join required to find products in a specific cart
    List<CartProduct> findByCart_Id(int cartId);
}