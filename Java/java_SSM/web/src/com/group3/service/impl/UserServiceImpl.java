package com.group3.service.impl;


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

}
