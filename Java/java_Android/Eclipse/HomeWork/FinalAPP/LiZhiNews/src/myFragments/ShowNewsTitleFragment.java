package myFragments;

import java.util.ArrayList;

import liZhiDataBase.LiZhiDataManager;
import liZhiNewsAdapter.LiZhiMainTopAdapter;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.handmark.pulltorefresh.library.PullToRefreshBase;
import com.handmark.pulltorefresh.library.PullToRefreshBase.Mode;
import com.handmark.pulltorefresh.library.PullToRefreshBase.OnRefreshListener2;
import com.handmark.pulltorefresh.library.PullToRefreshListView;
import com.lizhinews.R;

import bean.DataBean;
import bean.FeedBean;
import bean.TopBean;
import utils.HttpUtils;
import utils.HttpUtils.OnNetWorkRespond;
import utils.Path_URL;
import utils.UtilsMark;
import android.annotation.SuppressLint;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.view.ViewPager;
import android.text.TextUtils;
import android.util.Log;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

public class ShowNewsTitleFragment extends Fragment implements ViewPager.OnPageChangeListener,OnRefreshListener2<ListView>{
	private MyAdapter adapter;
	private PullToRefreshListView ptrListView;
	private ArrayList<ImageView> imageViews;
	private String topUrl,contentUrl1,contentUrl2;
	private int mark,drawableId;
	private LiZhiMainTopAdapter topAdapter;
	private int pageIndex=1;
	private int type;
	private ArrayList<TopBean> resours;
	
