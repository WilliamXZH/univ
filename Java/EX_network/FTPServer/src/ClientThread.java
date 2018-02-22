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




public class ClientThread extends Thread {
	private Socket socketClient;//�ͻ���socket
	private String dir = "";//����·��
	private String pdir = "/";//���·��
	private Random generator=new Random();//�����
	private int restint = 0;
	public ClientThread(Socket client, String F_DIR){
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
		System.out.println("�ͻ��˵�IP�ǣ�"+clientIp);
		pw.println("connect succeed");
		pw.flush();
		String command = "";//����
		String UserName= "";//�û���
		String PassWords="";//����
		String str="";//��������
		boolean b = true;
		boolean loginstuts=false;
		int port_high;
		int port_low;
		Socket tempsocket = null;
		while(b){
			try{
				command = br.readLine();
				System.out.println("�ͻ��˷�����ָ�"+command);
				if(command==null){
					System.out.println("�ͻ������ӶϿ�");
					break;
				}
			}catch(Exception e){
				e.printStackTrace();
				pw.println("331 ������Ҫ������");
				pw.flush();
				loginstuts=false;
				b = false;
			}
			//����user
			if(command.toUpperCase().startsWith("USER")){
				//�ͻ��˷���USER���� --��¼����
				//ȡ�û���
				UserName=command.substring(4).trim();//��ȡ����λ�Ժ�����ݣ�ȥ������������˵Ŀո�
				//�ж��û����Ƿ�Ϊ��
				if(UserName==null||UserName.equals("")){
					System.out.println("�û���Ϊ��");
					pw.println("501 �������� �û�������Ϊ��");
					pw.flush();
				}else{
					pw.println("331 ��Ҫ�������룬�û���Ϊ�� " + UserName);
					pw.flush();
				}
				
			}//����user����
			//���� pass
			else if(command.toUpperCase().startsWith("PASS")){
				PassWords = command.substring(4).trim();//��ȡ����λ�Ժ�����ݣ�ȥ������������˵Ŀո�
				if(null==PassWords||PassWords.equals("")){
					System.out.println("����Ϊ��");
					pw.println("501 �������� ���벻��Ϊ��");
					pw.flush();
				}else{
					//У�������Ƿ���ȷ����ȷ�����½������ʱ��ֹ��½
					if(PassWords.equals(UserName)){//Ϊ�򻯳���ʹ��������û�����ͬʱΪ������ȷ
						System.out.println("������ȷ����½�ɹ�");
						loginstuts=true;
						pw.println("230 ��½�ɹ�");
						pw.flush();
						
					}else{
						loginstuts=false;
						System.out.println("������󣬵�½ʧ��");
						UserName="";
						pw.println("530 ��½ʧ�ܣ�δ��½����");
						pw.flush();
					}
				}
			}//����pass����
			// QUIT����
			else if(command.toUpperCase().startsWith("QUIT")){
				System.out.println("("+UserName+") ("+clientIp+")> "+command);
				b = false;
				pw.println("221 Goodbye");
				pw.flush();
				System.out.println("("+UserName+") ("+clientIp+")> 221 Goodbye");
				try {
					Thread.currentThread();//��ȡ��ǰ�߳�
					Thread.sleep(1000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			} //end QUIT
			//����cwd
			else if(command.toUpperCase().startsWith("CWD")){
				System.out.println("("+UserName+") ("+clientIp+")> "+command);
				if(loginstuts){
					str = command.substring(3).trim();
					if("".equals(str)){
						//pw.println("250 Broken client detected, missing argument to CWD. /""+pdir+"/" is current directory.");
						pw.println("250 �ļ���Ϊ���, û�в�����CWDָ��. "+pdir+" Ϊ��ǰĿ¼");
						pw.flush();
						//System.out.println("("+username+") ("+clientIp+")> 250 Broken client detected, missing argument to CWD. /""+pdir+"/" is current directory.");
					}
					else{
						//�ж�Ŀ¼�Ƿ����
						String tmpDir = dir + "/" + str;
						File file = new File(tmpDir);
						if(file.exists()){//Ŀ¼����
							dir = dir + "/" + str;
							if("/".equals(pdir)){
								pdir = pdir + str;
							}
							else{
								pdir = pdir + "/" + str;
							}
//							System.out.println("�û�"+clientIp+"��"+username+"ִ��CWD����");
							//pw.println("250 CWD successful. /""+pdir+"/" is current directory");
							pw.println("250 CWD successful. "+pdir+" ����Ϊ��ǰĿ¼");
							pw.flush();
							//System.out.println("("+username+") ("+clientIp+")> 250 CWD successful. /""+pdir+"/" is current directory");
						}
						else{//Ŀ¼������
							//pw.println("550 CWD failed. /""+pdir+"/": directory not found.");
							pw.println("550 CWD failed. "+pdir+": Ŀ¼δ�ҵ�");
							pw.flush();
							//System.out.println("("+username+") ("+clientIp+")> 550 CWD failed. /""+pdir+"/": directory not found.");
						}
					}
				}
				else{
					pw.println("530 δ��¼����");
					pw.flush();
					System.out.println("("+UserName+") ("+clientIp+")> "+"530 δ��¼����");
				}
			} //end CWD
			//RETR����
			else if(command.toUpperCase().startsWith("RETR")){
				System.out.println("("+UserName+") ("+clientIp+")> "+command);
				if(loginstuts){
					str = command.substring(4).trim();
					if("".equals(str)){
						pw.println("501 ��������");
						pw.flush();
						System.out.println("("+UserName+") ("+clientIp+")> 501 ��������");
					}
					else {
						try {
							pw.println("150 ������");
							pw.flush();
							System.out.println("("+UserName+") ("+clientIp+")> 150 ������");
							RandomAccessFile outfile = null;
							OutputStream outsocket = null;
							try {
								//�������ж�ȡ��������д�루��ѡ������������ļ��������ļ�����ָ������
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
								pw.println("226 ������������");
								pw.flush();
								System.out.println("("+UserName+") ("+clientIp+")> 226 ������������");
							} catch (FileNotFoundException e) { 
								e.printStackTrace();
								pw.println("503 �Ҳ���ָ�����ļ�");
								pw.flush();
							} catch (IOException e) {
								e.printStackTrace();
							} 
							
						} catch (Exception e){
							pw.println("503 ����ָ������");
							pw.flush();
							System.out.println("("+UserName+") ("+clientIp+")> 503����ָ������");
							e.printStackTrace();
						}
					}
				}
				else{
					pw.println("530 δ��¼����");
					pw.flush();
					System.out.println("("+UserName+") ("+clientIp+")> "+"530 δ��¼����");
				}
			}//end RETR
			//rest����
			else if(command.toUpperCase().startsWith("REST")){
				if(loginstuts){
					str = command.substring(4).trim();
					restint=Integer.parseInt(str);
					pw.println("250 ƫ����������ɣ�Ϊ��֤�ļ�����������������������ʹ��ƫ����");
					pw.flush();
				}else{
					pw.println("530 δ��¼����");
					pw.flush();
					System.out.println("("+UserName+") ("+clientIp+")> "+"530 δ��¼����");
				}
			}
			//REST����
			//STOR����
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
							
//							System.out.println("�û�"+clientIp+"��"+username+"ִ��STOR����");
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
					pw.println("530 δ��¼����");
					pw.flush();
					System.out.println("("+UserName+") ("+clientIp+")> "+"530 δ��¼����");
				}
			} //end STOR
			
			//NLST����
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
//						System.out.println("�û�"+clientIp+"��"+username+"ִ��NLST����");
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
					pw.println("530 δ��¼����");
					pw.flush();
					System.out.println("("+UserName+") ("+clientIp+")> "+"530 δ��¼����");
				}
			} //end NLST
			
