package com.example.noname;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.example.noname.bean.WelTitle;
import com.example.noname.utils.HttpUtils;
import com.example.noname.utils.QLApi;
import com.example.noname.utils.HttpUtils.OnNetWorkResponse;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Parcelable;
import android.view.KeyEvent;
import android.view.animation.Animation;
import android.view.animation.Animation.AnimationListener;
import android.view.animation.AnimationUtils;
import android.widget.ImageView;

/**
 * 欢迎界面
 * 
 * @author
 * 
 */
public class WelcomeActivity extends Activity implements AnimationListener {
	private ImageView imageView = null;
	private Animation alphaAnimation = null;
	/**
	 * Tab标题
	 */
	private List<WelTitle> list;

	@Override
	protected void onCreate(Bundle savedInstanceState) {

		super.onCreate(savedInstanceState);
		setContentView(R.layout.welcome);
//		initTitle();
		imageView = (ImageView) findViewById(R.id.welcome_image_view);
		alphaAnimation = AnimationUtils.loadAnimation(this,
				R.anim.welcome_alpha);
		alphaAnimation.setFillEnabled(true); // 启动Fill保持
		alphaAnimation.setFillAfter(true); // 设置动画的最后一帧是保持在View上面
		imageView.setAnimation(alphaAnimation);
		alphaAnimation.setAnimationListener(this); // 为动画设置监听
	}

	@Override
	public void onAnimationStart(Animation animation) {

	}

	@Override
	public void onAnimationEnd(Animation animation) {
		// 动画结束时结束欢迎界面并转到软件的主界面
//		intent.putExtra("list", (Serializable)list);
//		System.out.println("list1"+list);
		Intent intent = new Intent().setClass(WelcomeActivity.this, MainActivity.class);
		startActivity(intent);
	}

	@Override
	public void onAnimationRepeat(Animation animation) {

	}

	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {
		// 在欢迎界面屏蔽BACK键
		if (keyCode == KeyEvent.KEYCODE_BACK) {
			return false;
		}
		return false;
	}

	/**
	 * 初始化标题栏
	 */
	private void initTitle() {
		HttpUtils.RequestNetWork(QLApi.TITLE_URL, new OnNetWorkResponse() {
			@Override
			public void ok(String response) {
				try {
					JSONObject o1 = new JSONObject(response);
					String status = o1.getString("status");
					if (status.equals("ok")) {
						String paramz = o1.getString("paramz");
//						System.out.println("paramz"+paramz);
						JSONObject o2 = new JSONObject(paramz);
						String columns = o2.getString("columns");
//						System.out.println("columns"+columns);
						list = new ArrayList<WelTitle>();
						System.out.println(list);
						JSONArray j1 = new JSONArray(columns);
						for (int i = 0; i < j1.length(); i++) {
							JSONObject o3 = j1.getJSONObject(i);
							WelTitle welTitle = new WelTitle();
							welTitle.setName(o3.getString("name"));
							list.add(welTitle);
						}
					}
				} catch (JSONException e) {
					e.printStackTrace();
				}

			}

			@Override
			public void error(String error) {

			}
		});

	}
}
