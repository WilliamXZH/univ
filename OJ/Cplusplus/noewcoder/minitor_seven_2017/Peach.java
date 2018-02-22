import java.util.Scanner;
import java.util.List;
import java.util.ArrayList;
class Peach{

    public static void main(String[] args){
		Scanner scanner = new Scanner(System.in);
		Integer total = scanner.nextInt();
		List<Integer> numbers = new ArrayList<>();
		for(int i=0;i<total;i++){
			Integer num = scanner.nextInt();
			numbers.add(num);
		}
		System.out.println(getMax(numbers,0,0));
    }

	public static Integer getMax(List<Integer> numbers,Integer cur,Integer min){
		if(cur==numbers.size()){
			return 0;
		}

		if(numbers.get(cur)<min||numbers.get(cur)==0){
			return getMax(numbers,cur+1,min);
		}else{
			Integer num1 = getMax(numbers,cur+1,min);
			Integer num2 = getMax(numbers,cur+1,numbers.get(cur))+1;
			return num1>num2?num1:num2;
		}

	}
}