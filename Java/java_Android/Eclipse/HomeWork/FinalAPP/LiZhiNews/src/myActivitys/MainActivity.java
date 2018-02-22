package myActivitys;

import java.util.ArrayList;

import utils.Path_URL;
import utils.UtilsMark;
import myFragments.ShowNewsTitleFragment;
import myFragments.SlidingMenuFragment;
import cn.jpush.android.api.BasicPushNotificationBuilder;
import cn.jpush.android.api.JPushInterface;
import com.jeremyfeinstein.slidingmenu.lib.SlidingMenu;
import com.lizhinews.R;
import android.app.ActionBar;
import android.app.Notification;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;
import android.support.v4.app.FragmentTransaction;
import android.support.v4.view.ViewPager;
import android.util.DisplayMetrics;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.HorizontalScrollView;
import android.widget.LinearLayout.LayoutParams;
import android.widget.RadioButton;
import android.widget.RadioGroup;

public class MainActivity extends FragmentActivity {
	private RadioGroup radioGroup;
	private ViewPager viewPager;
	private ArrayList<Fragment> lists;
	private HorizontalScrollView scrollView;
	private LayoutParams params;
	private View indicate;
	private Animation animation;
	private SlidingMenu slidingMenu;
	@Override
	protected void onCreate(Bundle arg0) {
		super.onCreate(arg0);
		BasicPushNotificationBuilder builder=new BasicPushNotificationBuilder(this);
		builder.statusBarDrawable=R.drawable.liusheng;
		builder.notificationFlags=Notification.FLAG_AUTO_CANCEL;
		builder.notificationDefaults=Notification.DEFAULT_SOUND|Notification.DEFAULT_LIGHTS|Notification.DEFAULT_VIBRATE;
		JPushInterface.setPushNotificationBuilder(1, builder);
		
		ActionBar actionBar=getActionBar();
		actionBar.hide();
		
		setContentView(R.layout.lizhinews_main);
		radioGroup=(RadioGroup)findViewById(R.id.radioGroup1);
		viewPager=(ViewPager)findViewById(R.id.viewPagerLiZhi);
		scrollView=(HorizontalScrollView)findViewById(R.id.horizontalScrollView1);
		indicate=(View)findViewById(R.id.indicate);
		params=(LayoutParams)indicate.getLayoutParams();
		animation=(Animation)AnimationUtils.loadAnimation(this,R.anim.anim);
		animation.setFillAfter(true);
		
		slidingMenu=new SlidingMenu(this);
		slidingMenu.setMode(SlidingMenu.LEFT);
		slidingMenu.setMenu(R.layout.slidingmenu_left);
		SlidingMenuFragment smFragemnt=new SlidingMenuFragment();
		FragmentManager fragmentManager=getSupportFragmentManager();
		FragmentTransaction ft=fragmentManager.beginTransaction();
		ft.add(R.id.ll_slidingmenu_left, smFragemnt);
		ft.commit();
		slidingMenu.setTouchModeAbove(SlidingMenu.TOUCHMODE_MARGIN);
		slidingMenu.setBehindScrollScale(0.5f);
		slidingMenu.setShadowDrawable(R.drawable.shadow);
		slidingMenu.setShadowWidth(100);
		slidingMenu.setFadeDegree(0.35f);
		
		DisplayMetrics dm=new DisplayMetrics();
		getWindowManager().getDefaultDisplay().getMetrics(dm);
		int width=dm.widthPixels;
		slidingMenu.setBehindWidth(width*4/5);
		slidingMenu.attachToActivity(this, SlidingMenu.SLIDING_CONTENT);
		
		ShowNewsTitleFragment sntf1=ShowNewsTitleFragment.getInstance( UtilsMark.HEADLINE_MARK,0, 
				0, Path_URL.TOP_URL, Path_URL.FRONTPAGEURL1,Path_URL.FRONTPAGEURL2);
		ShowNewsTitleFragment sntf2=ShowNewsTitleFragment.getInstance(UtilsMark.SINGLEIMAGE_MARK,1,
				0, Path_URL.JIANGSU_URLTOP, Path_URL.JIANGSU_URL1,Path_URL.JIANGSU_URL2);
		ShowNewsTitleFragment sntf3=ShowNewsTitleFragment.getInstance(UtilsMark.NOLOAD_MARK,2, 
				R.drawable.lzp, null, Path_URL.LIZHIPAI,Path_URL.LIZHIPAI2);
		ShowNewsTitleFragment sntf4=ShowNewsTitleFragment.getInstance(UtilsMark.NOLOAD_MARK,3,
				R.drawable.djyf,null, Path_URL.DUJIAYIFAN,Path_URL.DUJIAYIFAN2);
		ShowNewsTitleFragment sntf5=ShowNewsTitleFragment.getInstance(UtilsMark.SINGLEIMAGE_MARK,4,
				0, Path_URL.tiyu_top, Path_URL.tiyu1,Path_URL.tiyu2);
		ShowNewsTitleFragment sntf6=ShowNewsTitleFragment.getInstance(UtilsMark.SINGLEIMAGE_MARK,5,
				0, Path_URL.guoji_top, Path_URL.guoji1,Path_URL.guoji2);
		lists=new ArrayList<Fragment>();
		lists.add(sntf1);
		lists.add(sntf2);
		lists.add(sntf3);
		lists.add(sntf4);
		lists.add(sntf5);
		lists.add(sntf6);
		viewPager.setAdapter(new MyFragmentPagerAdapter(getSupportFragmentManager()));
		radioGroup.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {
			int index=0;
			@Override
			public void onCheckedChanged(RadioGroup group, int checkedId) {
				switch(checkedId){
				case R.id.rbHeadLine:
					index=0;
					break;
				case R.id.rbJiangSu:
					index=1;
					break;
				case R.id.rbLiZhiPai:
					index=2;
					break;
				case R.id.rbExclusive:
					index=3;
					break;
				case R.id.rbSport:
					index=4;
					break;
				case R.id.rbInternation:
					index=5;
					break;
				}
				for(int i=0;i<radioGroup.getChildCount();i++){
					radioGroup.getChildAt(i).clearAnimation();
				}
				RadioButton rb=(RadioButton) radioGroup.getChildAt(index);
				rb.startAnimation(animation);
				viewPager.setCurrentItem(index);
			}
		});
		viewPager.setOnPageChangeListener(new ViewPager.OnPageChangeListener() {
			
			@Override
			public void onPageSelected(int id) {
				//根据ViewPager 滑动改变RadioGroup
				RadioButton rb=(RadioButton) radioGroup.getChildAt(id);
				rb.setChecked(true);
				//使选中的RadioButton 在中间
				int left=rb.getLeft();
				int right=rb.getRight();
				int width=getWindow().getDecorView().getWidth();
				int x=left-width/2+(right-left)/2;
				scrollView.scrollTo(x, 0);
				switch(id){
				case 0:
					slidingMenu.setTouchModeAbove(SlidingMenu.TOUCHMODE_MARGIN);
					break;
				default:
					slidingMenu.setTouchModeAbove(SlidingMenu.TOUCHMODE_MARGIN);
					break;	
				}
			}
			
			@Override
			public void onPageScrolled(int arg0, float arg1, int arg2) {
				params.setMargins(params.width*arg0+(int)(params.width*arg1), 0, 0, 0);
				indicate.setLayoutParams(params);
			}
			
			@Override
			public void onPageScrollStateChanged(int arg0) {
				
			}
		});
	}
	class MyFragmentPagerAdapter extends FragmentPagerAdapter{

		public MyFragmentPagerAdapter(FragmentManager fm) {
			super(fm);
		}

		@Override
		public Fragment getItem(int index) {
			return lists.get(index);
		}

		@Override
		public int getCount() {
			return lists.size();
		}
	}
	@Override
	protected void onResume() {
		super.onResume();
		JPushInterface.onResume(this);
	}
	@Override
	protected void onPause() {
		super.onPause();
		JPushInterface.onPause(this);
	}
}
