package com.example.sqlite;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.View;
import android.widget.Toast;

public class MainActivity extends Activity
{
	private static int NUM = 1;

	@Override
	protected void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu)
	{
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

	public void saveClick(View view)
	{
		Vendor info = null;
		DBHelper helper = new DBHelper(MainActivity.this);
		for (int i = NUM; i < NUM + 10; i++)
		{
			info = new Vendor();
			info.setVendorName("name" + i);
			info.setAddress("addr" + i);
			info.setTel("130" + i);
			helper.insert(info);
		}
		NUM += 10;
		Toast.makeText(getApplicationContext(), "保存十条数据到SQLite中", Toast.LENGTH_SHORT).show();
	}

	public void findClick(View view)
	{
		Intent intent = new Intent();
		intent.setClass(MainActivity.this, MyListActivity.class);
		startActivity(intent);
	}
}
