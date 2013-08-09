package com.viapro.sm.dao.impl;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.viapro.sm.bean.Bill;
import com.viapro.sm.bean.Identify;
import com.viapro.sm.bean.Provider;
import com.viapro.sm.bean.User;
import com.viapro.sm.dao.BaseDao;
import com.viapro.sm.util.DBManager;
import com.viapro.sm.util.Page;

public class BaseDaoImpl<T> implements BaseDao<T> {

	@SuppressWarnings("rawtypes")
	private Class clazz;
	protected DBManager dbm;
	
	//使用反射获取泛型内的类型信息
	@SuppressWarnings("rawtypes")
	public BaseDaoImpl() {
		ParameterizedType pt = (ParameterizedType) this.getClass().getGenericSuperclass();
		clazz = (Class) pt.getActualTypeArguments()[0];
		dbm = new DBManager();
	}
	
	//添加
	@Override
	public boolean add(T t) {
		if (t == null)
			return false;
		if (getById(((Identify) t).getId()) != null)
			return false;
		StringBuilder sql = new StringBuilder("INSERT INTO ");
		if (clazz.getName().endsWith("Bill")) sql.append("viapro_bill VALUES(?,?,?,?,?,?,?,SYSDATE)");
		else if (clazz.getName().endsWith("Provider")) sql.append("viapro_PROVIDER VALUES(?,?,?,?,?,?,?)");
		else if (clazz.getName().endsWith("User")) sql.append("viapro_user VALUES(?,?,?,?,?,?,?,?)");
		return executeAddOrUpdate(t, sql.toString(), true); // true means execute add.
	}
	
