package pers.william.database;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import pers.william.question.QAAContainer;
import pers.william.utils.NumOper;
import pers.william.utils.RSOper;
import pers.william.question.QAA;

public class QAAOper {

	//private Connection conn=MySQLDB.getConn();	
	private Statement stmt=MySQLDB.getStmt();
	
	public QAAContainer Query(String keyword){
		QAAContainer tem=new QAAContainer();
		String sql="select * from qaa";
		
		try{
			//Statement stat=conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
			
			while(rs.next()){
				if(rs.getString(3).contains(keyword)
						||rs.getString(4).contains(keyword)){
					System.out.println("Query:"+rs.getInt(1));
					tem.add(new QAA(rs.getInt(1),rs.getInt(2),rs.getString(3),rs.getString(4)));
				}
			}
			System.out.println("Query qaa about "+keyword);
		}catch(SQLException e){
			e.printStackTrace();
		}
		return  tem;
	}
	public boolean addQuestion(int type,String que){
		return this.addQAA(type, que, null);
	}
	public boolean addQAA(int type,String que,String ans){
		return modifyQAA(-1,type,que,ans);
	}
	public boolean modifyQAA(int id,int newType,String newQue,String newAns){
		String sql="select * from qaa";
		String sql2="select * from qaa where que_id="+id+";";
		
		try{
			int count=0;
			String sql_tem;
			//Statement stat=conn.createStatement();
			
			count=RSOper.getSize(stmt.executeQuery(sql2));
			
			if(count>0){
				sql_tem="update qaa set que_type="
			+newType+",question="+newQue+",answer="+newAns+" where que_id="+id+";";
				
			}else{					
				while(true){
					int tem=0;
					ResultSet rs=stmt.executeQuery(sql);
					id=NumOper.getRandomId();
					while(rs.next()){
						if(rs.getInt(1)!=id){
							tem++;
						}else{
							break;
						}
					}					
					if(tem>=RSOper.getSize(stmt.executeQuery(sql))){
						break;
					}
				}
				sql_tem="insert into qaa value("
				+id+","+newType+",\""+newQue+"\",\""+newAns+"\");";
			}
			System.out.println("count_"+count+"_id_"+id+":"+sql_tem);
			
			return stmt.execute(sql_tem);
			
		}catch(SQLException e){
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean removeQuestion(int id){
		String sql="delete from qaa where que_id="+id+";";
		
		try{
			//Statement stat=conn.createStatement();
			System.out.println(sql);
			
			return stmt.execute(sql);
		}catch(SQLException e){
			e.printStackTrace();
		}
		return false;
	}
}
