package com.jtspringproject.JtSpringProject.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.jtspringproject.JtSpringProject.models.Category;

@Repository
public class categoryDaoImpl implements com.jtspringproject.JtSpringProject.dao.categoryDao {
	@Autowired
	private SessionFactory sessionFactory;

	public void setSessionFactory(SessionFactory sf) {
		this.sessionFactory = sf;
	}
	
	@Override
	@Transactional
	public Category addCategory(String name) {
		Category category = new Category();
		category.setName(name);
		this.sessionFactory.getCurrentSession().saveOrUpdate(category);
		return category;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public List<Category> getCategories() {
		return this.sessionFactory.getCurrentSession().createQuery("from CATEGORY").list();
	}
	
	@Override
	@Transactional
	public Boolean deletCategory(int id) {

		Session session = this.sessionFactory.getCurrentSession();
		Object persistanceInstance = session.load(Category.class, id);

		if (persistanceInstance != null) {
			session.delete(persistanceInstance);
			return true;
		}
		return false;
	}
	
	@Override
	@Transactional
	public Category updateCategory(int id, String name) {
		Category category = this.sessionFactory.getCurrentSession().get(Category.class, id);
		category.setName(name);

		this.sessionFactory.getCurrentSession().update(category);
		return category;
	}
	
	@Override
	@Transactional
	public Category getCategory(int id) {
		return this.sessionFactory.getCurrentSession().get(Category.class,id);
	}
}
