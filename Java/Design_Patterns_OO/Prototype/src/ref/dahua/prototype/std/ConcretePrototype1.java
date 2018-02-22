package ref.dahua.prototype.std;

public class ConcretePrototype1 extends Prototype {

	public ConcretePrototype1(String id) {
		super(id);
		// TODO Auto-generated constructor stub
	}

	@Override
	public Prototype Clone() {
		// TODO Auto-generated method stub
		try {
			return (Prototype)this.clone();
		} catch (CloneNotSupportedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

}
