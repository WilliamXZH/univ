package com.yidou.wandou.utils;

import com.yidou.wandou.bean.News;
import com.yidou.wandou.bean.Pictures;

import retrofit2.http.GET;
import retrofit2.http.Headers;
import retrofit2.http.Query;
import rx.Observable;

/**
 * Created by Administrator on 2016/11/11.
 */

public interface HttpNews
{
    @GET("index")
    Observable<News> getNews(@Query("type") String type, @Query("key") String key);

    @Headers("apikey:百度apistore key")//申请地址：http://apistore.baidu.com/apiworks/servicedetail/987.html
    @GET("list")
    Observable<Pictures> getPictures(@Query("id") String id, @Query("page") String page, @Query("rows") String rows);
}
