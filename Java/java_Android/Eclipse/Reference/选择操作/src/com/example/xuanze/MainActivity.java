package com.example.xuanze;



import android.net.Uri;
import android.os.Bundle;
import android.app.Activity;
import android.content.Intent;
import android.view.Menu;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        Button button1_bohao=(Button)this.findViewById(R.id.button1_bohao);
        button1_bohao.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO 自动生成的方法存根
				EditText editText1=(EditText)MainActivity.this.findViewById(R.id.editText1);
			    String   num=editText1.getText().toString();
			    
			    if(num!=null&&!num.equals("")){
			    Intent intent=new Intent();
			    intent.setAction(Intent.ACTION_CALL);
			    intent.setData(Uri.parse("tel:"+num));
			    startActivity(intent);
			    }
			    
			    editText1.setText("");
			}
        });
       
    }


  
}
