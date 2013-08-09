package com.viapro.sm.dao;

import com.viapro.sm.bean.User;

public interface UserDao extends BaseDao<User> {

	User getUserByUsername(String username);

}
