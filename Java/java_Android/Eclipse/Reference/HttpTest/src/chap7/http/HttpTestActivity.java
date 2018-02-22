package chap7.http;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;
import android.view.View;

public class HttpTestActivity extends Activity {
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        final EditText name = (EditText)findViewById(R.id.name);
    	final EditText pass = (EditText)findViewById(R.id.pass);
    	final Button button = (Button) findViewById(R.id.login);

    	button.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
            	if(name.getText().toString().equals(""))
            	{  	Toast toast = Toast.makeText(HttpTestActivity.this,
    					"输入用户名", Toast.LENGTH_LONG);
    				toast.show();
            	}else if(pass.getText().toString().equals(""))
            	{  	Toast toast = Toast.makeText(HttpTestActivity.this,
    					"输入密码", Toast.LENGTH_LONG);
    				toast.show();
            	}else{
        	    	try {
        	    		String n = name.getText().toString();
        	    		String p = pass.getText().toString();        	    		
        	    		URL url = new URL("http://10.0.2.2:8888/TestServer/Login?name="+n+"&pass="+p);
						HttpURLConnection uc = (HttpURLConnection)url.openConnection();
						InputStream out = uc.getInputStream();
						int i = out.read();						
						System.out.println("out="+i);
						if(i==49){
		    				Intent intent = new Intent(HttpTestActivity.this
		    						, WelcomeActivity.class);
		    				startActivity(intent);											
						}else{
							Toast toast = Toast.makeText(HttpTestActivity.this,
			    					"用户名或密码错误", Toast.LENGTH_LONG);
			    				toast.show();
						}
					} catch (IOException e) {
						e.printStackTrace();
					}
            	}

            }
        });

    }
}