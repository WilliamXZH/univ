package com.example.internalstorage;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Environment;
import android.view.Menu;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

public class MainActivity extends Activity
{

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

	// 保存用户名、密码到内部文件，打开新页面
	public void myclick(View view)
	{
		EditText userET = (EditText) findViewById(R.id.userName);
		EditText passET = (EditText) findViewById(R.id.userPass);
		FileOutputStream fos = null;
		try
		{
			fos = openFileOutput("mySaveFile", MODE_PRIVATE);
			fos.write((userET.getText().toString() + " " + passET.getText().toString()).getBytes());
			fos.flush();
			fos.close();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		Intent intent = new Intent();
		intent.setClass(getApplicationContext(), Result.class);
		startActivity(intent);
	}

	// 赋值图片
	public void picClick(View view)
	{
		File destFile = new File(Environment.getExternalStorageDirectory(), "pic.png");
		InputStream fis = null;
		try
		{
			fis = this.getResources().openRawResource(R.drawable.ic_launcher);
			FileOutputStream fos = new FileOutputStream(destFile);
			byte[] b = new byte[fis.available()];
			fis.read(b);
			fos.write(b);
			fos.close();
			Toast.makeText(MainActivity.this, "赋值图片完成!", Toast.LENGTH_LONG).show();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
}
