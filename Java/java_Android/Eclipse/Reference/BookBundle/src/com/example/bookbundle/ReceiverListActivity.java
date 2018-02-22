package com.example.bookbundle;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.GridView;
import android.widget.ImageView;

public class ReceiverListActivity extends Activity
{
    private GridView gridView;
    private int[] img=
    { R.drawable.receiver1, R.drawable.receiver2, R.drawable.receiver3, R.drawable.receiver4 };
    private String[] receiverName=
    { "小王", "小徐", "小黄", "小薛" };

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.receiverlist);
        gridView=(GridView) findViewById(R.id.gridView);
        BaseAdapter adapter=new BaseAdapter()
        {
            @Override
            public View getView(int position, View view, ViewGroup parent)
            {
                ImageView imageView;
                if(view == null)
                {
                    imageView=new ImageView(ReceiverListActivity.this);
                    imageView.setAdjustViewBounds(true);
                    imageView.setMaxWidth(200);
                    imageView.setMaxHeight(200);
                    imageView.setPadding(5, 5, 5, 5);
                }
                else
                    imageView=(ImageView) view;
                imageView.setImageResource(img[position]);
                return imageView;
            }

            @Override
            public long getItemId(int position)
            {
                return position;
            }

            @Override
            public Object getItem(int position)
            {
                return position;
            }

            @Override
            public int getCount()
            {
                return img.length;
            }
        };
        gridView.setAdapter(adapter);
        gridView.setOnItemClickListener(new AdapterView.OnItemClickListener()
        {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id)
            {
                Intent intent=getIntent();
                Bundle bundle=new Bundle();
                bundle.putString("receiverName", receiverName[position]);
                intent.putExtras(bundle);
                setResult(0x111, intent);
                finish();
            }
        });
    }

}