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
		System.out.println("�ͻ��˵�IP�ǣ�"+clientIp);
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
				System.out.println("�ͻ��˷�����ָ�"+command);
				if(command==null){
					System.out.println("�ͻ������ӶϿ�");
					break;
				}
			}catch(Exception e){
					e.printStackTrace();
					pw.println("331������Ҫ������");
					pw.flush();
					loginstuts=false;
					b=false;
			}
			if(command.toUpperCase().startsWith("USER")){
				UserName=command.substring(4).trim();
				if(UserName==null||UserName.equals("")){
					System.out.println("�û���Ϊ��");
					pw.println("501�������� �û�������Ϊ��");
					pw.flush();
				}else{
					pw.println("331��Ҫ�������룬�û���Ϊ��"+UserName);
					pw.flush();
				}
			}
			else if(command.toUpperCase().startsWith("PASS")){
				PassWords=command.substring(4).trim();
				if(null==PassWords||PassWords.equals("")){
					System.out.println("����Ϊ��");
					pw.println("501�������� ���벻��Ϊ��");
					pw.flush();
				}else{
					if(PassWords.equals(UserName)){
						System.out.println("������ȷ����½�ɹ�");
						loginstuts=true;
						pw.println("230��½�ɹ�");
						pw.flush();
					}else{
						loginstuts=false;
						System.out.println("������󣬵�¼ʧ��");
						UserName="";
						pw.println("530��¼ʧ�ܣ�δ��¼����");
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
						pw.println("250�ļ���Ϊ��ɣ�û�в�����CWDָ�"+pdir+" Ϊ��ǰĿ¼");
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
							System.out.println("�û�"+clientIp+":"+UserName+"ִ��CWD����");
							pw.println("250 CWD successful.\""+pdir+"\" is current dirctory");
							//pw.println("250 CWD successful. "+pdir+" ����Ϊ��ǰĿ¼");
							pw.flush();
						}else{
							pw.println("550 CWD failed. "+tempDir+":Ŀ¼δ�ҵ�");
							pw.flush();
						}
					}
				}else{
					pw.println("530δ��¼����");
					pw.flush();
					System.out.println("("+UserName+")("+clientIp+")>"+"530δ��¼����");
				}
			}else if(command.toUpperCase().startsWith("RETR")){
				System.out.println("("+UserName+")("+clientIp+")>"+command);
				if(loginstuts){
					str=command.substring(4).trim();
					if("".equals(str)){
						pw.println("501��������");
						pw.flush();
						System.out.println("("+UserName+")("+clientIp+")>501��������");
						
					}else{
						try{
							pw.println("150������");
							pw.flush();
							System.out.println("("+UserName+")("+clientIp+")>150������");
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
								pw.println("226 ������������");
								pw.flush();
								System.out.println("("+UserName+")("+clientIp+")>226������������");
								
							}catch(FileNotFoundException e){
								e.printStackTrace();
								pw.println("503�Ҳ���ָ�����ļ�");
								pw.flush();
							}catch(IOException e){
								e.printStackTrace();
							}
						}catch(Exception e){
							pw.println("503����ָ������");
							pw.flush();
							System.out.println("("+UserName+")("+clientIp+")> 503����ָ������");
							e.printStackTrace();
						}
					}
				}else{
					pw.println("530δ��¼����");
					pw.flush();
					System.out.println("("+UserName+")("+clientIp+")> "+"530δ��¼����");
					
				}
			}else if(command.toUpperCase().startsWith("REST")){
				if(loginstuts){
					str=command.substring(4).trim();
					restint=Integer.parseInt(str);
					pw.println("250ƫ����������ɣ�Ϊ��֤�ļ�����������������������ʹ��ƫ����");
					pw.flush();
				}else{
					pw.println("530δ��¼����");
					pw.flush();
					System.out.println("("+UserName+")("+clientIp+")>"+"530δ��¼����");
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
							pw.println("226 ������������");
							pw.flush();
							System.out.println("("+UserName+") ("+clientIp+")> 226 ������������");
						}catch(Exception e){
							pw.println("503δ��¼����");
							pw.flush();
							System.out.println("("+UserName+")("+clientIp+")>503Bad sequence of commands");
							e.printStackTrace();
						}
					}
				}else{
					pw.println("503δ��¼����");
					pw.flush();
					System.out.println("("+UserName+")("+clientIp+")> "+"503δ��¼����");
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
						System.out.println("�û�"+clientIp+":"+UserName+"ִ��NLST����");
						
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
					pw.println("530δ��¼����");
					pw.flush();
					System.out.println("("+UserName+")("+clientIp+")> "+"530 δ��¼����");
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
						System.out.println("�û�"+clientIp+":"+UserName+"ִ��LIST����");
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
					pw.println("530δ��¼����");
					pw.flush();
					System.out.println("("+UserName+")("+clientIp+")> "+"530δ��¼����");
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
						System.out.println("������������Ϣ����");
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
					pw.println("530δ��¼����");
					pw.flush();
					System.out.println("("+UserName+")("+clientIp+")> "+"530δ��¼����");
				}
			}else{
				System.out.println("�����ָ��");
				pw.println("500�������/��֧�ֵ�����");
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
			System.out.println("��Դ�ͷ�ʧ��");
		}
	}
}
