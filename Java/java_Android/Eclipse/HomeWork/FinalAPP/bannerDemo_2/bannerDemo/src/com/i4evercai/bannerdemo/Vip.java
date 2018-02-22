package com.i4evercai.bannerdemo;


import android.app.Activity;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.graphics.Color;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintStream;
import java.io.UnsupportedEncodingException;
import java.util.LinkedList;
import java.util.List;

import com.i4evercai.bannerdemo.Vip.getState;

public class Vip extends Activity {
	//private MyDataBaseHelper dbHelper;
	private Myapplication app;

	Handler handler;
	private int state[]=new int[5];

    BadgeView bv[]=new BadgeView[5];


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_vip);
		TextView newsview=(TextView)findViewById(R.id.newsTextView);
		TextView questionview=(TextView)findViewById(R.id.questionTextView);
		TextView serviceview=(TextView)findViewById(R.id.serviceTextView);
		TextView starview=(TextView)findViewById(R.id.starTextView);
		TextView lefTime=(TextView)findViewById(R.id.leftTime);

		app=(Myapplication) getApplication();




		lefTime.setText("您还剩余"+app.getTimes()+"次免费服务");

		newsview.setOnClickListener(new OnClickListener(){
			public void onClick(View v)
			{
				Intent intent=new Intent(Vip.this,MainActivity.class);
				startActivity(intent);
				overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out);
				
				//Toast.makeText(MainActivity.this,"点击成功2",Toast.LENGTH_SHORT).show();
			}
		});
		
		questionview.setOnClickListener(new OnClickListener(){
			public void onClick(View v)
			{
				Intent intent=new Intent(Vip.this,Question.class);
				//Toast.makeText(MainActivity.this,"点击成功3",Toast.LENGTH_SHORT).show();
				startActivity(intent);
				overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out);
			}
		});	
		serviceview.setOnClickListener(new OnClickListener(){
			public void onClick(View v)
			{
				Intent intent=new Intent(Vip.this,Service.class);
				startActivity(intent);
				overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out);
				//Toast.makeText(MainActivity.this,"点击成功4",Toast.LENGTH_SHORT).show();
			}
		});
		
		LinearLayout applyfor=(LinearLayout)findViewById(R.id.apply);
		applyfor.setOnClickListener(new LinearLayout.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				Log.i("click", "on create order");
				Intent intent=new Intent(Vip.this,Order.class);
				startActivity(intent);
				
				// TODO 自动生成的方法存根
				
			}
		});
		

		ImageView img1=(ImageView)findViewById(R.id.picture1);
		ImageView img2=(ImageView)findViewById(R.id.picture2);
		ImageView img3=(ImageView)findViewById(R.id.picture3);
		ImageView img4=(ImageView)findViewById(R.id.picture4);
		ImageView img5=(ImageView)findViewById(R.id.picture5);
		
		


		bv[0]=new BadgeView(this,(ImageView)findViewById(R.id.picture1));
		bv[1]=new BadgeView(this,(ImageView)findViewById(R.id.picture2));
		bv[2]=new BadgeView(this,(ImageView)findViewById(R.id.picture3));
		bv[3]=new BadgeView(this,(ImageView)findViewById(R.id.picture4));
		bv[4]=new BadgeView(this,(ImageView)findViewById(R.id.picture5));
		app.getOrderList();//判断订单此时的状态
		
		img1.setEnabled(false);//初始化为都不可点击
		img2.setEnabled(false);
		img3.setEnabled(false);
		img4.setEnabled(false);
		img5.setEnabled(false);
		for(int i=0;i<app.getOrderList().size();i++)
		{//判断订单状态
			if(app.getOrderList().get(i).getFlag()==1)
			{
				img1.setEnabled(true);
			}
			if(app.getOrderList().get(i).getFlag()==2)
			{
				img2.setEnabled(true);
			}
			if(app.getOrderList().get(i).getFlag()==3)
			{
				img3.setEnabled(true);
			}
			if(app.getOrderList().get(i).getFlag()==4)
			{
				img4.setEnabled(true);
			}
			if(app.getOrderList().get(i).getFlag()==5)
			{
				img5.setEnabled(true);
			}
		}
		img1.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {

				// TODO 自动生成的方法存根
				Toast.makeText(Vip.this,"有订单未支付",Toast.LENGTH_SHORT).show();
				Intent intent=new Intent(Vip.this,ShowOrder.class);
				intent.putExtra("judge","1");
				startActivity(intent);
				
			}
		});
		img2.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO 自动生成的方法存根
				Toast.makeText(Vip.this,"有订单未处理",Toast.LENGTH_SHORT).show();
				Intent intent=new Intent(Vip.this,ShowOrder.class);
				intent.putExtra("judge","2");
				startActivity(intent);
				
			}
		});
		img3.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO 自动生成的方法存根
				Toast.makeText(Vip.this,"有订单已处理",Toast.LENGTH_SHORT).show();
				Intent intent=new Intent(Vip.this,ShowOrder.class);
				intent.putExtra("judge","3");
				startActivity(intent);
				
			}
		});
		img4.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO 自动生成的方法存根
				Toast.makeText(Vip.this,"有订单待评价",Toast.LENGTH_SHORT).show();
				Intent intent=new Intent(Vip.this,ShowOrder.class);
				intent.putExtra("judge",4);
				startActivity(intent);
				
			}
		});
		img5.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO 自动生成的方法存根
				Toast.makeText(Vip.this,"有退款订单",Toast.LENGTH_SHORT).show();
				Intent intent=new Intent(Vip.this,ShowOrder.class);
				intent.putExtra("judge","5");
				startActivity(intent);
				
			}
		});
		
		
		//展示我的订单*/
		LinearLayout myOrder=(LinearLayout)findViewById(R.id.myOrder);
		myOrder.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO 自动生成的方法存根
				//跳转到展示所有订单状态的页面

				Intent intent=new Intent(Vip.this,ShowOrder.class);
				intent.putExtra("judge","6");
				startActivity(intent);
			}
		});

		
		handler=new Handler(){
			public void handleMessage(Message msg){
				super.handleMessage(msg);
				String states=msg.getData().getString("state");
				
				for(int i=0;i<5;i++){
					state[i]=Integer.parseInt(states.split("#")[1].split("_")[i]);
				}
				badgeAll();
			}
		};
		
		new getState().start();
		
	}

	public void badgeAll(){
		for(int i=0;i<5;i++)
			badge(bv[i],state[i]);
	}
	public void badge(BadgeView bv,int num){
		if(num!=0){		
		    bv.setText(""+num);  	      
		    bv.setTextColor(Color.YELLOW);  	      
		    bv.setTextSize(15);
		    bv.setBadgePosition(BadgeView.POSITION_TOP_RIGHT); //默认值  	      
		    bv.show();
		}else{			
	    	bv.setText(null);
	    	bv.hide();
		}
	}
	class getState extends Thread{
		public void run(){
			try {
				PrintStream writer=Client.getWriter();
				BufferedReader reader=Client.getReader();	
				writer.println("getstate#"+app.getUser());
				String states=reader.readLine();
				
				if(states!=null){
					Bundle b=new Bundle();
					b.putString("state", states);
					Message msg=Message.obtain();
					msg.setData(b);
					handler.sendMessage(msg);
				}
				
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}		
	}

	
}
