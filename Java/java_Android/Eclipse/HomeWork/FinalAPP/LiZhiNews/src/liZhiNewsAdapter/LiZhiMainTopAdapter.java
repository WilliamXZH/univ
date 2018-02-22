package liZhiNewsAdapter;

import java.util.ArrayList;

import com.lizhinews.R;

import utils.HttpUtils;
import utils.Path_URL;
import bean.TopBean;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.support.v4.view.PagerAdapter;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

public class LiZhiMainTopAdapter extends PagerAdapter {
	private ArrayList<TopBean> data;
	private ArrayList<View> viewList;
	private Context context;
	private Activity activity;
	
	public LiZhiMainTopAdapter(Context context,Activity activity, ArrayList<TopBean> data) {
		this.data = data;
		this.activity=activity;
		this.context=context;
		viewList=new ArrayList<View>();
		addItemView(context, data);
	}

	private void addItemView(Context context, final ArrayList<TopBean> data) {
		LayoutInflater inflater=LayoutInflater.from(context);
		if(data!=null){
			for(int i=0;i<data.size();i++){
				View view=inflater.inflate(R.layout.lizhinews_main_top_item, null);
				TextView subject=(TextView) view.findViewById(R.id.tv_top_subject);
				ImageView icon=(ImageView)view.findViewById(R.id.iv_top_icon);
				subject.setText(data.get(i).getSubject());
				final int index=i;
				HttpUtils.showImage(context, Path_URL.IMAGEURL+data.get(i).getPhoto(), icon);
				icon.setOnClickListener(new OnClickListener() {
					
					@Override
					public void onClick(View v) {
						Intent intent=new Intent("action.ShowImage");
						intent.putExtra("URL", Path_URL.IMAGE_MAP+data.get(index).getOid());
						activity.startActivity(intent);
					}
				});
				viewList.add(view);
			}
		}
	}
	
	public ArrayList<TopBean> getData() {
		return data;
	}

	public void setData(ArrayList<TopBean> data) {
		this.data = data;
		addItemView(context,data);
		notifyDataSetChanged();
	}

	@Override
	public int getCount() {
		if(data==null){
			return 0;
		}
		return data.size();
	}

	@Override
	public boolean isViewFromObject(View arg0, Object arg1) {
		return arg0==arg1;
	}
	@Override
	public Object instantiateItem(ViewGroup container, int position) {
		View view=viewList.get(position);
		container.addView(view);
		return view;
	}
	@Override
	public void destroyItem(ViewGroup container, int position, Object object) {
		View view=viewList.get(position);
		container.removeView(view);
	}
}
