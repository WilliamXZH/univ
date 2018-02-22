package com.example.androidhomework_1;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
//import android.util.TypedValue;
import android.view.Gravity;
import android.view.ViewGroup;
import android.view.ViewGroup.LayoutParams;
import android.widget.FrameLayout;
import android.widget.TextView;

public class ResultActivity extends AppCompatActivity{
	protected void onCreate(Bundle savedInstanceState){
		super.onCreate(savedInstanceState);
		FrameLayout frameLayout=new FrameLayout(this);
		//setContentView(R.layout.result_main);
		setContentView(frameLayout);
		
		Intent intent =getIntent();
        String info="姓名:" + intent.getStringExtra("name") + "\n";
        info+="学号:"+intent.getStringExtra("stuid")+"\n";
        info+="性别:"+intent.getStringExtra("sex")+"\n";
        info+="生日:"+intent.getStringExtra("date")+"\n";
        info+="手机:"+intent.getStringExtra("phone")+"\n";
        info+="邮箱:"+intent.getStringExtra("mail")+"\n";
        info+="地址:"+intent.getStringExtra("province")+intent.getStringExtra("city")+"\n";
        
        //TextView result=(TextView)findViewById(R.id.register_result);
		TextView result=new TextView(this);
		result.setText(info);
		//result.setTextSize(TypedValue.COMPLEX_UNIT_PX,20);
		frameLayout.addView(result);
		
		System.out.println(info);
		
		LayoutParams params=new LayoutParams(
			ViewGroup.LayoutParams.WRAP_CONTENT,
			ViewGroup.LayoutParams.WRAP_CONTENT
		);
		params.height=Gravity.CENTER_HORIZONTAL;
	}
}
