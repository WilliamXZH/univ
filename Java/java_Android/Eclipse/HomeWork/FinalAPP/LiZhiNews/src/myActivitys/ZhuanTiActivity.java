package myActivitys;

import java.util.ArrayList;
import bean.FeedBean;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.lizhinews.R;
import se.emilsjolander.stickylistheaders.StickyListHeadersAdapter;
import se.emilsjolander.stickylistheaders.StickyListHeadersListView;
import utils.HttpUtils;
import utils.HttpUtils.OnNetWorkRespond;
import utils.Path_URL;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

public class ZhuanTiActivity extends BaseActivity implements OnClickListener,OnItemClickListener{
	private StickyListHeadersListView stickyListView;
	private ImageView iv_zhuanti,iv_zhuanti_back;
	private TextView tv_zhuanti;
	private ArrayList<FeedBean> data;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		data=new ArrayList<FeedBean>();
		Intent intent=getIntent();
		String url=intent.getStringExtra("URL");
		setContentView(R.layout.zhuanti_main_layout);
		stickyListView=(StickyListHeadersListView)findViewById(R.id.StickyListHeadersListView_zhuanti);
		iv_zhuanti=(ImageView)findViewById(R.id.iv_zhuanti);
		iv_zhuanti_back=(ImageView)findViewById(R.id.iv_zhuanti_back);
		iv_zhuanti_back.setOnClickListener(this);
		tv_zhuanti=(TextView)findViewById(R.id.tv_zhuanti);
		HttpUtils.downLoadJson(this, url, new OnNetWorkRespond() {
			
			@Override
			public void onNetWorkError(String error) {
				Toast.makeText(ZhuanTiActivity.this, error, Toast.LENGTH_LONG).show();
			}
			
			@Override
			public void OnNetWorkOk(String json) {
				paserJson(json);
			}
		});
		//��ӵ���¼�
		stickyListView.setOnItemClickListener(this);
	}
	private void paserJson(String json){
		JSONObject jsonObject=JSONObject.parseObject(json);
		String status=jsonObject.getString("status");
		if(status.equals("ok")){
			JSONObject paramz=jsonObject.getJSONObject("paramz");
			JSONObject topic=paramz.getJSONObject("topic");
			String contents=topic.getString("contents");
			tv_zhuanti.setText(contents);
			String photo=topic.getString("photo");
			HttpUtils.showImage(this, Path_URL.IMAGEURL+photo, iv_zhuanti);
			JSONArray defaults=paramz.getJSONArray("defaults");
			for(int i=0;i<defaults.size();i++){
				JSONObject news=defaults.getJSONObject(i);
				FeedBean feedBean=JSONObject.parseObject(news.toJSONString(), FeedBean.class);
				feedBean.setType("头条新闻");
				data.add(feedBean);
			}
			
			JSONArray columns=paramz.getJSONArray("columns");
			
			for(int i=0;i<columns.size();i++){
				JSONObject news=columns.getJSONObject(i);
				String name=news.getString("name");
				JSONArray feed=news.getJSONArray("feed");
				for(int j=0;j<feed.size();j++){
					JSONObject fee=feed.getJSONObject(j);
					FeedBean feedBean=JSONObject.parseObject(fee.toJSONString(), FeedBean.class);
					feedBean.setType(name);
					data.add(feedBean);
				}
			}
		}
		MyAdapter adapter=new MyAdapter(data);
		stickyListView.setAdapter(adapter);
	}
	@Override
	public void onClick(View v) {
		switch(v.getId()){
		case R.id.iv_zhuanti_back:
			finish();
			break;
		}
	}
	class MyAdapter extends BaseAdapter implements StickyListHeadersAdapter{
		private ArrayList<FeedBean> data;
		
		public MyAdapter(ArrayList<FeedBean> data) {
			this.data = data;
		}

		public void setData(ArrayList<FeedBean> data) {
			this.data = data;
		}

		@Override
		public int getCount() {
			return data.size();
		}

		@Override
		public Object getItem(int position) {
			return data.get(position);
		}

		@Override
		public long getItemId(int position) {
			return position;
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			FeedBean feedBean=data.get(position);
			MyHolder holder=null;
			if(convertView==null){
				convertView=getLayoutInflater().inflate(R.layout.lizhinews_main_item, null);
				holder=new MyHolder();
				holder.ivItemIcon=(ImageView) convertView.findViewById(R.id.ivItemIcon);
				holder.tvSubject=(TextView)convertView.findViewById(R.id.tvSubject);
				holder.tvSummary=(TextView)convertView.findViewById(R.id.tvSummary);
				convertView.setTag(holder);
			}else{
				holder=(MyHolder) convertView.getTag();
			}
			holder.ivItemIcon.setImageResource(R.drawable.ic_bakgrady);
			HttpUtils.showImage(ZhuanTiActivity.this, 
					Path_URL.IMAGEURL+feedBean.getData().getCover(), holder.ivItemIcon);
			holder.tvSubject.setText(feedBean.getData().getSubject());
			holder.tvSummary.setText(feedBean.getData().getSummary());
			return convertView;
		}

		@Override
		public View getHeaderView(int position, View convertView,
				ViewGroup parent) {
			if(convertView==null){
				convertView=new TextView(ZhuanTiActivity.this);
			}
			TextView tv=(TextView) convertView;
			tv.setBackgroundColor(Color.GRAY);
			tv.setTextSize(20);
			tv.setText(data.get(position).getType());
			return convertView;
		}

		@Override
		public long getHeaderId(int position) {
			return data.get(position).getType().charAt(0);
		}
	}
	class MyHolder{
		ImageView ivItemIcon;
		TextView tvSubject;
		TextView tvSummary;
	}
	@Override
	public void onItemClick(AdapterView<?> parent, View view, int position,
			long id) {
		Intent intent=new Intent("action.secondui");
		intent.putExtra("URL", Path_URL.Information_url1+data.get(position).getOid());
		intent.putExtra("URLRATIVITE", Path_URL.RELATIVEINFORMATION+data.get(position).getOid()+Path_URL.RELATIVEINFORMATION1);
		startActivity(intent);
	}
}
