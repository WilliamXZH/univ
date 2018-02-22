package myActivitys;

import java.util.ArrayList;

import utils.HttpUtils;
import utils.HttpUtils.OnNetWorkRespond;
import utils.Path_URL;
import bean.MapBean;

import com.alibaba.fastjson.JSONObject;
import com.lizhinews.R;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.support.v4.view.ViewPager.OnPageChangeListener;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

public class ImageMapActivity extends BaseActivity implements OnPageChangeListener,View.OnClickListener{
	private ViewPager viewPager;
	private ImageView imageView_Image_Map_Back,imageView_Image_Map_DownLoad,imageView_Image_Map_Share;
	private TextView tv_imageView_Image_Map_Content,tv_imageView_Image_Map_Subject,tv_imageView_Image_Map_Icon;
	private MapBean mapBean;
	private ViewPagerAdapter adapter;
	private int iamgeIndex;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.iamgemap_activity_layout);
		Intent intent=getIntent();
		String url=intent.getStringExtra("URL");
		Log.i("传过来的URl", url);
		Log.i("传过来的URl", url);
		Log.i("传过来的URl", url);
		viewPager=(ViewPager)findViewById(R.id.viewPager_ImageMap);
		imageView_Image_Map_Back=(ImageView)findViewById(R.id.imageView_Image_Map_Back);
		imageView_Image_Map_DownLoad=(ImageView)findViewById(R.id.imageView_Image_Map_DownLoad);
		imageView_Image_Map_Share=(ImageView)findViewById(R.id.imageView_Image_Map_Share);
		tv_imageView_Image_Map_Content=(TextView)findViewById(R.id.tv_imageView_Image_Map_Content);
		tv_imageView_Image_Map_Subject=(TextView)findViewById(R.id.tv_imageView_Image_Map_Subject);
		tv_imageView_Image_Map_Icon=(TextView)findViewById(R.id.tv_imageView_Image_Map_Icon);
		//设置监听
		imageView_Image_Map_Back.setOnClickListener(this);
		imageView_Image_Map_DownLoad.setOnClickListener(this);
		imageView_Image_Map_Share.setOnClickListener(this);
		adapter=new ViewPagerAdapter(null);
		viewPager.setAdapter(adapter);
		viewPager.setOnPageChangeListener(this);
		if(url!=null){
			Log.i("画廊URL", url);
			HttpUtils.downLoadJson(this, url, new OnNetWorkRespond() {
				
				@Override
				public void onNetWorkError(String error) {
					
				}
				
				@Override
				public void OnNetWorkOk(String json) {
					parseJson(json);
				}
			});
		}
	}
	private void parseJson(String json){
		JSONObject jsonObject=JSONObject.parseObject(json);
		String status=jsonObject.getString("status");
		if(status.equals("ok")){
			JSONObject paramz=jsonObject.getJSONObject("paramz");
			JSONObject map=paramz.getJSONObject("map");
			mapBean=JSONObject.parseObject(map.toJSONString(), MapBean.class);
			adapter.setResources(mapBean);
			tv_imageView_Image_Map_Content.setText(mapBean.getPics().get(0).getSubject());
			tv_imageView_Image_Map_Subject.setText(mapBean.getSubject());
			tv_imageView_Image_Map_Icon.setText(0+1+"/"+mapBean.getPics().size());
		}
	}
	class ViewPagerAdapter extends PagerAdapter{
		ArrayList<View> views;
		MapBean resources;
		
		public MapBean getResources() {
			return resources;
		}
		public void setResources(MapBean resources) {
			this.resources = resources;
			addView();
			notifyDataSetChanged();
		}
		public ViewPagerAdapter(MapBean resources){
			this.resources=resources;
			addView();
		}
		private void addView(){
			if(resources!=null){
				views=new ArrayList<View>();
				for(int i=0;i<resources.getPics().size();i++){
					ImageView iv=new ImageView(ImageMapActivity.this);
					HttpUtils.showImage(ImageMapActivity.this, Path_URL.IMAGEURL+resources.getPics().get(i).getRaw(), iv);
					views.add(iv);
				}
			}
		}
		@Override
		public int getCount() {
			if(resources==null){
				return 0;
			}
			if(resources.getPics()==null){
				return 0;
			}
			return resources.getPics().size();
		}

		@Override
		public boolean isViewFromObject(View arg0, Object arg1) {
			return arg0==arg1;
		}
		@Override
		public Object instantiateItem(ViewGroup container, int position) {
			View view=views.get(position);
			container.addView(view);
			return view;
		}
		@Override
		public void destroyItem(ViewGroup container, int position, Object object) {
			View view=views.get(position);
			container.removeView(view);
		}
	}
	@Override
	public void onPageScrollStateChanged(int arg0) {
		
	}
	@Override
	public void onPageScrolled(int arg0, float arg1, int arg2) {
		
	}
	@Override
	public void onPageSelected(int arg0) {
		iamgeIndex=arg0;
		tv_imageView_Image_Map_Content.setText(mapBean.getPics().get(arg0).getSubject());
		tv_imageView_Image_Map_Subject.setText(mapBean.getSubject());
		tv_imageView_Image_Map_Icon.setText(arg0+1+"/"+mapBean.getPics().size());
	}
	@Override
	public void onClick(View v) {
		switch(v.getId()){
		case R.id.imageView_Image_Map_Back:
			finish();
			break;
		case R.id.imageView_Image_Map_DownLoad:
			HttpUtils.downLoadImage(this, Path_URL.IMAGEURL+mapBean.getPics().get(iamgeIndex).getRaw(), new HttpUtils.OnDownLoadImage() {
				
				@Override
				public void OnDownLoadOK() {
					Toast.makeText(ImageMapActivity.this, "下载完成", Toast.LENGTH_SHORT).show();
				}
				
				@Override
				public void OnDownLoadError() {
					Toast.makeText(ImageMapActivity.this, "下载失败", Toast.LENGTH_SHORT).show();
				}
			});
			break;
		case R.id.imageView_Image_Map_Share:
			break;
		}
	}
}
