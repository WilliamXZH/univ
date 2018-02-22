package com.example.administrator.homework;


import android.app.DatePickerDialog;
import android.content.Intent;
import android.net.Uri;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;

import android.widget.Toast;
import android.view.Gravity;

import java.util.ArrayList;
import java.util.List;

import android.app.Activity;
import android.view.MotionEvent;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Spinner;

import com.google.android.gms.appindexing.Action;
import com.google.android.gms.appindexing.AppIndex;
import com.google.android.gms.appindexing.Thing;
import com.google.android.gms.common.api.GoogleApiClient;

public class MainActivity extends AppCompatActivity {

    private Button btn;
    private TextView tv;
    private List<String> list = new ArrayList<String>();
    private TextView myTextView;
    private Spinner mySpinner;
    private ArrayAdapter<String> adapter;

    private EditText textName;
    private EditText textID;
    private EditText textEmail;
    private RadioGroup radioGroup;
    private EditText textAddress;

    private Button btn_submit;
    private Button btn_reset;

    private String name;
    private String id;
    private String email;
    private String sex;
    private String birth;
    private String province;
    private String address;
    private boolean flag;//判断控件里不为null

    /**
     * ATTENTION: This was auto-generated to implement the App Indexing API.
     * See https://g.co/AppIndexing/AndroidStudio for more information.
     */
    private GoogleApiClient client;

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        btn_reset=(Button) this.findViewById(R.id.reset);
        btn_submit = (Button) this.findViewById(R.id.submit);
        textName = (EditText) this.findViewById(R.id.editStudentName);
        textID = (EditText) this.findViewById(R.id.editStudentID);
        textEmail= (EditText) this.findViewById(R.id.editEmail);
        radioGroup= (RadioGroup) this.findViewById(R.id.sex);
        textAddress=(EditText)this.findViewById(R.id.editAdress);
        btn=(Button)this.findViewById(R.id.btndate);
        tv= (TextView) this.findViewById(R.id.tv);

        btn_submit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                name=textName.getText().toString();
                id=textID.getText().toString();
                email=textEmail.getText().toString();
                birth=tv.getText().toString();
                address=textAddress.getText().toString();
                Intent intent = new Intent(MainActivity.this, SecondActivity.class);
                Bundle bundle = new Bundle();
                bundle.putString("Name",name);
                bundle.putString("ID",id);
                bundle.putString("Email",email);
                bundle.putString("Sex",MainActivity.this.sex);
                bundle.putString("Birth",birth);
                bundle.putString("Province",province);
                bundle.putString("Address",address);
                intent.putExtras(bundle);
                startActivity(intent);
            }
        });
        btn_reset.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                resetInput();
            }
        });

        radioGroup.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(RadioGroup group, int checkedId) {
                int radioButtonID=group.getCheckedRadioButtonId();
                RadioButton rb= (RadioButton) MainActivity.this.findViewById(radioButtonID);
                sex=rb.getText().toString();
            }
        });

        btn.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v){
                new DatePickerDialog(MainActivity.this, new DatePickerDialog.OnDateSetListener() {
                    @Override
                    public void onDateSet(DatePicker view, int year, int monthOfYear, int dayOfMonth) {
                        tv.setText("出生日期："+String.format("%d-%d-%d",year,monthOfYear+1,dayOfMonth));
                    }
                },2000,1,2).show();
            }
        });
        list.add("北京");
        list.add("上海");
        list.add("深圳");
        list.add("福州");
        list.add("厦门");
        list.add("湖南");
        list.add("辽宁");
        myTextView = (TextView)findViewById(R.id.text_adress);
        mySpinner = (Spinner)findViewById(R.id.spinner_adress);
        adapter = new ArrayAdapter<String>(this,android.R.layout.simple_spinner_item, list);
//第三步：为适配器设置下拉列表下拉时的菜单样式。
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
//第四步：将适配器添加到下拉列表上
        mySpinner.setAdapter(adapter);
//第五步：为下拉列表设置各种事件的响应，这个事响应菜单被选中
        mySpinner.setOnItemSelectedListener(new Spinner.OnItemSelectedListener(){
            public void onItemSelected(AdapterView<?> arg0, View arg1, int arg2, long arg3) {
// TODO Auto-generated method stub
/* 将所选mySpinner 的值带入myTextView 中*/
                province= (String) mySpinner.getSelectedItem();
                myTextView.setText("选择省份："+ adapter.getItem(arg2));
/* 将mySpinner 显示*/
                arg0.setVisibility(View.VISIBLE);
            }
            public void onNothingSelected(AdapterView<?> arg0) {
// TODO Auto-generated method stub
                myTextView.setText("NONE");
                arg0.setVisibility(View.VISIBLE);
            }
        });
///*下拉菜单弹出的内容选项触屏事件处理*/
//        mySpinner.setOnTouchListener(new Spinner.OnTouchListener(){
//            public boolean onTouch(View v, MotionEvent event) {
//// TODO Auto-generated method stub
//                return false;
//            }
//        });
///*下拉菜单弹出的内容选项焦点改变事件处理*/
//        mySpinner.setOnFocusChangeListener(new Spinner.OnFocusChangeListener(){
//            public void onFocusChange(View v, boolean hasFocus) {
//// TODO Auto-generated method stub
//            }
//        });

    }

    public void resetInput(){
        textID.setText("");
        textName.setText("");
        textEmail.setText("");
        textAddress.setText("");
        radioGroup.check(R.id.male);
        tv.setText("出生日期:");
        mySpinner.setSelection(0);
    }

}