package com.example.spinner;

import android.app.Activity;
import android.os.Bundle;
import android.view.Menu;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.Toast;

public class MainActivity extends Activity
{
    private Spinner sp;
    private String result;

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        sp=(Spinner) findViewById(R.id.spinner);
        // 1.在xml中设置 android:entries="@array/ctype"
        // sp.getSelectedItem();

        ArrayAdapter<CharSequence> adapter1;
        ArrayAdapter<String> adapter2;
        // 2.在程序中指定获取资源文件中的数组xml
        adapter1=ArrayAdapter.createFromResource(this, R.array.ctype, android.R.layout.simple_dropdown_item_1line);
        adapter1.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);

        // 3.自定义字符串数组
        String[] ctype=
        { "身份证1", "学生证1", "军官证1", "工作证1" };
        adapter2=new ArrayAdapter<String>(this, android.R.layout.simple_dropdown_item_1line, ctype);
        adapter2.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);

        sp.setAdapter(adapter2);

        sp.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener()
        {
            @Override
            public void onItemSelected(AdapterView<?> parent, View arg1, int pos, long id)
            {
                result=parent.getItemAtPosition(pos).toString();
                Toast.makeText(MainActivity.this, result, Toast.LENGTH_SHORT).show();
            }

            @Override
            public void onNothingSelected(AdapterView<?> arg0)
            {
                // TODO Auto-generated method stub
            }

        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu)
    {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    public void click(View view)
    {
        Toast.makeText(MainActivity.this, result, Toast.LENGTH_SHORT).show();
    }
}
