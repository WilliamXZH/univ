package pers.william.server;

import pers.william.database.QAAOper;

public class ServerStarter {
	public static void main(String []args){
		QAAOper qaao=new QAAOper();
		
		qaao.addQAA(0, "How are you?", "I'm fine, thanks.");
		qaao.addQuestion(1, "����˭��");
		qaao.addQuestion(2, "����˭2��");
		qaao.addQuestion(3, "����˭3��");
		qaao.modifyQAA(3, 3, "123", "456");
		qaao.Query("u");
		
	}
}
