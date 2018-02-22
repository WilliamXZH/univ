package server;

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

public class ClientThread extends Thread{
	private Socket socketClient;
	private String dir="";
	private String pdir="/";
	private Random generator=new Random();
	private int restint=0;
	public ClientThread(Socket client,String F_DIR){
		this.socketClient=client;
		this.dir=F_DIR;
	}
	public void run(){
		InputStream is=null;
		OutputStream os=null;
		try{
			is=socketClient.getInputStream();
			os=socketClient.getOutputStream();
		}catch(Exception e){
			e.printStackTrace();
		}
		BufferedReader br=new BufferedReader(new InputStreamReader(is,Charset.forName("utf-8")));
		PrintWriter pw=new PrintWriter(os);
		String clientInetAddress=socketClient.getInetAddress().toString();
		System.out.println(clientInetAddress);
		String clientIp=clientInetAddress.substring(1);
		System.out.println("客户端的IP是："+clientIp);
		pw.println("connect succeed");
		pw.flush();
		String command="";
		String UserName="";
		String PassWords="";
		String str="";
		boolean b=true;
		boolean loginstuts=false;
		int port_high;
		int port_low;
		Socket tempsocket=null;
		while(b){
			try{
				command =br.readLine();
				System.out.println("客户端发来的指令："+command);
				if(command==null){
					System.out.println("客户端连接断开");
					break;
				}
			}catch(Exception e){
					e.printStackTrace();
					pw.println("331服务器要求密码");
					pw.flush();
					loginstuts=false;
					b=false;
			}
			if(command.toUpperCase().startsWith("USER")){
				UserName=command.substring(4).trim();
				if(UserName==null||UserName.equals("")){
					System.out.println("用户名为空");
					pw.println("501参数错误 用户名不能为空");
					pw.flush();
				}else{
					pw.println("331需要输入密码，用户名为："+UserName);
					pw.flush();
				}
			}
			else if(command.toUpperCase().startsWith("PASS")){
				PassWords=command.substring(4).trim();
				if(null==PassWords||PassWords.equals("")){
					System.out.println("密码为空");
					pw.println("501参数错误 密码不能为空");
					pw.flush();
				}else{
					if(PassWords.equals(UserName)){
						System.out.println("密码正确，登陆成功");
						loginstuts=true;
						pw.println("230登陆成功");
						pw.flush();
					}else{
						loginstuts=false;
						System.out.println("密码错误，登录失败");
						UserName="";
						pw.println("530登录失败，未登录网络");
						pw.flush();
					}
				}
			}
			else if(command.toUpperCase().startsWith("QUIT")){
				System.out.println("("+UserName+")("+clientIp+")>"+command);
				b=false;
				pw.println("221 Goodbye");
				pw.flush();
				System.out.println("("+UserName+")("+clientIp+")> 221 Goodbye");
				try{
					Thread.currentThread();
					Thread.sleep(1000);
					
				}catch(InterruptedException e){
					e.printStackTrace();
				}
			}
			else if(command.toUpperCase().startsWith("CWD")){
				System.out.println("("+UserName+")("+clientIp+")> "+command);
				if(loginstuts){
					str=command.substring(3).trim();
					if("".equals(str)){
						pw.println("250文件行为完成，没有参数的CWD指令。"+pdir+" 为当前目录");
						pw.flush();
					}
					else{
						String tempDir=dir+"/"+str;
						File file=new File(tempDir);
						if(file.exists()){
							dir = dir + "/" + str;
							if("/".contentEquals(pdir)){
								pdir=pdir+str;
							}else{
								pdir=pdir+"/"+str;
							}
							System.out.println("用户"+clientIp+":"+UserName+"执行CWD命令");
							pw.println("250 CWD successful.\""+pdir+"\" is current dirctory");
							//pw.println("250 CWD successful. "+pdir+" 已设为当前目录");
							pw.flush();
						}else{
							pw.println("550 CWD failed. "+tempDir+":目录未找到");
							pw.flush();
						}
					}
				}else{
					pw.println("530未登录网络");
					pw.flush();
					System.out.println("("+UserName+")("+clientIp+")>"+"530未登录网络");
				}
			}else if(command.toUpperCase().startsWith("RETR")){
				System.out.println("("+UserName+")("+clientIp+")>"+command);
				if(loginstuts){
					str=command.substring(4).trim();
					if("".equals(str)){
						pw.println("501参数错误");
						pw.flush();
						System.out.println("("+UserName+")("+clientIp+")>501参数错误");
						
					}else{
						try{
							pw.println("150打开连接");
							pw.flush();
							System.out.println("("+UserName+")("+clientIp+")>150打开链接");
							RandomAccessFile outfile=null;
							OutputStream outsocket=null;
							try{
								outfile=new RandomAccessFile(dir+"/"+str,"r");
								outsocket=tempsocket.getOutputStream();
								byte bytebuffer[]=new byte[2014];
								int length;
								try{
									while((length=outfile.read(bytebuffer))!=-1){
										outsocket.write(bytebuffer,0,length);
									}
									outsocket.close();
									outfile.close();
									tempsocket.close();
								}catch(Exception e){
									e.printStackTrace();
								}
								pw.println("226 结束数据连接");
								pw.flush();
								System.out.println("("+UserName+")("+clientIp+")>226结束数据连接");
								
							}catch(FileNotFoundException e){
								e.printStackTrace();
								pw.println("503找不到指定的文件");
								pw.flush();
							}catch(IOException e){
								e.printStackTrace();
							}
						}catch(Exception e){
							pw.println("503错误指令序列");
							pw.flush();
							System.out.println("("+UserName+")("+clientIp+")> 503错误指令序列");
							e.printStackTrace();
						}
					}
				}else{
					pw.println("530未登录网络");
					pw.flush();
					System.out.println("("+UserName+")("+clientIp+")> "+"530未登录网络");
					
				}
			}else if(command.toUpperCase().startsWith("REST")){
				if(loginstuts){
					str=command.substring(4).trim();
					restint=Integer.parseInt(str);
					pw.println("250偏移量设置完成，为保证文件传输完整，本服务器不会使用偏移量");
					pw.flush();
				}else{
					pw.println("530未登录网络");
					pw.flush();
					System.out.println("("+UserName+")("+clientIp+")>"+"530未登录网络");
				}
			}else if(command.toUpperCase().startsWith("STOR")){
				System.out.println("("+UserName+")("+clientIp+")> "+command);
				if(loginstuts){
					str=command.substring(4).trim();
					str="_"+str;
					if("".equals(str)){
						pw.println("501 Syntax error");
						pw.flush();
						System.out.println("("+UserName+")("+clientIp+")> 501 Syntax error");
					}else{
						try{
							pw.println("150 Opening data channel for file transfer.");
							pw.flush();
							System.out.println("("+UserName+")("+clientIp+")> 150 Openning data channel for file  transfer.");
							RandomAccessFile infile=null;
							InputStream insocket=null;
							try{
								infile=new RandomAccessFile(dir+"/"+str,"rw");
								System.out.println(dir+"/"+str);
								insocket=tempsocket.getInputStream();
							}catch(FileNotFoundException e){
								e.printStackTrace();
							}catch(IOException e){
								e.printStackTrace();
							}
							byte bytebuffer[]=new byte[2014];
							int length;
							try{
								while((length =insocket.read(bytebuffer) )!= -1){ 
									infile.write(bytebuffer, 0, length); 
								}
								insocket.close(); 
								infile.close(); 
								tempsocket.close(); 
							}catch(IOException e){
								e.printStackTrace();
							}
							pw.println("226 结束数据连接");
							pw.flush();
							System.out.println("("+UserName+") ("+clientIp+")> 226 结束数据连接");
						}catch(Exception e){
							pw.println("503未登录网络");
							pw.flush();
							System.out.println("("+UserName+")("+clientIp+")>503Bad sequence of commands");
							e.printStackTrace();
						}
					}
				}else{
					pw.println("503未登录网络");
					pw.flush();
					System.out.println("("+UserName+")("+clientIp+")> "+"503未登录网络");
				}
			}else if(command.toUpperCase().startsWith("NLST")){
				System.out.println("("+UserName+")("+clientIp+")> "+command);
				if(loginstuts){
					try{
						pw.println("150 Opening data channel for directory list.");
						pw.flush();
						System.out.println("("+UserName+")("+clientIp+")> 150 Opening data channel for directory list.");
						PrintWriter pwr=null;
						try{
							pwr=new PrintWriter(tempsocket.getOutputStream(),true);
						}catch(IOException e1){
							e1.printStackTrace();
						}
						File file=new File(dir);
						String[] dirstructure=new String[10];
						dirstructure=file.list();
						for(int i=0;i<dirstructure.length;i++){
							pwr.println(dirstructure[i]);
						}
						try{
							tempsocket.close();
							pwr.close();
						}catch(IOException e){
							e.printStackTrace();
						}
						System.out.println("用户"+clientIp+":"+UserName+"执行NLST命令");
						
						pw.println("226 Transfer Ok");
						pw.flush();
						System.out.println("("+UserName+")("+clientIp+")> 226 Transfer OK");
						
					}catch(Exception e){
						pw.println("503 Bad sequence of commands.");
						pw.flush();
						System.out.println("("+UserName+")("+clientIp+")> 503 Bad sequence of commands.");
						e.printStackTrace();
					}
				
				}else{
					pw.println("530未登录网络");
					pw.flush();
					System.out.println("("+UserName+")("+clientIp+")> "+"530 未登录网络");
				}
			}else if(command.toUpperCase().startsWith("LIST")){
				System.out.println("("+UserName+")("+clientIp+")> "+command);
				if(loginstuts){
					try{
						pw.println("150 Opening data channel for directory list.");
						pw.flush();
						System.out.println("("+UserName+")("+clientIp+")> 150 Opening data channel for directory list.");
						PrintWriter pwr=null;
						try{
							pwr=new PrintWriter(tempsocket.getOutputStream(),true);
							
						}catch(IOException e){
							e.printStackTrace();
						}
						FtpUtil.getDetailList(pwr, dir);
						try{
							tempsocket.close();
						}catch(IOException e){
							e.printStackTrace();
						}
						System.out.println("用户"+clientIp+":"+UserName+"执行LIST命令");
						pw.println("226 Transfer OK");
						pw.flush();
						System.out.println("("+UserName+")("+clientIp+")>226 Transfer Ok");
					}catch(Exception e){
						pw.println("503 Bad sequence of commands.");
						pw.flush();
						System.out.println("("+UserName+")("+clientIp+")> 503 Bad sequence of commands.");
						e.printStackTrace();
					}
					
				}else{
					pw.println("530未登录网络");
					pw.flush();
					System.out.println("("+UserName+")("+clientIp+")> "+"530未登录网络");
				}
			}else if(command.toUpperCase().startsWith("PASV")){
				if(loginstuts){
					ServerSocket ss=null;
					while(true){
						port_high=1+generator.nextInt(20);
						port_low=100+generator.nextInt(1000);
						try{
							ss=new ServerSocket(port_high*256+port_low);
							break;
						}catch(IOException e){
							continue;
						}
					}
					InetAddress i=null;
					try{
						i=InetAddress.getLocalHost();
						
					}catch(UnknownHostException e1){
						System.out.println("服务器网络信息出错");
						e1.printStackTrace();
					}
					pw.println("227 Enter Passive Mode ("+i.getHostAddress().replace(".",",")+","+port_high+","+port_low+")");
					pw.flush();
					System.out.println("("+UserName+")("+clientIp+")> 227 Entering Passive Mode ("+i.getHostAddress().replace(".",",")+","+port_high+","+port_low+")");
					try{
						tempsocket=ss.accept();
						ss.close();
					}catch(IOException e){
						e.printStackTrace();
					}
				}else{
					pw.println("530未登录网络");
					pw.flush();
					System.out.println("("+UserName+")("+clientIp+")> "+"530未登录网络");
				}
			}else{
				System.out.println("错误的指令");
				pw.println("500命令错误/不支持的命令");
				pw.flush();
			}
		}
		System.out.println("("+UserName+")("+clientIp+")> disconnected.");
		try{
			br.close();
			socketClient.close();
			pw.close();
		}catch(IOException e){
			e.printStackTrace();
			System.out.println("资源释放失败");
		}
	}
}
