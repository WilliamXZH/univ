package com.example.sp;

import android.app.Activity;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class SPShareActivity extends Activity
{
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        final EditText key=(EditText) findViewById(R.id.key);
        final EditText value=(EditText) findViewById(R.id.value);
        final Button save=(Button) findViewById(R.id.save);
        final Button read=(Button) findViewById(R.id.read);
        final SharedPreferences sp=getSharedPreferences("SPShare", MODE_WORLD_READABLE);
        final SharedPreferences.Editor editor=sp.edit();
        // 监听器中保存键值对
        save.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View arg0)
            {
                String k=key.getText().toString();
                String v=value.getText().toString();
                editor.putString(k, v);
                editor.commit();
                Toast.makeText(SPShareActivity.this, "保存成功!", Toast.LENGTH_LONG).show();
            }
        });
        // 监听器中根据键取值
        read.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View arg0)
            {
                String k=key.getText().toString();
                String v=sp.getString(k, "NO_VALUE");
                value.setText(v);
            }
        });
    }
}
