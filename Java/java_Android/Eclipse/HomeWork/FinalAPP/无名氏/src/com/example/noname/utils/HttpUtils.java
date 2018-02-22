package com.example.noname.utils;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.nio.ByteOrder;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Handler;

/**
 * 封装的 网络 + 线程
 */
public class HttpUtils {

	// 使用线程池来下载图片，同一时刻，最多有3个线程在运行
	private static ExecutorService execuotrs = Executors.newFixedThreadPool(3);

	interface OnBitmapNetWorkResponse {
		public void ok(Bitmap bitmap);

		public void error(String error);
	}

	public static void RequestBitmapNetWork(final String path,
			final OnBitmapNetWorkResponse response) {
		
		final Handler handler = new Handler();

		execuotrs.execute(new Runnable() {
			@Override
			public void run() {
				boolean isNetWorkOK = false;
				try {
					URL url = new URL(path);
					HttpURLConnection openConnection = (HttpURLConnection) url
							.openConnection();
					openConnection.setConnectTimeout(5000);
					openConnection.connect();
					if (openConnection.getResponseCode() == 200) {
						InputStream inputStream = openConnection
								.getInputStream();
						final Bitmap bitmap = BitmapFactory
								.decodeStream(inputStream);

						handler.post(new Runnable() {

							@Override
							public void run() {
								response.ok(bitmap);
							}
						});

						inputStream.close();
						isNetWorkOK = true;
					}

				} catch (MalformedURLException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				} finally {
					if (!isNetWorkOK) {
						handler.post(new Runnable() {

							@Override
							public void run() {
								response.error("服务器不在服务区内！");
							}
						});

					}

				}

			}
		});
	}

	public interface OnNetWorkResponse {
		public void ok(String response);

		public void error(String error);
	}

	public static void RequestNetWork(final String path,
			final OnNetWorkResponse response) {
		//实例化handler 
		final Handler hanlder = new Handler();

		new Thread() {
			public void run() {
				//标志位
				boolean isWorkOK = false;
				
				InputStream inputStream = null;
				ByteArrayOutputStream outStream = null;
				try {
					URL url = new URL(path);
					System.out.println("=======path========="+path);
					
					HttpURLConnection connection = (HttpURLConnection) url
							.openConnection();
					connection.setConnectTimeout(5000);
					connection.setDoInput(true);
					connection.connect();

					if (connection.getResponseCode() == 200) {
						inputStream = connection.getInputStream();
						outStream = new ByteArrayOutputStream();

						byte[] b = new byte[1024];
						int len = 0;
						while ((len = inputStream.read(b)) != -1) {
							outStream.write(b, 0, len);
						}
						outStream.flush();
						final String result = new String(
								outStream.toByteArray());

						hanlder.post(new Runnable() {

							@Override
							public void run() {
								response.ok(result);
							}
						});

						isWorkOK = true;
					}

				} catch (MalformedURLException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				} finally {
					// 网络操作出问题
					if (!isWorkOK) {
						response.error("服务器走神拉！");
					}

					if (inputStream != null) {
						try {
							inputStream.close();
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
					if (outStream != null) {
						try {
							outStream.close();
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				}

			};
		}.start();

	}

}
