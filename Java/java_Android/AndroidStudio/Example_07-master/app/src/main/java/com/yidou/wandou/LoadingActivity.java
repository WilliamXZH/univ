package com.yidou.wandou;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.animation.AlphaAnimation;
import android.view.animation.Animation;
import android.widget.ImageView;

public class LoadingActivity extends AppCompatActivity
{
    private ImageView mImageView;
    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_loading);
        initViews();
    }

    private void initViews()
    {
        mImageView = (ImageView) this.findViewById(R.id.image_loading);
        AlphaAnimation animation = new AlphaAnimation(0.0f, 1.0f);
        animation.setDuration(5000);
        mImageView.setAnimation(animation);
        animation.setAnimationListener(new Animation.AnimationListener()
        {
            @Override
            public void onAnimationStart(Animation animation)
            {
                //这里可以进行网络的判断
            }

            @Override
            public void onAnimationEnd(Animation animation)
            {
                Intent it = new Intent(LoadingActivity.this, MainActivity.class);
                startActivity(it);
                LoadingActivity.this.finish();
            }

            @Override
            public void onAnimationRepeat(Animation animation)
            {

            }
        });
        animation.start();
    }
}
