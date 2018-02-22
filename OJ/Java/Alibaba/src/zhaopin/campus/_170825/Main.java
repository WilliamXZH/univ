package zhaopin.campus._170825;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		List<UnilateralLine> lineList = new ArrayList<UnilateralLine>();
		while (scanner.hasNextLine()) {
			String[] options = scanner.nextLine().split(";");
			if (options.length < 5) {
				break;
			}
			lineList.add(new UnilateralLine(options[0], options[1], options[2], options[3], options[4], options[5]));
		}
		scanner.close();

		// wirte your code here
		List<String> result = calculateUnilateral(lineList);

		for (String str : result) {
			System.out.println(str);
		}
	}
	
	public static boolean calc(List<UnilateralLine> list,String sc, String sp, 
			Integer cur,boolean flags[],String res){
		UnilateralLine line = list.get(cur);
		if(sc.equals(line.getECen())||sp.equals(line.getEPro())){
			return true;
		}else{
			boolean flag = false;
			for(int i=0;i<flags.length;i++){
				if(!flags[i]){
					flag = true;
					break;
				}
			}
			if(!flag){
				return false;
			}
		}
		
		for(int j=0;j<list.size();j++){
			UnilateralLine line2 = list.get(j);
			if(j!=cur&&!flags[j]&&
					(list.get(cur).getECen().equals(line2.getSCen())
							||list.get(cur).getSPro().equals(line2.getSPro()))){
				if(calc(list,sc,sp,j,flags,res)){
					flags[j] = true;
					res = list.get(j).getId() +"+"+ res;
					return true;
				}
			}
		}
		
		return false;
	}

	public static List<String> calculateUnilateral(List<UnilateralLine> lineList) {
		List<String> result = new ArrayList<String>();
		
		int size = lineList.size();
		boolean flags[] = new boolean[size];
		
		for(int i=0;i<size;i++){
			UnilateralLine unilateralLine = lineList.get(i);
			
			if(!flags[i]){
				String sc = unilateralLine.getSCen();
				String sp = unilateralLine.getSPro();
				String ec = unilateralLine.getECen();
				String ep = unilateralLine.getEPro();
				
				String res = "";
				if(calc(lineList,sc,sp,i,flags,res)){
					res = lineList.get(i).getId() + "+" + res;
					result.add(res);
				}
				
			}
			
		}
		
		return result;
	}

	public static class UnilateralLine {
		private String id;
		private String sCen;// 出发分拨
		private String sPro;// 出发省
		private String eCen;// 到达分拨
		private String ePro;// 到达省
		// 9.6m/17.5m
		private String tType;// 车型

		public UnilateralLine(String id, String sCen, String sPro, String eCen, String ePro, String tType) {
			this.id = id;
			this.sCen = sCen;
			this.sPro = sPro;
			this.eCen = eCen;
			this.ePro = ePro;
			this.tType = tType;
		}

		public String getId() {
			return id;
		}

		public void setId(String id) {
			this.id = id;
		}

		public String getSCen() {
			return sCen;
		}

		public void setSCen(String ePro) {
			this.ePro = ePro;
		}

		public String getSPro() {
			return sPro;
		}

		public void setSPro(String sPro) {
			this.sPro = sPro;
		}

		public String getECen() {
			return eCen;
		}

		public void setECen(String eCen) {
			this.eCen = eCen;
		}

		public String getEPro() {
			return ePro;
		}

		public void setEPro(String ePro) {
			this.ePro = ePro;
		}

		public String getTType() {
			return tType;
		}

		public void setTType(String tType) {
			this.tType = tType;
		}
	}
}