import java.io.BufferedReader;
public class FileIO{
	public static void main(String []args){
		BufferedReader bIn=null;
		PrintWriter pw=null;
		try{
			bIn=new BufferedReader(new FileReader("input.dat"));
		}
		catch(FileNotFoundException e){
		}
		try
		{
			pw=new PrintWriter(new FileOutputStream("output.dat"));
		}
		catch (FileNotFoundException e)
		{
		}
		int recordCount=0;
		String record=null;
		try
		{
			record=bIn.readLine();
		}
		catch (IOException e)
		{
		}
		while(record!=null){
			recordCount++;
			try
			{
				record=bIn.readLine();
			}
			catch (IOException e)
			{
			}
		}
		System.out.println("Total of "+recordCount+" records transferred");
		try
		{
			bIn.close();
		}
		catch (IOException e)
		{
		}
		pw.close();
	}
}