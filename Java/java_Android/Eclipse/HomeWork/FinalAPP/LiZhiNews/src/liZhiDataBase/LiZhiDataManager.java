package liZhiDataBase;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

public class LiZhiDataManager {
	private LiZhiDBHelper helper;
	public LiZhiDataManager(Context context){
		helper=new LiZhiDBHelper(context);
	}
	public void insert(String json,int type){
		SQLiteDatabase db=helper.getWritableDatabase();
		//先删除记录
		db.delete("jsonData", "type=?", new String[]{type+""});
		//插入数据
		ContentValues values=new ContentValues();
		values.put("type", type);
		values.put("data", json);
		db.insert("jsonData", null, values);
		//关闭数据库
		db.close();
	}
	public String getJson(int type){
		String result="";
		SQLiteDatabase db=helper.getReadableDatabase();
		Cursor cursor=db.query("jsonData", null, "type=?", new String[]{type+""}, null, null, null);
		//cursor初始位置是-1,不是0;
		if(cursor.getCount()>0){
			cursor.moveToNext();
			result=cursor.getString(cursor.getColumnIndex("data"));
		}
		return result;
	}
	public void insertTop(String json,int type){
		SQLiteDatabase db=helper.getWritableDatabase();
		//先删除记录
		db.delete("topJson", "type=?", new String[]{type+""});
		//插入数据
		ContentValues values=new ContentValues();
		values.put("type", type);
		values.put("data", json);
		db.insert("topJson", null, values);
		//关闭数据库
		db.close();
	}
	public String getJsonTop(int type){
		String result="";
		SQLiteDatabase db=helper.getReadableDatabase();
		Cursor cursor=db.query("topJson", null, "type=?", new String[]{type+""}, null, null, null);
		//cursor初始位置是-1,不是0;
		if(cursor.getCount()>0){
			cursor.moveToNext();
			result=cursor.getString(cursor.getColumnIndex("data"));
		}
		return result;
	}
}
