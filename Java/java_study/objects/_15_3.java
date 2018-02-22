import java.io.*;
import java.util.StringTokenizer;
public class _15_3
{
	public static void main(String []args) throws IOException,FileNotFoundException{
		_15_3 xyz=new _15_3();
		xyz.reader();
		xyz.writer();
	}
	public void reader() throws IOException,FileNotFoundException{
		BufferedReader bIn=new BufferedReader(new FileReader("dat.txt"));
		String line=bIn.readLine();
		while(line!=null){
			line=line.trim();
			if(line.equals(" "))continue;
			line=bIn.readLine();
			System.out.println(line);
		}
		bIn.close();
	}
	public void writer() throws IOException,FileNotFoundException{
		PrintWriter pw=new PrintWriter(new FileOutputStream("txt.dat"));
		pw.println("I love you!");
		pw.close();
	}
}