package ref.dahua.proxy;

public class Pursuit implements GiveGift {

	SchoolGirl mm;
	
	public Pursuit() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Pursuit(SchoolGirl mm) {
		super();
		this.mm = mm;
	}

	@Override
	public void giveDolls() {
		// TODO Auto-generated method stub

		System.out.println(mm.getName()+" ����������");
		
	}

	@Override
	public void giveFlows() {
		// TODO Auto-generated method stub

		System.out.println(mm.getName()+" �����ʻ�");
		
	}

	@Override
	public void giveChocolate() {
		// TODO Auto-generated method stub

		System.out.println(mm.getName()+" �����ɿ���");
		
	}

}
