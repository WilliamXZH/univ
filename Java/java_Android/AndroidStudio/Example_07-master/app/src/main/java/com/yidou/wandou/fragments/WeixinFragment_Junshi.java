package com.yidou.wandou.fragments;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.support.v4.app.Fragment;
import android.support.v4.widget.SwipeRefreshLayout;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Toast;

import com.github.library.BaseRecyclerAdapter;
import com.github.library.BaseViewHolder;
import com.github.library.animation.AnimationType;
import com.squareup.picasso.Picasso;
import com.yidou.wandou.Constances;
import com.yidou.wandou.R;
import com.yidou.wandou.UrlActivity;
import com.yidou.wandou.bean.News;
import com.yidou.wandou.utils.HttpNews;

import java.util.List;

import retrofit2.Retrofit;
import retrofit2.adapter.rxjava.RxJavaCallAdapterFactory;
import retrofit2.converter.gson.GsonConverterFactory;
import rx.Subscriber;
import rx.android.schedulers.AndroidSchedulers;
import rx.schedulers.Schedulers;

/**
 * Created by Administrator on 2016/11/11.
 */

public class WeixinFragment_Junshi extends Fragment implements SwipeRefreshLayout.OnRefreshListener
{
    private RecyclerView mRecyclerView;
    private SwipeRefreshLayout mRefreshLayout;
    private List<News.ResultBean.DataBean> mList;
    private BaseRecyclerAdapter<News.ResultBean.DataBean> mAdapter;
    private Handler mHandler = new Handler();


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState)
    {
        View views = inflater.inflate(R.layout.fragment_junshi, container, false);
        mRecyclerView = (RecyclerView) views.findViewById(R.id.fragment_junshi_recycler);
        mRefreshLayout = (SwipeRefreshLayout) views.findViewById(R.id.fragment_junshi_swipe);
        mRefreshLayout.setColorSchemeResources(R.color.colorAccent);
        mRefreshLayout.setOnRefreshListener(this);
        LinearLayoutManager manager = new LinearLayoutManager(getActivity(), LinearLayoutManager.VERTICAL, false);
        mRecyclerView.setLayoutManager(manager);
        return views;
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState)
    {
        super.onActivityCreated(savedInstanceState);
        mAdapter = new BaseRecyclerAdapter<News.ResultBean.DataBean>(getActivity(), getDatas(), R.layout.fragment_recycler_junshi_item)
        {
            @Override
            protected void convert(BaseViewHolder helper, final News.ResultBean.DataBean item)
            {
                helper.setText(R.id.fragment_recycler_junshi_item_texts_title, item.getTitle());
                helper.setText(R.id.fragment_recycler_junshi_item_texts_date, item.getDate());
                helper.setText(R.id.fragment_recycler_junshi_item_texts_authorname, item.getAuthor_name());
                ImageView imageView = (ImageView) helper.getConvertView().findViewById(R.id.fragment_recycler_junshi_item_images_name);
                Picasso.with(getActivity()).load(item.getThumbnail_pic_s()).fit().into(imageView);
                LinearLayout layout = (LinearLayout) helper.getConvertView().findViewById(R.id.fragment_recycler_junshi_item_item_linear);
                layout.setOnClickListener(new View.OnClickListener()
                {
                    @Override
                    public void onClick(View v)
                    {
                        Intent it = new Intent(v.getContext(), UrlActivity.class);
                        it.putExtra("info", item.getUrl());
                        v.getContext().startActivity(it);
                    }
                });
            }
        };
        mAdapter.openLoadAnimation(AnimationType.SLIDE_TOP);//ok
        mRecyclerView.setAdapter(mAdapter);
    }

    private List<News.ResultBean.DataBean> getDatas()
    {
        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl(Constances.NEWS_URL)
                .addConverterFactory(GsonConverterFactory.create())
                .addCallAdapterFactory(RxJavaCallAdapterFactory.create())
                .build();
        HttpNews http = retrofit.create(HttpNews.class);
        http.getNews(Constances.JUN, Constances.KEY)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Subscriber<News>()
                {
                    @Override
                    public void onCompleted()
                    {
                        mAdapter.setData(mList);
                    }

                    @Override
                    public void onError(Throwable e)
                    {
                        Toast.makeText(getActivity(), e.getMessage(), Toast.LENGTH_SHORT).show();
                    }

                    @Override
                    public void onNext(News news)
                    {
                        mList = news.getResult().getData();

                    }
                });
        return mList;
    }

    @Override
    public void onRefresh()
    {
        mHandler.postDelayed(new Runnable()
        {
            @Override
            public void run()
            {
                mAdapter.setData(getDatas());
                mRefreshLayout.setRefreshing(false);
            }
        }, 1000);
    }
}
