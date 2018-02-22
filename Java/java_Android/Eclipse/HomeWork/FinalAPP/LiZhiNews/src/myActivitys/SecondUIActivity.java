package myActivitys;

import java.util.ArrayList;
import cn.sharesdk.framework.ShareSDK;
import cn.sharesdk.onekeyshare.OnekeyShare;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.android.volley.RequestQueue;
import com.android.volley.toolbox.ImageLoader;
import com.android.volley.toolbox.NetworkImageView;
import com.android.volley.toolbox.Volley;
import com.lizhinews.R;
import bean.ArticleBean;
import bean.RativiteNewsBean;
import utils.HttpUtils;
import utils.HttpUtils.OnNetWorkRespond;
import utils.MyImageCache;
import utils.Path_URL;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;
import android.widget.ListView;
import android.widget.TextView;

public class SecondUIActivity extends BaseActivity implements View.OnClickListener{
	private ListView listView;
	private ArticleBean article;
	private TextView tvcontent_title1,tvcontent_title2;
	private ImageView iv_secondui_back,iv_secondui_comment,iv_secondui_share;
	private ListView listView_RativiteNews;
	private ArrayList<RativiteNewsBean> rativiteNewsList;
	private MyImageCache myImageCache;
	private ImageLoader loader;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		//下载缓存技术
		myImageCache=MyImageCache.getInstance(getApplicationContext());
		RequestQueue queue=Volley.newRequestQueue(this);
		loader=new ImageLoader(queue, myImageCache);
		
		
		rativiteNewsList=new ArrayList<RativiteNewsBean>();
		setContentView(R.layout.second_ui_activity_main_layouy);
		listView=(ListView)findViewById(R.id.listViewSpecificContent);
		//解析
		listView.setDividerHeight(0);
		iv_secondui_back=(ImageView)findViewById(R.id.iv_secondui_back);
		iv_secondui_comment=(ImageView)findViewById(R.id.iv_secondui_comment);
		iv_secondui_share=(ImageView)findViewById(R.id.iv_secondui_share);
		//设置监听
		iv_secondui_back.setOnClickListener(this);
		iv_secondui_comment.setOnClickListener(this);
		iv_secondui_share.setOnClickListener(this);
		//listView 头部
		View view=getLayoutInflater().inflate(R.layout.content_title, null);
		tvcontent_title1=(TextView)view.findViewById(R.id.tvcontent_title1);
		tvcontent_title2=(TextView)view.findViewById(R.id.tvcontent_title2);
		listView.addHeaderView(view);
		//尾部
		View endview=LayoutInflater.from(this).inflate(R.layout.second_ui_activity_listview_end, null);
		listView.addFooterView(endview);
		//相关新闻的listView
		View raView=LayoutInflater.from(this).inflate(R.layout.rativitenewslayout, null);
		listView_RativiteNews=(ListView)raView.findViewById(R.id.listView_RativiteNews);
		listView_RativiteNews.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> parent, View view,
					int position, long id) {
				Intent intent=new Intent("action.secondui");
				intent.putExtra("URL",Path_URL.Information_url1+rativiteNewsList.get(position).getId()+Path_URL.Information_url2);
				startActivity(intent);
			}
		});
		listView.addFooterView(raView);
		Intent intent=getIntent();
		String url=intent.getStringExtra("URL");
		String urlRativite=intent.getStringExtra("URLRATIVITE");
		//下载JSON
		HttpUtils.downLoadJson(this, url, new OnNetWorkRespond() {
			
			@Override
			public void onNetWorkError(String error) {
				
			}
			
			@Override
			public void OnNetWorkOk(String json) {
				parseJson (json);
			}
		});
		//下载相关新闻的JSON
		if(urlRativite!=null){
			HttpUtils.downLoadJson(this, urlRativite, new OnNetWorkRespond() {
				
				@Override
				public void onNetWorkError(String error) {
					
				}
				
				@Override
				public void OnNetWorkOk(String json) {
					parseRativiteNewJson(json);
				}
			});
		}
	}
	//解析JSON
	private void parseJson (String json){
		JSONObject jsonObject=JSONObject.parseObject(json);
		String status=jsonObject.getString("status");
		if(status.equals("ok")){
			JSONObject paramz=jsonObject.getJSONObject("paramz");
			JSONObject articleObject=paramz.getJSONObject("article");
			article=JSONObject.parseObject(articleObject.toJSONString(), ArticleBean.class);
			tvcontent_title1.setText(article.getSubject());
			tvcontent_title2.setText("来源:"+article.getOrigin()+"\t"+article.getOrigined());
			listView.setAdapter(new MyListViewAdapter());
		}
	}
	//解析相关新闻的JSON
	private void parseRativiteNewJson(String json){
		JSONObject jsonObject=JSONObject.parseObject(json);
		String status=jsonObject.getString("status");
		if(status.equals("ok")){
			JSONObject paramz=jsonObject.getJSONObject("paramz");
			JSONArray articles=paramz.getJSONArray("articles");
			rativiteNewsList.addAll(JSONArray.parseArray(articles.toJSONString(), RativiteNewsBean.class));
			RativiteNewAdapter adapter=new RativiteNewAdapter(rativiteNewsList);
			listView_RativiteNews.setAdapter(adapter);
		}
	}
	class MyListViewAdapter extends BaseAdapter{

		@Override
		public int getCount() {
			return article.getContents().size();
		}

		@Override
		public Object getItem(int position) {
			return article.getContents().get(position);
		}

		@Override
		public long getItemId(int position) {
			return position;
		}
		
		@Override
		public int getViewTypeCount() {
			return 2;
		}

		@Override
		public int getItemViewType(int position) {
			if(article.getContents().get(position).getCategory().equals("txt")){
				return 0;
			}
			return 1;
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			switch(getItemViewType(position)){
			case 0:
				if(convertView==null){
					convertView=new TextView(SecondUIActivity.this);
				}
				TextView tv=(TextView) convertView;
				tv.setTextSize(18);
				tv.setTextColor(Color.GRAY);
				tv.setText("\t\t"+article.getContents().get(position).getText());
				break;
			case 1:
				if(convertView==null){
					LinearLayout linearLayout=new LinearLayout(SecondUIActivity.this);
					NetworkImageView imageView=new NetworkImageView(SecondUIActivity.this);
					linearLayout.addView(imageView);
					int width=getWindow().getDecorView().getWidth();
					int height=0;
					if(article.getContents().get(position).getWidth()!=0){
						height=width* article.getContents().get(position).getHeight()
								/article.getContents().get(position).getWidth();
					}else{
						height=article.getContents().get(position).getHeight();
					}
					LayoutParams linearParams=new LayoutParams(width,height);
					linearParams.gravity=Gravity.CENTER;
					imageView.setLayoutParams(linearParams);
					imageView.setDefaultImageResId(R.drawable.ic_bakgrady);
					imageView.setErrorImageResId(R.drawable.ic_bakgrady);
					convertView=linearLayout;
				}
				LinearLayout con=(LinearLayout)convertView;
				((NetworkImageView)(con.getChildAt(0))).setImageUrl(article.getContents().get(position).getLink(), loader);
				break;
			}
			return convertView;
		}
	}
	@Override
	public void onClick(View v) {
		switch(v.getId()){
		case R.id.iv_secondui_back:
			finish();
			break;
		case R.id.iv_secondui_comment:
			
			
			break;
		case R.id.iv_secondui_share:
			showShare();
			break;
		}
	}
	private void showShare() {
		ShareSDK.initSDK(this);
		OnekeyShare oks = new OnekeyShare();
		//关闭SSO授权
		oks.disableSSOWhenAuthorize();
		 
		// 分享时Notification的图标和文字
		oks.setNotification(R.drawable.ic_launcher, getString(R.string.app_name));
		// title标题，印象笔记、邮箱、信息、微信、人人网和QQ空间使用
		oks.setTitle(getString(R.string.share));
		// titleUrl是标题的网络链接，仅在人人网和QQ空间使用
		oks.setTitleUrl("http://sharesdk.cn");
		// text是分享文本，所有平台都需要这个字段
		oks.setText("我是分享文本");
		// imagePath是图片的本地路径，Linked-In以外的平台都支持此参数
		//oks.setImagePath("/sdcard/test.jpg");//确保SDcard下面存在此张图片
		// url仅在微信（包括好友和朋友圈）中使用
		oks.setUrl("http://sharesdk.cn");
		// comment是我对这条分享的评论，仅在人人网和QQ空间使用
		oks.setComment("我是测试评论文本");
		// site是分享此内容的网站名称，仅在QQ空间使用
		oks.setSite(getString(R.string.app_name));
		// siteUrl是分享此内容的网站地址，仅在QQ空间使用
		oks.setSiteUrl("http://sharesdk.cn");
		 
		// 启动分享GUI
		oks.show(this);
	}
	class RativiteNewAdapter extends BaseAdapter{
		ArrayList<RativiteNewsBean> dataResourse;
		
		public RativiteNewAdapter(ArrayList<RativiteNewsBean> dataResourse) {
			this.dataResourse = dataResourse;
		}

		@Override
		public int getCount() {
			return dataResourse.size();
		}

		@Override
		public Object getItem(int position) {
			return dataResourse.get(position);
		}

		@Override
		public long getItemId(int position) {
			return position;
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			if(convertView==null){
				convertView=new TextView(SecondUIActivity.this);
			}
			TextView tv=(TextView) convertView;
			tv.setTextSize(18);
			tv.setText(dataResourse.get(position).getSubject());
			return convertView;
		}
	}
}
