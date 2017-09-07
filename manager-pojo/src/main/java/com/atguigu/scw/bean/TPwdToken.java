package com.atguigu.scw.bean;

import java.util.Date;

public class TPwdToken {
    private Integer userid;

    private String token;

    private Date passTime;

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token == null ? null : token.trim();
    }

    public Date getPassTime() {
        return passTime;
    }

    public void setPassTime(Date passTime) {
        this.passTime = passTime;
    }
}