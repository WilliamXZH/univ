package utils;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.lang.ref.SoftReference;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Environment;
import android.support.v4.util.LruCache;
import com.android.volley.toolbox.ImageLoader.ImageCache;

public class MyImageCache implements ImageCache{
	private LruCache<String, Bitmap> lruCache;
	private HashMap<String, SoftReference<Bitmap>> sofeCache;
	private Context applicationContext;
	private static MyImageCache myImageCache;
	//ApplicationContext
	public static MyImageCache getInstance(Context applicationContext){
		if(myImageCache==null){
			myImageCache=new MyImageCache(applicationContext);
		}
		return myImageCache;
	}
	private MyImageCache(Context applicationContext){
		this.applicationContext=applicationContext;
		int maxSize=(int)(Runtime.getRuntime().maxMemory()/8);
		lruCache=new LruCache<String, Bitmap>(maxSize){
			@Override
			protected int sizeOf(String key, Bitmap value) {
				return value.getRowBytes()*value.getHeight();
			}
			@Override
			protected void entryRemoved(boolean evicted, String key,
					Bitmap oldValue, Bitmap newValue) {
				super.entryRemoved(evicted, key, oldValue, newValue);
				//放入软引用
				if(evicted){
					sofeCache.put(key, new SoftReference<Bitmap>(oldValue));
				}
			}
		};
		sofeCache=new HashMap<String, SoftReference<Bitmap>>();
	}
	@Override
	public Bitmap getBitmap(String url) {
		//1.从LruCache中取图片
		Bitmap bitmap=lruCache.get(url);
		if(bitmap!=null){
			return bitmap;
		}
		//2.从软引用中取
		SoftReference<Bitmap> reference=sofeCache.get(url);
		if(reference!=null){
			bitmap=reference.get();
			if(bitmap!=null){
				lruCache.put(url, bitmap);
				return bitmap;
			}
		}
		//3.从本地取图片
		File imageFile=getImageFile(url);
		if(imageFile!=null&&imageFile.exists()){
			bitmap=BitmapFactory.decodeFile(imageFile.getPath());
			if(bitmap!=null){
				//设置最近修改时间
				imageFile.setLastModified(System.currentTimeMillis());
				return bitmap;
			}
		}
		return null;
	}
	//保存图片
	@Override
	public void putBitmap(String url, Bitmap bitmap) {
		//首先判断是否需要删除图片
		deleteCacheFiles();
		lruCache.put(url, bitmap);
		//存图片到本地
		File imageFile=getImageFile(url);
		FileOutputStream outputStream=null;
		try {
			outputStream=new FileOutputStream(imageFile);
			bitmap.compress(Bitmap.CompressFormat.PNG, 100, outputStream);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}finally{
			if(outputStream!=null){
				try {
					outputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	//文件完整路径
	private File getImageFile(String url){
		File dir = getCacheDir();
		String[] array=url.split("/");
		String name=array[array.length-1];
		File file=new File(dir, name);
		return file;
		
	}
	//得到根目录
	private File getCacheDir() {
		File root=null;
		if(Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)){
			root=applicationContext.getExternalCacheDir();
		}else{
			root=applicationContext.getCacheDir();
		}
		return root;
	}
	private void deleteCacheFiles(){
		//计算所有图片的大小
		File cacheDir=getCacheDir();
		File[]files=cacheDir.listFiles();
		long length=0;
		for(int i=0;i<files.length;i++){
			length+=files[i].length();
		}
		
		if(length<=10*1024*1024){
			return;
		}
		//对图片进行排序
		Arrays.sort(files,new Comparator<File>() {

			@Override
			public int compare(File lhs, File rhs) {
				return (int) (lhs.lastModified()-rhs.lastModified());
			}
		});
		//删除图片
		for(int i=0;i<files.length/2;i++){
			files[i].delete();
		}
	}
}
