import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintStream;
import java.net.Socket;

public class Client {
	public static void main(String[] args){
		try {
			String filename="login.html";
			//String filename="ios.jpg";
			String savelocation="d:/";
			Socket s=new Socket("127.0.0.1",8888);
			PrintStream writer =new PrintStream(s.getOutputStream());
			writer.println("GET /"+filename+" HTPP/1.1");
			writer.println("Host:localhost");
			writer.println("connection:keep-alive");
			writer.println();
			writer.flush();
			
			InputStream in=s.getInputStream();
			BufferedReader reader=new BufferedReader(new InputStreamReader(in));
			String firstLineOfResponse=reader.readLine();
			String temstr=firstLineOfResponse.split(" ")[1];
			if(temstr.equals("200")){
					
				String secondLineOfResponse=reader.readLine();
				String threeLineOfResponse=reader.readLine();
				String fourLineOfResponse=reader.readLine();
				
				System.out.println(firstLineOfResponse+"\n"+secondLineOfResponse+"\n"+threeLineOfResponse+"\n"+fourLineOfResponse);
				byte[] b=new byte[1024];
				OutputStream out=new FileOutputStream(savelocation+"/_"+filename);
				int len;
				while((len=in.read(b))!=-1){
					out.write(b,0,len);
				}
				System.out.println(new String(b,"gb2312"));
				in.close();
				out.close();
			}else if(temstr.equals("404")){
					
				StringBuffer result=new StringBuffer(firstLineOfResponse);
				String line;
				while((line=reader.readLine())!=null){
					result.append(line);
				}
				reader.close();
				System.out.println(result);
				s.close();
			}else{
				System.out.println("some unknowed error occured.");
			}
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
