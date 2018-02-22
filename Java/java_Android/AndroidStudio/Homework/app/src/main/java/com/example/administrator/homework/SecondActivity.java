package com.example.administrator.homework;

import android.app.Activity;
import android.location.Address;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

/**
 * Created by Administrator on 2016/10/22 0022.
 */

public class SecondActivity extends Activity {
    private EditText showMessage;

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);

        showMessage = (EditText) this.findViewById(R.id.message);

        Bundle bundle = SecondActivity.this.getIntent().getExtras();
        String name = bundle.getString("Name");
        String id = bundle.getString("ID");
        String email=bundle.getString("Email");
        String sex=bundle.getString("Sex");
        String birth=bundle.getString("Birth");
        String province=bundle.getString("Province");
        String address=bundle.getString("Address");

        showMessage.setText("姓名："+name+"\n学号："+id+"\n性别："+sex+"\n邮箱地址："+email+"\n"+birth+"\n省份:"+province+"\n详细地址："+ address);
    }
}
