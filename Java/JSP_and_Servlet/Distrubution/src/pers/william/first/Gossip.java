package pers.william.first;

import java.util.Random;

public class Gossip {
	
	private int k=3;
	private int n=1000;
	int gossip[]=new int[n];
	public static void main(String[] args){
		new Gossip().start();
	}
	private void start(){
		for(int i=0;i<n;i++){
				gossip[i]=0;
		}
		
		new gossipThread(0,0).start();	

		try {
			Thread.sleep(5000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		int count=0;
		for(int i=0;i<n;i++){
				System.out.print(gossip[i]+"\t");
				if(gossip[i]==0)count++;
			if((i+1)%10==0) System.out.print("#\n");
		}
		System.out.println("count:"+count);
		
	}
	class gossipThread extends Thread{
		int cur;
		int par;
		Random ran=new Random();
		gossipThread(int c,int p){
			this.cur=c;
			this.par=p;
		}
		
		public void run(){
			boolean flag=true;
			
//			int count=2;
//			int tmp[]=new int[n];
//			tmp[0]=par;
//			tmp[1]=cur;
			
			gossip[cur]=1;
			while(flag){
				int next = 0;
//				boolean flag2=true;
//				while(flag2){
//					flag2=false;
					next=ran.nextInt()%n;
					next=next<0?-next:next;					
//					for(int i=0;i<count;i++){
//						if(next==tmp[i])flag2=true;
//					}
//				}
				if(gossip[next]!=1){
//					tmp[count]=next;
//					count++;
					new gossipThread(next,cur).start();
				}else{
					int test=ran.nextInt()%k;
					test=test<0?-test:test;
					if(test<1){
						flag=false;
					}else{
						continue;
					}
					
				}
			}			
		}
	}
}
