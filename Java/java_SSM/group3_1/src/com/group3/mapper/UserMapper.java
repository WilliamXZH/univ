package com.group3.mapper;



import com.group3.po.User;

public interface UserMapper {

	public User userLogin(User user);
	public User selectUserInfo(String id);
	public User selectUserByMailAndIdtfNum(User user);
	public User selectUserByCelAndIdtfNum(User user);
	public User testUserByCel(String telNum);
	public User testUserByMail(String mail);
	public int userRegister(User user);
	public int retrievePassword(User user);
	public int updatePassword(User user);
	public int updateTelNum(User user);
	public int updateMail(User user);
	public int updateUserType(User user);
	public int updateAddress(User user);
}
