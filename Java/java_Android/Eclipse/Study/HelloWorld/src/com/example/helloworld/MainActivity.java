package com.example.helloworld;

import android.support.v7.app.ActionBarActivity;
import android.util.TypedValue;
import android.graphics.Color;
import android.os.Bundle;
import android.view.Gravity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.ViewGroup;
import android.view.ViewGroup.LayoutParams;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

@SuppressWarnings("deprecation")
public class MainActivity extends ActionBarActivity {
	
	private int ImgNum=5;//OOM
	private ImageView []img=new ImageView[ImgNum];
	private int[] imagePath=new int[ImgNum];
//	{
//			R.drawable.back_0,R.drawable.back_1,R.drawable.back_2,R.drawable.back_3
//			,R.drawable.back_4,R.drawable.back_5,R.drawable.back_6,R.drawable.back_7,
//			//R.drawable.back_8,R.drawable.back_9
//	};
	private void CreateImagePath(){
		int base=R.drawable.back_0;//0x7f020046;
		for(int i=0;i<ImgNum;i++){
			imagePath[i]=base+i;
		}
	}
	
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		
		//FrameLayout frameLayout=new FrameLayout(this);
		//setContentView(frameLayout);
		
		//frameLayout.setBackgroundDrawable(this.getResources(),R.drawable.);
		
		CreateImagePath();
		LinearLayout layout=(LinearLayout)findViewById(R.id.layout);
		for(int i=0;i<imagePath.length;i++){
			img[i]=new ImageView(this);
			img[i].setImageResource(imagePath[i]);
			img[i].setPadding(4,4,4,4);
			LayoutParams params=new LayoutParams(200,120);
			img[i].setLayoutParams(params);
			layout.addView(img[i]);
		}
		
		
		
		
		
		
//		frameLayout.setBackgroundDrawable(this.getResources().getDrawable(R.drawable.abc_cab_background_internal_bg));

//		
//		TextView text1=new TextView(this);
//		text1.setText("在Java代码中控制UI界面");
//		text1.setTextSize(TypedValue.COMPLEX_UNIT_PX,20);
//		text1.setTextColor(Color.rgb(1,1,1));
//		frameLayout.addView(text1);
//		
//		TextView text2=new TextView(this);
//		text2.setText("单击进入游戏");
//		text2.setTextSize(TypedValue.COMPLEX_UNIT_PX,20);
//		text2.setTextColor(Color.rgb(1,1,1));
//		LayoutParams params=new LayoutParams(
//				ViewGroup.LayoutParams.WRAP_CONTENT,
//				ViewGroup.LayoutParams.WRAP_CONTENT
//				);
//		params.height=Gravity.CENTER_HORIZONTAL;//Gravity.CENTER_VERTICAL;
//		text2.setLayoutParams(params);
//		frameLayout.addView(text2);
		
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		// Handle action bar item clicks here. The action bar will
		// automatically handle clicks on the Home/Up button, so long
		// as you specify a parent activity in AndroidManifest.xml.
		int id = item.getItemId();
		if (id == R.id.action_settings) {
			return true;
		}
		return super.onOptionsItemSelected(item);
	}
}
