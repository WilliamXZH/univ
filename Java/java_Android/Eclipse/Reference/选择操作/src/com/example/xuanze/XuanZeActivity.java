package com.example.xuanze;



import android.os.Bundle;
import android.app.Activity;
import android.content.Intent;
import android.view.Menu;
import android.view.View;
import android.widget.Button;

public class XuanZeActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_xuan_ze);
        
        Button button1=(Button)this.findViewById(R.id.button1);
        Button button2=(Button)this.findViewById(R.id.button2);
        //拨号键监听
        button1.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO 自动生成的方法存根
				Intent intent=new Intent();
				
				intent.setClass(XuanZeActivity.this,MainActivity.class );
			    startActivity(intent);
				XuanZeActivity.this.finish();
			}
		});
    

   //归属地查询监听器
    button2.setOnClickListener(new View.OnClickListener() {
		
		@Override
		public void onClick(View v) {
			// TODO 自动生成的方法存根
			Intent intent=new Intent();
			
			intent.setClass(XuanZeActivity.this,PhoneAdressActivity.class );
		    startActivity(intent);
			XuanZeActivity.this.finish();
		}
	});
    
    }   
    
}
