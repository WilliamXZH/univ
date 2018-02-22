package com.i4evercai.bannerdemo;

import java.util.ArrayList;
import java.util.List;

import com.i4evercai.bannerdemo.ui.BannerView;
import com.i4evercai.bannerdemo.ui.News;
import com.i4evercai.bannerdemo.ui.acAdapter;

import android.app.Activity;
import android.content.ContentValues;
import android.content.Intent;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends Activity
{
	BannerView bannerView;
	private ListView listview;
	private List<News> newslist=new ArrayList<News>();
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
			
		newslist=newsInit();
		bannerView = (BannerView) findViewById(R.id.bannerview1);
		if (bannerView == null)
			System.out.println("onCreate null");
		TextView newsview = (TextView) findViewById(R.id.newsTextView);
		TextView questionview = (TextView) findViewById(R.id.questionTextView);
		TextView serviceview = (TextView) findViewById(R.id.serviceTextView);
		TextView starview = (TextView) findViewById(R.id.starTextView);
		newsview.setClickable(true);
		listview=(ListView)findViewById(R.id.listview);
		acAdapter adapter = new acAdapter(MainActivity.this, R.layout.item, newslist);
		listview.setAdapter(adapter);
		listview.setOnItemClickListener(new AdapterView.OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int arg2,
					long arg3) {
				// TODO Auto-generated method stub
				//Toast.makeText(MainActivity.this, newslist.get(arg2).getShort_content(), Toast.LENGTH_LONG).show();
		        switch (arg0.getId()){

	            case R.id.listview:
	                Intent intent=new Intent(MainActivity.this,CommentNew.class);
	                startActivity(intent);
	                break;
	        }
			}
		});
		questionview.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {

				Intent intent = new Intent(MainActivity.this, Question.class);
				startActivity(intent);
				// overridePendingTransition(android.R.anim.slide_in_left,android.R.anim.slide_out_right);
				// 左向右
				// overridePendingTransition(android.R.anim.slide_out_right,android.R.anim.slide_in_left);
				// 右向左
				overridePendingTransition(android.R.anim.fade_in,
						android.R.anim.fade_out);
				// Toast.makeText(MainActivity.this,"点击成功2",Toast.LENGTH_SHORT).show();
			}
		});

		serviceview.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				Intent intent = new Intent(MainActivity.this, Service.class);
				// Toast.makeText(MainActivity.this,"点击成功3",Toast.LENGTH_SHORT).show();
				startActivity(intent);
				overridePendingTransition(android.R.anim.fade_in,
						android.R.anim.fade_out);
			}
		});
		starview.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				Intent intent = new Intent(MainActivity.this, Vip.class);
				startActivity(intent);
				overridePendingTransition(android.R.anim.fade_in,
						android.R.anim.fade_out);
				// Toast.makeText(MainActivity.this,"点击成功4",Toast.LENGTH_SHORT).show();
			}
		});
		
	
		
		
	}
	protected List<News> newsInit(){
		List<News> listNews=new ArrayList<News>();
		for(int i=0;i<5;i++){
			News temp=new News();
			temp.setName("title/title of news "+i);
			temp.setShort_content("content/content of news "+i+"");
			listNews.add(temp);
		}
		return listNews;
		
	}
	protected void onResume() {
		super.onResume();
		bannerView.bannerStartPlay();
	}

	@Override
	protected void onPause() {
		super.onPause();
		bannerView.bannerStopPlay();
	}
}
