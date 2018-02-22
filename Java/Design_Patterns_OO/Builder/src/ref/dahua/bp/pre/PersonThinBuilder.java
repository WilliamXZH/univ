package ref.dahua.bp.pre;

import java.awt.Graphics;

public class PersonThinBuilder extends PersonBuilder {

	public PersonThinBuilder(Graphics g) {
		super(g);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void buildHead() {
		// TODO Auto-generated method stub
		g.drawRect(50, 20, 30, 30);
	}

	@Override
	public void buildBody() {
		// TODO Auto-generated method stub
		g.drawRect(60, 50, 10, 50);
	}

	@Override
	public void buildArmLeft() {
		// TODO Auto-generated method stub
		g.drawLine(60, 50, 40, 100);
	}

	@Override
	public void buildArmRight() {
		// TODO Auto-generated method stub
		g.drawLine(70, 50, 90, 100);
	}

	@Override
	public void buildLegLeft() {
		// TODO Auto-generated method stub
		g.drawLine(60, 100, 45, 150);
	}

	@Override
	public void buildLegRight() {
		// TODO Auto-generated method stub

		g.drawLine(70, 100, 85, 150);
	}
	
}
