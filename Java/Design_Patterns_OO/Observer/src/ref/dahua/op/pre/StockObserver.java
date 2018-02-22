package ref.dahua.op.pre;

public class StockObserver {

	private String name;
	private Secretary sub;
	
	public StockObserver(String name, Secretary sub){
		this.name = name;
		this.sub = sub;
	}
	
	public void update(){
		System.out.printf("%s %s关闭股票行情，请继续工作!\n",sub.getAction(),name);
	}
	
	
}
