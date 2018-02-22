package com.example.androidhomework_1;

//import android.support.v7.app.ActionBarActivity;
import android.support.v7.app.AppCompatActivity;
import android.app.ActivityManager;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;

public class MainActivity extends AppCompatActivity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		
		//MainScreenButtonActivity MSBA=new MainScreenButtonActivity();
		
		Button RegisterButton=(Button)findViewById(R.id.button_register);
		//RegisterButton.setOnClickListener(MSBA.RegisterListener);
		RegisterButton.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				//if(v.getId()==R.id.button_register){
					Intent intent=new Intent(MainActivity.this,RegisterActivity.class);
					
					//Intent intent=new Intent(MainActivity.this,ResultActivity.class);
					
					//intent.setClass(MainActivity.this,RegisterActivity.class);
					startActivity(intent);
					//setContentView(R.layout.register_main);
				//}
			}
		});
		
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
	
	public void exit(View v){
		System.exit(0);
		//android.os.Process.killProcess(android.os.Process.myPid());
		ActivityManager am= (ActivityManager) this
				.getSystemService(Context.ACTIVITY_SERVICE);
		am.killBackgroundProcesses(this.getPackageName());
		
		
		
//		Intent intent = new Intent(); 
//		intent.setAction(GlobalVarable.EXIT_ACTION); // 退出动作 
//		this.sendBroadcast(intent);// 发送广播 
//		super.finish(); //退出后台线程,以及销毁静态变量
//		System.exit(0);
	}
}
