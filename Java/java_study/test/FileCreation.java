import java.io.File;
import java.io.IOException;
import java.util.Scanner;

public class FileCreation
{
	public static void main(String []args){
		String path = null;
		Scanner sc = new Scanner(System.in);
		path = sc.next();
		try{
			File file = new File("./"+path);
			file.createNewFile();
		}catch(IOException e){
			e.printStackTrace();
		}
	}
}