	private ImageView iv_singleimage_top;
	private  ViewPager viewPagerTop;
	private LiZhiDataManager dataManager;
	public static ShowNewsTitleFragment getInstance(int mark,int type,
			int drawableId,String topUrl,String contentUrl1,String contentUrl2){
		Bundle bundle=new Bundle();
		bundle.putString("topUrl", topUrl);
		bundle.putString("contentUrl1", contentUrl1);
		bundle.putString("contentUrl2", contentUrl2);
		bundle.putInt("mark", mark);
		bundle.putInt("type", type);
		bundle.putInt("drawableId", drawableId);
		ShowNewsTitleFragment fragment=new ShowNewsTitleFragment();
		fragment.setArguments(bundle);
		return fragment;
	}
	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		//����
		dataManager=new LiZhiDataManager(getActivity());
		final String topJson=dataManager.getJsonTop(type);
		//��һ��Fragment��Top����
		View view=null;
		pageIndex=1;
		if(mark==UtilsMark.HEADLINE_MARK){
			view=inflater.inflate(R.layout.lizhinews_main_fragment_layout, null);
			ptrListView=(PullToRefreshListView)view.findViewById(R.id.listViewAllNewsItem);
			View topView=(View)inflater.inflate(R.layout.lizhinews_main_top, null);
			viewPagerTop=(ViewPager)topView.findViewById(R.id.viewPagerLiZhiTop);
			//���ü���
			viewPagerTop.setOnPageChangeListener(ShowNewsTitleFragment.this);
			ImageView ivTop1=(ImageView)topView.findViewById(R.id.ivTop1);
			ImageView ivTop2=(ImageView)topView.findViewById(R.id.ivTop2);
			ImageView ivTop3=(ImageView)topView.findViewById(R.id.ivTop3);
			ImageView ivTop4=(ImageView)topView.findViewById(R.id.ivTop4);
			ImageView ivTop5=(ImageView)topView.findViewById(R.id.ivTop5);
			imageViews=new ArrayList<ImageView>();
			imageViews.add(ivTop1);
			imageViews.add(ivTop2);
			imageViews.add(ivTop3);
			imageViews.add(ivTop4);
			imageViews.add(ivTop5);
			//����Ĭ��Сͼ���ʼ״̬
			for(int i=0;i<imageViews.size();i++){
				imageViews.get(i).setEnabled(false);
			}
			ivTop1.setEnabled(true);
			//���붥����ListView
			ptrListView.getRefreshableView().addHeaderView(topView);
			//����ViewPager����������
			topAdapter=new LiZhiMainTopAdapter(getActivity(),getActivity(), null);
			viewPagerTop.setAdapter(topAdapter);
			//�������ͼƬJSON
			if(!TextUtils.isEmpty(topJson)){
				parserTopJson(topJson,false);
			}else{
				HttpUtils.downLoadJson(getActivity(), topUrl, new OnNetWorkRespond() {
					@Override
					public void onNetWorkError(String error) {
						Toast.makeText(getActivity(), error, Toast.LENGTH_LONG).show();
					}
					
					@Override
					public void OnNetWorkOk(String json) {
						Log.i("HttpUtils.getJson", json);
						parserTopJson(json,false);
						dataManager.insertTop(topJson, type);
					}
				});
			}
		}else if(mark==UtilsMark.SINGLEIMAGE_MARK){
			view=inflater.inflate(R.layout.lizhinews_main_fragment_layout, null);
			ptrListView=(PullToRefreshListView)view.findViewById(R.id.listViewAllNewsItem);
			View singleTopView=inflater.inflate(R.layout.lizhinews_singleimage_top, null);
			ptrListView.getRefreshableView().addHeaderView(singleTopView);
			iv_singleimage_top=(ImageView)singleTopView.findViewById(R.id.iv_singleimage_top);
			//
			if(!TextUtils.isEmpty(topJson)){
				parserTopJson(topJson,false);
				Log.i("���Ե�ͼ��ʾ", "))))))))))))))))))))))))");
			}else{
				//�����ͼƬ
				HttpUtils.downLoadJson(getActivity(), topUrl, new OnNetWorkRespond() {
					
					@Override
					public void onNetWorkError(String error) {
						
					}
					@Override
					public void OnNetWorkOk(String json) {
						parserTopJson(json,false);
						dataManager.insertTop(json, type);
					}
				});
			}
		}else if(mark==UtilsMark.NOLOAD_MARK){
			view=inflater.inflate(R.layout.lizhinews_pai, null);
			ptrListView=(PullToRefreshListView)view.findViewById(R.id.listView_pai);
			ImageView imageView_pai=(ImageView)view.findViewById(R.id.imageView_pai);
			imageView_pai.setBackgroundResource(drawableId);
			
		}
		//��listView���������
		ptrListView.getRefreshableView().setOnItemClickListener(new AdapterView.OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> parent, View view,
					int position, long id) {
				if(position==1){
					switch(mark){
					case UtilsMark.SINGLEIMAGE_MARK:
						Intent intent=new Intent("action.secondui");
						intent.putExtra("URL", Path_URL.Information_url1+resours.get(0).getOid());
						intent.putExtra("URLRATIVITE", Path_URL.RELATIVEINFORMATION+resours.get(0).getOid()+Path_URL.RELATIVEINFORMATION1);
						getActivity().startActivity(intent);
						return;
					}
				}
				if(adapter.getAllData().get(position-ptrListView.getRefreshableView().getHeaderViewsCount()).getCategory().equals("topic")){
					Intent intent=new Intent("action.zhuanti");
					intent.putExtra("URL", Path_URL.ZHUANTI+adapter.getAllData()
							.get(position-ptrListView.getRefreshableView().getHeaderViewsCount()).getOid());
					getActivity().startActivity(intent);
					return;
				}
				if(adapter.getAllData().get(position-ptrListView.getRefreshableView().getHeaderViewsCount()).getCategory().equals("map")){
					Intent intent=new Intent("action.ShowImage");
					intent.putExtra("URL", Path_URL.IMAGE_MAP+adapter.getAllData()
							.get(position-ptrListView.getRefreshableView().getHeaderViewsCount()).getOid());
					getActivity().startActivity(intent);
					return;
				}
				
				Intent intent=new Intent("action.secondui");
				intent.putExtra("URL", Path_URL.Information_url1+adapter.getAllData()
						.get(position-ptrListView.getRefreshableView().getHeaderViewsCount()).getOid());
				intent.putExtra("URLRATIVITE", Path_URL.RELATIVEINFORMATION+adapter.getAllData()
						.get(position-ptrListView.getRefreshableView().getHeaderViewsCount()).getOid()
						+Path_URL.RELATIVEINFORMATION1);
				getActivity().startActivity(intent);
			}
		});
		TextView emptyView=new TextView(getActivity());
		emptyView.setText("����ƴ�����...");
		emptyView.setGravity(Gravity.CENTER);
		emptyView.setTextSize(20);
		ptrListView.getRefreshableView().setEmptyView(emptyView);
		//��������б�������
		
		ptrListView.setMode(Mode.BOTH);
		ptrListView.setOnRefreshListener(this);
		adapter=new MyAdapter(null);
		ptrListView.getRefreshableView().setAdapter(adapter);
		//����ݿ�ȡ���,�����ݴ���,ֱ�ӽ���
		dataManager=new LiZhiDataManager(getActivity());
		String json=dataManager.getJson(type);
		if(!TextUtils.isEmpty(json)){
			parserJson(json);
		}else{
			HttpUtils.downLoadJson(getActivity(), contentUrl1+pageIndex+contentUrl2, new OnNetWorkRespond() {
				
				@Override
				public void onNetWorkError(String error) {
					Toast.makeText(getActivity(), error, Toast.LENGTH_LONG).show();
				}
				
				@Override
				public void OnNetWorkOk(String json) {
					parserJson(json);
				}
			});
		}
		
		return view;
	}
	@SuppressLint("UseSparseArrays")
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		//ȡ�����
		Bundle bundle=getArguments();
		topUrl=bundle.getString("topUrl");
		contentUrl1=bundle.getString("contentUrl1");
		contentUrl2=bundle.getString("contentUrl2");
		mark=bundle.getInt("mark");
		drawableId=bundle.getInt("drawableId");
		type=bundle.getInt("type");
	}
	//����ͷ��ķ���
	private void parserTopJson(String json,boolean isRefrash){
		JSONObject jsonObject=JSONObject.parseObject(json);
		if(jsonObject.getString("status").equals("ok")){
			JSONObject paramz=jsonObject.getJSONObject("paramz");
			JSONArray tops=paramz.getJSONArray("tops");
			resours=(ArrayList<TopBean>) JSONArray.parseArray(tops.toJSONString(), TopBean.class);
			switch(mark){
			case UtilsMark.HEADLINE_MARK:
				if(isRefrash){
					dataManager.insertTop(json, type);
				}
				topAdapter.setData(resours);
				break;
			case UtilsMark.SINGLEIMAGE_MARK:
				if(isRefrash){
					dataManager.insertTop(json, type);
				}
				HttpUtils.showImage(getActivity(), Path_URL.IMAGEURL+resours.get(0).getPhoto(), iv_singleimage_top);
				Log.i("��ͼ��URL", Path_URL.IMAGEURL+resours.get(0).getPhoto());
				break;
			}
		}
	}
	//�������ݵķ���
	private void parserJson(String json){
		Log.i("parserJson Json", "json");
		JSONObject jsonObject=JSONObject.parseObject(json);
		String status=jsonObject.getString("status");
		if(status.equals("ok")){
			JSONObject paramz=jsonObject.getJSONObject("paramz");
			JSONArray feeds=paramz.getJSONArray("feeds");
			ArrayList<FeedBean> data=(ArrayList<FeedBean>) JSONArray.parseArray(feeds.toJSONString(), FeedBean.class);
			if(pageIndex==1){
				//����ݿ�����һҳ��JSON,���allData,����������
				dataManager.insert(json, type);
				adapter.setAllData(data);
			}
			else{
				adapter.getAllData().addAll(data);
			}
			adapter.notifyDataSetChanged();
		}
		pageIndex++;
	}
	class MyAdapter extends BaseAdapter{
		ArrayList<FeedBean> allData;
		
		public MyAdapter(ArrayList<FeedBean> data) {
			this.allData = data;
		}
		
		public ArrayList<FeedBean> getAllData() {
			return allData;
		}

		public void setAllData(ArrayList<FeedBean> allData) {
			this.allData = allData;
		}

		@Override
		public int getCount() {
			if(allData==null){
				return 0;
			}
			return allData.size();
		}

		@Override
		public Object getItem(int position) {
			return allData.get(position);
		}

		@Override
		public long getItemId(int position) {
			return position;
		}
		//�����������еĲ������͵ĸ���
		@Override
		public int getViewTypeCount() {
			return 5;
		}
		//���positionλ�÷��ز�������
		@Override
		public int getItemViewType(int position) {
			if(allData.get(position).getCategory().equals("map")){
				return 1;
			}else if(allData.get(position).getData().getFormat().equals("original")){
				return 4;
			}else if(allData.get(position).getCategory().equals("article")){
				return 0;
			}else if(allData.get(position).getCategory().equals("topic")){
				return 2;
			}else if(allData.get(position).getCategory().equals("vote")){
				return 3;
			}
			return 0;
		}
		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			DataBean  dataBean=allData.get(position).getData();
			Log.i("databean---getView", dataBean.toString());
			
			if(getItemViewType(position)==1){
				final MapViewHolder mViewHolder;
				if(convertView==null){
					convertView=LayoutInflater.from(getActivity()).inflate(R.layout.lizhinew_main_nonnormal, null);
					mViewHolder=new MapViewHolder();
					mViewHolder.tvItemTitle=(TextView)convertView.findViewById(R.id.tvItemTitle);
					mViewHolder.ivItem_Icon1=(ImageView)convertView.findViewById(R.id.ivItem_Icon1);
					mViewHolder.ivItem_Icon2=(ImageView)convertView.findViewById(R.id.ivItem_Icon2);
					mViewHolder.ivItem_Icon3=(ImageView)convertView.findViewById(R.id.ivItem_Icon3);
					convertView.setTag(mViewHolder);
				}else{
					mViewHolder=(MapViewHolder) convertView.getTag();
				}
				mViewHolder.tvItemTitle.setText(dataBean.getSubject());
				
				mViewHolder.ivItem_Icon1.setImageResource(R.drawable.ic_bakgrady);
				mViewHolder.ivItem_Icon2.setImageResource(R.drawable.ic_bakgrady);
				mViewHolder.ivItem_Icon3.setImageResource(R.drawable.ic_bakgrady);
				
				HttpUtils.showImage(getActivity(),Path_URL.IMAGEURL+dataBean.getPics().get(0).getPhoto(), mViewHolder.ivItem_Icon1);
				HttpUtils.showImage(getActivity(),Path_URL.IMAGEURL+dataBean.getPics().get(1).getPhoto(), mViewHolder.ivItem_Icon2);
				HttpUtils.showImage(getActivity(),Path_URL.IMAGEURL+dataBean.getPics().get(2).getPhoto(), mViewHolder.ivItem_Icon3);
				return convertView;
			}else{
				View view=convertView;
				MyHold myHold=null;
				if(view==null){
					view=LayoutInflater.from(getActivity()).inflate(R.layout.lizhinews_main_item, parent,false);
					myHold=new MyHold(view);
					view.setTag(myHold);
				}
				myHold=(MyHold) view.getTag();
				TextView tvSubject=myHold.getTvSubject();
				TextView tvSummary=myHold.getTvSummary();
				TextView tvCategory=myHold.getTvCategory();
				switch(getItemViewType(position)){
				case 0:
					break;
				case 2:
					tvCategory.setBackgroundColor(Color.RED);
					tvCategory.setText("专题");
					break;
				case 3:
					tvCategory.setBackgroundColor(Color.RED);
					tvCategory.setText("投票");
					break;
				case 4:
					tvCategory.setBackgroundColor(Color.RED);
					tvCategory.setText("独家");
					break;
				}
				
				ImageView ivItemIcon=myHold.getIvItemIcon();
				tvSubject.setText(dataBean.getSubject().trim());
				
				System.out.println("===="+dataBean.getSummary());
				System.out.println("===="+tvSummary.toString());
				
				if(null!=dataBean.getSummary())
				tvSummary.setText(dataBean.getSummary().trim());
				else
					tvSummary.setText("");
				//���õ�ʱ��,�ٴӼ��ض�ӦͼƬ,����ͼƬ��λ
				ivItemIcon.setImageResource(R.drawable.ic_bakgrady);
				HttpUtils.showImage(getActivity(),Path_URL.IMAGEURL+dataBean.getCover(), ivItemIcon);
				return view;
			}
		}
	}
	//��ʾ����ͼƬ��Item��holder
	class MapViewHolder{
		TextView tvItemTitle;
		ImageView ivItem_Icon1;
		ImageView ivItem_Icon2;
		ImageView ivItem_Icon3;
	}
	//������ģʽ
	class MyHold{
		View view;
		ImageView ivItemIcon;
		TextView tvSubject;
		TextView tvSummary;
		TextView tvCategory;
		public MyHold(View view){
			this.view=view;
		}
		public TextView getTvSubject(){
			if(tvSubject==null){
				tvSubject=(TextView) view.findViewById(R.id.tvSubject);
			}
			return tvSubject;
		}
		public TextView getTvSummary(){
			if(tvSummary==null){
				tvSummary=(TextView) view.findViewById(R.id.tvSummary);
			}
			return tvSummary;
		}
		public TextView getTvCategory(){
			if(tvCategory==null){
				tvCategory=(TextView) view.findViewById(R.id.tvIndicateCategory);
			}
			return tvCategory;
		}
		
		public ImageView getIvItemIcon(){
			if(ivItemIcon==null){
				ivItemIcon=(ImageView) view.findViewById(R.id.ivItemIcon);
			}
			return ivItemIcon;
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
		//����Ĭ��Сͼ��״̬
		for(int i=0;i<imageViews.size();i++){
			imageViews.get(i).setEnabled(false);
		}
		imageViews.get(arg0).setEnabled(true);
	}
	//下来刷新
	@Override
	public void onPullDownToRefresh(PullToRefreshBase<ListView> refreshView) {
		ptrListView.getLoadingLayoutProxy().setPullLabel("下拉刷新");
		ptrListView.getLoadingLayoutProxy().setReleaseLabel("下拉以刷新");
		ptrListView.getLoadingLayoutProxy().setRefreshingLabel("正在刷新...");
		pageIndex = 1;
		Log.i("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@", "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		// ˢ����������
		HttpUtils.downLoadJson(getActivity(), contentUrl1 + pageIndex+ contentUrl2, new OnNetWorkRespond() {

			@Override
			public void onNetWorkError(String error) {
				Toast.makeText(getActivity(), error, Toast.LENGTH_LONG).show();
			}

			@Override
			public void OnNetWorkOk(String json) {
				parserJson(json);
				ptrListView.onRefreshComplete();
			}
		});
		//ˢ��ͷ��
		HttpUtils.downLoadJson(getActivity(), topUrl, new OnNetWorkRespond() {
			
			@Override
			public void onNetWorkError(String error) {
				
			}
			
			@Override
			public void OnNetWorkOk(String json) {
				parserTopJson(json, true);
				ptrListView.onRefreshComplete();
			}
		});
	}
	//��-��ҳ����
	@Override
	public void onPullUpToRefresh(PullToRefreshBase<ListView> refreshView) {
		ptrListView.getLoadingLayoutProxy().setPullLabel("加载更多");
		ptrListView.getLoadingLayoutProxy().setReleaseLabel("放开以加载");
		ptrListView.getLoadingLayoutProxy().setRefreshingLabel("正在加载更多...");
		//��ҳ�������Ų���
		HttpUtils.downLoadJson(getActivity(), contentUrl1+pageIndex+contentUrl2, new OnNetWorkRespond() {
			
			@Override
			public void onNetWorkError(String error) {
				Toast.makeText(getActivity(), error, Toast.LENGTH_LONG).show();
			}
			
			@Override
			public void OnNetWorkOk(String json) {
				parserJson(json);
				ptrListView.onRefreshComplete();
			}
		});
	}
	@Override
	public void onDestroyView() {
		super.onDestroyView();
	}
}
