package com.viapro.sm.web.servlet;

import java.io.IOException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.viapro.sm.bean.User;
import com.viapro.sm.service.impl.UserServiceImpl;

public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
		super.init();
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		UserServiceImpl usi = new UserServiceImpl();
		
		request.getSession().setAttribute("year", Calendar.getInstance().get(Calendar.YEAR));
		
		String userName = request.getParameter("userName");
		String password = request.getParameter("passWord");
		
		User user = usi.getUserByUserName(userName);

		if( user == null ){
			request.setAttribute("message","用户不存在");
			request.getRequestDispatcher("/login.jsp").forward(request, response);
			return ;
		}
		
		boolean isSuccess = false;
		
		if(user.getPassword().equals(password)) isSuccess = true;
		
		if(!isSuccess){
			request.setAttribute("message","密码输入错误");
			request.setAttribute("userName",userName);
			request.getRequestDispatcher("/login.jsp").forward(request, response);
			return ;
		}
		
		request.getSession().setAttribute("user", user);
		request.getRequestDispatcher("/WEB-INF/page/admin_index.jsp").forward(request, response);
	}
}
