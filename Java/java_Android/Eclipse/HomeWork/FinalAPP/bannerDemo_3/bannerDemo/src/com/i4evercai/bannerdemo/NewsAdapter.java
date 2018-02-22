package com.i4evercai.bannerdemo;


import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;
import java.util.LinkedList;

/**
 * Created by Administrator on 2016/12/2.
 */

    public class NewsAdapter extends BaseAdapter {
        private LinkedList<New> News;
        private Context mContext;

        public NewsAdapter(LinkedList<New> mData, Context mContext) {
            this.News = mData;
            this.mContext = mContext;
        }

    @Override
    public int getCount() {
        return News.size();
    }

    @Override
    public Object getItem(int position) {
        return null;
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        convertView = LayoutInflater.from(mContext).inflate(R.layout.news,parent,false);
        ImageView img_icon = (ImageView) convertView.findViewById(R.id.img_icon);
        TextView title = (TextView) convertView.findViewById(R.id.title);
        TextView content = (TextView) convertView.findViewById(R.id.content);
        img_icon.setBackgroundResource(News.get(position).getIcon());
        title.setText(News.get(position).getTitle());
        content.setText(News.get(position).getContent());
        return convertView;

    }
}
