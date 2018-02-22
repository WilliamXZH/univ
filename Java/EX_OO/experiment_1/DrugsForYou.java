import java.util.*;
public class DrugsForYou
{
	List<user> user_history=new ArrayList<user>();
	List<drug> drugs=new ArrayList<drug>();
	public void SysMenu(){
		System.out.println("1.指定用户请求的处方历史记录");
		System.out.println("2.某种药物的所有副作用的报表");
		System.out.println("3.特定药物的通用代替药物清单");
		System.out.println("4.给定的处方是否可以再次给药");
		System.out.println("****************************");
		System.out.println("请选择:");
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