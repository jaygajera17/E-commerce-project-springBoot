package com.jtspringproject.JtSpringProject.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.jtspringproject.JtSpringProject.models.Product;

@Repository
public class productDao {
	@Autowired
    private SessionFactory sessionFactory;
	
	public void setSessionFactory(SessionFactory sf) {
        this.sessionFactory = sf;
    }
	
	@Transactional
	public List<Product> getProducts(){
		return this.sessionFactory.getCurrentSession().createQuery("from PRODUCT").list();
	}
	
	@Transactional
	public Product addProduct(Product product) {
		this.sessionFactory.getCurrentSession().save(product);
		return product;
	}
	
	@Transactional
	public Product getProduct(int id) {
		return this.sessionFactory.getCurrentSession().get(Product.class, id);
	}

	@Transactional
	public Product updateProduct(Product product){
		this.sessionFactory.getCurrentSession().update(String.valueOf(Product.class), product);
		return product;
	}

	@Transactional
	public Boolean deletProduct(int id) {

		Session session = this.sessionFactory.getCurrentSession();
		Object persistanceInstance = session.load(Product.class, id);

		if (persistanceInstance != null) {
			session.delete(persistanceInstance);
			return true;
		}
		return false;
	}

	@Transactional
	public int getPairedProduct(int id) {
		// access db get product with id then return the int value under the column labelled paired_product_id
		Session session1 = this.sessionFactory.getCurrentSession();
		Product product = (Product) session1.load(Product.class, id);
		return product.getPairedProduct();
	}

	@Transactional
	public int updatePairedProduct(int id, int paired_product_id) {
		// access db get product with id
		// set column value for column paired_product_id to int paired_product_id
		Session session1 = this.sessionFactory.getCurrentSession();
		Product product = (Product) session1.load(Product.class, id);

		product.setPairedProduct(paired_product_id);
		this.updateProduct(product);

		// acess db get prodcut with paired_product_id
		// set column value for column paired_product_id to int id
		Session session2 = this.sessionFactory.getCurrentSession();
		Product paired_product = (Product) session2.load(Product.class, paired_product_id);

		paired_product.setPairedProduct(id);
		session2.save(paired_product); // ??

		return paired_product_id;
	}

}
