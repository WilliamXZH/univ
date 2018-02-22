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
                // TODO �Զ����ɵķ������
                // ʵ�ֹ����صĲ�ѯ
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

    // Ŀ�ģ�ʵ�����߲�ѯ�����صĹ���
   protected void query()
    {
        // �жϵ绰�����Ƿ���ȷ
        final String num=editText1_guishudi.getText().toString();
        if(TextUtils.isEmpty(num) && num.length() <= 7)
        {
            Toast.makeText(this, "�绰�������벻��ȷ", Toast.LENGTH_SHORT).show();
            return;
        }

        new Thread(new Runnable()
        {
            @Override
            public void run()
            {

                // 1ָ�������ռ�͵��õķ���
                String name="http://WebXml.com.cn/";//Ҫ���ʵ������ռ�
                String method="getMobileCodeInfo";

                // 2��װSOAP�༰���ò���
                SoapObject request=new SoapObject(name, method);
                request.addProperty("mobileCode", num);
                request.addProperty("userID", "");
                // ����汾��,����webservice��������Ϣ
                SoapSerializationEnvelope envelope=new SoapSerializationEnvelope(SoapEnvelope.VER12);
                envelope.bodyOut=request;
                envelope.dotNet=true;// ������У��

                // ָ��Ҫ���ʵ�WSDL
                HttpTransportSE ht=new HttpTransportSE("http://webservice.webxml.com.cn/WebServices/MobileCodeWS.asmx?wsdl");
                try
                {
                    ht.call(null, envelope);
                    String result=envelope.getResponse().toString();// ��ȡ��Ӧ�Ľ��
                    Message msg=handler.obtainMessage(SUCCESS, result);
                    handler.sendMessage(msg);
                }
                catch(Exception e)
                {
                    // TODO �Զ����ɵ� catch ��
                    e.printStackTrace();
                }
            }

        }).start();

    }

}
