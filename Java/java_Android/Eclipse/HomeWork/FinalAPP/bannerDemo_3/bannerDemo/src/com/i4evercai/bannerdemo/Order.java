package com.i4evercai.bannerdemo;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import com.i4evercai.bannerdemo.Order.AddOrder;

import android.app.Activity;
import android.content.ContentValues;
import android.content.Intent;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

public class Order extends Activity {
	private MyDataBaseHelper dbHelper;
	private Myapplication app;
	
	String type="";
	int cost;
	String company="";
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_order);
		
		app=(Myapplication) getApplication();
		
		Intent intent=getIntent();
		ArrayList<String> stringlist=intent.getStringArrayListExtra("orderstr");
		TextView serviceType=(TextView)findViewById(R.id.showtype);
		
		for(int i=0;i<stringlist.size();i++)
		{
			type+=stringlist.get(i)+" ";
		}
		serviceType.setText(type);
		
		
		
		
		TextView goodNum=(TextView)findViewById(R.id.goodNum);
		TextView charge=(TextView)findViewById(R.id.charge);
		goodNum.setText("共"+stringlist.size()+"件商品");
		
		cost=stringlist.size()*500;
		charge.setText("合计："+cost+"元");
		TextView sum=(TextView)findViewById(R.id.Sum);
		sum.setText("合计："+stringlist.size()*500+"元");
		TextView freeTime=(TextView)findViewById(R.id.freeTime);
		freeTime.setText("您还有"+app.getTimes()+"次免费次数");
	
		
		LinearLayout free=(LinearLayout)findViewById(R.id.free);
		free.setOnClickListener(new LinearLayout.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO 自动生成的方法存根
							
			
				if(app.getTimes()<=0)
				{	
					Toast.makeText(Order.this,"对不起，您的免费次数已经用完了！",Toast.LENGTH_SHORT).show();
				}
				else
				{
					TextView freeTime=(TextView)findViewById(R.id.freeTime);
					freeTime.setText("您还有"+(app.getTimes()-1)+"次免费次数");
					app.setTimes(app.getTimes()-1);
					TextView charge=(TextView)findViewById(R.id.charge);
					charge.setText("合计：0元");
					TextView sum=(TextView)findViewById(R.id.Sum);
					sum.setText("合计：0元");
					EditText companyName=(EditText)findViewById(R.id.companyName);
					String name=companyName.getText().toString();
				}
				
			
			}
		});
		
		
		TextView submit=(TextView)findViewById(R.id.submit);
		
		
		submit.setOnClickListener(new TextView.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				EditText name=(EditText) findViewById(R.id.companyName);
				company=name.getText().toString();
				
				if(company.equals(""))
				{
					Toast.makeText(Order.this,"您还没有填入您的公司的名称！",Toast.LENGTH_SHORT).show();
				}
				else
				{
					
					//其他两个变量不需要点击就已经赋值了
					OrderItem tempItem=new OrderItem();
					tempItem.setCost(cost);
					tempItem.setCompany(company);
					tempItem.setServiceType(type);
					tempItem.setFlag(2);
					tempItem.setUser(app.getUser());
					
					new AddOrder(tempItem.toString()).start();
					app.getOrderList().add(tempItem);
					
					Intent intent=new Intent(Order.this,Vip.class);
					startActivity(intent);
				}	
				
				
				
				// TODO 自动生成的方法存根
				
			}
		});
		
	}
	class AddOrder extends Thread{
		String str;
		AddOrder(String tmp){
			this.str=tmp;
		}
		public void run(){
			//s=Client.getSocket();
			try {
				PrintStream writer=Client.getWriter();
				BufferedReader reader=Client.getReader();	
				writer.println("addorderitem#"+str);
				reader.readLine();
				
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}		
	}

	
}
