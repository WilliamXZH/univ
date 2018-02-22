package book_user;
public class User {
	private String UserName;
	private String UserPassword;
	public User(String username,String userpassword){
			this.UserName=username;
			this.UserPassword=userpassword;
	}
	
	
	public String getUserPassword() {
		return UserPassword;
	}
	public void setUserPassword(String userPassword) {
		UserPassword = userPassword;
	}
	public String getUserName() {
		return UserName;
	}
	public void setUserName(String userName) {
		UserName = userName;
	}
}
