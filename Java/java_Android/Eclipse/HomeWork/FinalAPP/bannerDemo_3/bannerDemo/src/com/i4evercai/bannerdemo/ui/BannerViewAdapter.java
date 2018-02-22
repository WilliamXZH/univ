package com.i4evercai.bannerdemo.ui;

import java.util.List;

import android.content.Context;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.ImageView;

public class BannerViewAdapter extends PagerAdapter {
	private List<ImageView> list;
	private Context context;
	
	public BannerViewAdapter(Context context, List<ImageView> list) {
		this.context = context;
		this.list = list;
	}

	@Override
	public int getCount() {
		// TODO Auto-generated method stub
		return list.size();
	}

	@Override
	public boolean isViewFromObject(View arg0, Object arg1) {
		// TODO Auto-generated method stub
		return arg0 == arg1;
	}

	public ImageView instantiateItem(View arg0, final int arg1) {
		((ViewPager) arg0).addView(list.get(arg1));
		list.get(arg1).setOnClickListener(new OnClickListener()
		{

			@Override
			public void onClick(View view) {
				// TODO Auto-generated method stub
				System.out.println("onClick:"+arg1);
			}
			
		});
		return list.get(arg1);
	}

	@Override
	public void destroyItem(View arg0, int arg1, Object arg2) {
		((ViewPager) arg0).removeView((View) arg2);
	}
}
