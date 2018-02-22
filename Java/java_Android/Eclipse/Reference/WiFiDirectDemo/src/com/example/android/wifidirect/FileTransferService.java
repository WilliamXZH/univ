// Copyright 2011 Google Inc. All Rights Reserved.

package com.example.android.wifidirect;

import android.app.IntentService;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.util.Log;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.net.Socket;

/**
 * 文件远程传输服务
 * A service that process each file transfer request i.e Intent by opening a
 * socket connection with the WiFi Direct Group Owner and writing the file
 */
public class FileTransferService extends IntentService
{

	private static final int SOCKET_TIMEOUT = 5000;
	public static final String ACTION_SEND_FILE = "com.example.android.wifidirect.SEND_FILE";
	public static final String EXTRAS_FILE_PATH = "file_url";
	public static final String EXTRAS_GROUP_OWNER_ADDRESS = "go_host";
	public static final String EXTRAS_GROUP_OWNER_PORT = "go_port";

	public FileTransferService(String name)
	{
		super(name);
	}

	public FileTransferService()
	{
		super("FileTransferService");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see android.app.IntentService#onHandleIntent(android.content.Intent)
	 */
	@Override
	protected void onHandleIntent(Intent intent)
	{

		Context context = getApplicationContext();
		if (intent.getAction().equals(ACTION_SEND_FILE))
		{
			//获取要传输的文件地址URI
			String fileUri = intent.getExtras().getString(EXTRAS_FILE_PATH);
			//获取要连接的远程主机地址
			String host = intent.getExtras().getString(
					EXTRAS_GROUP_OWNER_ADDRESS);
			Socket socket = new Socket();
			//获取要连接的远程主机地址的端口号
			int port = intent.getExtras().getInt(EXTRAS_GROUP_OWNER_PORT);

			try
			{
				Log.d(WiFiDirectActivity.TAG, "Opening client socket - ");				
				socket.bind(null);
				//连接到远程主机
				socket.connect((new InetSocketAddress(host, port)),
						SOCKET_TIMEOUT);

				Log.d(WiFiDirectActivity.TAG,
						"Client socket - " + socket.isConnected());
				//获取输出流
				OutputStream stream = socket.getOutputStream();
				ContentResolver cr = context.getContentResolver();
				InputStream is = null;
				try
				{
					//通过ContentResolver获取要传输的文件所对应的输入流
					is = cr.openInputStream(Uri.parse(fileUri));
				} catch (FileNotFoundException e)
				{
					Log.d(WiFiDirectActivity.TAG, e.toString());
				}
				//将文件从输入流中拷贝到输出流，即发送到远程主机端
				DeviceDetailFragment.copyFile(is, stream);
				Log.d(WiFiDirectActivity.TAG, "Client: Data written");
			} catch (IOException e)
			{
				Log.e(WiFiDirectActivity.TAG, e.getMessage());
			} finally
			{
				if (socket != null)
				{
					if (socket.isConnected())
					{
						try
						{
							socket.close();
						} catch (IOException e)
						{
							// Give up
							e.printStackTrace();
						}
					}
				}
			}

		}
	}
}
