package com.jtspringproject.JtSpringProject.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.jtspringproject.JtSpringProject.models.Category;
import com.jtspringproject.JtSpringProject.models.Product;

@Repository
public class productDao {
	@Autowired
	private SessionFactory sessionFactory;

	public void setSessionFactory(SessionFactory sf) {
		this.sessionFactory = sf;
	}

	@Transactional
	public List<Product> getProducts() {
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

	public Product updateProduct(Product product) {
		this.sessionFactory.getCurrentSession().update(String.valueOf(Product.class), product);
		return product;
	}

	@Transactional
	public void updateproductprice(int id,int price){
		Product product=this.sessionFactory.getCurrentSession().get(Product.class,id);
		product.setPrice(price);
		this.sessionFactory.getCurrentSession().update(product);
	}
	@Transactional
	public boolean deleteProduct(int id) {
		Session session = sessionFactory.getCurrentSession();
		Product product = session.get(Product.class, id);

		if (product != null) {
			session.delete(product);
			return true;
		}
		return false;
	}

	@Transactional
	public Product getProductByname(String name) {
		Session session = sessionFactory.getCurrentSession();
		return session.createQuery("from PRODUCT p where p.name= :name", Product.class).
				setParameter("name", name).uniqueResult();

	}

	@Transactional
	public List<Product> sortonprice() {
		Session session = sessionFactory.getCurrentSession();
		return session.createQuery("from PRODUCT P order by p.price asc",
						Product.class).list();
	}
	@Transactional
	public List<Product> sortonCategory(String Category) {
		Session session = sessionFactory.getCurrentSession();
		return session.createQuery("from PRODUCT P where p.category.name= :catname order by p.price asc",
						Product.class)
				.setParameter("catname", Category).list();
	}
}



