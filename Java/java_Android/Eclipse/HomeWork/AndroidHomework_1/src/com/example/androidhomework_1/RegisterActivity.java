package com.example.androidhomework_1;

import android.app.DatePickerDialog;
import android.content.ContentValues;
import android.content.DialogInterface;
import android.content.Intent;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.DatePicker;
import android.widget.EditText;
//import android.widget.FrameLayout;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

public class RegisterActivity extends AppCompatActivity{
	
	//private int year,month,day;
	private String sex;
	private TextView date;
	private EditText name,stuid,password,phone,mail,city;
	private RadioGroup sexgroup;
	private Spinner province;
	
	protected void onCreate(Bundle savedInstanceState){
		super.onCreate(savedInstanceState);
		setContentView(R.layout.register_main);
		//setContentView(R.layout.activity_main);
		
		name=(EditText)findViewById(R.id.name_create);
		stuid=(EditText)findViewById(R.id.stuid_create);
		password=(EditText)findViewById(R.id.password_create);
		phone=(EditText)findViewById(R.id.phone_create);
		mail=(EditText)findViewById(R.id.mail_create);
		city=(EditText)findViewById(R.id.city_create);
		
		sexgroup=(RadioGroup)findViewById(R.id.sex_group);
		province=(Spinner)findViewById(R.id.province_select);
		date=(TextView)findViewById(R.id.showtime);
	}	
	
	
	public void register(View v){
		for(int i=0; i < sexgroup.getChildCount(); i++)
        {
            RadioButton r=(RadioButton) sexgroup.getChildAt(i);
            if(r.isChecked())
            {
                sex=r.getText().toString();
                break;
            }
        } 
		Intent intent=new Intent();
        intent.setClass(RegisterActivity.this, ResultActivity.class);
        intent.putExtra("name", name.getText().toString());
        intent.putExtra("stuid", stuid.getText().toString());
        intent.putExtra("sex",sex);
        intent.putExtra("date", date.getText().toString());
        intent.putExtra("password", password.getText().toString());
        intent.putExtra("phone", phone.getText().toString());
        intent.putExtra("mail",mail.getText().toString());
        intent.putExtra("province", province.getSelectedItem().toString());
        intent.putExtra("city", city.getText().toString());
        startActivity(intent);
	}
	
	public void datePicker(View v){
        DatePickerDialog datepd=new DatePickerDialog(this, new DatePickerDialog.OnDateSetListener()
        {
            @Override
            public void onDateSet(DatePicker dp, int year, int month, int day)
            {
//                RegisterActivity.this.year=year;
//                RegisterActivity.this.month=month;
//                RegisterActivity.this.day=day;
                date.setText(year + "-" + (month + 1) + "-" + day);
            }
        }, 2016, 10, 29);
        datepd.setMessage("ÇëÑ¡ÔñÈÕÆÚ");
        datepd.show();
	}
	public void toDB(View v){
		SQLiteDatabase db=this.openOrCreateDatabase("myDataBase.db",MODE_PRIVATE, null);
		db.execSQL("drop table if exists info");
		db.execSQL("create table info(name varchar(20),stuid varchar(20) primary key,sex integer,"
				+ "data varchar(20),password varchar(20),phone varchar(20),"
				+ "mail varchar(20),province integer,city varchar(10))");
		ContentValues values=new ContentValues();
		values.put("name", name.getText().toString());
		values.put("stuid", stuid.getText().toString());
		values.put("sex", sexgroup.getCheckedRadioButtonId()); 
		values.put("date", date.getText().toString());
		values.put("password", password.getText().toString());
		values.put("phone", phone.getText().toString());
		values.put("mail", mail.getText().toString());
		values.put("province", province.getSelectedItemPosition());
		values.put("city",city.getText().toString());
		db.insert("info", null, values);
		
		AlertDialog alert=new AlertDialog.Builder(this).create();
		alert.setTitle("Add Register Infomation To SQLite");
		alert.setMessage("Infomation Added Successful!");
        alert.setButton(DialogInterface.BUTTON_POSITIVE, "Confirm", new DialogInterface.OnClickListener()
        {
            @Override
            public void onClick(DialogInterface dialog, int which)
            {
                Toast.makeText(getApplicationContext(), "Register Information Insert Finished!", Toast.LENGTH_LONG).show();
            }
        });
        alert.setButton(DialogInterface.BUTTON_NEGATIVE, "Cancel", new DialogInterface.OnClickListener()
        {
            @Override
            public void onClick(DialogInterface dialog, int which)
            {
                Toast.makeText(getApplicationContext(), "Sorry, I don't know how to cancel!", Toast.LENGTH_LONG).show();
            }
        });
        alert.show();
		db.close();
	}
	public void readDB(View v){
		Intent intent = new Intent(RegisterActivity.this,ResultActivity.class);;
	 	SQLiteDatabase db=this.openOrCreateDatabase("myDataBase.db",MODE_PRIVATE, null);
		Cursor cur = db.rawQuery("SELECT * FROM info", null);
		if(cur != null){
		    if(cur.moveToFirst()){
/*		        //do{
			    	name.setText(cur.getString(cur.getColumnIndex("name")));
			    	stuid.setText(cur.getString(cur.getColumnIndex("stuid")));
			    	//sex.set.setText(cur.getString(cur.getColumnIndex("name")));
			    	name.setText(cur.getString(cur.getColumnIndex("name")));
			    	date.setText(cur.getString(cur.getColumnIndex("date")));
			    	password.setText(cur.getString(cur.getColumnIndex("password")));
			    	phone.setText(cur.getString(cur.getColumnIndex("phone")));
			    	mail.setText(cur.getString(cur.getColumnIndex("nail")));
			    	//province.setText(cur.getString(cur.getColumnIndex("province")));
			    	city.setText(cur.getString(cur.getColumnIndex("city")));
			    	
		        	
		        //}while(cur.moveToNext());*/		    	
		    	intent.putExtra("name", cur.getString(cur.getColumnIndex("name")));
		    	intent.putExtra("stuid", cur.getString(cur.getColumnIndex("stuid")));
		    	intent.putExtra("sex", cur.getInt(cur.getColumnIndex("sex")));
		    	intent.putExtra("date", cur.getString(cur.getColumnIndex("date")));
		    	intent.putExtra("password", cur.getString(cur.getColumnIndex("password")));
		    	intent.putExtra("phone", cur.getString(cur.getColumnIndex("phone")));
		    	intent.putExtra("mail", cur.getString(cur.getColumnIndex("mail")));
		    	intent.putExtra("province", cur.getInt(cur.getColumnIndex("province")));
		    	intent.putExtra("city", cur.getString(cur.getColumnIndex("city")));
		    }
		}
		cur.close();
		db.close();
		startActivity(intent);
		
		//System.out.println(name.getText().toString());
		//this.register(findViewById(R.id.button_submit));

	}

}

