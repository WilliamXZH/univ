import java.io.*;
import java.net.*;
public class DataDownUtil
{
	public static String GetHtmlResourceByUrl(String url,String encoding){
		//存储临时文件
		StringBuffer buffer=new StringBuffer();
		URL urlObj=null;
		URLConnection uc=null;
		InputStreamReader isr=null;
		BufferedReader reader=null;

		try{
			//建立网络连接
			urlObj=new URL(url);
			//打开网络结构
			uc=urlObj.openConnection();
			//建立文件写入流
			isr=new InputStreamReader(uc.getInputStream(),encoding);
			//建立缓冲流
			reader=new BufferedReader(isr);
			//建立临时文件
			String temp=null;
			while((temp=reader.readLine())!=null){
				buffer.append(temp);//追加内容，一边读，一边写
			}


		}catch(MalformedURLException e){
			e.printStackTrace();
			System.out.println("世界上最遥远的距离就是没网。检查设置");
		}catch(IOException e){
			e.printStackTrace();
			System.out.println("打开网络连接失败，请重新尝试");
		}finally{
			if(isr!=null){
				try{
					isr.close();
				}catch(IOException e){
					e.printStackTrace();
				}
			}
		}
		return buffer.toString();
	}
	public static void main(String []args){
		//String url="http://hotels.ctrip.com/hotel/beijing1#ctm_ref=hod_hp_sb_1st";
		String url="http://www.cnmooc.org/home/login.mooc?historyUrl=L3BvcnRhbC9teUNvdXJzZUluZGV4LzEubW9vYw%3D%3D";
		String encoding="utf-8";


		//1.根据网址和页面的编码集获网页的源代码
		String html=GetHtmlResourceByUrl(url,encoding);
		System.out.print(html);
		//2.解析源代码
		//3.


	}
}