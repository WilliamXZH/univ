package com.example.checkboxtest;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.Toast;

public class MainActivity extends Activity
{
    private CheckBox mp4, mkv, ts;
    private CompoundButton.OnCheckedChangeListener listener=new CompoundButton.OnCheckedChangeListener()
    {
        @Override
        public void onCheckedChanged(CompoundButton buttonView, boolean isChecked)
        {
            if(isChecked)
                Toast.makeText(MainActivity.this, "您选中：" + buttonView.getText().toString() + " 格式!", Toast.LENGTH_SHORT).show();
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        mp4=(CheckBox) findViewById(R.id.mp4);
        mkv=(CheckBox) findViewById(R.id.mkv);
        ts=(CheckBox) findViewById(R.id.ts);
        // 注册监听器
        mp4.setOnCheckedChangeListener(listener);
        mkv.setOnCheckedChangeListener(listener);
        ts.setOnCheckedChangeListener(listener);
    }

    public void myClick(View view)
    {
        String choosedItem="";
        if(mp4.isChecked())
            choosedItem+=mp4.getText().toString() + ",";
        if(mkv.isChecked())
            choosedItem+=mkv.getText().toString() + ",";
        if(ts.isChecked())
            choosedItem+=ts.getText().toString();
        Toast.makeText(MainActivity.this, "支持格式是：" + choosedItem, Toast.LENGTH_SHORT).show();
    }
}
