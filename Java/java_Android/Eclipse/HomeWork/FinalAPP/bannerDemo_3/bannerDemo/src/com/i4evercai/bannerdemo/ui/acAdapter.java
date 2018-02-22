package com.i4evercai.bannerdemo.ui;


import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import java.util.List;

import com.i4evercai.bannerdemo.R;

public class acAdapter extends ArrayAdapter<News>
{
    private int resourceId;
    public acAdapter(Context context, int textViewResourceId, List<News> Volunterings)
    {
        super(context,textViewResourceId, Volunterings);
        this.resourceId=textViewResourceId;
    }
    public View getView(int position, View convertView, ViewGroup parent)
    {
        News v=getItem(position);
        View view;
        ViewHolder viewHolder;
        if(convertView==null)
        {
            view=LayoutInflater.from(getContext()).inflate(resourceId,null);
            viewHolder=new ViewHolder();
            viewHolder.tvName=(TextView)view.findViewById(R.id.rank_name);
            viewHolder.tvContent=(TextView)view.findViewById(R.id.short_content);
            view.setTag(viewHolder);
        }
        else
        {
            view=convertView;
            viewHolder=(ViewHolder) view.getTag();
        }
        viewHolder.tvContent.setText(v.getShort_content());
        viewHolder.tvName.setText(v.getName());
        return view;

    }

    class ViewHolder
    {
        TextView tvName;
        TextView tvContent;
        TextView num4need;
    }
}
