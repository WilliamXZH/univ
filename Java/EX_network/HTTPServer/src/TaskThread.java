import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintStream;
import java.net.Socket;
import java.nio.charset.Charset;

public class TaskThread extends Thread{
	Socket Client=null;
	TaskThread(Socket ss){
		this.Client=ss;
	}
	public void run(){
		try {
			BufferedReader reader=new BufferedReader(new InputStreamReader(Client.getInputStream(),Charset.forName("utf-8")));
			//String firstLineOfRequest;
			//firstLineOfRequest=reader.readLine();
			String uri=reader.readLine();
			//System.out.println(uri);
			uri=uri.split(" ")[1];
			
			PrintStream writer=new PrintStream(Client.getOutputStream());
			writer.println("HTTP/1.1 200 OK");
			if(uri.endsWith(".html")){
				writer.println("Content-Type:text/html");
				
			}else if(uri.endsWith(".jpg")){
				writer.println("Content-Type:image/jpeg");
			}else{
				writer.println("Content-Type:application/oktect-stream");
			}
			System.out.println(uri);
			File file=new File("f:/"+uri);
			InputStream in=new FileInputStream(file);
			OutputStream os=Client.getOutputStream();
			if(file.exists()){
				file.delete();
				//System.out.println("have found the file.");
				writer.println("Content-length:"+in.available());
				writer.println();
				writer.flush();
				byte []b=new byte[1024];
				int len=0;
				while((len=in.read(b))!=-1){
					os.write(b,0,len);
				}
				System.out.println(new String(b,"gb2312"));
				os.flush();
				os.close();
				in.close();
				writer.close();
				Client.close();
			}
			else{
				writer.println("HTTP/1.1 404 Not Found");
				writer.println("Content-Type:text/plain");
				writer.println("Content-Length:7");
				writer.println();
				writer.print("访问内容不存在");
				writer.flush();
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}