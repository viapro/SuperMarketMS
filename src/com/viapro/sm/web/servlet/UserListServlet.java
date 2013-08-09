package com.viapro.sm.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.viapro.sm.bean.User;
import com.viapro.sm.service.impl.UserServiceImpl;
import com.viapro.sm.util.Page;

public class UserListServlet extends HttpServlet {

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
		
		String userName = request.getParameter("userName");
		String userGender = request.getParameter("userGender");
		String currentPage = request.getParameter("currentPage");
		
		request.setAttribute("userName", userName);
		request.setAttribute("userGender", userGender);
		request.setAttribute("currentPage", currentPage);
		
		if("".equals(userName)) userName = null;
		Page<User> page = usi.getUserPage(userName, userGender, currentPage);
		request.setAttribute("page", page);
		request.getRequestDispatcher("/WEB-INF/page/userList.jsp").forward(request, response);
	}

}
