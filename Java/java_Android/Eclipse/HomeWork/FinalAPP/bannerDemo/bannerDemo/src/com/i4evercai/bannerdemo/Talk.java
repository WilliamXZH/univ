package com.i4evercai.bannerdemo;



/**
 * Created by Administrator on 2016/12/4.
 */

public class Talk {
    private String username;
    private String time;
    private String text;

    Talk(String username,String time,String text){
        this.username=username;
        this.text=text;
        this.time=time;
    }

    public String getText() {
        return text;
    }

    public String getUsername() {
        return username;
    }

    public String getTime() {
        return time;
    }
}
