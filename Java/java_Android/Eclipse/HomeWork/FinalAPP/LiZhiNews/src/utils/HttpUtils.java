package utils;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.ref.SoftReference;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.util.HashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Environment;
import android.os.Handler;
import android.support.v4.util.LruCache;
import android.util.Log;
import android.widget.ImageView;
import android.widget.Toast;

public class HttpUtils {
	//内部接口
	public interface OnNetWorkRespond{
		public void OnNetWorkOk(String json);
		public void onNetWorkError(String error);
	}
	public interface OnDownLoadImage{
		public void OnDownLoadOK();
		public void OnDownLoadError();
	}
	//线程池
	private static ExecutorService threadPool=Executors.newFixedThreadPool(3);
	//软引用
	private static HashMap<String, SoftReference<Bitmap>> softCache=new HashMap<String, SoftReference<Bitmap>>();
	private static HashMap<String, SoftReference<String>> softCacheString=new HashMap<String, SoftReference<String>>();
	//lruCache 
	private static LruCache<String, Bitmap> lruCache=new LruCache<String, Bitmap>((int) (Runtime.getRuntime().maxMemory()/8)){
		protected int sizeOf(String key, Bitmap value) {
			return value.getRowBytes()*value.getHeight();
		};
		protected void entryRemoved(boolean evicted, String key, Bitmap oldValue, Bitmap newValue) {
			if(evicted){
				SoftReference<Bitmap> soft=new SoftReference<Bitmap>(oldValue);
				softCache.put(key, soft);
			}
		};
	};
	private static LruCache<String, String> lruCacheString=new LruCache<String, String>((int) (Runtime.getRuntime().maxMemory()/8)){
		protected int sizeOf(String key, String value) {
			return value.getBytes().length;
		};
		protected void entryRemoved(boolean evicted, String key, String oldValue, String newValue) {
			if(evicted){
				SoftReference<String> soft=new SoftReference<String>(oldValue);
				softCacheString.put(key, soft);
			}
		};
	};

