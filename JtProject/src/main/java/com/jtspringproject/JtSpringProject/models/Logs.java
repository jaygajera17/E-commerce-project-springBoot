package com.jtspringproject.JtSpringProject.models;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.time.LocalDateTime;

@Entity(name="Logs")
public class Logs {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public int logid;
    public long userid;
    public String searchkeyword;
    public LocalDateTime date;


    public long getUserid() {
        return userid;
    }

    public void setUserid(long userid) {
        this.userid = userid;
    }

    public String getSearchkeyword() {
        return searchkeyword;
    }

    public void setSearchkeyword(String searchkeyword) {
        this.searchkeyword = searchkeyword;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }
}
