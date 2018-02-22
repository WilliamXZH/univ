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
    { "百度", "谷歌", "必应" };

    protected void onCreate(Bundle savedInstanceState)
    {
        // 隐藏营运商图标、电量等
        this.getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void myclick1(View view)
    {
        AlertDialog alert=new AlertDialog.Builder(this).create();
        alert.setTitle("多按钮对话框");
        alert.setMessage("请选择一个按钮!");
        alert.setButton(DialogInterface.BUTTON_POSITIVE, "确定", new DialogInterface.OnClickListener()
        {
            @Override
            public void onClick(DialogInterface dialog, int which)
            {
                Toast.makeText(getApplicationContext(), "确定被点击", Toast.LENGTH_LONG).show();
            }
        });
        alert.setButton(DialogInterface.BUTTON_NEUTRAL, "中立", new DialogInterface.OnClickListener()
        {
            @Override
            public void onClick(DialogInterface dialog, int which)
            {
                Toast.makeText(getApplicationContext(), "中立被点击", Toast.LENGTH_LONG).show();
            }
        });
        alert.setButton(DialogInterface.BUTTON_NEGATIVE, "取消", new DialogInterface.OnClickListener()
        {
            @Override
            public void onClick(DialogInterface dialog, int which)
            {
                Toast.makeText(getApplicationContext(), "取消被点击", Toast.LENGTH_LONG).show();
            }
        });
        alert.show();
    }

    public void myclick2(View view)
    {
        Builder builder=new AlertDialog.Builder(MainActivity.this);
        builder.setIcon(R.drawable.search);
        builder.setTitle("列表对话框");
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
        builder.setTitle("单选对话框");
        builder.setSingleChoiceItems(items, 0, new DialogInterface.OnClickListener()
        {
            @Override
            public void onClick(DialogInterface dialog, int which)
            {
                Toast.makeText(getApplicationContext(), items[which] + "被选中了!", Toast.LENGTH_LONG).show();
            }
        });
        builder.setPositiveButton("确定", null);
        builder.create().show();
    }

    public void myclick4(View view)
    {
        boolean[] itemsChecked=new boolean[items.length];
        Builder builder=new AlertDialog.Builder(MainActivity.this);
        builder.setIcon(R.drawable.search);
        builder.setTitle("多选对话框");
        builder.setMultiChoiceItems(items, itemsChecked, new DialogInterface.OnMultiChoiceClickListener()
        {
            @Override
            public void onClick(DialogInterface dialog, int which, boolean isChecked)
            {
                Toast.makeText(getApplicationContext(), items[which] + "被选中了!", Toast.LENGTH_LONG).show();
            }
        });
        builder.setPositiveButton("确定", null);
        builder.setNegativeButton("取消", null);
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
        builder.setTitle("带图标列表对话框");
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
