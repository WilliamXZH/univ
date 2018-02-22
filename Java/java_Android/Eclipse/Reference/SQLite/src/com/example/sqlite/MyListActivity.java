package com.example.sqlite;

import java.util.ArrayList;

import android.app.Activity;
import android.os.Bundle;
import android.view.Menu;
import android.widget.ArrayAdapter;
import android.widget.ListView;

public class MyListActivity extends Activity
{
	@Override
	protected void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.mylist);

		DBHelper helper = new DBHelper(MyListActivity.this);
		ArrayList<Vendor> list = helper.find();
		ArrayList<String> al = new ArrayList<String>();
		for (Vendor info : list)
		{
			System.out.println(info.getVendorName());
			al.add(info.getVendorName());
		}

		ListView lv = (ListView) findViewById(R.id.mylist);
		ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, R.layout.listmod, al);
		lv.setAdapter(adapter);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu)
	{
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

}
