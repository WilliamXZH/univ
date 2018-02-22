import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class UserinfoDAO {

	public List<Userinfo> userlist = new ArrayList<Userinfo>();
	UserinfoDAO(){
		userlist.add(new Userinfo("Tom","Tom"));
		userlist.add(new Userinfo("123","123"));
		userlist.add(new Userinfo("jack","jack"));
		userlist.add(new Userinfo("luly","luly"));
		userlist.add(new Userinfo("lily","lily"));
		userlist.add(new Userinfo("Jerry","Jerry"));
	}
	public boolean validateUser(String name, String pass) {
		// TODO Auto-generated method stub
		for(int i=0;i<userlist.size();i++){
			Userinfo temuser=userlist.get(i);
			if(temuser.getName().equals(name)&&temuser.getpass().equals(pass))
				return true;
		}
		/*for(Userinfo temuser:userlist){
			if(temuser.getName().equals(name)&&temuser.getpass().equals(pass))
				return true;
			
		}
		Iterator<Userinfo> it=userlist.iterator();
		Userinfo temuser=null;
		while((temuser=it.next())!=null){
			if(temuser.getName().equals(name)&&temuser.getpass().equals(pass))
				return true;
		}*/
		return false;
	}
	public List<Userinfo> getUserList(){
		return this.userlist;
	}
	public Userinfo getUserinfo(String name){
		for(int i=0;i<userlist.size();i++){
			if(name.equals(userlist.get(i).getName())){
				return userlist.get(i);
			}
		}
		return null; 
	}

}
