package pers.william.singleton.firstexper;

public class SingletonThread extends Thread {
	LazySingleton lazy;
	EagerSingleton eager;

	SingletonThread(LazySingleton lazy, EagerSingleton eager) {
		this.lazy = lazy;
		this.eager = eager;
	}

	public void run() {
		lazy = LazySingleton.getInstance();
		eager = EagerSingleton.getInstance();
	}
}
