package ref.dahua.prototype;

public class Client {

	public static void main(String[] args) {
		Resume a = new Resume("大鸟");
		System.out.println(a);
		
		a.setPersonalInfo("男", "29");
		a.setWorkExperience("1999-2000", "XX公司");
		
		Resume b = (Resume)a.Clone();
		b.setWorkExperience("1998-2006", "YY企业");
		
		Resume c = (Resume)a.Clone();
		c.setPersonalInfo("男", "24");
		
		a.display();
		b.display();
		c.display();
		
	}
	
}
