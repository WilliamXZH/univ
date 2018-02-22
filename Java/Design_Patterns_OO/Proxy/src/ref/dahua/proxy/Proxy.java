package ref.dahua.proxy;

public class Proxy implements GiveGift {

	Pursuit gg;
	
	public Proxy(SchoolGirl mm){
		
		gg = new Pursuit(mm);
		
	}

	@Override
	public void giveDolls() {
		// TODO Auto-generated method stub
		gg.giveDolls();
		
	}

	@Override
	public void giveFlows() {
		// TODO Auto-generated method stub
		gg.giveFlows();

	}

	@Override
	public void giveChocolate() {
		// TODO Auto-generated method stub
		gg.giveChocolate();

	}

}
