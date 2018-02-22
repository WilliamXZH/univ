package ref.dahua.fmp;

public class VolunteerFactory implements IFactory {

	@Override
	public LeiFeng CreateLeiFeng() {
		// TODO Auto-generated method stub
		return new Volunteer();
	}

}
