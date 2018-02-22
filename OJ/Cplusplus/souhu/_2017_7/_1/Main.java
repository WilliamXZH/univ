import java.util.*;
public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        while (sc.hasNext()) {
            StringBuilder yy = new StringBuilder();
            yy.append(sc.next());
            int cnt = sc.nextInt();
            int count = 0;
            while (count < cnt) {
                int len = yy.length() -1;
                int s = 0;
                while (s < len && yy.codePointAt(s) >= yy.codePointAt(s+1))
                s++;
                yy.deleteCharAt(s);
                count++; //¼ÇÂ¼É¾³ý¸öÊý  
            }
            System.out.println(yy);
        }
    }
}