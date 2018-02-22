
public class ProducerConsumerTest {
	public static void main(String[] args) {
		Container con = new Container();
		Producer p = new Producer(con);
		Consumer c = new Consumer(con);
		new Thread(p).start();
		new Thread(c).start();
	}

}

class Goods {
	int id;

	public Goods(int id) {
		this.id = id;
	}

	public String toString() {
		return "商品" + this.id;
	}
}

class Container {// 容器采用栈，先进后出
	private int index = 0;
	Goods[] goods = new Goods[6];

	public synchronized void push(Goods good) {
		while (index == goods.length) {// 当容器满了，生产者等待
			try {
				wait();
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		goods[index] = good;
		index++;
		notifyAll();// 当生产者放入商品后通知消费者
	}

	public synchronized Goods pop() {
		while (index == 0) {// 当容器内没有商品是等待
			try {
				wait();
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		index--;
		notifyAll();// 当消费者消费了商品后通知生产者
		return goods[index];
	}
}

class Producer implements Runnable {

	Container con = new Container();

	public Producer(Container con) {
		this.con = con;
	}

	public void run() {
		for (int i = 0; i < 20; i++) {
			Goods good = new Goods(i);
			con.push(good);
			System.out.println("生产了：" + good);
			try {
				Thread.sleep(100);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}

class Consumer implements Runnable {

	Container con = new Container();

	public Consumer(Container con) {
		this.con = con;
	}

	public void run() {
		for (int i = 0; i < 20; i++) {
			Goods good = con.pop();
			System.out.println("消费了：" + good);
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
