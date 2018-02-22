package com.example.radiobuttontest;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.Toast;

public class MainActivity extends Activity
{
    private RadioGroup choosenet;
    private RadioButton chinamobile, chinaunion, chinatelcom;

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        choosenet=(RadioGroup) findViewById(R.id.choosenet);
        chinamobile=(RadioButton) findViewById(R.id.chinamobile);
        chinaunion=(RadioButton) findViewById(R.id.chinaunion);
        chinatelcom=(RadioButton) findViewById(R.id.chinatelcom);
        // 按钮组对象添加监听器
        choosenet.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener()
        {
            @Override
            public void onCheckedChanged(RadioGroup group, int checkedId)
            {
                RadioButton r=(RadioButton) findViewById(checkedId);
                Toast.makeText(MainActivity.this, "您使用的是:" + r.getText(), Toast.LENGTH_SHORT).show();
            }
        });
    }

    // 按钮单击方法
    public void choosed(View view)
    {
        for(int i=0; i < choosenet.getChildCount(); i++)
        {
            RadioButton r=(RadioButton) choosenet.getChildAt(i);
            if(r.isChecked())
            {
                Toast.makeText(MainActivity.this, "您使用的是:" + r.getText(), Toast.LENGTH_SHORT).show();
                break;
            }
        }
    }
}
