package com.example.androidhomework_1;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.view.View;

public class MainScreenButtonActivity extends AppCompatActivity {
	public View.OnClickListener RegisterListener=new View.OnClickListener() {
		
		@Override
		public void onClick(View v) {
			// TODO Auto-generated method stub
			if(v.getId()==R.id.button_register){
					
				setContentView(R.layout.register_main);
				Intent intent=new Intent();
				//intent.setClass(MainActivity.this,RegisterActivity.class);
				startActivity(intent);
			}
		}
	};
}
