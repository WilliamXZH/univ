package com.example.noname.Fragment;

import java.util.ArrayList;
import java.util.List;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewGroup.LayoutParams;
import android.widget.AdapterView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.AdapterView.OnItemClickListener;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.example.noname.R;
import com.example.noname.adapter.NewsAdapter;
import com.example.noname.adapter.RollViewPager;
import com.example.noname.adapter.RollViewPager.OnPagerClickCallback;
import com.example.noname.bean.News;
import com.example.noname.pullrefreshview.PullToRefreshBase;
import com.example.noname.pullrefreshview.PullToRefreshBase.OnRefreshListener;
import com.example.noname.pullrefreshview.PullToRefreshListView;
import com.example.noname.utils.CommonUtil;
import com.example.noname.utils.HttpUtils;
import com.example.noname.utils.HttpUtils.OnNetWorkResponse;
import com.example.noname.utils.QLApi;
import com.example.noname.utils.SharePreUtil;
import com.example.noname.utils.TopPager;
import com.lidroid.xutils.ViewUtils;
import com.lidroid.xutils.view.annotation.ViewInject;

public class ViewPageItemFragment extends Fragment implements
		OnRefreshListener<ListView> {
	@ViewInject(R.id.top_news_title)
	private TextView topNewsTitle;
	@ViewInject(R.id.loading_view)
	protected View loadingView;
	@ViewInject(R.id.top_news_viewpager)
	private LinearLayout mViewPagerLay;
	@ViewInject(R.id.dots_ll)
	private LinearLayout dotLl;
	@ViewInject(R.id.lv_item_news)
	private PullToRefreshListView ptrLv;
	private View topNewsView;
	private RollViewPager mViewPager;
	private View view;
	private String title;
	private NewsAdapter adapter;
	// 加载更多对应url,为空时没有更多数据
	private String moreUrl;
	public boolean isLoadSuccess;
	private ArrayList<String> titleList, urlList;
	private ArrayList<View> dotList;
	private String adsafe;
	private String news;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		initBundle();
	}

	// --------------------得到activity传来的数据----------------
	private void initBundle() {
		Bundle bundle1 = getArguments();
		adsafe = bundle1.getString("adsafe");
		System.out.println(adsafe);
		news = bundle1.getString("title");
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		// 1，轮播图要单独存在，并且随处可用
		topNewsView = View.inflate(getActivity(), R.layout.layout_roll_view,
				null);
		// 2,ListView(添加一个头addHeader，将轮播图添加进去)
		view = View.inflate(getActivity(), R.layout.frag_item_news, null);
		ViewUtils.inject(this, view);
		ViewUtils.inject(this, topNewsView);
		initPullListView();
		initData();
		return view;
	}

	@Override
	public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onViewCreated(view, savedInstanceState);
	}

	/**
	 * 初始化数据
	 */
	private void initData() {
		// getNewsList(news, true);
		if (!TextUtils.isEmpty(news)) {// 传过来的url不等于空
			String result = SharePreUtil.getStringData(getActivity(), news, "");
			if (!TextUtils.isEmpty(result)) {
				processData(result, true);
			}
			getNewsList(news, true);
		}
	}

	private void initPullListView() {
		// 下拉加载的事件不支持
		ptrLv.setPullLoadEnabled(false);
		// 上拉加载,下拉刷新支持
		ptrLv.setScrollLoadEnabled(true);
		// ---------------------- 得到实际的ListView 设置点击---------------------
		ptrLv.getRefreshableView().setOnItemClickListener(
				new OnItemClickListener() {

					@Override
					public void onItemClick(AdapterView<?> arg0, View arg1,
							int arg2, long arg3) {

					}

				});
		ptrLv.setOnRefreshListener(this);
	}

	@Override
	public void onActivityCreated(Bundle savedInstanceState) {
		super.onActivityCreated(savedInstanceState);
	}

	// ---------------------------------pull监听事件------------------------------
	@Override
	public void onPullDownToRefresh(PullToRefreshBase<ListView> refreshView) {
		// 下拉刷新，请求网络，url(一样),清除之前数据，再次加载一遍
		getNewsList(news, true);
	}

	@Override
	public void onPullUpToRefresh(PullToRefreshBase<ListView> refreshView) {
		// 上拉加载，请求网络，url(moreUrl),原有数据的基础上，再天添加一部分
		getNewsList(moreUrl, false);
	}

	private void getNewsList(final String loadUrl, final boolean isRefresh) {
		HttpUtils.RequestNetWork(loadUrl, new OnNetWorkResponse() {

			@Override
			public void ok(String response) {
				// 数据持久化
				if (isRefresh) {
					SharePreUtil.saveStringData(getActivity(), news, response);
					// 解析
				}
				processData(response, isRefresh);
			}

			@Override
			public void error(String error) {
				onLoaded();
			}

		});
	}

	protected void onLoaded() {
		dismissLoadingView();
		ptrLv.onPullDownRefreshComplete();
		ptrLv.onPullUpRefreshComplete();
	}

	private void dismissLoadingView() {
		if (loadingView != null)
			loadingView.setVisibility(View.INVISIBLE);
	}

	protected void processData(String json, final boolean isRefresh) {
		ParseAdSafe(isRefresh);
		getListNews(json);
		
	}

	private void getListNews(String response) {
		JSONObject object = JSONObject.parseObject(response);
		String status = object.getString("status");
		if (status.equals("ok")) {
			JSONObject paramz = object.getJSONObject("paramz");
			JSONArray feeds = paramz.getJSONArray("feeds");

			List<News> newsList = JSONArray.parseArray(feeds.toJSONString(),
					News.class);

			if (adapter == null) {
				adapter = new NewsAdapter(getActivity(), newsList);
				ptrLv.getRefreshableView().setAdapter(adapter);
			} else {
				adapter.notifyDataSetChanged();
			}
			onLoaded();
			setLastUpdateTime();
		}
	}

	protected void setLastUpdateTime() {
		String text = CommonUtil.getStringDate();
		ptrLv.setLastUpdatedLabel(text);
	}

	private void initDot(int size) {
		dotList = new ArrayList<View>();
		dotLl.removeAllViews();
		for (int i = 0; i < size; i++) {
			LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(
					CommonUtil.dip2px(getActivity(), 6), CommonUtil.dip2px(
							getActivity(), 6));
			params.setMargins(5, 0, 5, 0);
			View m = new View(getActivity());
			if (i == 0) {
				m.setBackgroundResource(R.drawable.dot_focus);
			} else {
				m.setBackgroundResource(R.drawable.dot_normal);
			}
			m.setLayoutParams(params);
			dotLl.addView(m);
			dotList.add(m);
		}
	}

	/**解析广告栏数据
	 * @param isRefresh  是否是下拉刷新
	 */
	private void ParseAdSafe(final boolean isRefresh) {
		HttpUtils.RequestNetWork(adsafe, new OnNetWorkResponse() {

			@Override
			public void ok(String response) {
				JSONObject object = (JSONObject) JSONObject.parse(response);
				String status = object.getString("status");
				if (status.equals("ok")) {
					JSONObject paramz = object.getJSONObject("paramz");
					JSONArray tops = paramz.getJSONArray("tops");
					final List<TopPager> topPagers = JSONArray.parseArray(
							tops.toJSONString(), TopPager.class);
					isLoadSuccess = true;
					titleList = new ArrayList<String>();
					urlList = new ArrayList<String>();
					if (isRefresh) {
						for (int i = 0; i < topPagers.size(); i++) {
							titleList.add(topPagers.get(i).getSubject());
							urlList.add(QLApi.Image_Header
									+ topPagers.get(i).getPhoto());
						}
						initDot(topPagers.size());
						mViewPager = new RollViewPager(getActivity(), dotList,
								R.drawable.dot_focus, R.drawable.dot_normal,
								new OnPagerClickCallback() {
									@Override
									public void onPagerClick(int position) {
									}
								});
						mViewPager
								.setLayoutParams(new LinearLayout.LayoutParams(
										LayoutParams.MATCH_PARENT,
										LayoutParams.WRAP_CONTENT));
						// top新闻的图片地址
						mViewPager.setUriList(urlList);
						mViewPager.setTitle(topNewsTitle, titleList);
						mViewPager.startRoll();
						mViewPagerLay.removeAllViews();
						mViewPagerLay.addView(mViewPager);
						if (ptrLv.getRefreshableView().getHeaderViewsCount() < 1) {
							ptrLv.getRefreshableView().addHeaderView(
									topNewsView);
						}
					}

				}
			}

			@Override
			public void error(String error) {

			}
		});
	}
}