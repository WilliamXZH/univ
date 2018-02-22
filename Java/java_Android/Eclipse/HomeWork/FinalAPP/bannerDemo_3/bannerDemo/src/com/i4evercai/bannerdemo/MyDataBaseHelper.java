package com.i4evercai.bannerdemo;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteDatabase.CursorFactory;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;
import android.widget.Toast;

public class MyDataBaseHelper extends SQLiteOpenHelper{
	public static final String CREAT_USER="create table user("
			+"id integer primary key autoincrement,"
			+"userName text,"
			+"service text,"
			+"freetime text"
			+")";
	private Context mycontext;
	public MyDataBaseHelper(Context context, String name,
			CursorFactory factory, int version) {
		super(context, name, factory, version);
		mycontext=context;
		// TODO 自动生成的构造函数存根
	}
	public void onUpgrade(SQLiteDatabase db,int oldVersion,int newVersion)
	{//这两个方法都是必须重写的
		
	}
	@Override
	public void onCreate(SQLiteDatabase db) {
		// TODO 自动生成的方法存根
		db.execSQL(CREAT_USER);
		//Toast.makeText(mycontext, "已存入数据库", Toast.LENGTH_LONG).show();
	}
}
