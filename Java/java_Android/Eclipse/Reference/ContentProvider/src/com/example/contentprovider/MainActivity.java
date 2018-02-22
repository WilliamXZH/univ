package com.example.contentprovider;

import java.util.ArrayList;
import android.app.Activity;
import android.database.Cursor;
import android.os.Bundle;
import android.provider.ContactsContract;
import android.provider.ContactsContract.CommonDataKinds.Phone;
import android.provider.ContactsContract.Contacts;
import android.view.Menu;
import android.widget.ArrayAdapter;
import android.widget.ListView;

public class MainActivity extends Activity
{
    private static final String[] COLUMNS=
    { Contacts.DISPLAY_NAME, Phone.NUMBER };

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        Cursor cursor=this.managedQuery(ContactsContract.CommonDataKinds.Phone.CONTENT_URI, COLUMNS, null, null, null);
        int idIndex=cursor.getColumnIndex(COLUMNS[0]);
        int numIndex=cursor.getColumnIndex(COLUMNS[1]);
        ArrayList<String> list=new ArrayList<String>();
        while(cursor.moveToNext())
        {
            String name=cursor.getString(idIndex);
            String num=cursor.getString(numIndex);
            list.add(name + " " + num);
        }
        if(cursor.isClosed())
        {
            cursor.close();
            cursor=null;
        }
        ListView lv=(ListView) findViewById(R.id.lv);
        ArrayAdapter<String> adapter=new ArrayAdapter<String>(this, R.layout.list_item, list);
        lv.setAdapter(adapter);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu)
    {
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

}