	//根据Id删除
	@Override
	public boolean deleteById(Serializable id) {
		if (id == null) return false;
		if (getById(id) == null) return false;
		boolean isSuccess = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		StringBuilder sql = new StringBuilder("DELETE ");
		if (clazz.getName().endsWith("Bill")) sql.append("viapro_bill ");
		else if (clazz.getName().endsWith("Provider")) sql.append("viapro_provider ");
		else if (clazz.getName().endsWith("User")) sql.append("viapro_user ");
		sql.append("WHERE ID=?");
		try {
			conn = dbm.getConnection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, id.toString());
			isSuccess = pstmt.executeUpdate() == 0 ? false : true;
			conn.commit();
		} catch (java.sql.SQLIntegrityConstraintViolationException e){
			System.out.println("违反完整约束条件!");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbm.closeResource(conn, pstmt, null);
		}
		return isSuccess;
	}

	//修改
	@Override
	public boolean update(T t) {
		if (t == null)
			return false;
		if (getById(((Identify) t).getId()) == null)
			return false;
		StringBuilder sql = new StringBuilder("UPDATE ");
		if (clazz.getName().endsWith("Bill"))
			sql.append("viapro_bill SET PRODUCT_NAME=?,AMOUNT=?,MONEY=?,PAYSTATE=?,PROVIDER_ID=?,PRODUCT_DESC=? WHERE ID=?");
		else if (clazz.getName().endsWith("Provider"))
			sql.append("viapro_provider SET proName=?,proDesc=?,CONTACT=?,TEL=?,FAX=?,ADDRESS=? WHERE ID=?");
		else if (clazz.getName().endsWith("User"))
			sql.append("viapro_user SET username=?,PASSWORD=?,gender=?,yob=?,mobile=?,address=?,privilege=? WHERE ID=?");
		return executeAddOrUpdate(t, sql.toString(), false); // false means execute update.
	}
	
	//根据Id查询
	@Override
	public T getById(Serializable id) {
		T t = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sql = new StringBuilder("select * from ");
		if (clazz.getName().endsWith("Bill")) sql.append("viapro_bill ");
		else if (clazz.getName().endsWith("Provider")) sql.append("viapro_provider ");
		else if (clazz.getName().endsWith("User")) sql.append("viapro_user ");
		sql.append("where id=?");
		try {
			conn = dbm.getConnection();
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, id.toString());
			rs = pstmt.executeQuery();
			List<T> list = sealT(rs);
			if (list.size() == 0) t = null;
			else t = list.get(0);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbm.closeResource(conn, pstmt, rs);
		}
		return t;
	}

	//根据姓名和属性来查询分页列表
	@Override
	public List<T> getPageList(String name, String attr, Integer start, Integer end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean isConcat = false;
		boolean isName = isExist(name);
		boolean isAttr = isExist(attr);
		boolean isPage = start!=null && end!=null;
		List<T> list = null;
		StringBuilder sql = new StringBuilder("SELECT * FROM (");
		if (clazz.getName().endsWith("Bill")) {
			sql.append("SELECT b.*, ROWNUM rn FROM viapro_bill b ");
			if (isName) {
				sql.append("WHERE UPPER(b.PRODUCT_NAME) like UPPER(?) ");
				isConcat = true;
			}
			if (isAttr) {
				if (isConcat) sql.append("AND b.PAYSTATE like ?");
				else sql.append("WHERE b.PAYSTATE like ?");
			}
		} else if (clazz.getName().endsWith("Provider")) {
			sql.append("SELECT p.*, ROWNUM rn FROM viapro_provider p ");
			if (isName) {
				sql.append("WHERE UPPER(p.proName) like UPPER(?) ");
				isConcat = true;
			}
			if (isAttr) {
				if (isConcat) sql.append("AND UPPER(p.proDesc) like UPPER(?)");
				else sql.append("Where UPPER(p.proDesc) like UPPER(?)");
			}
		} else if (clazz.getName().endsWith("User")) {
			sql.append("SELECT u.*, ROWNUM rn FROM viapro_user u ");
			if (isName) {
				sql.append("WHERE UPPER(u.username) like UPPER(?) ");
				isConcat = true;
			}
			if (isAttr) {
				if (isConcat) sql.append("AND u.gender like ?");
				else sql.append("WHERE u.gender like ?");
			}
		}
		sql.append(") ");
		if (isPage)
			sql.append("WHERE rn>=? AND rn<=?");
		try {
			conn = dbm.getConnection();
			pstmt = conn.prepareStatement(sql.toString());
			if (isName) {
				pstmt.setString(1, "%" + name + "%");
				if (isAttr) {
					pstmt.setString(2, "%" + attr + "%");
					if (isPage) {
						pstmt.setInt(3, start);
						pstmt.setInt(4, end);
					}
				} else {
					if (isPage) {
						pstmt.setInt(2, start);
						pstmt.setInt(3, end);
					}
				}
			} else {
				if (isAttr) {
					pstmt.setString(1, "%" + attr + "%");
					if (isPage) {
						pstmt.setInt(2, start);
						pstmt.setInt(3, end);
					}
				} else {
					if (isPage) {
						pstmt.setInt(1, start);
						pstmt.setInt(2, end);
					}
				}
			}
			rs = pstmt.executeQuery();
			list = sealT(rs);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbm.closeResource(conn, pstmt, rs);
		}
		return list;
	}

	//根据查询返回Page对象
	public Page<T> getPage(String name, String attr, String currentPage) {
		int rowCount = getRowCount(name, attr);
		if (currentPage == null || "".equals(currentPage)) {
			Page<T> page = new Page<T>(rowCount, 1);
			List<T> list = getPageList(null, null, 1, page.getPageSize());
			page.setList(list);
			return page;
		} else {
			Page<T> page = new Page<T>(rowCount, Integer.parseInt(currentPage));
			List<T> list = getPageList(name, attr, page.getStart() + 1, page.getStart() + page.getPageSize());
			page.setList(list);
			return page;
		}
	}
	
	//把查询行数的方法单独用SQL来优化，分页才有了意义。
	private int getRowCount(String name, String attr) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int rowCount = 0;
		boolean isConcat = false;
		boolean isName = isExist(name);
		boolean isAttr = isExist(attr);
		StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM");
		if (clazz.getName().endsWith("Bill")) {
			sql.append(" viapro_bill");
			if (isName) {
				sql.append(" WHERE UPPER(PRODUCT_NAME) like UPPER(?) ");
				isConcat = true;
			}
			if (isAttr) {
				if (isConcat) sql.append(" AND PAYSTATE like ?");
				else sql.append(" WHERE PAYSTATE like ?");
			}
		} else if (clazz.getName().endsWith("Provider")) {
			sql.append(" viapro_provider");
			if (isName) {
				sql.append(" WHERE UPPER(proName) like UPPER(?) ");
				isConcat = true;
			}
			if (isAttr) {
				if (isConcat) sql.append(" AND UPPER(proDesc) like UPPER(?)");
				else sql.append(" Where UPPER(proDesc) like UPPER(?)");
			}
		} else if (clazz.getName().endsWith("User")) {
			sql.append(" viapro_user");
			if (isName) {
				sql.append(" WHERE UPPER(username) like UPPER(?) ");
				isConcat = true;
			}
			if (isAttr) {
				if (isConcat) sql.append(" AND gender like ?");
				else sql.append(" WHERE gender like ?");
			}
		}
		try {
			conn = dbm.getConnection();
			pstmt = conn.prepareStatement(sql.toString());
			if (isName) {
				pstmt.setString(1, "%" + name + "%");
				if (isAttr) pstmt.setString(2, "%" + attr + "%");
			} else if (isAttr) pstmt.setString(1, "%" + attr + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) rowCount = rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbm.closeResource(conn, pstmt, rs);
		}
		return rowCount;
	}
	
	//获取查询结果并封装到对象
	@SuppressWarnings("unchecked")
	protected List<T> sealT(ResultSet rs) {
		if (clazz.getName().endsWith("Bill")) {
			List<Bill> Bills = new ArrayList<Bill>();
			try {
				while (rs.next()) {
					Bill bill = new Bill();
					bill.setId(rs.getInt("Id"));
					bill.setProductName(rs.getString("PRODUCT_NAME"));
					bill.setAmount(rs.getInt("amount"));
					bill.setMoney(rs.getInt("MONEY"));
					bill.setPaystate(rs.getInt("PAYSTATE"));
					bill.setProviderId(rs.getInt("PROVIDER_ID"));
					bill.setProductDesc(rs.getString("PRODUCT_DESC"));
					bill.setBillDate(rs.getDate("billdate"));
					Bills.add(bill);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return (List<T>) Bills;
		} else if (clazz.getName().endsWith("Provider")) {
			List<Provider> providers = new ArrayList<Provider>();
			try {
				while (rs.next()) {
					Provider pro = new Provider();
					pro.setId(rs.getInt("Id"));
					pro.setProName(rs.getString("ProName"));
					pro.setProDesc(rs.getString("proDesc"));
					pro.setContact(rs.getString("CONTACT"));
					pro.setTel(rs.getString("TEL"));
					pro.setFax(rs.getString("FAX"));
					pro.setAddress(rs.getString("ADDRESS"));
					providers.add(pro);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return (List<T>) providers;
		} else if (clazz.getName().endsWith("User")) {
			List<User> users = new ArrayList<User>();
			try {
				while (rs.next()) {
					User user = new User();
					user.setId(rs.getInt("Id"));
					user.setUsername(rs.getString("username"));
					user.setPassword(rs.getString("password"));
					user.setGender(rs.getInt("gender"));
					user.setYob(rs.getInt("yob"));
					user.setMobile(rs.getString("mobile"));
					user.setAddress(rs.getString("address"));
					user.setPrivilege(rs.getInt("privilege"));
					users.add(user);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return (List<T>) users;
		}
		return null;
	}
	
	//根据isAdd来执行增加或修改
	private boolean executeAddOrUpdate(T t, String sql, boolean isAdd) {
		boolean isSuccess = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int[] seatNum;
		conn = dbm.getConnection();
		if (clazz.getName().endsWith("Bill")) {
			seatNum = (isAdd) ? new int[] { 1, 2, 3, 4, 5, 6, 7 } : new int[] { 7, 1, 2, 3, 4, 5, 6 };
			try {
				conn.setAutoCommit(false);
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(seatNum[0], Integer.valueOf(((Bill) t).getId().toString()));
				pstmt.setString(seatNum[1], ((Bill) t).getProductName());
				pstmt.setInt(seatNum[2], ((Bill) t).getAmount());
				pstmt.setInt(seatNum[3], ((Bill) t).getMoney());
				pstmt.setInt(seatNum[4], ((Bill) t).getPaystate());
				pstmt.setInt(seatNum[5], ((Bill) t).getProviderId());
				pstmt.setString(seatNum[6], ((Bill) t).getProductDesc());
				conn.commit();
				isSuccess = pstmt.executeUpdate() == 0 ? false : true;
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				dbm.closeResource(conn, pstmt, rs);
			}
			return isSuccess;
		} else if (clazz.getName().endsWith("Provider")) {
			seatNum = (isAdd) ? new int[] { 1, 2, 3, 4, 5, 6, 7 } : new int[] { 7, 1, 2, 3, 4, 5, 6 };
			try {
				conn.setAutoCommit(false);
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(seatNum[0], Integer.valueOf(((Provider) t).getId().toString()));
				pstmt.setString(seatNum[1], ((Provider) t).getProName());
				pstmt.setString(seatNum[2], ((Provider) t).getProDesc());
				pstmt.setString(seatNum[3], ((Provider) t).getContact());
				pstmt.setString(seatNum[4], ((Provider) t).getTel());
				pstmt.setString(seatNum[5], ((Provider) t).getFax());
				pstmt.setString(seatNum[6], ((Provider) t).getAddress());
				conn.commit();
				isSuccess = pstmt.executeUpdate() == 0 ? false : true;
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				dbm.closeResource(conn, pstmt, rs);
			}
			return isSuccess;
		} else if (clazz.getName().endsWith("User")) {
			seatNum = (isAdd) ? new int[] { 1, 2, 3, 4, 5, 6, 7, 8 } : new int[] { 8, 1, 2, 3, 4, 5, 6, 7 };
			try {
				 conn.setAutoCommit(false);
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(seatNum[0], Integer.valueOf(((User) t).getId().toString()));
				pstmt.setString(seatNum[1], ((User) t).getUsername());
				pstmt.setString(seatNum[2], ((User) t).getPassword());
				pstmt.setInt(seatNum[3], ((User) t).getGender());
				pstmt.setInt(seatNum[4], ((User) t).getYob());
				pstmt.setString(seatNum[5], ((User) t).getMobile());
				pstmt.setString(seatNum[6], ((User) t).getAddress());
				pstmt.setInt(seatNum[7], ((User) t).getPrivilege());
				conn.commit();
				isSuccess = pstmt.executeUpdate() == 0 ? false : true;
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				dbm.closeResource(conn, pstmt, rs);
			}
			return isSuccess;
		}
		return isSuccess;
	}
	
	//返回数据的有效性
	private boolean isExist(String str){
		return str!=null && !str.equals("");
	}
}
