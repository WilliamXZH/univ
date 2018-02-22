package com.i4evercai.bannerdemo;


import java.text.SimpleDateFormat;
import java.util.LinkedList;
import java.util.List;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.view.View;

import java.text.DateFormat;
import java.util.Date;

import com.i4evercai.bannerdemo.ui.TalkAdapter;

public class CommentNew extends Activity  implements View.OnClickListener
{
	private List<Talk> talks = null;
    private Context mContext;
    private TalkAdapter mAdapter = null;
    private ListView talk;
    private Button button;
    private EditText editText;
    private Date date;
	@Override
	
	protected void onCreate(Bundle savedInstanceState) 
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_comment_new);
	    talk=(ListView)findViewById(R.id.talk);
        button=(Button)findViewById(R.id.button);
        talks=new LinkedList<Talk>();
        mContext=CommentNew.this;
        mAdapter= new TalkAdapter((LinkedList<Talk>) talks,mContext);
        talk.setAdapter(mAdapter);
        button.setOnClickListener(this);

		
	}
	
	 @Override
	    public void onClick(View v) {
	        String text,time;
	        date=new Date();
	        DateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        time=format.format(date);
	        editText=(EditText)findViewById(R.id.editText);
	        text=editText.getText().toString();
	        talks.add(new Talk("郭豪：",time,text));
	        mAdapter.notifyDataSetChanged();
	        editText.setText("");
	    }

}

	
