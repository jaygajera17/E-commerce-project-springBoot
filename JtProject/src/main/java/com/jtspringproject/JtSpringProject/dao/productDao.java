package com.jtspringproject.JtSpringProject.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.jtspringproject.JtSpringProject.models.Product;

@Repository
public interface productDao {
	
	public void setSessionFactory(SessionFactory sf);
	
	@Transactional
	public List<Product> getProducts();
	
	@Transactional
	public Product addProduct(Product product);
	
	@Transactional
	public Product getProduct(int id);

	public Product updateProduct(Product product);
	
	@Transactional
	public Boolean deletProduct(int id);
}
