package com.jtspringproject.JtSpringProject.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.jtspringproject.JtSpringProject.models.Category;

@Repository
public interface categoryDao {


	public void setSessionFactory(SessionFactory sf);

	@Transactional
	public Category addCategory(String name);

	@Transactional
	public List<Category> getCategories();

	@Transactional
	public Boolean deletCategory(int id);

	@Transactional
	public Category updateCategory(int id, String name);

	@Transactional
	public Category getCategory(int id);
}
