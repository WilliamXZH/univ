package com.i4evercai.bannerdemo;



/**
 * Created by Administrator on 2016/12/2.
 */

    public class New {
        public String title;
        public String content;
        public int icon;
        New(String title,String content,int icon){
            this.title=title;
            this.content=content;
            this.icon=icon;
        }

    public String getContent() {
        return content;
    }

    public int getIcon() {
        return icon;
    }

    public String getTitle() {
        return title;
    }
}
