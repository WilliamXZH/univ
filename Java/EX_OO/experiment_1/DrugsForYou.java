import java.util.*;
public class DrugsForYou
{
	List<user> user_history=new ArrayList<user>();
	List<drug> drugs=new ArrayList<drug>();
	public void SysMenu(){
		System.out.println("1.ָ���û�����Ĵ�����ʷ��¼");
		System.out.println("2.ĳ��ҩ������и����õı���");
		System.out.println("3.�ض�ҩ���ͨ�ô���ҩ���嵥");
		System.out.println("4.�����Ĵ����Ƿ�����ٴθ�ҩ");
		System.out.println("****************************");
		System.out.println("��ѡ��:");
	}
	void diguser(){
	}
	void side_effect(){
	}
	void sub(){
	}
	boolean digpre(){
		return false;
	}
	public static void main(String []args){
		DrugsForYou one=new DrugsForYou();
		one.SysMenu();
	}
}