package com.yidou.wandou.fragments;

import android.os.Bundle;
import android.os.Handler;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v4.widget.SwipeRefreshLayout;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import com.github.library.BaseRecyclerAdapter;
import com.github.library.BaseViewHolder;
import com.github.library.animation.AnimationType;
import com.squareup.picasso.Picasso;
import com.yidou.wandou.Constances;
import com.yidou.wandou.R;
import com.yidou.wandou.bean.Pictures;
import com.yidou.wandou.utils.HttpNews;

import java.util.List;

import retrofit2.Retrofit;
import retrofit2.adapter.rxjava.RxJavaCallAdapterFactory;
import retrofit2.converter.gson.GsonConverterFactory;
import rx.Scheduler;
import rx.Subscriber;
import rx.android.schedulers.AndroidSchedulers;
import rx.schedulers.Schedulers;

/**
 * Created by Administrator on 2016/11/11.
 */

public class HomeFragment extends Fragment implements SwipeRefreshLayout.OnRefreshListener
{
    private RecyclerView mRecyclerView;
    private SwipeRefreshLayout mRefreshLayout;
    private BaseRecyclerAdapter<Pictures.TngouBean> mAdapter;
    private List<Pictures.TngouBean> mList;
    private Handler mHandler = new Handler();



    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState)
    {
        View views = inflater.inflate(R.layout.fragment_home, container, false);
        mRecyclerView = (RecyclerView) views.findViewById(R.id.fragment_home_recycler);
        mRecyclerView.setLayoutManager(new LinearLayoutManager(getActivity()));
        mRefreshLayout = (SwipeRefreshLayout) views.findViewById(R.id.fragment_home_swipe);
        mRefreshLayout.setColorSchemeResources(R.color.colorPrimary);
        mRefreshLayout.setOnRefreshListener(this);
        return views;
    }

    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState)
    {
        super.onActivityCreated(savedInstanceState);
        mAdapter = new BaseRecyclerAdapter<Pictures.TngouBean>(getActivity(), getDatas(), R.layout.fragment_home_item)
        {
            @Override
            protected void convert(BaseViewHolder helper, Pictures.TngouBean item)
            {
                helper.setText(R.id.fragment_home_texts, item.getName());
                ImageView images = (ImageView) helper.getConvertView().findViewById(R.id.fragment_home_images);
                Picasso.with(getActivity()).load(Constances.IMGS + item.getImg()).fit().into(images);
            }
        };
        mAdapter.openLoadAnimation(AnimationType.SLIDE_LEFT);//ok
        mRecyclerView.setAdapter(mAdapter);
    }

    private List<Pictures.TngouBean> getDatas()
    {
        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl(Constances.Pictures)
                .addConverterFactory(GsonConverterFactory.create())
                .addCallAdapterFactory(RxJavaCallAdapterFactory.create())
                .build();
        HttpNews news = retrofit.create(HttpNews.class);
        news.getPictures("0", "1", "20")
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Subscriber<Pictures>()
                {
                    @Override
                    public void onCompleted()
                    {
                        mAdapter.setData(mList);
                    }

                    @Override
                    public void onError(Throwable e)
                    {

                    }

                    @Override
                    public void onNext(Pictures pictures)
                    {
                        mList = pictures.getTngou();
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
