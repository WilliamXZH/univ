package com.group3.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.group3.mapper.UserMapper;
import com.group3.po.User;
import com.group3.service.UserService;

@Service
public class UserServiceImpl implements UserService {

	@Resource
	UserMapper userMapper;

	@Override
	public User userLogin(User user) {
		//System.out.println(user);
		return userMapper.userLogin(user);

	}

	@Override
	public boolean userRegister(User user) {
		System.out.println(user);
		int result = userMapper.userRegister(user);
		if (result > 0) {
			return true;
		}
		return false;
	}

	@Override
	public User getUserInfo(String id) {
		// TODO Auto-generated method stub
		User currentUser = userMapper.selectUserInfo(id);
		return currentUser;
	}

	@Override
	public boolean retirevePassword(User user) {
		if (userMapper.retrievePassword(user) > 0) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public User getUserByCel(User user) {
		return userMapper.selectUserByCelAndIdtfNum(user);
	}

	@Override
	public User getUserByMail(User user) {
		return userMapper.selectUserByMailAndIdtfNum(user);
	}

	@Override
	public boolean updateUserInfo(User user, String property) {
		// TODO Auto-generated method stub
		boolean flag = false;
		int result = 0;
		switch (property) {
		case "password":
			result = userMapper.updatePassword(user);
			break;
		case "telNum":
			result = userMapper.updateTelNum(user);
			break;
		case "mail":
			result = userMapper.updateMail(user);
			break;
		case "userType":
			result = userMapper.updateUserType(user);
			break;
		case "address":
			result = userMapper.updateAddress(user);
			break;
			
		}
		if (result > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public boolean testUserByCel(String telNum) {
		if (userMapper.testUserByCel(telNum) != null) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean testUserByMail(String mail) {
		if (userMapper.testUserByMail(mail) != null) {
			return true;
		} else {
			return false;
		}
	}

}
