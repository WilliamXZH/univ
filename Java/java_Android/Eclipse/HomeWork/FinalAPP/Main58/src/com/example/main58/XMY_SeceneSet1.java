package com.example.main58;

import java.util.HashMap;

import android.app.Activity;
import android.content.res.Configuration;
import android.os.Bundle;
import android.os.Handler;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.view.ViewGroup.LayoutParams;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.ScrollView;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;

/**
 * 首页场景设置
 * 
 * @author xumy
 * 
 */
public class XMY_SeceneSet1 extends Activity {
	private HashMap<Integer, Object[]> mapStatus = new HashMap<Integer, Object[]>();
	// private int mPosition;
	private ImageButton imgBack;
	private TextView txtTitle;
	private TableLayout page_view;
	private View view;
	private ScrollView scrollView;
	/**
	 * 列
	 */
	private int COL = 4;

	/**
	 * 行
	 */
	// private int ROW = 3;
	private LayoutInflater inflate;
	private final int FP = ViewGroup.LayoutParams.MATCH_PARENT;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setContentView(R.layout.xmy_seceneset1);
		mapStatus.put(0, new Object[] { 0, 0, 0, R.drawable.ic_launcher,
				R.drawable.ic_launcher });
		mapStatus.put(1, new Object[] { 0, 0, 0, R.drawable.ic_launcher,
				R.drawable.ic_launcher });
		mapStatus.put(2, new Object[] { 0, 0, 0, R.drawable.ic_launcher,
				R.drawable.ic_launcher });
		mapStatus.put(3, new Object[] { 0, 0, 0, R.drawable.ic_launcher,
				R.drawable.ic_launcher });
		mapStatus.put(4, new Object[] { 0, 0, 0, R.drawable.ic_launcher,
				R.drawable.ic_launcher });
		mapStatus.put(5, new Object[] { 0, 0, 0, R.drawable.ic_launcher,
				R.drawable.ic_launcher });
		mapStatus.put(6, new Object[] { 0, 0, 0, R.drawable.ic_launcher,
				R.drawable.ic_launcher });
		mapStatus.put(7, new Object[] { 0, 0, 0, R.drawable.ic_launcher,
				R.drawable.ic_launcher });
		mapStatus.put(8, new Object[] { 0, 0, 0, R.drawable.ic_launcher,
				R.drawable.ic_launcher });
		mapStatus.put(9, new Object[] { 0, 0, 0, R.drawable.ic_launcher,
				R.drawable.ic_launcher });
		mapStatus.put(10, new Object[] { 0, 0, 0, R.drawable.ic_launcher,
				R.drawable.ic_launcher });
		mapStatus.put(11, new Object[] { 0, 0, 0, R.drawable.ic_launcher,
				R.drawable.ic_launcher });
		mapStatus.put(12, new Object[] { 0, 0, 0, R.drawable.ic_launcher,
				R.drawable.ic_launcher });
		mapStatus.put(13, new Object[] { 0, 0, 0, R.drawable.ic_launcher,
				R.drawable.ic_launcher });
		mapStatus.put(14, new Object[] { 0, 0, 0, R.drawable.ic_launcher,
				R.drawable.ic_launcher });
		mapStatus.put(15, new Object[] { 0, 0, 0, R.drawable.ic_launcher,
				R.drawable.ic_launcher });
		mapStatus.put(16, new Object[] { 0, 0, 0, R.drawable.ic_launcher,
				R.drawable.ic_launcher });
		mapStatus.put(17, new Object[] { 0, 0, 0, R.drawable.ic_launcher,
				R.drawable.ic_launcher });
		mapStatus.put(18, new Object[] { 0, 0, 0, R.drawable.ic_launcher,
				R.drawable.ic_launcher });
		scrollView = (ScrollView) findViewById(R.id.scrollview);

