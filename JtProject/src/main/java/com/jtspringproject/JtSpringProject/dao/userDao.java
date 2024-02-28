package com.jtspringproject.JtSpringProject.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.jtspringproject.JtSpringProject.models.User;


@Repository
public interface userDao {
	
	public void setSessionFactory(SessionFactory sf);
   @Transactional
    public List<User> getAllUser();
    
    @Transactional
	public User saveUser(User user);
    
//    public User checkLogin() {
//    	this.sessionFactory.getCurrentSession().
//    }
    @Transactional
    public User getUser(String username,String password);

	@Transactional
	public boolean userExists(String username);
}
