package com.viapro.sm.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * 数据库管理类
 */
public class DBManager {

	private String driver = ConfigManager.getInstance().getString(
			"jdbc.driver_class");
	private String url = ConfigManager.getInstance().getString(
			"jdbc.connection.url");
	private String user = ConfigManager.getInstance().getString(
			"jdbc.connection.username");
	private String password = ConfigManager.getInstance().getString(
			"jdbc.connection.password");

//	注册驱动
	public DBManager() {
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

//	获取连接
	public Connection getConnection() {
		Connection conn = null;
		try {
			conn = DriverManager.getConnection(url, user, password);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}

//	关闭资源
	public void closeResource(Connection conn, Statement stmt, ResultSet rs) {
		try {
			if (rs != null)
				rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
					if (conn != null)
						conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

}
