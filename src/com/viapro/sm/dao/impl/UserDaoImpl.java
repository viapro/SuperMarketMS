package com.viapro.sm.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.viapro.sm.bean.User;
import com.viapro.sm.dao.UserDao;

public class UserDaoImpl extends BaseDaoImpl<User> implements UserDao {
	//这个是UserDao特有的查询方法
	@Override
	public User getUserByUsername(String username){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<User> list = null;
		StringBuilder sql = new StringBuilder("SELECT * FROM viapro_user WHERE UPPER(username) = UPPER(?)");
		try {
			conn = dbm.getConnection();
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, username);
			rs = pstmt.executeQuery();
			list = sealT(rs);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbm.closeResource(conn, pstmt, rs);
		}
		if(list.size()==0) return null;
		else return (User) list.get(0);
	}
}
