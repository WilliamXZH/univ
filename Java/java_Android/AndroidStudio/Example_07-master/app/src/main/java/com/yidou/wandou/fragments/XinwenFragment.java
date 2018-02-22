package com.yidou.wandou.fragments;

import android.os.Bundle;
import android.support.design.widget.TabLayout;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import com.yidou.wandou.R;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


public class XinwenFragment extends Fragment
{
    private TabLayout mLayout;
    private ViewPager mViewPager;

    private String[] titles = {
            "头条", "时尚", "军事"
    };
    private List<Fragment> mFragments;


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState)
    {
        View views = inflater.inflate(R.layout.fragment_xinwen, container, false);
        mViewPager = (ViewPager) views.findViewById(R.id.viewPagers);
        mLayout = (TabLayout) views.findViewById(R.id.tabs);


        MainAdapter adapter = new MainAdapter(getFragmentManager(), addFragments(), Arrays.asList(titles));
        mViewPager.setAdapter(adapter);
        mLayout.setupWithViewPager(mViewPager);
        mLayout.setTabsFromPagerAdapter(adapter);
        return views;
    }

    private List<Fragment> addFragments()
    {
        mFragments = new ArrayList<>();
        mFragments.add(new WeixinFragment_Top());
        mFragments.add(new WeixinFragment_Shishang());
        mFragments.add(new WeixinFragment_Junshi());
        return mFragments;
    }

    private class MainAdapter extends FragmentStatePagerAdapter
    {
        private List<Fragment> mFragments;
        private List<String> mTitles;

        public MainAdapter(FragmentManager fm, List<Fragment> fragments, List<String> title)
        {
            super(fm);
            mFragments = fragments;
            mTitles = title;
        }

        @Override
        public Fragment getItem(int position)
        {
            return mFragments.get(position);
        }

        @Override
        public int getCount()
        {
            return mFragments.size();
        }

        @Override
        public CharSequence getPageTitle(int position)
        {
            return mTitles.get(position);
        }
    }
}
