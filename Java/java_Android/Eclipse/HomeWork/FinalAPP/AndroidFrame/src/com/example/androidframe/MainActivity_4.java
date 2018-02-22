package com.example.androidframe;

import android.support.v7.app.AppCompatActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;

public class MainActivity_4 extends AppCompatActivity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.four);
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
	
	
	public void jump(View v){
		Intent intent = null;
		if(v.getId()==R.id.button_first){
			intent.setClass(MainActivity_4.this, MainActivity.class);
		}else if(v.getId()==R.id.button_second){
			intent.setClass(MainActivity_4.this, MainActivity_2.class);
			
		}else if(v.getId()==R.id.button_third){
			intent.setClass(MainActivity_4.this, MainActivity_3.class);
			
		}else if(v.getId()==R.id.button_fourth){
			intent.setClass(MainActivity_4.this, MainActivity_3.class);
			
		}
		startActivity(intent);
	}
}