	public static void isRefresh(final Context context, final String path,
			final OnNetWorkRespond respond) {
		final Handler handler = new Handler();
		threadPool.execute(new Runnable() {

			@Override
			public void run() {
				URL url;
				try {
					url = new URL(path);
					HttpURLConnection conn = (HttpURLConnection) url
							.openConnection();
					conn.setRequestMethod("GET");
					conn.setConnectTimeout(5000);
					int respondCode = conn.getResponseCode();
					
					if (respondCode != 200) {
						try {
							Thread.sleep(500);
						} catch (InterruptedException e) {
							e.printStackTrace();
						}
						Toast.makeText(context, "服务器连接失败", Toast.LENGTH_LONG).show();
						respond.onNetWorkError("服务器连接失败");
						return;
					}
					handler.post(new Runnable() {
						
						@Override
						public void run() {
							refreshingJson(context,path,respond);
						}
					});
				} catch (MalformedURLException e) {
					e.printStackTrace();
				} catch (ProtocolException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}

			}
		});
	}
	private static void refreshingJson(Context context,String path,OnNetWorkRespond respond){
			File root=null;
			if(Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)){
				root=context.getExternalCacheDir();
			}else{
				root=context.getCacheDir();
			}
			if(root!=null&&root.exists()){
				File[]files=root.listFiles();
				for(File f:files){
					if(f.getName().endsWith(".txt")){
						f.delete();
					}
				}
			}
			getJson(context,path,respond);
			
		
	}
	//缓存到android 缓存路径
	private static File getFilePath(Context context,String path){
		File root=null;
		if(Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)){
			root=context.getExternalCacheDir();
		}else{
			root=context.getCacheDir();
		}
		String[] arr=path.split("/");
		String name=arr[arr.length-1];
		return new File(root, name);
	}
	private static File getImagePath(Context context,String path){
		File root=null;
		if(Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)){
			root=Environment.getExternalStorageDirectory();
		}else{
			root=context.getCacheDir();
		}
		
		File dir=new File(root+"/喵喵新闻");
		if(!dir.exists()){
			dir.mkdir();
		}
		String[] arr=path.split("/");
		String name=arr[arr.length-1];
		return new File(dir, name);
	}
	//三级缓存取JSON
	public static void LoadJsonString(Context context,String path,OnNetWorkRespond respond){
		String json=lruCacheString.get(path);
		if(json!=null){
			respond.OnNetWorkOk(json);
			return;
		}
		SoftReference<String> softReference=softCacheString.get(path);
		if(softReference!=null){
			json=softReference.get();
			if(json!=null){
				lruCacheString.put(path, json);
				respond.OnNetWorkOk(json);
				return;
			}
		}
		File file=getFilePath(context, path+".txt");
		if(file!=null&&file.exists()){
			FileInputStream inputStream=null;
			ByteArrayOutputStream outputStream=null;
			try {
				inputStream=new FileInputStream(file);
				outputStream=new ByteArrayOutputStream();
				byte[] buffer=new byte[1024];
				int len=inputStream.read(buffer, 0, 1024);
				while(len!=-1){
					outputStream.write(buffer, 0, len);
					len=inputStream.read(buffer, 0, 1024);
				}
				outputStream.flush();
				json=outputStream.toString();
				respond.OnNetWorkOk(json);
				return;
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}finally{
				if(outputStream!=null){
					try {
						outputStream.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				if(inputStream!=null){
					try {
						inputStream.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
		getJson(context,path, respond);
	}
	public static void showImage(Context context,String path,ImageView imageView){
		imageView.setTag(path);
		Bitmap bitmap=lruCache.get(path);
		if(bitmap!=null){
			imageView.setImageBitmap(bitmap);
			return;
		}
		SoftReference<Bitmap> softReference=softCache.get(path);
		if(softReference!=null){
			bitmap=softReference.get();
			if(bitmap!=null){
				imageView.setImageBitmap(bitmap);
				lruCache.put(path, bitmap);
				return;
			}
		}
		File file=getFilePath(context, path);
		if(file!=null&&file.exists()){
			bitmap=BitmapFactory.decodeFile(file.getPath());
			if(bitmap!=null){
				imageView.setImageBitmap(bitmap);
				lruCache.put(path, bitmap);
			}
			return;
		}
		downLoadImage(context, path, imageView);
	}
	private static void downLoadImage(final Context context,final String path,final ImageView imageView){
		final Handler handler=new Handler();
		threadPool.execute(new Runnable() {
			
			@Override
			public void run() {
				FileOutputStream outputStream=null;
				InputStream is=null;
				try {
					URL url=new URL(path);
					HttpURLConnection conn=(HttpURLConnection) url.openConnection();
					conn.setRequestMethod("GET");
					conn.setConnectTimeout(5000);
					conn.connect();
					int respondCode=conn.getResponseCode();
					if(respondCode==HttpURLConnection.HTTP_OK){
						is=conn.getInputStream();
						final Bitmap bitmap=BitmapFactory.decodeStream(is);
						File file= getFilePath(context, path);
						outputStream=new FileOutputStream(file);
						bitmap.compress(Bitmap.CompressFormat.PNG, 100, outputStream);
						outputStream.flush();
						lruCache.put(path, bitmap);
						handler.post(new Runnable() {
							
							@Override
							public void run() {
								String p=(String) imageView.getTag();
								if(p.equals(path)){
									imageView.setImageBitmap(bitmap);
								}
							}
						});
					}
					
				} catch (MalformedURLException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}finally{
					if(is!=null){
						try {
							is.close();
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
					if(outputStream!=null){
						try {
							outputStream.close();
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				}
			}
		});
		
	}
	//下载图片
	public static void downLoadImage(final Context context,final String path,final OnDownLoadImage downloader){
		final Handler handler=new Handler();
		threadPool.execute(new Runnable() {
			
			@Override
			public void run() {
				FileOutputStream outputStream=null;
				InputStream is=null;
				try {
					URL url=new URL(path);
					HttpURLConnection conn=(HttpURLConnection) url.openConnection();
					conn.setRequestMethod("GET");
					conn.setConnectTimeout(5000);
					conn.connect();
					int respondCode=conn.getResponseCode();
					if(respondCode==HttpURLConnection.HTTP_OK){
						is=conn.getInputStream();
						final Bitmap bitmap=BitmapFactory.decodeStream(is);
						File file= getImagePath(context, path);
						Log.i("图片存储路径", file.getPath());
						Log.i("图片存储路径", file.getPath());
						Log.i("图片存储路径", file.getPath());
						outputStream=new FileOutputStream(file);
						bitmap.compress(Bitmap.CompressFormat.PNG, 100, outputStream);
						outputStream.flush();
						handler.post(new Runnable() {
							
							@Override
							public void run() {
								downloader.OnDownLoadOK();
							}
						});
					}
					
				} catch (MalformedURLException e) {
					e.printStackTrace();
					handler.post(new Runnable() {
						
						@Override
						public void run() {
							downloader.OnDownLoadError();;
						}
					});
				} catch (IOException e) {
					e.printStackTrace();
					handler.post(new Runnable() {
						
						@Override
						public void run() {
							downloader.OnDownLoadError();;
						}
					});
				}finally{
					if(is!=null){
						try {
							is.close();
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
					if(outputStream!=null){
						try {
							outputStream.close();
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				}
			}
		});
		
	}
	//���JSON
	private static void getJson(final Context context,final String path,final OnNetWorkRespond respond){
		final Handler handler=new Handler();
		threadPool.execute(new Runnable() {
			InputStream inputStream=null;
			FileOutputStream fos=null;
			@Override
			public void run() {
				try {
					StringBuilder sb=new StringBuilder();
					URL url=new URL(path);
					HttpURLConnection conn=(HttpURLConnection) url.openConnection();
					conn.setRequestMethod("GET");
					conn.setConnectTimeout(5000);
					int respondCode=conn.getResponseCode();
					if(respondCode==HttpURLConnection.HTTP_OK){
						inputStream=conn.getInputStream();
						File file=getFilePath(context, path+".txt");
						fos=new FileOutputStream(file);
						byte[]buffer=new byte[1024];
						int len=inputStream.read(buffer, 0, 1024);
						while(len!=-1){
							sb.append(new String(buffer,0,len));
							fos.write(buffer, 0, len);
							len=inputStream.read(buffer, 0, 1024);
						}
						final String json=sb.toString();
						lruCacheString.put(path, json);
						handler.post(new Runnable() {
							
							@Override
							public void run() {
								respond.OnNetWorkOk(json);
							}
						});
					}else{
						handler.post(new Runnable() {
							
							@Override
							public void run() {
								respond.onNetWorkError("下载失败");
							}
						});
					}
				} catch (IOException e) {
					e.printStackTrace();
					handler.post(new Runnable() {
						
						@Override
						public void run() {
							respond.onNetWorkError("无法连接服务器");
						}
					});
				}finally{
					if(inputStream!=null){
						try {
							inputStream.close();
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
					if(fos!=null){
						try {
							fos.close();
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				}
			}
		});
	}
	//����JSON
	public static void downLoadJson(final Context context,final String path,final OnNetWorkRespond respond){
		final Handler handler=new Handler();
		threadPool.execute(new Runnable() {
			InputStream inputStream=null;
			ByteArrayOutputStream outputStream=null;
			@Override
			public void run() {
				try {
					URL url=new URL(path);
					HttpURLConnection conn=(HttpURLConnection) url.openConnection();
					conn.setRequestMethod("GET");
					conn.setConnectTimeout(5000);
					int respondCode=conn.getResponseCode();
					if(respondCode==HttpURLConnection.HTTP_OK){
						inputStream=conn.getInputStream();
						outputStream=new ByteArrayOutputStream();
						byte[]buffer=new byte[1024];
						int len=inputStream.read(buffer, 0, 1024);
						while(len!=-1){
							outputStream.write(buffer, 0, len);
							len=inputStream.read(buffer, 0, 1024);
						}
						outputStream.flush();
						final String json=outputStream.toString();
						handler.post(new Runnable() {
							
							@Override
							public void run() {
								respond.OnNetWorkOk(json);
							}
						});
					}else{
						handler.post(new Runnable() {
							
							@Override
							public void run() {
								respond.onNetWorkError("下载失败�");
							}
						});
					}
				} catch (IOException e) {
					e.printStackTrace();
					handler.post(new Runnable() {
						
						@Override
						public void run() {
							respond.onNetWorkError("下载失败");
						}
					});
				}finally{
					if(inputStream!=null){
						try {
							inputStream.close();
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
					if(outputStream!=null){
						try {
							outputStream.close();
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				}
			}
		});
	}
}
