package com.example.bookbundle;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

public class BookResultActivity extends Activity
{
    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.bookresult);
        TextView result=(TextView) findViewById(R.id.result);
        Intent intent=getIntent();
        String bookItem="姓名：" + intent.getStringExtra("name") + "\n";
        bookItem+="日期：" + intent.getStringExtra("date") + "\n";
        bookItem+="技师：" + intent.getStringExtra("receiver") + "\n";
        bookItem+="选择项目：" + intent.getStringExtra("serviceName");
        result.setText(bookItem);
    }
}
