package myActivitys;

import cn.jpush.android.api.JPushInterface;
import android.app.ActionBar;
import android.app.Activity;
import android.os.Bundle;

public class BaseActivity extends Activity {
	@Override
	protected void onPause() {
		super.onPause();
		JPushInterface.onPause(this);
	}
	@Override
	protected void onResume() {
		super.onResume();
		JPushInterface.onResume(this);
	}
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		ActionBar actionBar=getActionBar();
		actionBar.hide();
	}
}
