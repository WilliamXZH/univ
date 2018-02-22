package com.yidou.wandou.fragments;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.yidou.wandou.R;

/**
 * Created by Administrator on 2016/11/11.
 */

public class SettingFragment extends Fragment
{

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState)
    {
        View views = inflater.inflate(R.layout.fragment_setting, container, false);
        return views;
    }
}
