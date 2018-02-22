package com.example.noname.adapter;

import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.example.noname.R;
import com.example.noname.bean.News;
import com.example.noname.bean.NewsData;
import com.example.noname.utils.ImageLoader;
import com.example.noname.utils.QLApi;
import com.loopj.android.image.SmartImageView;

public class NewsAdapter extends BaseAdapter {

	public static final int VIEWTYPE_ARTICLE = 0;
	public static final int VIEWTYPE_MAP = 1;

	private Context context;
	private List<News> data;
	private LayoutInflater inflater;

	public NewsAdapter(Context context, List<News> data) {
		super();
		this.context = context;
		this.data = data;
		inflater = LayoutInflater.from(context);
	}

	
	
	public List<News> getData() {
		return data;
	}



	public void setData(List<News> data) {
		this.data = data;
	}


	public void addData(List<News> data){
		this.data.addAll(data);
		notifyDataSetChanged();
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
	public int getViewTypeCount() {
		return 2;
	}

	@Override
	public int getItemViewType(int position) {

		News news = data.get(position);
		if (news.getCategory().equals("map")) {
			return VIEWTYPE_MAP;
		} else {
			return VIEWTYPE_ARTICLE;
		}
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {

		switch (getItemViewType(position)) {
		case VIEWTYPE_ARTICLE:
			ViewHolder holder = null;
			if (convertView == null) {
				convertView = inflater
						.inflate(R.layout.list_item_article, null);
				holder = new ViewHolder();
				holder.cover = (SmartImageView) convertView
						.findViewById(R.id.iv_listitem_articleCover);
				holder.subject = (TextView) convertView
						.findViewById(R.id.tv_listitem_articleSubject);
				holder.summary = (TextView) convertView
						.findViewById(R.id.tv_listitem_articleSummary);
				convertView.setTag(holder);
			} else {
				holder = (ViewHolder) convertView.getTag();
			}

			NewsData newsData = data.get(position).getData();
			holder.subject.setText(newsData.getSubject());
			holder.summary.setText(newsData.getSummary());
			holder.cover.setImageUrl(QLApi.Image_Header+newsData.getCover());
			break;

		case VIEWTYPE_MAP:
			ViewMapHodler mapholder=null;
			if (convertView == null) {
				convertView = inflater.inflate(R.layout.list_item_map, null);
				mapholder=new ViewMapHodler();
				mapholder.subject=(TextView) convertView.findViewById(R.id.tv_listitem_mapSubject);
				mapholder.icon1=(SmartImageView) convertView.findViewById(R.id.iv_listitem_mapIcon1);
				mapholder.icon2=(SmartImageView) convertView.findViewById(R.id.iv_listitem_mapIcon2);
				mapholder.icon3=(SmartImageView) convertView.findViewById(R.id.iv_listitem_mapIcon3);
				convertView.setTag(mapholder);
			}else{
				mapholder=(ViewMapHodler) convertView.getTag();
			}
			
			NewsData newsData2 = data.get(position).getData();
			mapholder.subject.setText(newsData2.getSubject());
			
			mapholder.icon1.setImageUrl(QLApi.Image_Header+newsData2.getPics().get(0).getPhoto());
			mapholder.icon2.setImageUrl(QLApi.Image_Header+newsData2.getPics().get(1).getPhoto());
			mapholder.icon3.setImageUrl(QLApi.Image_Header+newsData2.getPics().get(2).getPhoto());
			
			break;
		}

		return convertView;
	}

	class ViewHolder {
		SmartImageView cover;
		TextView subject;
		TextView summary;

	}

	class ViewMapHodler {
		TextView subject;
		SmartImageView icon1;
		SmartImageView icon2;
		SmartImageView icon3;
	}

}
