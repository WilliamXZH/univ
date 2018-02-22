package com.example.book;

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

public class BookActivity extends Activity
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
        getMenuInflater().inflate(R.menu.book, menu);
        return true;
    }

    public void chooseDate(View view)
    {
        DatePickerDialog datepd=new DatePickerDialog(this, new DatePickerDialog.OnDateSetListener()
        {
            @Override
            public void onDateSet(DatePicker dp, int year, int month, int day)
            {
                BookActivity.this.year=year;
                BookActivity.this.month=month;
                BookActivity.this.day=day;
                date.setText(year + "-" + (month + 1) + "-" + day);
            }
        }, 2013, 8, 20);
        datepd.setMessage("«Î—°‘Ò»’∆⁄");
        datepd.show();
    }

    public void chooseReceiver(View view)
    {

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
        // intent.setClassName("com.example.book", "com.example.book.BookResultActivity");
        // intent.setClassName(BookActivity.this, "com.example.book.BookResultActivity");
        intent.setClass(BookActivity.this, BookResultActivity.class);
        intent.putExtra("name", name.getText().toString());
        intent.putExtra("date", date.getText().toString());
        intent.putExtra("receiver", receiver.getText().toString());
        intent.putExtra("serviceName", serviceName);
        startActivity(intent);
    }
}
