package pers.william.singleton.firstexper;

/**
 * @copyright(c) William
 * @author William XZH
 * @version v1.0
 * @Description These is a eager singleton, and will be initialized when it is loading.
 * @FunctionList 
 * 1. EagerSingleton() --- The constructor of the class.<br/>
 * 2. getInstance() --- Get the unique instance of the class.<br/>
 * 3. printNumber() --- Print the information of the class,
 * @History
 *  <author>   <date>   <version>   <description> 
 * 1.William   16/11/8     1.0           <br/>
 * 2.<br/>
 * 3.<br/>
 */

public final class EagerSingleton {
	
	private static int state=0;//it's mean is similar to LazySingleton's state, 
	
	private static int getnum=0;//as well as the getnum.
	
	private static EagerSingleton instance=new EagerSingleton();
	//initialization, the most flag of EagerSingleton.
	
	
	/**
	 * @Function EagerSingleton
	 * @Description Constructor of the eager singleton, when it was called, 
	 * 	  it's attribution <b>number</b> will add one.
	 * @Calls none
	 * @Called_By 
	 * @Table_Accessed none
	 * @Table_Updated none
	 * @Input none
	 * @Output none
	 * @Return none returns
	 * @Others 
	 * 
	 */
	private EagerSingleton(){
		state++;
	}
	public int getState(){
		return state;
	}
	public int getNum(){
		return getnum;
	}
	
	/**
	 * @return the unique instance of eager singleton.
	 */
	public static EagerSingleton getInstance(){
		getnum++;
		return instance;
	}
}
