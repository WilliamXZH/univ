package com.group3.service;


import com.group3.po.User;

public interface UserService {
	
public User userLogin(User user);
	
	public boolean userRegister(User user);

	public User getUserInfo(String id);
	public User getUserByCel(User user);
	public User getUserByMail(User user);
	public boolean testUserByCel(String telNum);
	public boolean testUserByMail(String mail);
	
	public boolean retirevePassword(User user);
	/**
	 * 
	 * @param user 修改后的user对象
	 * @param property 修改的属性
	 * @return
	 */
	public boolean updateUserInfo(User user,String property);
	
}
