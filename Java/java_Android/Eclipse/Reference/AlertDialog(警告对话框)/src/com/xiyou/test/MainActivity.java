package com.xiyou.test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.content.DialogInterface;
import android.os.Bundle;
import android.view.View;
import android.view.WindowManager;
import android.widget.SimpleAdapter;
import android.widget.Toast;

public class MainActivity extends Activity
{
    private CharSequence[] items=
    { "�ٶ�", "�ȸ�", "��Ӧ" };

    protected void onCreate(Bundle savedInstanceState)
    {
        // ����Ӫ����ͼ�ꡢ������
        this.getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void myclick1(View view)
    {
        AlertDialog alert=new AlertDialog.Builder(this).create();
        alert.setTitle("�ఴť�Ի���");
        alert.setMessage("��ѡ��һ����ť!");
        alert.setButton(DialogInterface.BUTTON_POSITIVE, "ȷ��", new DialogInterface.OnClickListener()
        {
            @Override
            public void onClick(DialogInterface dialog, int which)
            {
                Toast.makeText(getApplicationContext(), "ȷ�������", Toast.LENGTH_LONG).show();
            }
        });
        alert.setButton(DialogInterface.BUTTON_NEUTRAL, "����", new DialogInterface.OnClickListener()
        {
            @Override
            public void onClick(DialogInterface dialog, int which)
            {
                Toast.makeText(getApplicationContext(), "���������", Toast.LENGTH_LONG).show();
            }
        });
        alert.setButton(DialogInterface.BUTTON_NEGATIVE, "ȡ��", new DialogInterface.OnClickListener()
        {
            @Override
            public void onClick(DialogInterface dialog, int which)
            {
                Toast.makeText(getApplicationContext(), "ȡ�������", Toast.LENGTH_LONG).show();
            }
        });
        alert.show();
    }

    public void myclick2(View view)
    {
        Builder builder=new AlertDialog.Builder(MainActivity.this);
        builder.setIcon(R.drawable.search);
        builder.setTitle("�б�Ի���");
        builder.setItems(items, new DialogInterface.OnClickListener()
        {
            @Override
            public void onClick(DialogInterface dialog, int which)
            {
                Toast.makeText(getApplicationContext(), items[which], Toast.LENGTH_LONG).show();
            }
        });
        builder.create().show();
    }

    public void myclick3(View view)
    {
        Builder builder=new AlertDialog.Builder(MainActivity.this);
        builder.setIcon(R.drawable.search);
        builder.setTitle("��ѡ�Ի���");
        builder.setSingleChoiceItems(items, 0, new DialogInterface.OnClickListener()
        {
            @Override
            public void onClick(DialogInterface dialog, int which)
            {
                Toast.makeText(getApplicationContext(), items[which] + "��ѡ����!", Toast.LENGTH_LONG).show();
            }
        });
        builder.setPositiveButton("ȷ��", null);
        builder.create().show();
    }

    public void myclick4(View view)
    {
        boolean[] itemsChecked=new boolean[items.length];
        Builder builder=new AlertDialog.Builder(MainActivity.this);
        builder.setIcon(R.drawable.search);
        builder.setTitle("��ѡ�Ի���");
        builder.setMultiChoiceItems(items, itemsChecked, new DialogInterface.OnMultiChoiceClickListener()
        {
            @Override
            public void onClick(DialogInterface dialog, int which, boolean isChecked)
            {
                Toast.makeText(getApplicationContext(), items[which] + "��ѡ����!", Toast.LENGTH_LONG).show();
            }
        });
        builder.setPositiveButton("ȷ��", null);
        builder.setNegativeButton("ȡ��", null);
        builder.create().show();
    }

    public void myclick5(View view)
    {
        int[] imageId=
        { R.drawable.baidu, R.drawable.google, R.drawable.bing };
        List<Map<String, Object>> listItems=new ArrayList<Map<String, Object>>();
        Map<String, Object> map;
        listItems.clear();
        for(int i=0; i < imageId.length; i++)
        {
            map=new HashMap<String, Object>();
            map.put("image", imageId[i]);
            map.put("title", items[i]);
            listItems.add(map);
        }
        final SimpleAdapter adapter=new SimpleAdapter(this, listItems, R.layout.items, new String[]
        { "image", "title" }, new int[]
        { R.id.image, R.id.title });

        Builder builder=new AlertDialog.Builder(MainActivity.this);
        builder.setIcon(R.drawable.search);
        builder.setTitle("��ͼ���б�Ի���");
        builder.setAdapter(adapter, new DialogInterface.OnClickListener()
        {
            @Override
            public void onClick(DialogInterface dialog, int which)
            {
                Toast.makeText(getApplicationContext(), items[which], Toast.LENGTH_LONG).show();
            }
        });
        builder.create().show();
    }
}
