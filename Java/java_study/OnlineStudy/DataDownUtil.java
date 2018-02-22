import java.io.*;
import java.net.*;
public class DataDownUtil
{
	public static String GetHtmlResourceByUrl(String url,String encoding){
		//�洢��ʱ�ļ�
		StringBuffer buffer=new StringBuffer();
		URL urlObj=null;
		URLConnection uc=null;
		InputStreamReader isr=null;
		BufferedReader reader=null;

		try{
			//������������
			urlObj=new URL(url);
			//������ṹ
			uc=urlObj.openConnection();
			//�����ļ�д����
			isr=new InputStreamReader(uc.getInputStream(),encoding);
			//����������
			reader=new BufferedReader(isr);
			//������ʱ�ļ�
			String temp=null;
			while((temp=reader.readLine())!=null){
				buffer.append(temp);//׷�����ݣ�һ�߶���һ��д
			}


		}catch(MalformedURLException e){
			e.printStackTrace();
			System.out.println("��������ңԶ�ľ������û�����������");
		}catch(IOException e){
			e.printStackTrace();
			System.out.println("����������ʧ�ܣ������³���");
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


		//1.������ַ��ҳ��ı��뼯����ҳ��Դ����
		String html=GetHtmlResourceByUrl(url,encoding);
		System.out.print(html);
		//2.����Դ����
		//3.


	}
}