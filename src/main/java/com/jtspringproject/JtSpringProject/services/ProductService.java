package com.jtspringproject.JtSpringProject.services;

import java.util.List;
import org.springframework.stereotype.Service;
import com.jtspringproject.JtSpringProject.repository.ProductRepository;
import com.jtspringproject.JtSpringProject.models.Product;

@Service
public class ProductService {

	private final ProductRepository productRepository;

	public ProductService(ProductRepository productRepository) {
		this.productRepository = productRepository;
	}

	public List<Product> getProducts() {
		return productRepository.findAll();
	}

	public Product addProduct(Product product) {
		return productRepository.save(product);
	}

	public Product getProduct(int id) {
		return productRepository.findById(id).orElse(null);
	}

	public Product updateProduct(int id, Product product) {
		product.setId(id);
		return productRepository.save(product); // .save() acts as update when ID is present
	}

	public boolean deleteProduct(int id) {
		if (productRepository.existsById(id)) {
			productRepository.deleteById(id);
			return true;
		}
		return false;
	}
}