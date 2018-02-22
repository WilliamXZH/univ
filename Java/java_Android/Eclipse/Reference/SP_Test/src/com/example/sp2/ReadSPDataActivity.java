package com.example.sp2;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.pm.PackageManager.NameNotFoundException;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class ReadSPDataActivity extends Activity
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
        Context context=null;
        try
        {
            context=createPackageContext("com.example.sp", Context.CONTEXT_IGNORE_SECURITY);
        }
        catch(NameNotFoundException e)
        {
            e.printStackTrace();
        }
        final SharedPreferences sp=context.getSharedPreferences("SPShare", MODE_WORLD_READABLE);
        final SharedPreferences.Editor editor=sp.edit();
        save.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View arg0)
            {
                String k=key.getText().toString();
                String v=value.getText().toString();
                editor.putString(k, v);
                editor.commit();
                Toast.makeText(ReadSPDataActivity.this, "±£´æ³É¹¦!", Toast.LENGTH_LONG).show();

            }
        });
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
