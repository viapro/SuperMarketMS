package com.viapro.sm.service;

import java.io.Serializable;

import com.viapro.sm.bean.User;
import com.viapro.sm.util.Page;

public interface UserService {
	boolean addUser(User user);
	boolean deleteUserById(Serializable id);
	boolean updateUser(User user);
	User getUserById(Serializable id);
	Page<User> getUserPage(String username, String gender, String currentPage);
	User getUserByUserName(String userName);
}
