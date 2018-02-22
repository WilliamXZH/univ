package myFragments;

import com.lizhinews.R;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.TextView;

public class SlidingMenuFragment extends Fragment {
	private GridView gridView;
	private String[]data={"新闻","江苏城市","专题","原创","图集","监督","投票","荔枝电台","活动"};
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
	}
	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		View view=inflater.inflate(R.layout.slidingmenufragmentlayout, null);
		gridView=(GridView)view.findViewById(R.id.gridViewSlidingMenu);
		gridView.setAdapter(new GridViewAdapter());
		return view;
	}
	class GridViewAdapter extends BaseAdapter{

		@Override
		public int getCount() {
			return data.length;
		}

		@Override
		public Object getItem(int position) {
			return data[position];
		}

		@Override
		public long getItemId(int position) {
			return position;
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			GridViewHolder holder=null;
			if(convertView==null){
				LayoutInflater inflater=LayoutInflater.from(getActivity());
				convertView=inflater.inflate(R.layout.slidingmenufragment_gridview_item, null);
				holder=new GridViewHolder();
				holder.tv=(TextView)convertView.findViewById(R.id.textViewGrid);
				holder.iv=(ImageView)convertView.findViewById(R.id.imageViewGrid);
				convertView.setTag(holder);
			}else{
				holder=(GridViewHolder) convertView.getTag();
			}
			holder.tv.setText(data[position]);
			return convertView;
		}
	}
	class GridViewHolder{
		TextView tv;
		ImageView iv;
	}
}
