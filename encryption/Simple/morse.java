import java.util.Scanner;
public class morse
{
	String []morseKeyLetter={"01","1000","1010","100",
		"0","0010","110","0000",
		"00","0111","101","0100",
		"11","10","111","0110",
		"1101","010","000","1",
		"001","0001","011","1001",
		"1011","1100"};
	String []morseKeyDigit={"11111","01111","00111","00011","00001",
		"00000","10000","11000","11100","11110"
	};
	String []morseKeyPunc={"101011","010010","#","0001001",
	"%","0000","011110","10110","101101","*","+","110011","001101",
	"010101","10010"
	};
	String []morseKeyPunc2={"111000","101010","<","10001",">","001100","011010"
	};
	public static void main(String []args){
		Scanner scan=new Scanner(System.in);
		morse t=new morse();
		String str=scan.next();
		System.out.println(str);
		System.out.println(t.EncreptionByMorse(str));
		System.out.println(t.DecreptionByMorse(t.EncreptionByMorse(str)));
	}
	public String EncreptionByMorse(String OriText){
		int Length=OriText.length();
		String EncrepText="";
		OriText=OriText.toLowerCase();
		if(Length>0){
			if(Character.isDigit(OriText.charAt(0))){
				EncrepText+=morseKeyDigit[OriText.charAt(0)-'0'];
			}else{//isLetter()
				EncrepText+=morseKeyLetter[OriText.charAt(0)-'a'];
			}
		}else return EncrepText;
		for(int i=1;i<Length;i++){
			char CurrentChar=OriText.charAt(i);
			if(Character.isDigit(CurrentChar)){
				EncrepText+="."+morseKeyDigit[CurrentChar-'0'];
			}else{//isLetter()
				EncrepText+="."+morseKeyLetter[CurrentChar-'a'];
			}
		}
		return EncrepText;
	}
	public String DecreptionByMorse(String OriText){
		String []HandText=OriText.split("\\.");
		String result="";
		for(int i=0;i<HandText.length;i++){
			boolean flag=false;
			for(int j=0;j<morseKeyLetter.length;j++){
				//System.out.println(HandText[i]+"\t"+morseKeyLetter[j]);
				if(HandText[i].equals(morseKeyLetter[j])){
					flag=true;
					result+=(char)('a'+j);
					break;
				}
			}
			if(!flag){
				for(int j=0;j<morseKeyDigit.length;j++){
					if(HandText[i].equals(morseKeyDigit[j])){
						result+=(char)('0'+j);
						break;
					}
				}
			}
		}
		return result;
	}
}
