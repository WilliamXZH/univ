package com.example.internalstorage;

import java.io.FileInputStream;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;

public class Result extends Activity
{

	@Override
	protected void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.result);

		try
		{
			FileInputStream fin = this.openFileInput("mySaveFile");
			byte[] buffer = new byte[fin.available()];
			fin.read(buffer);
			String result = new String(buffer);
			TextView userName = (TextView) findViewById(R.id.userNameTV);
			TextView userPass = (TextView) findViewById(R.id.userPassTV);
			userName.setText(result.split(" ")[0]);
			userPass.setText(result.split(" ")[1]);
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
}
