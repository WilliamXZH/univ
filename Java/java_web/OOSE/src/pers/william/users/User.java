package pers.william.users;

import java.util.List;

public abstract class User {
	String UserId;
	String UserName;
	String Password;
	List<User> Friends;
	
	abstract boolean login();
}
