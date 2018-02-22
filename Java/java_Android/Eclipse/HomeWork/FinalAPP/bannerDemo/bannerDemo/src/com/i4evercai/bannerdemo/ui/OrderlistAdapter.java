package com.i4evercai.bannerdemo.ui;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ListView;
import android.widget.TextView;

import java.util.LinkedList;

import com.i4evercai.bannerdemo.OrderItem;
import com.i4evercai.bannerdemo.R;
import com.i4evercai.bannerdemo.R.id;
import com.i4evercai.bannerdemo.R.layout;

/**
 * Created by Administrator on 2016/12/6.
 */

public class OrderlistAdapter extends BaseAdapter {
    private LinkedList<OrderItem> orderItems;
    private Context context;
    public OrderlistAdapter(LinkedList<OrderItem> orderItems, Context context){
        this.orderItems=orderItems;
        this.context=context;
    }

    @Override
    public int getCount() {
        return orderItems.size();
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
        convertView = LayoutInflater.from(context).inflate(R.layout.oneorder,parent,false);
        TextView company=(TextView) convertView.findViewById(R.id.company);
        TextView serviceType = (TextView) convertView.findViewById(R.id.serviceType);
        TextView cost = (TextView) convertView.findViewById(R.id.cost);
        TextView flag = (TextView) convertView.findViewById(R.id.state);
        company.setText(orderItems.get(position).getCompany());
        serviceType.setText(orderItems.get(position).getServiceType());
        cost.setText(""+orderItems.get(position).getCost());
        flag.setText(""+orderItems.get(position).getFlag());
        return convertView;
    }
}
