package com.example.datetimepicker;

import java.util.Calendar;
import android.app.Activity;
import android.os.Bundle;
import android.view.Menu;
import android.widget.DatePicker;
import android.widget.DatePicker.OnDateChangedListener;
import android.widget.TextView;
import android.widget.TimePicker;
import android.widget.TimePicker.OnTimeChangedListener;

public class MainActivity extends Activity
{
    private int year, month, date, hour, minute;
    private TextView showTime;

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        showTime=(TextView) findViewById(R.id.showTime);
        DatePicker datePicker=(DatePicker) findViewById(R.id.datePicker);
        TimePicker timePicker=(TimePicker) findViewById(R.id.timePicker);
        timePicker.setIs24HourView(true);

        Calendar cl=Calendar.getInstance();
        year=cl.get(Calendar.YEAR);
        month=cl.get(Calendar.MONTH);
        date=cl.get(Calendar.DAY_OF_MONTH);
        hour=cl.get(Calendar.HOUR_OF_DAY);
        minute=cl.get(Calendar.MINUTE);
        show(year, month, date, hour, minute);

        timePicker.setCurrentHour(hour);
        timePicker.setCurrentMinute(minute);

        datePicker.init(year, month, date, new OnDateChangedListener()
        {
            public void onDateChanged(DatePicker dp, int year, int month, int day)
            {
                MainActivity.this.year=year;
                MainActivity.this.month=month;
                MainActivity.this.date=day;
                show(year, month, date, hour, minute);
            }
        });

        timePicker.setOnTimeChangedListener(new OnTimeChangedListener()
        {
            public void onTimeChanged(TimePicker tp, int hour, int minute)
            {
                MainActivity.this.hour=hour;
                MainActivity.this.minute=minute;
                show(year, month, date, hour, minute);
            }
        });
    }

    private void show(int year, int month, int day, int hour, int minute)
    {
        String str=year + "-" + (month + 1) + "-" + day + " " + hour + ":" + minute + " ";
        showTime.setText(str);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu)
    {
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

}
