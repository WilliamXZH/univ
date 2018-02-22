public class Main {
	public static void main(String[] args) throws IOException {
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		DecimalFormat df = new DecimalFormat("0.00000000");
		String input = br.readLine();
		int n = Integer.valueOf(input);
		double[] nums = new double[n];
		for (int i = 0; i < n; i++)
			nums[i] = Double.parseDouble(br.readLine());
		double max = 0;//全局最小值
		int j = 1;
		for (int i = 0; i < n; i++) {
			double m = 0;//局部最小值
			for (; j < n;) {
				boolean f = false;
				double max0 = Math.abs(nums[j] - nums[i]);
				if (max0 > 180) {
					max0 = 360 - max0;
					if (max0 > m) {
						m = max0;
					}
					break;
				}else{
					m = max0;
					j++;
				}
			}
			max = max > m ? max : m;
			if (j == n)
				break;
		}
		System.out.println(df.format(max));
	}
}
