public class Bubble
{
	public static void main(String []args){
		int a[] = {2,5,1,7,8,9};
		//System.out.println(a.length);
		for(int i=0;i<a.length;i++){
			//System.out.print(a[i]+":");
			for(int j=a.length-1;j>0;j--){
				if(a[j]<a[j-1]){
//					a[j] = a[j]^a[j+1];
//					a[j+1] = a[j]^a[j+1];
//					a[j] = a[j]^a[j+1];
					int tmp = a[j];
					a[j] = a[j-1];
					a[j-1] = tmp;
				}
			}
			System.out.println(a[i]);
		}

	}
}