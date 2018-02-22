package myActivitys;

import com.lizhinews.R;

import android.content.Intent;
import android.os.Bundle;

public class LoginActivity extends BaseActivity {
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.loginactivitylayout);
		new Thread(new Runnable() {
			
			@Override
			public void run() {
				try {
					Thread.sleep(2000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				Intent intent=new Intent("action.show");
				startActivity(intent);
				finish();
			}
		}).start();
		
	}
	@Override
	protected void onResume() {
		super.onResume();
	}
}