		inflate = LayoutInflater.from(this);
		init();
	}

	

	private RelativeLayout rel = null;
	private TextView txt = null;

	/**
	 * 初始化主页图标
	 */
	public void init() {
		int j = 0;
		page_view = new TableLayout(this);
		page_view.setStretchAllColumns(true);
		int m = 0;
		int len = mapStatus.size();
		int length = mapStatus.size() / COL;
		int lens = len % COL;
		boolean bol = false;
		if (lens != 0) {
			length += 1;
			bol = true;
		}
		for (; j < length; j++) {
			final int n = j;
			final int l = m + 100;
			TableRow tableRow = new TableRow(this);
			int length1 = COL;
			if (bol) {
				if (j == length - 1) {
					length1 = lens;
				}
			}
			for (int col = 0; col < length1; col++) {
				final View view = inflate.inflate(R.layout.xmy_secene_item,
						null);
				final TextView txtOne = (TextView) view
						.findViewById(R.id.title);

				txtOne.setText("厨房");
				txtOne.setTag(l);
				txtOne.setOnClickListener(new TxtClick(m, n, txtOne));
				Object[] p = mapStatus.get(m);
				if (Integer.parseInt(p[0].toString()) == 1
						&& Integer.parseInt(p[1].toString()) == 1) {
					txtOne.setCompoundDrawablesWithIntrinsicBounds(0,
							Integer.parseInt(p[3].toString()), 0,
							R.drawable.xmy_secene_trigon);
				} else {
					if (Integer.parseInt(p[0].toString()) == 0
							&& Integer.parseInt(p[1].toString()) == 0) {
						txtOne.setCompoundDrawablesWithIntrinsicBounds(0,
								Integer.parseInt(p[4].toString()), 0,
								R.drawable.xmy_secene_trigon1);
					} else {
						txtOne.setCompoundDrawablesWithIntrinsicBounds(0,
								Integer.parseInt(p[3].toString()), 0,
								R.drawable.xmy_secene_trigon1);
					}
				}
				tableRow.addView(view);
				m++;
			}
			page_view.addView(tableRow, new TableLayout.LayoutParams(FP,
					LayoutParams.WRAP_CONTENT));
			// page_view.setLayoutParams(new LayoutParams(FP, FP));
			tableRow = new TableRow(this);
			View view = inflate.inflate(R.layout.xmy_folder_view, null);
			view.setTag(n);
			page_view.addView(view, new TableLayout.LayoutParams(FP,
					LayoutParams.WRAP_CONTENT));
			page_view.setLayoutParams(new LayoutParams(FP,
					LayoutParams.WRAP_CONTENT));
		}
		// scrollView.removeAllViews();
		scrollView.addView(page_view);
	}

	private int clickPosition;

	class TxtClick implements OnClickListener {
		private int mPosition;
		private int mTag;
		private TextView mTxtView;

		public TxtClick(int position, int tag, TextView txtView) {
			mPosition = position;
			mTag = tag;
			mTxtView = txtView;
		}

		@Override
		public void onClick(View v) {
			if (rel == null) {
				rel = (RelativeLayout) page_view.findViewWithTag(mTag);
				showSeceneTemperature(rel);
				rel.setVisibility(View.VISIBLE);
				txt = mTxtView;
				txt.setCompoundDrawablesWithIntrinsicBounds(0,
						R.drawable.ic_launcher, 0,
						R.drawable.xmy_secene_trigon);
			} else {
				if (rel.getVisibility() == View.VISIBLE) {
					rel.setVisibility(View.GONE);
					txt.setCompoundDrawablesWithIntrinsicBounds(0,
							R.drawable.ic_launcher, 0,
							R.drawable.xmy_secene_trigon1);

				} else if (rel.getVisibility() == View.GONE) {
					if (clickPosition == mPosition) {
						showSeceneTemperature(rel);
						rel.setVisibility(View.VISIBLE);
						txt.setCompoundDrawablesWithIntrinsicBounds(0,
								R.drawable.ic_launcher, 0,
								R.drawable.xmy_secene_trigon);
					}
				}
				if (clickPosition != mPosition) {
					rel = (RelativeLayout) page_view.findViewWithTag(mTag);
					showSeceneTemperature(rel);
					rel.setVisibility(View.VISIBLE);
					
					txt = mTxtView;
					txt.setCompoundDrawablesWithIntrinsicBounds(0,
							R.drawable.ic_launcher, 0,
							R.drawable.xmy_secene_trigon);
				}
			}

			clickPosition = mPosition;
		}

	}

	private void showSeceneTemperature(View view) {
	}

	Handler handler = new Handler() {
		public void handleMessage(android.os.Message msg) {
			switch (msg.what) {
			}
		};
	};
	
}
