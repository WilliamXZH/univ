package pers.william.test;

public class Client {
	public static String getClientSQL(int n){
		//int n=ids.length;
		
		String tmp="prompt Loading CLIENT...\r\n";
		String first="赵钱孙李周吴郑王冯陈楮卫蒋沈韩杨"
				+ "朱秦尤许何吕施张孔曹严华金魏陶姜"
				+ "戚谢邹喻柏水窦章云苏潘葛奚范彭郎"
				+ "鲁韦昌马苗凤花方俞任袁柳酆鲍史唐"
				+ "费廉岑薛雷贺倪汤滕殷罗毕郝邬安常"
				+ "乐于时傅皮卞齐康伍余元卜顾孟平黄"
				+ "和穆萧尹姚邵湛汪祁毛禹狄米贝明臧"
				+ "计伏成戴谈宋茅庞熊纪舒屈项祝董梁"
				+ "杜阮蓝闽席季麻强贾路娄危江童颜郭"
				+ "梅盛林刁锺徐丘骆高夏蔡田樊胡凌霍"
				+ "虞万支柯昝管卢莫经房裘缪干解应宗"
				+ "丁宣贲邓郁单杭洪包诸左石崔吉钮龚"
				+ "程嵇邢滑裴陆荣翁荀羊於惠甄麹家封"
				+ "芮羿储靳汲邴糜松井段富巫乌焦巴弓"
				+ "牧隗山谷车侯宓蓬全郗班仰秋仲伊宫"
				+ "宁仇栾暴甘斜厉戎祖武符刘景詹束龙"
				+ "叶幸司韶郜黎蓟薄印宿白怀蒲邰从鄂"
				+ "索咸籍赖卓蔺屠蒙池乔阴郁胥能苍双"
				+ "闻莘党翟谭贡劳逄姬申扶堵冉宰郦雍"
				+ "郤璩桑桂濮牛寿通边扈燕冀郏浦尚农"
				+ "温别庄晏柴瞿阎充慕连茹习宦艾鱼容"
				+ "向古易慎戈廖庾终暨居衡步都耿满弘"
				+ "匡国文寇广禄阙东欧殳沃利蔚越夔隆"
				+ "师巩厍聂晁勾敖融冷訾辛阚那简饶空"
				+ "曾毋沙乜养鞠须丰巢关蒯相查后荆红"
				+ "游竺权逑盖益桓公";
		String road[]={"新秀街","白塔街","南塔街","泉园街","丰乐街"
				,"马关桥街","东陵街","英达街","前进街","东湖街"
				,"五三街","桃仙街","祝家街","高坎街","李相街"};
		int size=first.length();
		
		for(int i=0;i<n;i++){
			//ids[i]=Utils.getRandomInt()%1000+300;
//			boolean flag=true;
//			while(flag){
//				flag=false;
//				//ids[i]=Utils.getRandomInt()%1000+300;
//				for(int j=0;j<i;j++){
//					if(ids[i]==ids[j]){
//						flag=true;
//						break;
//					}
//				}
//			}
			
			tmp+="insert into CLIENT (id, name, address, tel) values ("
					//+ids[i]+",\'"+first.charAt(Utils.getRandomInt()%size)
					+(i+1)+",\'"+first.charAt(Utils.getRandomInt()%size)
					//+ids[i]+"\',\'浑南新区"+road[Utils.getRandomInt()%road.length]+ids[i]
					+i+"\',\'浑南新区"+road[Utils.getRandomInt()%road.length]+i
					+"号\',\'"+(Utils.getRandomInt()%100000+100000)+""
					+(Utils.getRandomInt()%90000+10000)+"\');\r\n";
			if(i%100==99)tmp+="commit;\r\n"
					+"prompt "+(i+1)+" records committed...\r\n";
		}
		
		
		return tmp;
	}
}
