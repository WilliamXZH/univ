package com.example.progressbar;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.Menu;
import android.view.View;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends Activity
{
    private TextView pbText;
    private ProgressBar pb1, pb2;
    private Handler myHandler;
    private int pvalue;

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        pbText=(TextView) findViewById(R.id.pbText);
        pb1=(ProgressBar) findViewById(R.id.pb1);
        pb2=(ProgressBar) findViewById(R.id.pb2);

        myHandler=new Handler()
        {
            @Override
            public void handleMessage(Message msg)
            {
                pb1.setProgress(msg.arg1);
                pbText.setText("正在下载中...(" + msg.arg1 + "%)");
                if(msg.what == 0x222)
                {
                    Toast.makeText(MainActivity.this, "进度条执行完成!", Toast.LENGTH_SHORT).show();
                }
            }
        };
    }

    public void myClick(View view)
    {
        pb1.setVisibility(View.VISIBLE);
        pb2.setVisibility(View.VISIBLE);
        pb1.setProgress(0);// 设置初始进度值为0
        new Thread(new Runnable()
        {
            @Override
            public void run()
            {
                pvalue=0;
                while(true)
                {
                    pvalue+=(int) (Math.random() * 10);
                    try
                    {
                        Thread.sleep(100);
                    }
                    catch(Exception e)
                    {
                        e.printStackTrace();
                    }
                    Message mes=new Message();
                    if(pvalue < 100)
                    {
                        mes.arg1=pvalue;
                        mes.what=0x111;
                        myHandler.sendMessage(mes);
                    }
                    else
                    {
                        mes.arg1=100;
                        mes.what=0x222;
                        myHandler.sendMessage(mes);
                        break;
                    }
                }
            }
        }).start();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu)
    {
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }
}
