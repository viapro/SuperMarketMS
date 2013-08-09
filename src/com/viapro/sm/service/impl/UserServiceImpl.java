package com.viapro.sm.service.impl;

import java.io.Serializable;

import com.viapro.sm.bean.User;
import com.viapro.sm.dao.impl.UserDaoImpl;
import com.viapro.sm.service.UserService;
import com.viapro.sm.util.Page;

public class UserServiceImpl implements UserService{
	
	private UserDaoImpl udi = null;
	
	public UserServiceImpl(){
		udi = new UserDaoImpl();
	}

	@Override
	public boolean addUser(User user) {
		return udi.add(user);
	}

	@Override
	public boolean deleteUserById(Serializable id) {
		return udi.deleteById(id);
	}

	@Override
	public boolean updateUser(User user) {
		return udi.update(user);
	}

	@Override
	public User getUserById(Serializable id) {
		return udi.getById(id);
	}

	@Override
	public Page<User> getUserPage(String username, String gender, String currentPage) {
		return udi.getPage(username, gender, currentPage);
	}

	@Override
	public User getUserByUserName(String userName) {
		return udi.getUserByUsername(userName);
	}
}
