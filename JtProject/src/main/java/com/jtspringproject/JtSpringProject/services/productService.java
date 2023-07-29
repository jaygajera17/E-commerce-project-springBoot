package com.jtspringproject.JtSpringProject.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jtspringproject.JtSpringProject.dao.productDao;
import com.jtspringproject.JtSpringProject.models.Product;

@Service
public class productService {
	@Autowired
	private productDao productDao;
	
	public List<Product> getProducts(){
		return this.productDao.getProducts();
	}
	
	public Product addProduct(Product product) {
		return this.productDao.addProduct(product);
	}
	
	public Product getProduct(int id) {
		return this.productDao.getProduct(id);
	}

	public Product updateProduct(Product product){
		return this.productDao.updateProduct(product);
	}

	public boolean deleteProduct(int id) {
		return this.productDao.deletProduct(id);
	}

	public int getPairedProduct(int id) {
		return this.productDao.getPairedProduct(id);
	}

	public int updatePairedProduct(int id, int paired_product_id) {
		return this.updatePairedProduct(id, paired_product_id);
	}
}
