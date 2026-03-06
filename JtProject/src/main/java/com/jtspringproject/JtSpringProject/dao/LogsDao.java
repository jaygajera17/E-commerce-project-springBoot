package com.jtspringproject.JtSpringProject.dao;

import com.jtspringproject.JtSpringProject.models.Logs;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;


@Repository
public class LogsDao {
    @Autowired
    private SessionFactory sessionFactory;

    @Transactional
    public void savelog(long userid,String keyword){
        LocalDateTime date=LocalDateTime.now();
        Logs log=new Logs();
        log.setDate(date);
        log.setSearchkeyword(keyword);
        log.setUserid(userid);
        sessionFactory.getCurrentSession().save(log);
        System.out.println("Saved the log in the database");
    }
    @Transactional
    public List<Logs> getall(){
        return sessionFactory.getCurrentSession().createQuery("FROM Logs",Logs.class).list();
    }
}
