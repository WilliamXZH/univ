package liZhiDataBase;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class LiZhiDBHelper extends SQLiteOpenHelper {
	private final static int VERSION=2;

	public LiZhiDBHelper(Context context) {
		super(context, "LiZhiNew.db", null, VERSION);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		String sql="create table jsonData(_id Integer primary key autoincrement,type integer,data text)";
		db.execSQL(sql);
		String sql2="create table topJson(_id Integer primary key autoincrement,type integer,data text)";
		db.execSQL(sql2);
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
		String deleteSql1="drop table jsonData";
		db.execSQL(deleteSql1);
		String deleteSql2="drop table topJson";
		db.execSQL(deleteSql2);
		String sql="create table jsonData(_id Integer primary key autoincrement,type integer,data text)";
		db.execSQL(sql);
		String sql2="create table topJson(_id Integer primary key autoincrement,type integer,data text)";
		db.execSQL(sql2);
	}
}
