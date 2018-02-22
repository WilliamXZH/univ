package com.example.bookbundle;

import android.app.Activity;
import android.app.DatePickerDialog;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.View;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.RadioGroup;

public class BookBundleActivity extends Activity
{
    private EditText name, date, receiver;
    private RadioGroup service;
    private int year, month, day;
    private String serviceName;

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        name=(EditText) findViewById(R.id.name);
        date=(EditText) findViewById(R.id.date);
        receiver=(EditText) findViewById(R.id.receiver);
        service=(RadioGroup) findViewById(R.id.service);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu)
    {
        getMenuInflater().inflate(R.menu.book_bundle, menu);
        return true;
    }

    public void chooseDate(View view)
    {
        DatePickerDialog datepd=new DatePickerDialog(this, new DatePickerDialog.OnDateSetListener()
        {
            @Override
            public void onDateSet(DatePicker dp, int year, int month, int day)
            {
                BookBundleActivity.this.year=year;
                BookBundleActivity.this.month=month;
                BookBundleActivity.this.day=day;
                date.setText(year + "-" + (month + 1) + "-" + day);
            }
        }, 2013, 8, 20);
        datepd.setMessage("请选择日期");
        datepd.show();
    }

    public void book(View view)
    {
        for(int i=0; i < service.getChildCount(); i++)
        {
            RadioButton r=(RadioButton) service.getChildAt(i);
            if(r.isChecked())
            {
                serviceName=r.getText().toString();
                break;
            }
        }
        Intent intent=new Intent();
        // intent.setClassName("com.example.bookbundle",
        // "com.example.bookbundle.BookResultActivity");
        // intent.setClassName(BookBundleActivity.this,
        // "com.example.bookbundle.BookResultActivity");
        intent.setClass(BookBundleActivity.this, BookResultActivity.class);
        Bundle bundle=new Bundle();
        bundle.putString("name", name.getText().toString());
        bundle.putString("date", date.getText().toString());
        bundle.putString("receiver", receiver.getText().toString());
        bundle.putString("serviceName", serviceName);
        intent.putExtras(bundle);
        startActivity(intent);
    }

    // 新增:选择技师
    public void chooseReceiver(View view)
    {
        Intent intent=new Intent();
        intent.setClass(BookBundleActivity.this, ReceiverListActivity.class);
        startActivityForResult(intent, 0x111);
    }

    // 新增:回调方法
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data)
    {
        super.onActivityResult(requestCode, resultCode, data);
        if(requestCode == 0x111 && resultCode == 0x111)
        {
            Bundle bundle=data.getExtras();
            receiver.setText(bundle.getString("receiverName"));
        }
    }
}
