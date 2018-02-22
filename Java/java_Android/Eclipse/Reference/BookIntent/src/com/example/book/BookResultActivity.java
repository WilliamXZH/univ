package com.example.book;

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
        String bookItem="������" + intent.getStringExtra("name") + "\n";
        bookItem+="���ڣ�" + intent.getStringExtra("date") + "\n";
        bookItem+="��ʦ��" + intent.getStringExtra("receiver") + "\n";
        bookItem+="ѡ����Ŀ��" + intent.getStringExtra("serviceName");
        result.setText(bookItem);
    }
}
