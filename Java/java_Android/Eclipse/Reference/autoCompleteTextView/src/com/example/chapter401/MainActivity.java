package com.example.chapter401;

import android.app.Activity;
import android.os.Bundle;
import android.view.Menu;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;
import android.widget.Toast;

public class MainActivity extends Activity
{
    private String[] keys=
    { "android", "android入门", "android实例", "android开发方法", "html", "html技术", "html元素", "html教程" };
    private AutoCompleteTextView actv;

    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        actv=(AutoCompleteTextView) findViewById(R.id.actv);
        ArrayAdapter<String> adapter=new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, keys);
        actv.setAdapter(adapter);
    }

    public void myClick(View view)
    {
        Toast.makeText(MainActivity.this, actv.getText().toString(), Toast.LENGTH_LONG).show();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu)
    {
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

}
