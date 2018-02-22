import java.util.concurrent.Callable;
import java.util.concurrent.FutureTask;
import java.util.concurrent.ExecutionException;
import java.util.Random;
public class CallableAndFuture
{
	public static void main(String []args){
		Callable<Integer> callable = new Callable<Integer>(){
			public Integer call() throws Exception{
				System.out.println("Random:");
				return new Random().nextInt(100);
			}
		};
		FutureTask<Integer> future = new FutureTask<Integer>(callable);
		new Thread(future).start();
		try{
			Thread.sleep(5000);
			System.out.println(future.get());
		}catch(InterruptedException e){
			e.printStackTrace();
		}catch(ExecutionException e){
			e.printStackTrace();
		}
	}
}