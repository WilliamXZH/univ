import java.util.Scanner;
 
public class Main {
 
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println(gem(sc.nextLine()));
        sc.close();
    }
 
    public static int gem(String str) {
        char[] ca = str.toCharArray();
        int len = str.length();
        for (int x = 5; x < len; x++) { // xΪ��ȡ��ʯ�ĸ���
            for (int y = 0; y < len; y++) {//yΪxȷ��������µ����Ĵ���
                StringBuilder temp = new StringBuilder("");
                for (int z = y; z < y + x; z++) {
                    temp.append(ca[z % len]);
                }
                String t = temp.toString();
                if (t.contains("A") && t.contains("B") && t.contains("C") && t.contains("D") && t.contains("E")) {
                    return len - x;
                }
            }
        }
        return 0;
    }
}