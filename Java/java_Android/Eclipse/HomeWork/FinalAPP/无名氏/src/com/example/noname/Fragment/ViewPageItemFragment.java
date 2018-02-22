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
	// ���ظ����Ӧurl,Ϊ��ʱû�и�������
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

	// --------------------�õ�activity����������----------------
	private void initBundle() {
		Bundle bundle1 = getArguments();
		adsafe = bundle1.getString("adsafe");
		System.out.println(adsafe);
		news = bundle1.getString("title");
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		// 1���ֲ�ͼҪ�������ڣ������洦����
		topNewsView = View.inflate(getActivity(), R.layout.layout_roll_view,
				null);
		// 2,ListView(���һ��ͷaddHeader�����ֲ�ͼ��ӽ�ȥ)
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
	 * ��ʼ������
	 */
	private void initData() {
		// getNewsList(news, true);
		if (!TextUtils.isEmpty(news)) {// ��������url�����ڿ�
			String result = SharePreUtil.getStringData(getActivity(), news, "");
			if (!TextUtils.isEmpty(result)) {
				processData(result, true);
			}
			getNewsList(news, true);
		}
	}

	private void initPullListView() {
		// �������ص��¼���֧��
		ptrLv.setPullLoadEnabled(false);
		// ��������,����ˢ��֧��
		ptrLv.setScrollLoadEnabled(true);
		// ---------------------- �õ�ʵ�ʵ�ListView ���õ��---------------------
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

	// ---------------------------------pull�����¼�------------------------------
	@Override
	public void onPullDownToRefresh(PullToRefreshBase<ListView> refreshView) {
		// ����ˢ�£��������磬url(һ��),���֮ǰ���ݣ��ٴμ���һ��
		getNewsList(news, true);
	}

	@Override
	public void onPullUpToRefresh(PullToRefreshBase<ListView> refreshView) {
		// �������أ��������磬url(moreUrl),ԭ�����ݵĻ����ϣ��������һ����
		getNewsList(moreUrl, false);
	}

	private void getNewsList(final String loadUrl, final boolean isRefresh) {
		HttpUtils.RequestNetWork(loadUrl, new OnNetWorkResponse() {

			@Override
			public void ok(String response) {
				// ���ݳ־û�
				if (isRefresh) {
					SharePreUtil.saveStringData(getActivity(), news, response);
					// ����
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

	/**�������������
	 * @param isRefresh  �Ƿ�������ˢ��
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
						// top���ŵ�ͼƬ��ַ
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