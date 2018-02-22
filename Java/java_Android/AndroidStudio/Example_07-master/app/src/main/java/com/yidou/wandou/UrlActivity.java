package com.yidou.wandou;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.webkit.WebView;

public class UrlActivity extends AppCompatActivity
{
    private WebView mWebView;
    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_url);
        initViews();
    }

    private void initViews()
    {
        mWebView = (WebView) this.findViewById(R.id.webView);
        Intent it = getIntent();
        String url = it.getStringExtra("info");
        Log.e("info", url);
        mWebView.loadUrl(url);
    }
}
