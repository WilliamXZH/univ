package job.neu.edu.cn;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;

public class LoginTest {

	private URL url;

	private URLConnection conn;

	public void setURL(String urlAddr) {

		try {
			url = new URL(urlAddr);
			conn = url.openConnection();

			// conn.setRequestProperty("Pragma:", "no-cache");
			// conn.setRequestProperty("Cache-Control", "no-cache");

		} catch (MalformedURLException ex) {
			ex.printStackTrace();
		} catch (IOException ex) {
			ex.printStackTrace();
		}
	}

	public void sendPost(String post) {
		conn.setDoInput(true);
		conn.setDoOutput(true);
		PrintWriter output;
		try {
			output = new PrintWriter(conn.getOutputStream());
			output.print(post);
			output.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	public String getContent() {
		String line, result = "";
		try {
			conn.connect();
			BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			while ((line = in.readLine()) != null) {
				result += line + "\n";
			}
			in.close();
		} catch (IOException ex) {
			ex.printStackTrace();
		}
		return result;
	}

	public static void main(String[] args) {
		String urlAddr = "http://job.neu.edu.cn/ALogin.aspx";
		String post = "__VIEWSTATE=/wEPDwUKMTk1OTA2NTQzNmQYAQUeX19Db250cm9sc1JlcXVpcmVQb3N0QmFja0tleV9fFgEFC0ltZ0J0bkxvZ2lut1MxN61qUnhegZK1SkJxX0mFQEw=";
		post +="&__EVENTVALIDATION=/wEWBAKZtMOODwLF1bSzCQLVqbaRCwK4v/1ZoCfy3AFr4GFQAAK4rpQrKG1VayE=";
		post +="&TxtUserName=20144760&TxtPassword=lsr521xu";
		post +="&ImgBtnLogin.x=0&ImgBtnLogin.y=0";
		
		System.out.println(post);
		
		LoginTest test = new LoginTest();

		test.setURL(urlAddr);
		test.sendPost(post);
		System.out.println(test.getContent());
	}

}
