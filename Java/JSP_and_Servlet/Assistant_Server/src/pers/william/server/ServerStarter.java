package pers.william.server;

import pers.william.database.QAAOper;

public class ServerStarter {
	public static void main(String []args){
		QAAOper qaao=new QAAOper();
		
		qaao.addQAA(0, "How are you?", "I'm fine, thanks.");
		qaao.addQuestion(1, "ÄãÊÇË­£¿");
		qaao.addQuestion(2, "ÄãÊÇË­2£¿");
		qaao.addQuestion(3, "ÄãÊÇË­3£¿");
		qaao.modifyQAA(3, 3, "123", "456");
		qaao.Query("u");
		
	}
}
