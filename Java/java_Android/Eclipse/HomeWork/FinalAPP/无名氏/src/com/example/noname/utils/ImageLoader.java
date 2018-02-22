package com.example.noname.utils;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.widget.ImageView;

import com.example.noname.utils.HttpUtils.OnBitmapNetWorkResponse;

/**
 * 加载图片
 * 
 * 
 */
public class ImageLoader {

	private static HashMap<String, Bitmap> cache = new HashMap<String, Bitmap>();

	public static void loadImage(final Context context,
			final ImageView imageView, final String path) {

		// 从 缓存中取图片
		Bitmap bitmap = cache.get(path);
		if (bitmap != null) {
			imageView.setImageBitmap(bitmap);
			return;
		}

		// 从 内置存储器中取图片
		File imageFile = getImageFile(context, path);
		// 文件存在
		if (imageFile.exists()) {
			//最后的修改时间
			imageFile.setLastModified(System.currentTimeMillis());
			bitmap = BitmapFactory.decodeFile(imageFile.getPath());
			imageView.setImageBitmap(bitmap);
			// 加载到缓存中
			cache.put(path, bitmap);
			return;
		}

		// 从网上下载图片
		HttpUtils.RequestBitmapNetWork(path, new OnBitmapNetWorkResponse() {

			@Override
			public void ok(Bitmap bitmap) {
				imageView.setImageBitmap(bitmap);
				// 放到缓存中
				cache.put(path, bitmap);

				deleteCache(context);

				// 放到内置存储器中
				File file = getImageFile(context, path);

				FileOutputStream out = null;
				try {
					out = new FileOutputStream(file);
					bitmap.compress(Bitmap.CompressFormat.PNG, 100, out);

				} catch (FileNotFoundException e) {
					e.printStackTrace();
				} finally {
					if (out != null) {
						try {
							out.close();
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				}

			}

			@Override
			public void error(String error) {

			}
		});

	}

	private static File getImageFile(Context context, final String path) {
		File cacheDir = context.getCacheDir();
		String[] split = path.split("/");
		File imageFile = new File(cacheDir, split[split.length - 1]);
		return imageFile;
	}

	/**
	 * 删除 缓存文件，控制缓存空间大小
	 * 
	 * @param context
	 */
	private static void deleteCache(Context context) {

		File cacheDir = context.getCacheDir();
		File[] listFiles = cacheDir.listFiles();
		// 文件夹的大小
		long length = 0;
		for (File file : listFiles) {
			length += file.length();
		}

		// 缓存的空间是不是大于5M
		if (5 * 1024 * 1024 > length) {
			return;
		}
		
		Arrays.sort(listFiles, new Comparator<File>() {
			// 1 < 2  负数  1 >2 正数  1=2  0 
			@Override
			public int compare(File lhs, File rhs) {
				return (int)(lhs.lastModified()-rhs.lastModified());
			}
		});
		
		for (int i = 0; i < listFiles.length/2; i++) {
			listFiles[i].delete();
		}
	}

}
