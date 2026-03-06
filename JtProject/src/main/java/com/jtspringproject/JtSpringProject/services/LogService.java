package com.jtspringproject.JtSpringProject.services;

import com.jtspringproject.JtSpringProject.dao.LogsDao;
import com.jtspringproject.JtSpringProject.models.Logs;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class LogService {
    @Autowired
    LogsDao logrepo;

    public void savelogs(long userid,String keyword){
        logrepo.savelog(userid,keyword);
    }
    public List<Logs> getalllogs(){
       return logrepo.getall();
    }
}
