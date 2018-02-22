package com.example.xuanze;



import org.ksoap2.SoapEnvelope;
import org.ksoap2.serialization.SoapObject;
import org.ksoap2.serialization.SoapSerializationEnvelope;
import org.ksoap2.transport.HttpTransportSE;
import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;

import android.os.Message;
import android.text.TextUtils;

import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

public class PhoneAdressActivity extends Activity
{
    protected static final int SUCCESS=1;
    private  EditText editText1_guishudi;
    private Button button1_guishudi;
    private TextView textView2_guishudi;

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_phone_adress);

        editText1_guishudi=(EditText) findViewById(R.id.editText1_guishudi);
        button1_guishudi=(Button) findViewById(R.id.button1_guishudi);
        textView2_guishudi=(TextView) findViewById(R.id.textView2_guishudi);

        button1_guishudi.setOnClickListener(new OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                // TODO 自动生成的方法存根
                // 实现归属地的查询
                query();
            }
        });

    }

    private Handler handler=new Handler()
    {
        public void handlerMessge(Message msg)
        {
            switch(msg.what)
            {
                case SUCCESS:
                    textView2_guishudi.setText(msg.obj.toString());
                    break;
                default:
                    break;
            }

        };
    };

    // 目的：实现在线查询归属地的功能
   protected void query()
    {
        // 判断电话号码是否正确
        final String num=editText1_guishudi.getText().toString();
        if(TextUtils.isEmpty(num) && num.length() <= 7)
        {
            Toast.makeText(this, "电话号码输入不正确", Toast.LENGTH_SHORT).show();
            return;
        }

        new Thread(new Runnable()
        {
            @Override
            public void run()
            {

                // 1指定命名空间和调用的方法
                String name="http://WebXml.com.cn/";//要访问的命名空间
                String method="getMobileCodeInfo";

                // 2封装SOAP类及设置参数
                SoapObject request=new SoapObject(name, method);
                request.addProperty("mobileCode", num);
                request.addProperty("userID", "");
                // 引入版本号,生成webservice的请求信息
                SoapSerializationEnvelope envelope=new SoapSerializationEnvelope(SoapEnvelope.VER12);
                envelope.bodyOut=request;
                envelope.dotNet=true;// 服务器校验

                // 指定要访问的WSDL
                HttpTransportSE ht=new HttpTransportSE("http://webservice.webxml.com.cn/WebServices/MobileCodeWS.asmx?wsdl");
                try
                {
                    ht.call(null, envelope);
                    String result=envelope.getResponse().toString();// 获取相应的结果
                    Message msg=handler.obtainMessage(SUCCESS, result);
                    handler.sendMessage(msg);
                }
                catch(Exception e)
                {
                    // TODO 自动生成的 catch 块
                    e.printStackTrace();
                }
            }

        }).start();

    }

}
