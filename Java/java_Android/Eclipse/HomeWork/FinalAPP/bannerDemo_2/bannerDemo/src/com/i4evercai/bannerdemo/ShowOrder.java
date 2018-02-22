package com.i4evercai.bannerdemo;

import android.content.Context;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.ListView;

import java.util.LinkedList;
import java.util.List;

import com.i4evercai.bannerdemo.ui.OrderlistAdapter;

public class ShowOrder extends AppCompatActivity {
    private List<OrderItem> orderItems=null;
    private OrderlistAdapter orderlistAdapter = null;
    private Context context;
    private ListView orderlistView;
    private Myapplication app;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_showorder);
        int i;
        orderItems=new LinkedList<OrderItem>();
        app=(Myapplication) getApplication();
        Intent intent=getIntent();
        String str=intent.getStringExtra("judge");
        orderlistView=(ListView)findViewById(R.id.myOrderlist);
        context=ShowOrder.this;
        orderlistAdapter=new OrderlistAdapter((LinkedList<OrderItem>) orderItems,context);
        orderlistView.setAdapter(orderlistAdapter);
        orderItems.clear();

        OrderItem tempItme=new OrderItem();
        tempItme.setCost(5000);
        tempItme.setCompany("zxsdfkjds");
        tempItme.setServiceType("kzdjsfgj");
        tempItme.setFlag(3);
        app.getOrderList().add(tempItme);

        for(i=0;i<app.getOrderList().size();i++)
        {
            if(Integer.parseInt(str)==6)
            {
                orderItems.add(app.getOrderList().get(i));
                continue;
            }
            if(app.getOrderList().get(i).getFlag()== Integer.parseInt(str))
            {
                orderItems.add(app.getOrderList().get(i));
            }
        }
        orderlistAdapter.notifyDataSetChanged();
    }



}
