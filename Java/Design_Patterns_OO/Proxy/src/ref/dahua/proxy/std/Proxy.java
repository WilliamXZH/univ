package ref.dahua.proxy.std;

public class Proxy implements Subject {

	RealSubject realSubject;
	
	@Override
	public void request() {
		// TODO Auto-generated method stub
		
		if(realSubject==null){
			realSubject = new RealSubject();
		}
		
		realSubject.request();
		
	}

}
