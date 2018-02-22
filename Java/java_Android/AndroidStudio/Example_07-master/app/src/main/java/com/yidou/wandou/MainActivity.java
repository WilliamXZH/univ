package com.yidou.wandou;

import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;
import android.support.v4.view.ViewPager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import com.lzy.widget.AlphaIndicator;
import com.yidou.wandou.fragments.HomeFragment;
import com.yidou.wandou.fragments.SettingFragment;
import com.yidou.wandou.fragments.XinwenFragment;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity
{
    private ViewPager mViewPager;
    private AlphaIndicator mIndicator;

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        initView();
    }

    private void initView()
    {
        mViewPager = (ViewPager) this.findViewById(R.id.viewPager);
        mIndicator = (AlphaIndicator) this.findViewById(R.id.alpha);
        mViewPager.setAdapter(new MainAdapter(getSupportFragmentManager()));
        mIndicator.setViewPager(mViewPager);
    }
    private class MainAdapter extends FragmentPagerAdapter
    {
        private List<Fragment> mFragments = new ArrayList<>();
        public MainAdapter(FragmentManager fm)
        {
            super(fm);
            mFragments.add(new XinwenFragment());
            mFragments.add(new HomeFragment());
            mFragments.add(new SettingFragment());
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
    }
}
