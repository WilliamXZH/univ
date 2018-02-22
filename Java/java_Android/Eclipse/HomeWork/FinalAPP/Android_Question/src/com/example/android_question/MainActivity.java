package com.example.android_question;

import android.support.v7.app.AppCompatActivity;
import android.util.TypedValue;
import android.content.res.Resources;
import android.graphics.Color;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.RadioGroup;
import android.widget.RelativeLayout;

public  class MainActivity extends AppCompatActivity implements OnClickListener{
	private Container cont;
	
    private Button myButton;
    private EditText myEditText;
    private RelativeLayout myLayout;
    private RadioGroup group;

    
    protected void init(){
    	cont=new Container();
    	
	    myLayout = new RelativeLayout(this);
	    myLayout.setBackgroundColor(Color.BLUE);
    }
    protected void Menu(){
	    myButton = new Button(this);
	    myButton.setText("Search");
	
	    myEditText = new EditText(this);
	    myEditText.setHint("Input keywords!");
	
	    myButton.setId(1);
	    myEditText.setId(2);
	
	    RelativeLayout.LayoutParams buttonParams =
	            new RelativeLayout.LayoutParams(
	                    RelativeLayout.LayoutParams.WRAP_CONTENT,
	                    RelativeLayout.LayoutParams.WRAP_CONTENT);
	
	    buttonParams.addRule(RelativeLayout.CENTER_HORIZONTAL);
	    buttonParams.addRule(RelativeLayout.CENTER_VERTICAL);
	    RelativeLayout.LayoutParams textParams =
	            new RelativeLayout.LayoutParams(
	                    RelativeLayout.LayoutParams.WRAP_CONTENT,
	                    RelativeLayout.LayoutParams.WRAP_CONTENT);
	
	    textParams.addRule(RelativeLayout.ABOVE, myButton.getId());
	    textParams.addRule(RelativeLayout.CENTER_HORIZONTAL);
	    textParams.setMargins(0, 0, 0, 80);
	    Resources r = getResources();
	    int px = (int) TypedValue.applyDimension(
	            TypedValue.COMPLEX_UNIT_DIP, 200, r.getDisplayMetrics());
	
	    myEditText.setWidth(px);
	    myButton.setOnClickListener(this);
	    myLayout.addView(myButton, buttonParams);
	    myLayout.addView(myEditText, textParams);
	    
	    
	    group=new RadioGroup(this);
	    CheckBox check1=new CheckBox(null, null);
    }
    
	@Override
	protected void onCreate(Bundle savedInstanceState) {
	    super.onCreate(savedInstanceState);
	    
	    setContentView(myLayout);
	

    }
	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		int id=v.getId();
		
		switch(id){
		case 1:
			break;
		case 2:
			break;
		default:
				
		}
	}
}