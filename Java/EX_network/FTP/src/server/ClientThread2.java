package server;
import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.RandomAccessFile;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.UnknownHostException;
import java.nio.charset.Charset;
import java.util.Random;

import javax.swing.plaf.basic.BasicInternalFrameTitlePane.RestoreAction;




public class ClientThread2 extends Thread {
	private Socket socketClient;//客户端socket
	private String dir = "";//绝对路径
	private String pdir = "/";//相对路径
	private Random generator=new Random();//随机数
	private int restint = 0;
	public ClientThread2(Socket client, String F_DIR){
		this.socketClient = client;
		this.dir = F_DIR;
	}
	public void run(){
		InputStream is=null;
		OutputStream os = null;
		try{
			is=socketClient.getInputStream();
			os=socketClient.getOutputStream();
		}catch(Exception e){
			e.printStackTrace();
		}
		BufferedReader br=new BufferedReader(new InputStreamReader(is,Charset.forName("utf-8")));
		PrintWriter pw = new PrintWriter(os);
		String clientInetAddress=socketClient.getInetAddress().toString();
		System.out.println(clientInetAddress);
		String clientIp=clientInetAddress.substring(1);
		System.out.println("客户端的IP是："+clientIp);
		pw.println("connect succeed");
		pw.flush();
		String command = "";//命令
		String UserName= "";//用户名
		String PassWords="";//密码
		String str="";//命令内容
		boolean b = true;
		boolean loginstuts=false;
		int port_high;
		int port_low;
		Socket tempsocket = null;
		while(b){
			try{
				command = br.readLine();
				System.out.println("客户端发来的指令："+command);
				if(command==null){
					System.out.println("客户端连接断开");
					break;
				}
			}catch(Exception e){
				e.printStackTrace();
				pw.println("331 服务器要求密码");
				pw.flush();
				loginstuts=false;
				b = false;
			}
			//命令user
			if(command.toUpperCase().startsWith("USER")){
				//客户端发出USER命令 --登录操作
				//取用户名
				UserName=command.substring(4).trim();//截取第四位以后的内容，去掉获得内容两端的空格
				//判断用户名是否为空
				if(UserName==null||UserName.equals("")){
					System.out.println("用户名为空");
					pw.println("501 参数错误 用户名不能为空");
					pw.flush();
				}else{
					pw.println("331 需要输入密码，用户名为： " + UserName);
					pw.flush();
				}
				
			}//命令user结束
			//命令 pass
			else if(command.toUpperCase().startsWith("PASS")){
				PassWords = command.substring(4).trim();//截取第四位以后的内容，去掉获得内容两端的空格
				if(null==PassWords||PassWords.equals("")){
					System.out.println("密码为空");
					pw.println("501 参数错误 密码不能为空");
					pw.flush();
				}else{
					//校验密码是否正确，正确允许登陆，错误时阻止登陆
					if(PassWords.equals(UserName)){//为简化程序，使用密码可用户名相同时为密码正确
						System.out.println("密码正确，登陆成功");
						loginstuts=true;
						pw.println("230 登陆成功");
						pw.flush();
						
					}else{
						loginstuts=false;
						System.out.println("密码错误，登陆失败");
						UserName="";
						pw.println("530 登陆失败，未登陆网络");
						pw.flush();
					}
				}
			}//命令pass结束
			// QUIT命令
			else if(command.toUpperCase().startsWith("QUIT")){
				System.out.println("("+UserName+") ("+clientIp+")> "+command);
				b = false;
				pw.println("221 Goodbye");
				pw.flush();
				System.out.println("("+UserName+") ("+clientIp+")> 221 Goodbye");
				try {
					Thread.currentThread();//获取当前线程
					Thread.sleep(1000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			} //end QUIT
			//命令cwd
			else if(command.toUpperCase().startsWith("CWD")){
				System.out.println("("+UserName+") ("+clientIp+")> "+command);
				if(loginstuts){
					str = command.substring(3).trim();
					if("".equals(str)){
						//pw.println("250 Broken client detected, missing argument to CWD. /""+pdir+"/" is current directory.");
						pw.println("250 文件行为完成, 没有参数的CWD指令. "+pdir+" 为当前目录");
						pw.flush();
						//System.out.println("("+username+") ("+clientIp+")> 250 Broken client detected, missing argument to CWD. /""+pdir+"/" is current directory.");
					}
					else{
						//判断目录是否存在
						String tmpDir = dir + "/" + str;
						File file = new File(tmpDir);
						if(file.exists()){//目录存在
							dir = dir + "/" + str;
							if("/".equals(pdir)){
								pdir = pdir + str;
							}
							else{
								pdir = pdir + "/" + str;
							}
							System.out.println("用户"+clientIp+"："+UserName+"执行CWD命令");
							//pw.println("250 CWD successful. \""+pdir+"\" is current directory");
							pw.println("250 CWD successful. "+pdir+" 已设为当前目录");
							pw.flush();
							//System.out.println("("+username+") ("+clientIp+")> 250 CWD successful. /""+pdir+"/" is current directory");
						}
						else{//目录不存在
							//pw.println("550 CWD failed. /""+pdir+"/": directory not found.");
							pw.println("550 CWD failed. "+pdir+": 目录未找到");
							pw.flush();
							//System.out.println("("+username+") ("+clientIp+")> 550 CWD failed. /""+pdir+"/": directory not found.");
						}
					}
				}
				else{
					pw.println("530 未登录网络");
					pw.flush();
					System.out.println("("+UserName+") ("+clientIp+")> "+"530 未登录网络");
				}
			} //end CWD
			//RETR命令
			else if(command.toUpperCase().startsWith("RETR")){
				System.out.println("("+UserName+") ("+clientIp+")> "+command);
				if(loginstuts){
					str = command.substring(4).trim();
					if("".equals(str)){
						pw.println("501 参数错误");
						pw.flush();
						System.out.println("("+UserName+") ("+clientIp+")> 501 参数错误");
					}
					else {
						try {
							pw.println("150 打开连接");
							pw.flush();
							System.out.println("("+UserName+") ("+clientIp+")> 150 打开连接");
							RandomAccessFile outfile = null;
							OutputStream outsocket = null;
							try {
								//创建从中读取和向其中写入（可选）的随机访问文件流，该文件具有指定名称
								outfile = new RandomAccessFile(dir+"/"+str,"r");
								outsocket = tempsocket.getOutputStream();
								byte bytebuffer[]= new byte[1024]; 
								int length; 
								try{ 
									while((length = outfile.read(bytebuffer)) != -1){ 
										outsocket.write(bytebuffer, 0, length); 
									} 
									outsocket.close(); 
									outfile.close(); 
									tempsocket.close(); 
								} 
								catch(IOException e){
									e.printStackTrace();
								}
								pw.println("226 结束数据连接");
								pw.flush();
								System.out.println("("+UserName+") ("+clientIp+")> 226 结束数据连接");
							} catch (FileNotFoundException e) { 
								e.printStackTrace();
								pw.println("503 找不到指定的文件");
								pw.flush();
							} catch (IOException e) {
								e.printStackTrace();
							} 
							
						} catch (Exception e){
							pw.println("503 错误指令序列");
							pw.flush();
							System.out.println("("+UserName+") ("+clientIp+")> 503错误指令序列");
							e.printStackTrace();
						}
					}
				}
				else{
					pw.println("530 未登录网络");
					pw.flush();
					System.out.println("("+UserName+") ("+clientIp+")> "+"530 未登录网络");
				}
			}//end RETR
			//rest命令
			else if(command.toUpperCase().startsWith("REST")){
				if(loginstuts){
					str = command.substring(4).trim();
					restint=Integer.parseInt(str);
					pw.println("250 偏移量设置完成，为保证文件传输完整，本服务器不会使用偏移量");
					pw.flush();
				}else{
					pw.println("530 未登录网络");
					pw.flush();
					System.out.println("("+UserName+") ("+clientIp+")> "+"530 未登录网络");
				}
			}
			//REST结束
			//STOR命令
			else if(command.toUpperCase().startsWith("STOR")){ 
				System.out.println("("+UserName+") ("+clientIp+")> "+command);
				if(loginstuts){
					str = command.substring(4).trim();
					if("".equals(str)){
						pw.println("501 Syntax error");
						pw.flush();
						System.out.println("("+UserName+") ("+clientIp+")> 501 Syntax error");
					}
					else {
						try {
							pw.println("150 Opening data channel for file transfer."); 
							pw.flush();
							System.out.println("("+UserName+") ("+clientIp+")> 150 Opening data channel for file transfer.");
							RandomAccessFile infile = null;
							InputStream insocket = null;
							try {
								infile = new RandomAccessFile(dir+"/"+str,"rw");
								insocket = tempsocket.getInputStream(); 
							} catch (FileNotFoundException e) { 
								e.printStackTrace();
							} catch (IOException e) {
								e.printStackTrace();
							} 
							byte bytebuffer[] = new byte[1024]; 
							int length; 
							try{
								while((length =insocket.read(bytebuffer) )!= -1){ 
									infile.write(bytebuffer, 0, length); 
								}
								insocket.close(); 
								infile.close(); 
								tempsocket.close(); 
							} 
							catch(IOException e){
								e.printStackTrace();
							}
							
//							System.out.println("用户"+clientIp+"："+username+"执行STOR命令");
							pw.println("226 Transfer OK");
							pw.flush();
							System.out.println("("+UserName+") ("+clientIp+")> 226 Transfer OK");
						} catch (Exception e){
							pw.println("503 Bad sequence of commands.");
							pw.flush();
							System.out.println("("+UserName+") ("+clientIp+")> 503 Bad sequence of commands.");
							e.printStackTrace();
						}
					}
				} else {
					pw.println("530 未登录网络");
					pw.flush();
					System.out.println("("+UserName+") ("+clientIp+")> "+"530 未登录网络");
				}
			} //end STOR
			
			//NLST命令
			else if(command.toUpperCase().startsWith("NLST")) { 
				System.out.println("("+UserName+") ("+clientIp+")> "+command);
				if(loginstuts){
					try {
						pw.println("150 Opening data channel for directory list."); 
						pw.flush();
						System.out.println("("+UserName+") ("+clientIp+")> 150 Opening data channel for directory list.");
						PrintWriter pwr = null;
						try {
							pwr= new PrintWriter(tempsocket.getOutputStream(),true);
						} catch (IOException e1) {
							e1.printStackTrace();
						} 
						File file = new File(dir); 
						String[] dirstructure = new String[10]; 
						dirstructure= file.list(); 
						for(int i=0;i<dirstructure.length;i++){
							pwr.println(dirstructure[i]); 
						}
						try {
							tempsocket.close();
							pwr.close();
						} catch (IOException e) {
							e.printStackTrace();
						} 
//						System.out.println("用户"+clientIp+"："+username+"执行NLST命令");
						pw.println("226 Transfer OK"); 
						pw.flush();
						System.out.println("("+UserName+") ("+clientIp+")> 226 Transfer OK");
					} catch (Exception e){
						pw.println("503 Bad sequence of commands.");
						pw.flush();
						System.out.println("("+UserName+") ("+clientIp+")> 503 Bad sequence of commands.");
						e.printStackTrace();
					}
				}else{
					pw.println("530 未登录网络");
					pw.flush();
					System.out.println("("+UserName+") ("+clientIp+")> "+"530 未登录网络");
				}
			} //end NLST
			
			//LIST命令
			else if(command.toUpperCase().startsWith("LIST")) { 
				System.out.println("("+UserName+") ("+clientIp+")> "+command);
				if(loginstuts){
					try{
						pw.println("150 Opening data channel for directory list."); 
						pw.flush();
						System.out.println("("+UserName+") ("+clientIp+")> 150 Opening data channel for directory list.");
						PrintWriter pwr = null;
						try {
							pwr= new PrintWriter(tempsocket.getOutputStream(),true);
						} catch (IOException e) {
							e.printStackTrace();
						} 
						FtpUtil.getDetailList(pwr, dir);
						try {
							tempsocket.close();
							pwr.close();
						} catch (IOException e) {
							e.printStackTrace();
						} 
//						System.out.println("用户"+clientIp+"："+username+"执行LIST命令");
						pw.println("226 Transfer OK"); 
						pw.flush();
						System.out.println("("+UserName+") ("+clientIp+")> 226 Transfer OK");
					} catch (Exception e){
						pw.println("503 Bad sequence of commands.");
						pw.flush();
						System.out.println("("+UserName+") ("+clientIp+")> 503 Bad sequence of commands.");
						e.printStackTrace();
					}
				} else {
					pw.println("530 未登录网络");
					pw.flush();
					System.out.println("("+UserName+") ("+clientIp+")> "+"530 未登录网络");
				}
			} //end LIST
			//命令pasv
			else if(command.toUpperCase().startsWith("PASV")){
				if(loginstuts){
					ServerSocket ss = null;
					while( true ){
						//获取服务器空闲端口
						port_high = 1 + generator.nextInt(20);
						port_low = 100 + generator.nextInt(1000);
						try {
							//服务器绑定端口
							ss = new ServerSocket(port_high * 256 + port_low);
							break;
						} catch (IOException e) {
							continue;
						}
					}
					InetAddress i = null;
					try {
						i = InetAddress.getLocalHost();
					} catch (UnknownHostException e1) {
						System.out.println("服务器网络信息出错");
						e1.printStackTrace();
					}
					pw.println("227 Entering Passive Mode ("+i.getHostAddress().replace(".", ",")+","+port_high+","+port_low+")");
					pw.flush();
					System.out.println("("+UserName+") ("+clientIp+")> 227 Entering Passive Mode ("+i.getHostAddress().replace(".", ",")+","+port_high+","+port_low+")");
					try {
						//被动模式下的socket
						tempsocket = ss.accept();
						ss.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
					
				}
				else{
					pw.println("530 未登录网络");
					pw.flush();
					System.out.println("("+UserName+") ("+clientIp+")> "+"530 未登录网络");
				}			
			}
			else{
				System.out.println("错误的指令");
				pw.println("500 命令错误/不支持的命令");
				pw.flush();
			}
		}
		//用户连接断开
		System.out.println("("+UserName+") ("+clientIp+")> disconnected.");
		//释放所使用的系统资源
		try {
			br.close();
			socketClient.close();
			pw.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("资源释放失败");
		}

	}
	
}
