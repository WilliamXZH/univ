//package com.example.switchfragment;
//
//
//import android.os.Bundle;
//import android.support.v4.app.FragmentActivity;
//import android.support.v4.app.FragmentTransaction;
//import android.view.View;
//import android.view.View.OnClickListener;
//import android.widget.Button;
//
//public class CopyOfMainActivity extends FragmentActivity implements OnClickListener{
//
//	Button buttonOne;
//	Button buttonTwo;
//	Button buttonThree;
//	Button buttonFour;
//	
//	@Override
//	protected void onCreate(Bundle savedInstanceState) {
//		super.onCreate(savedInstanceState);
//		setContentView(R.layout.activity_main);
//		buttonOne=(Button)findViewById(R.id.btn_one);
//		buttonTwo=(Button)findViewById(R.id.btn_two);
//		buttonThree=(Button)findViewById(R.id.btn_three);
//		buttonFour=(Button)findViewById(R.id.btn_four);
//		
//		buttonOne.setOnClickListener(this);
//		buttonTwo.setOnClickListener(this);
//		buttonThree.setOnClickListener(this);
//		buttonFour.setOnClickListener(this);
//		
//		
//		if (savedInstanceState==null)
//		{
//			FragmentTransaction fragmentTransaction=getSupportFragmentManager().beginTransaction();
//			OneFragment oneFragment=new OneFragment();
//			fragmentTransaction.add(R.id.fragment_content_view,oneFragment);
//			fragmentTransaction.commit();
//		}
//	}
//
//	@Override
//	public void onClick(View v)
//	{
//		FragmentTransaction fragmentTransaction=getSupportFragmentManager().beginTransaction();
//		switch (v.getId())
//		{
//		case R.id.btn_one:
//			OneFragment oneFragment=new OneFragment();
//			fragmentTransaction.replace(R.id.fragment_content_view,oneFragment);
//			fragmentTransaction.commit();
//			break;
//		case R.id.btn_two:
//			TwoFragment twoFragment=new TwoFragment();
//			fragmentTransaction.replace(R.id.fragment_content_view,twoFragment);
//			fragmentTransaction.commit();
//			break;
//		case R.id.btn_three:
//			ThreeFragment threeFragment=new ThreeFragment();
//			fragmentTransaction.replace(R.id.fragment_content_view,threeFragment);
//			fragmentTransaction.commit();
//			break;
//		case R.id.btn_four:
//			FourFragment fourFragment=new FourFragment();
//			fragmentTransaction.replace(R.id.fragment_content_view,fourFragment);
//			fragmentTransaction.commit();
//			break;
//		default:
//			break;
//		}
//		
//	}
//
//}
