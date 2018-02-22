package com.example.sqlite;

import java.util.ArrayList;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

public class DBHelper
{
	private static final String DATABASE_NAME = "mydb";
	private static final int DATABASE_VERSION = 1;
	private static final String TABLE_NAME = "vendor";
	private static final String[] COLUMNS =
	{ "id", "vendor", "address", "tel" };
	private String sql = "";

	private DBOpenHelper helper;
	private SQLiteDatabase db;

	public DBHelper(Context context)
	{
		sql = "create table " + TABLE_NAME + " (" + COLUMNS[0] + " integer primary key autoincrement, " + COLUMNS[1]
				+ " varchar(50)," + COLUMNS[2] + " varchar(50)," + COLUMNS[3] + " varchar(20));";
		helper = new DBOpenHelper(context, DATABASE_NAME, DATABASE_VERSION, TABLE_NAME, sql);
		db = helper.getWritableDatabase();
	}

	public void insert(Vendor data)
	{
		ContentValues values = new ContentValues();
		values.put(COLUMNS[1], data.getVendorName());
		values.put(COLUMNS[2], data.getAddress());
		values.put(COLUMNS[3], data.getTel());
		db.insert(TABLE_NAME, null, values);
	}

	public ArrayList<Vendor> find()
	{
		ArrayList<Vendor> list = new ArrayList<Vendor>();
		Vendor vendor = null;
		Cursor cursor = db.query(TABLE_NAME, COLUMNS, null, null, null, null, null);
		while (cursor.moveToNext())
		{
			vendor = new Vendor();
			vendor.setId(cursor.getInt(0));
			vendor.setVendorName(cursor.getString(1));
			vendor.setAddress(cursor.getString(2));
			vendor.setTel(cursor.getString(3));
			list.add(vendor);
		}
		cursor.close();
		return list;
	}
}
