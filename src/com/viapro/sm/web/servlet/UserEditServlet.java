package com.viapro.sm.web.servlet;

import java.io.IOException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.viapro.sm.bean.User;
import com.viapro.sm.service.impl.UserServiceImpl;

public class UserEditServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	UserServiceImpl usi = null;

	@Override
	public void init() throws ServletException {
		super.init();
		usi = new UserServiceImpl();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setAttribute("currentPage", request.getParameter("currentPage"));
		request.setAttribute("userName", request.getParameter("userName"));
		request.setAttribute("userGender", request.getParameter("userGender"));
		request.setAttribute("message", "");
		
		if(request.getParameter("isDelete")!=null && request.getParameter("isDelete").equals("true")){
			String id = request.getParameter("id");
			if(usi.deleteUserById(id))
				request.setAttribute("message", "编号为"+id+"的用户已删除");
			else request.setAttribute("message", "用户删除失败");
		} else {
			//加强非空判断
			for(String param : new String[]{request.getParameter("id"),request.getParameter("gender"),
					request.getParameter("age"),request.getParameter("auth")})
				if(param==null || param.equals("")) {
					request.getRequestDispatcher("/error.jsp").forward(request, response);
					return;
				}
			
			User user = new User();
			user.setId(Integer.valueOf(request.getParameter("id")));
			user.setUsername(request.getParameter("username"));
			user.setGender(Integer.valueOf(request.getParameter("gender")));
			user.setYob((Calendar.getInstance().get(Calendar.YEAR))-Integer.valueOf(request.getParameter("age")));
			user.setMobile(request.getParameter("mobile"));
			user.setAddress(request.getParameter("address"));
			user.setPrivilege(Integer.valueOf(request.getParameter("auth")));
			
			if(request.getParameter("isAdd")!=null && request.getParameter("isAdd").equals("true")){
				boolean isIdExist = usi.getUserById(user.getId())!=null;
				boolean isNameExist = usi.getUserByUserName(user.getUsername())!=null;
				if(isIdExist || isNameExist){
					if (isIdExist) request.setAttribute("message", "编号为"+user.getId()+"的用户已存在，请修改编号后重新提交");
					else if (isNameExist) request.setAttribute("message", "该用户名已经存在，请修改后重新提交");
					request.setAttribute("user_to_add", user);
					request.getRequestDispatcher("GotoUserEditPage.do").forward(request, response);
					return;
				}
				user.setPassword(request.getParameter("password"));
				if(usi.addUser(user)) request.setAttribute("message", "编号为"+user.getId()+"的用户已添加");
				
			} else if(request.getParameter("isUpdate")!=null && request.getParameter("isUpdate").equals("true")){
				user.setPassword(usi.getUserById(request.getParameter("id")).getPassword()); //补充密码信息
				if(usi.updateUser(user)) request.setAttribute("message", "编号为"+user.getId()+"的用户信息已修改");
				else request.setAttribute("message", "用户修改失败");
			}
		}
		request.getRequestDispatcher("UserList.do").forward(request, response);
	}

}
