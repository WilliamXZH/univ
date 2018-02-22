package pers.william.singleton.firstexper;

/** 
 * @author William , and my Chinese name is XZH
 * @version 1.0.0.20161017_alpha
 * @since JDK 1.7 
 * @see state:It means the times of initialization.
 * @see getname:It means the times of accessing method GetInstance().
 * @see LazySingleton:The most important flag of the singleton pattern.
 */
public final class LazySingleton {
	
	/**
	 * It means the times of the class's constructor be called.
	 */
	private static int state=0;
	
	/**
	 * It means the times of the method getInstance be called.
	 */
	private static int getnum=0;
	
	/**
	 * The most important flag of the singleton pattern.
	 */
	private static LazySingleton instance=null;//or give it nothing;
	
	/**
	 * @return  The Constructor of the LazySigleton.  
	 */
	private LazySingleton(){
		state++;
	}
	
	/**
	 *  @return The times of the constructor called.  
	 */
	public int getState(){
		return state;
	}
	public int getNum(){
		return getnum;
	}
	
	
	public static LazySingleton getInstance(){
		getnum++;
		if(instance==null){
			instance=new LazySingleton();
		}
		return instance;
	}
	
/*	public static synchronized LazySingleton getInstance(){
		getnum++;
		if(instance==null){
			instance=new LazySingleton();
		}
		return instance;
	}*/
	
/*	public static LazySingleton getInstance(){
		getnum++;
		if(instance==null){
			synchronized(LazySingleton.class){
				instance=new LazySingleton();
			}
		}
		return instance;
	}*/
	
	/**
	 * @return LazySingleton's unique instance.
	 * @annotation when it was called, the attribution getnum will add one.
	 * @history
	 * I write four kinds of method of getInstance() according to the teacher's power point.<br/>
	 * 1.The first is not secure about thread.<br/>
	 * 2.The second is secure about thread, but not efficient.<br/>
	 * 3.The third is secure about thread, and more efficient than the second, 
	 * but still cost too many time.<br/>
	 * 4.The fourth is double checked, it's secure and the most efficient measure.  <br/>
	 */
/*	public static LazySingleton getInstance(){
		getnum++;
		if(instance==null){
			synchronized(LazySingleton.class){
				if(instance==null){
					instance=new LazySingleton();
				}
			}
		}
		return instance;
	}*/
	
}
