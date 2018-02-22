package ref.dahua.prototype;

public class Client {

	public static void main(String[] args) {
		Resume a = new Resume("����");
		System.out.println(a);
		
		a.setPersonalInfo("��", "29");
		a.setWorkExperience("1999-2000", "XX��˾");
		
		Resume b = (Resume)a.Clone();
		b.setWorkExperience("1998-2006", "YY��ҵ");
		
		Resume c = (Resume)a.Clone();
		c.setPersonalInfo("��", "24");
		
		a.display();
		b.display();
		c.display();
		
	}
	
}
