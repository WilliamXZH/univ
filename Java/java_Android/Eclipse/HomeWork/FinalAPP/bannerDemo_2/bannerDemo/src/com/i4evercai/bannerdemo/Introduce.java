package com.i4evercai.bannerdemo;


import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.TextView;

public class Introduce extends Activity {

	
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_introduce);
		TextView text1=(TextView)findViewById(R.id.showText1);
		TextView text2=(TextView)findViewById(R.id.showText2);
		TextView text3=(TextView)findViewById(R.id.showText3);
		TextView text4=(TextView)findViewById(R.id.showText4);
		Intent intent=getIntent();
		String str=intent.getStringExtra("jump");
		if(str.equals("Annual"))
		{
			text1.setText("我是年报跳转过来的");
			text2.setText("2:");
			text3.setText("3:");
			text4.setText("4:");
		}
		else if(str.equals("license"))
		{
			text1.setText("我是执照跳转过来的");
			text2.setText("2:");
			text3.setText("3:");
			text4.setText("4:");
		}
		else
		{
			text1.setText("我是税跳转过来的");
			text2.setText("2:");
			text3.setText("3:");
			text4.setText("4:");
		}
		
	}

	
}
