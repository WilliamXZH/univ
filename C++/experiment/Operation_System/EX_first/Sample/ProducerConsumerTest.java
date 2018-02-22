
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
		return "��Ʒ" + this.id;
	}
}

class Container {// ��������ջ���Ƚ����
	private int index = 0;
	Goods[] goods = new Goods[6];

	public synchronized void push(Goods good) {
		while (index == goods.length) {// ���������ˣ������ߵȴ�
			try {
				wait();
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		goods[index] = good;
		index++;
		notifyAll();// �������߷�����Ʒ��֪ͨ������
	}

	public synchronized Goods pop() {
		while (index == 0) {// ��������û����Ʒ�ǵȴ�
			try {
				wait();
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		index--;
		notifyAll();// ����������������Ʒ��֪ͨ������
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
			System.out.println("�����ˣ�" + good);
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
			System.out.println("�����ˣ�" + good);
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