			//LIST����
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
//						System.out.println("�û�"+clientIp+"��"+username+"ִ��LIST����");
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
					pw.println("530 δ��¼����");
					pw.flush();
					System.out.println("("+UserName+") ("+clientIp+")> "+"530 δ��¼����");
				}
			} //end LIST
			//����pasv
			else if(command.toUpperCase().startsWith("PASV")){
				if(loginstuts){
					ServerSocket ss = null;
					while( true ){
						//��ȡ���������ж˿�
						port_high = 1 + generator.nextInt(20);
						port_low = 100 + generator.nextInt(1000);
						try {
							//�������󶨶˿�
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
						System.out.println("������������Ϣ����");
						e1.printStackTrace();
					}
					pw.println("227 Entering Passive Mode ("+i.getHostAddress().replace(".", ",")+","+port_high+","+port_low+")");
					pw.flush();
					System.out.println("("+UserName+") ("+clientIp+")> 227 Entering Passive Mode ("+i.getHostAddress().replace(".", ",")+","+port_high+","+port_low+")");
					try {
						//����ģʽ�µ�socket
						tempsocket = ss.accept();
						ss.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
					
				}
				else{
					pw.println("530 δ��¼����");
					pw.flush();
					System.out.println("("+UserName+") ("+clientIp+")> "+"530 δ��¼����");
				}			
			}
			else{
				System.out.println("�����ָ��");
				pw.println("500 �������/��֧�ֵ�����");
				pw.flush();
			}
		}
		//�û����ӶϿ�
		System.out.println("("+UserName+") ("+clientIp+")> disconnected.");
		//�ͷ���ʹ�õ�ϵͳ��Դ
		try {
			br.close();
			socketClient.close();
			pw.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("��Դ�ͷ�ʧ��");
		}

	}
	
}
