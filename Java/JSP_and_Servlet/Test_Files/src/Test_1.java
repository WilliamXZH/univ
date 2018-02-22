import java.io.*;
class ss
{
	public String ip;
	public void Thread(String ip){
		this.ip=ip;
	}
	public void run(){
		try{
			Process process=Runtime.getRuntime().exec("ping"+ip+"-w 280 -n 1");
			InputStream is=process.getInputStream();
			InputStreamReader isr=new InputStreamReader(is);
			BufferedReader in=new BufferedReader(isr);
			String line=in.readLine();
			while(line!=null){
				if(line!=null&&!line.equals("ю╢вт")||(line.length()>10&&
						line.substring(0,10).equals("Reply from"))){
					//pingMap.put(ip,"true");
				}
			}
			line=in.readLine();
		}catch(IOException e){
			
		}
	}
	public static void main(String[] args){
		ss s=new ss();
		s.run();
	}
}