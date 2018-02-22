package com.i4evercai.bannerdemo;


import java.util.LinkedList;
import java.util.List;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.ListView;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.AdapterView;
public class Question extends Activity  implements AdapterView.OnItemSelectedListener,AdapterView.OnItemClickListener
{
	
	private List<New> ques = null;
    private Context mContext;
    private NewsAdapter mAdapter = null;
    private ListView que;
    private Spinner spinner;
    private TextView textView;

	@Override
	protected void onCreate(Bundle savedInstanceState) 
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_question);
		TextView newsview=(TextView)findViewById(R.id.newsTextView);
		TextView questionview=(TextView)findViewById(R.id.questionTextView);
		TextView serviceview=(TextView)findViewById(R.id.serviceTextView);
		TextView starview=(TextView)findViewById(R.id.starTextView);
		newsview.setOnClickListener(new OnClickListener(){
			public void onClick(View v)
			{
				Intent intent=new Intent(Question.this,MainActivity.class);
				startActivity(intent);
				overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out);
				//Toast.makeText(MainActivity.this,"点击成功2",Toast.LENGTH_SHORT).show();
			}
		});
		
		serviceview.setOnClickListener(new OnClickListener(){
			public void onClick(View v)
			{
				Intent intent=new Intent(Question.this,Service.class);
				//Toast.makeText(MainActivity.this,"点击成功3",Toast.LENGTH_SHORT).show();
				startActivity(intent);
				overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out);
			}
		});	
		starview.setOnClickListener(new OnClickListener(){
			public void onClick(View v)
			{
				Intent intent=new Intent(Question.this,Vip.class);
				startActivity(intent);
				overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out);
				//Toast.makeText(MainActivity.this,"点击成功4",Toast.LENGTH_SHORT).show();
			}
		});
		
		mContext = Question.this;
        que = (ListView) findViewById(R.id.questionlistview);
        spinner=(Spinner)findViewById(R.id.questionspainner);
        ques = new LinkedList<New>();
        mAdapter = new NewsAdapter((LinkedList<New>) ques, mContext);
        que.setAdapter(mAdapter);
        que.setOnItemClickListener(this);
        spinner.setOnItemSelectedListener(this);

		
		
		//郭豪
		
	
	
	
	
	
	}
	
	
    @Override
    public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
        switch (parent.getId()){
            case R.id.questionspainner:
                ques.clear();
                switch (position){
                    case 0:
                        ques.add(new New("工商政策法规", "查看回答", R.drawable.question));
                        ques.add(new New("工商政策法规", "查看回答", R.drawable.question));
                        ques.add(new New("工商政策法规", "查看回答", R.drawable.question));
                        ques.add(new New("工商政策法规", "查看回答", R.drawable.question));
                        mAdapter.notifyDataSetChanged();
                        break;
                    case 1:
                        ques.add(new New("税务", "查看回答", R.drawable.question));
                        ques.add(new New("税务", "查看回答", R.drawable.question));
                        ques.add(new New("税务", "查看回答", R.drawable.question));
                        ques.add(new New("税务", "查看回答", R.drawable.question));
                        mAdapter.notifyDataSetChanged();
                        break;
                    case 2:
                        ques.add(new New("政府政策", "查看回答", R.drawable.question));
                        ques.add(new New("政府政策", "查看回答", R.drawable.question));
                        ques.add(new New("政府政策", "查看回答", R.drawable.question));
                        ques.add(new New("政府政策", "查看回答", R.drawable.question));

                        mAdapter.notifyDataSetChanged();
                        break;
                }
                break;

        }
    }

    @Override
    public void onNothingSelected(AdapterView<?> parent) {
    }
    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        switch (parent.getId()){

            case R.id.questionlistview:
                Intent intent=new Intent(Question.this,ShowQuestion.class);
                startActivity(intent);
                break;

        }
    }



	
}
