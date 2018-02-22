package pers.william.singleton.firstexper;

public class Client {
	
	public static void main(String[] args){
		
		LazySingleton lazy=LazySingleton.getInstance();
		EagerSingleton eager=EagerSingleton.getInstance();

/*		for(int i=0;i<99;i++){
			new Thread(new Runnable(){//test the thead's securement.			
				public void run(){
					for(int j=0;j<99;j++){
						new Thread(new Runnable(){
							public void run(){
											
								//test the singleton.
								LazySingleton lazy_2=LazySingleton.getInstance();
								EagerSingleton eager_2=EagerSingleton.getInstance();
							}
						}).start();
					}
				}
				
			}).start();
		}*/
		
		for(int i=0;i<9999;i++){
			(new SingletonThread(lazy,eager)).start();
		}
		
/*		new Thread(new Runnable(){
			public void run(){
				for(int i=0;i<10000;i++){
					LazySingleton lazy_2=LazySingleton.getInstance();
				}
			}
		}).start(); 
		new Thread(new Runnable(){
			public void run(){
				for(int i=0;i<10000;i++){
					EagerSingleton eager_2=EagerSingleton.getInstance();
				}
			}
		}).start();	*/
		
		System.out.println("lazy's state is "+lazy.getState()+", getnum is "+lazy.getNum());
		System.out.println("eager's state is "+eager.getState()+", getnum is "+eager.getNum());
		
	}
	
}
