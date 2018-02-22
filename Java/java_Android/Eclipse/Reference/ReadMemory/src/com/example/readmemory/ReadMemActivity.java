package com.example.readmemory;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.PrintStream;
import android.app.Activity;
import android.os.Bundle;
import android.view.Menu;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

public class ReadMemActivity extends Activity
{

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        final EditText title=(EditText) findViewById(R.id.title);
        final EditText text=(EditText) findViewById(R.id.text);
        final Button save=(Button) findViewById(R.id.save);
        final Button read=(Button) findViewById(R.id.read);
        save.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View view)
            {
                String t=title.getText().toString();
                String v=text.getText().toString();
                try
                {
                    FileOutputStream out=openFileOutput(t, MODE_PRIVATE);
                    PrintStream ps=new PrintStream(out);
                    ps.println(v);
                    ps.close();
                }
                catch(Exception e)
                {
                    e.printStackTrace();
                }
            }
        });
        read.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View view)
            {
                String t=title.getText().toString();
                try
                {
                    FileInputStream in=openFileInput(t);
                    byte[] buff=new byte[1024];
                    int hasRead=0;
                    StringBuilder sb=new StringBuilder("");
                    while((hasRead=in.read(buff)) > 0)
                    {
                        sb.append(new String(buff, 0, hasRead));
                    }
                    text.setText(sb.toString());
                }
                catch(Exception e)
                {
                    e.printStackTrace();
                }
            }
        });

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu)
    {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.read_mem, menu);
        return true;
    }

}
