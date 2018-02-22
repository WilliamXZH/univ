package com.i4evercai.bannerdemo.ui;



import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import java.util.LinkedList;

import com.i4evercai.bannerdemo.R;
import com.i4evercai.bannerdemo.Talk;
import com.i4evercai.bannerdemo.R.id;
import com.i4evercai.bannerdemo.R.layout;

/**
 * Created by Administrator on 2016/12/4.
 */

public class TalkAdapter extends BaseAdapter {
    private LinkedList<Talk> Talks;
    private Context mContext;
    public TalkAdapter(LinkedList<Talk> mData, Context mContext){
        this.Talks=mData;
        this.mContext=mContext;
    }
    @Override
    public int getCount() {
        return Talks.size();
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
        convertView = LayoutInflater.from(mContext).inflate(R.layout.talk,parent,false);

        TextView user = (TextView) convertView.findViewById(R.id.username);
        TextView timee = (TextView) convertView.findViewById(R.id.time);
        TextView text = (TextView) convertView.findViewById(R.id.text);
        user.setText(Talks.get(position).getUsername());
        timee.setText(Talks.get(position).getTime());

        text.setText(Talks.get(position).getText());
        return convertView;

    }
}
