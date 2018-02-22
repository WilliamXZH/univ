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
        // �������б����ֵ��
        save.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View arg0)
            {
                String k=key.getText().toString();
                String v=value.getText().toString();
                editor.putString(k, v);
                editor.commit();
                Toast.makeText(SPShareActivity.this, "����ɹ�!", Toast.LENGTH_LONG).show();
            }
        });
        // �������и��ݼ�ȡֵ
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
