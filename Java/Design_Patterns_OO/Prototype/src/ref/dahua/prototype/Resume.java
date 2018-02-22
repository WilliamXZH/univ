package ref.dahua.prototype;

public class Resume implements Cloneable {

	private String name;
	private String sex;
	private String age;
	private String timeArea;
	private String company;
	
	public Resume(String name){
		this.name = name;
	}

	public void setPersonalInfo(String sex, String age){
		this.sex = sex;
		this.age = age;
	}
	
	public void setWorkExperience(String timeArea, String company){
		this.timeArea = timeArea;
		this.company = company;
	}
	
	public void display(){
		System.out.println(name+" " + sex + " " + age);
		System.out.println("工作经历" + timeArea+ " " + company);
	}
	
	public Object Clone(){
		try {
			return (Object)this.clone();
		} catch (CloneNotSupportedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	@Override
	public String toString() {
		return "Resume [name=" + name + ", sex=" + sex + ", age=" + age + ", timeArea=" + timeArea + ", company="
				+ company + "]";
	}
	
}
