package com.example.readcontent;

import android.app.Activity;
import android.content.ContentResolver;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.view.Menu;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

public class ReadContentActivity extends Activity
{
    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        Button btn=(Button) findViewById(R.id.getData);
        final EditText list=(EditText) findViewById(R.id.list);
        btn.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View view)
            {
                ContentResolver resolver=getContentResolver();
                Uri uri=Uri.parse("content://com.example.sqlite1.StuProvider");
                Cursor cursor=resolver.query(uri, null, null, null, null);
                while(true)
                {
                    if(cursor.moveToNext() == false)
                        break;
                    String i=cursor.getString(0);
                    String n=cursor.getString(1);
                    int s=cursor.getInt(2);
                    String tmp=list.getText().toString();
                    list.setText(tmp + i + " " + n + " " + s + "\n");
                }
            }
        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu)
    {
        getMenuInflater().inflate(R.menu.read_content, menu);
        return true;
    }

}
