package com.jtspringproject.JtSpringProject.dao;

import java.util.List;

import com.jtspringproject.JtSpringProject.models.Product;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.jtspringproject.JtSpringProject.models.Category;

@Repository
public class categoryDao {
	@Autowired
	private SessionFactory sessionFactory;

	public void setSessionFactory(SessionFactory sf) {
		this.sessionFactory = sf;
	}

	@Transactional
	public Category addCategory(String name) {
		Category category = new Category();
		category.setName(name);
		this.sessionFactory.getCurrentSession().saveOrUpdate(category);
		return category;
	}

	@Transactional
	public List<Category> getCategories() {
		return this.sessionFactory.getCurrentSession().createQuery("from CATEGORY").list();
	}

	@Transactional
	public Boolean deleteCategory(int id) {

		Session session = this.sessionFactory.getCurrentSession();
		Object persistanceInstance = session.get(Category.class, id);
		Object productInstance = session.get(Product.class,id);

		if (persistanceInstance != null) {

			if(productInstance != null)
			{
				return false;
			}
			session.delete(persistanceInstance);
			return true;
		}
		return false;
	}

	@Transactional
	public Category updateCategory(int id, String name) {
		Category category = this.sessionFactory.getCurrentSession().get(Category.class, id);
		category.setName(name);

		this.sessionFactory.getCurrentSession().update(category);
		return category;
	}

	@Transactional
	public Category getCategory(int id) {
		return this.sessionFactory.getCurrentSession().get(Category.class,id);
	}
}
