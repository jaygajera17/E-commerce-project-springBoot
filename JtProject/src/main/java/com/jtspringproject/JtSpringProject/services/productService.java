package com.jtspringproject.JtSpringProject.services;

import java.time.LocalDateTime;
import java.util.List;

import DTO.DiscountPrice;
import DTO.productdto;
import com.jtspringproject.JtSpringProject.dao.DiscountDao;
import com.jtspringproject.JtSpringProject.dao.LogsDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.context.ApplicationEventPublisher;
import com.jtspringproject.JtSpringProject.dao.productDao;
import com.jtspringproject.JtSpringProject.models.Product;

@Service
public class ProductService {
	@Autowired
	public productDao ProductDao;
	@Autowired
	public LogService logservice;
    @Autowired
	public DiscountDao discountDao;
	@Autowired
	public ApplicationEventPublisher eventPublisher;

	public List<Product> getProducts(){
		return ProductDao.getProducts();
	}
	
	public Product addProduct(Product product) {
		return ProductDao.addProduct(product);
	}
	
	public Product getProduct(int id) {
		return ProductDao.getProduct(id);
	}

	public Product getProductByName(String name, long userid){
		LocalDateTime now= LocalDateTime.now();
		logservice.savelogs(userid,name);
		return ProductDao.getProductByname(name);
	}

	public Product updateProduct(int id,Product product){
		product.setId(id);
		return ProductDao.updateProduct(product);
	}
	public void updateProductPrice(int id,productdto product){
        System.out.println(product);
		if(product.oldprice>product.newprice){
			DiscountPrice disprice=new DiscountPrice();
			disprice.setProductid(id);
			disprice.setOldprice(product.oldprice);
			disprice.setNewprice(product.newprice);
			ProductDao.updateproductprice(id,product.newprice);
			eventPublisher.publishEvent(
					disprice
			);
		}
		else{
			discountDao.removeDiscount(id);
			ProductDao.updateproductprice(id,product.newprice);
		}
	}
	public boolean deleteProduct(int id) {
		return ProductDao.deleteProduct(id);
	}
    public List<Product> sortonprice(){
		return ProductDao.sortonprice();
	}
	public List<Product> sortoncategory(String name){
		return ProductDao.sortonCategory(name);
	}

}
