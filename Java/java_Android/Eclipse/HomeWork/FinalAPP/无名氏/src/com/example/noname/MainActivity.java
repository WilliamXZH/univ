package com.example.noname;



import java.util.ArrayList;
import java.util.List;

import com.example.noname.Fragment.ViewPageItemFragment;
import com.example.noname.bean.WelTitle;
import com.example.noname.pagerindicator.TabPageIndicator;
import com.example.noname.utils.QLApi;

import android.os.Bundle;
import android.os.Parcelable;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;
import android.support.v4.app.FragmentTransaction;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.support.v4.view.ViewPager.OnPageChangeListener;
import android.view.ViewGroup;


public class MainActivity extends FragmentActivity implements OnPageChangeListener {
	private String[] adsafe={QLApi.VEIW_PAGE,QLApi.TOW_ADSAFE,QLApi.THREE_ADSAFE,QLApi.FIVE_ADSAFE,QLApi.SIX_ADSAFE,QLApi.SEVEN_ADSAFE,QLApi.EIGHT_ADSAFE,QLApi.NIGHT_ADSAFE};
	private String []NewsCenter={QLApi.NEWS_CENTER,QLApi.TOW,QLApi.THREE,QLApi.FIVE,QLApi.SIX,QLApi.SEVEN,QLApi.EIGHT,QLApi.NIGHT};
	/**
	 * Tab����
	 */
	private static final String[] TITLE = new String[] { "ͷ��", "����", "����", "���",
										"����", "����", "����", "�Ƽ�" };
	private ViewPager pager;
	private List<WelTitle> list;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
//        initBudle();
        initViewPage();
//------2.ʵ����TabPageIndicatorȻ������ViewPager��֮����------------------------------
        TabPageIndicator indicator = (TabPageIndicator)findViewById(R.id.indicator);
//------3.����Ҫ����TabPageIndicator��ViewPager����------------------------------        
        indicator.setViewPager(pager); 
//------4.�������Ҫ��ViewPager���ü�������indicator���þ�����        
        indicator.setOnPageChangeListener(this);
    }
    
    
private void initBudle() {
	list=(List<WelTitle>) getIntent().getSerializableExtra("list");
	System.out.println(list);
	}

//------1.��ʼ��ViewPage-----------------------------------------------------	
	private void initViewPage() {
				//ViewPager��adapter
				FragmentPagerAdapter adapter = new TabPageIndicatorAdapter(getSupportFragmentManager());
		        pager = (ViewPager)findViewById(R.id.pager);
		        pager.setAdapter(adapter);
		   
	}


	@Override
	public void onPageScrollStateChanged(int arg0) {
		
	}


	@Override
	public void onPageScrolled(int arg0, float arg1, int arg2) {
		
	}


	@Override
	public void onPageSelected(int arg0) {
		
	}

	/**
	 * ViewPager������
	 * @author len
	 *
	 */
    class TabPageIndicatorAdapter extends FragmentPagerAdapter {
        public TabPageIndicatorAdapter(FragmentManager fm) {
            super(fm);
        }

        @Override
        public Fragment getItem(int position) {
        	//�½�һ��Fragment��չʾViewPager item�����ݣ������ݲ���
        	Fragment fragment = new ViewPageItemFragment();
        	Bundle bundle=new Bundle();
        	bundle.putString("adsafe",adsafe[position]);
        	bundle.putString("title",NewsCenter[position]);
//        	adsafe[position],NewsCenter[position]
        	fragment.setArguments(bundle);
//        	ViewPageItemFragment viewPageItemFragment=new ViewPageItemFragment();
        	
            return fragment;
        }
//        public Object instantiateItem(ViewGroup container, int position) {
//
//        	ViewPageItemFragment f = (ViewPageItemFragment) super.instantiateItem(container, position);
//        	Bundle bundle=new Bundle();
//        	bundle.putString("adsafe",adsafe[position]);
//        	bundle.putString("title",NewsCenter[position]);
////        	adsafe[position],NewsCenter[position]
//        	f.setArguments(bundle);
//        	 
//
//        	 return f;
//
//        	 }

        @Override
        public CharSequence getPageTitle(int position) {
        	 return TITLE[position % TITLE.length];
        }

        @Override
        public int getCount() {
        	return TITLE.length;
        }
//        @Override
//
//        public int getItemPosition(Object object) {
//
//        return PagerAdapter.POSITION_NONE;
//
//        } 
        
    }

}
