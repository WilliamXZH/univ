package ref.dahua.fmp;

public class UndergraduateFactory implements IFactory {

	@Override
	public LeiFeng CreateLeiFeng() {
		return new Undergraduate();
	}

}
