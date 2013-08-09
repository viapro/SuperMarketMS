package com.viapro.sm.web.servlet;

import java.io.IOException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.viapro.sm.bean.User;
import com.viapro.sm.service.impl.UserServiceImpl;

public class GotoUserEditPageServlet extends HttpServlet {

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
		
		request.getSession().setAttribute("year", Calendar.getInstance().get(Calendar.YEAR));
		request.setAttribute("currentPage", request.getParameter("currentPage"));
		request.setAttribute("userName", request.getParameter("userName"));
		request.setAttribute("userGender", request.getParameter("userGender"));
		request.setAttribute("user_to_edit_id", request.getParameter("user_to_edit_id"));
		
		if(request.getParameter("isAdd")!=null && request.getParameter("isAdd").equals("true")){
			request.setAttribute("isAdd", true);
			request.setAttribute("isEdit", false);
		} else if (request.getParameter("isEdit")!=null && request.getParameter("isEdit").equals("true")){
			if(request.getParameter("user_to_edit_id")==null || request.getParameter("user_to_edit_id").equals("")) {
				request.getRequestDispatcher("/error.jsp").forward(request, response);
				return;
			}
			request.setAttribute("user_to_edit", usi.getUserById(request.getParameter("user_to_edit_id")));
			request.setAttribute("isAdd", false);
			request.setAttribute("isEdit", true);
		} else if (request.getParameter("isModifyPassword")!=null && request.getParameter("isModifyPassword").equals("true")){
			request.setAttribute("isAdd", false);
			request.setAttribute("isEdit", false);
			request.setAttribute("isModifyPassword", true);
		} else if(request.getParameter("doModifyPassword")!=null && request.getParameter("doModifyPassword").equals("true")){
			//加强非空判断
			for(String param : new String[]{request.getParameter("oldPassword"),request.getParameter("newPassword"),
					request.getParameter("newPasswordConfirm"),request.getParameter("user_to_edit_id")})
				if(param==null || param.equals("")) {
					request.getRequestDispatcher("/error.jsp").forward(request, response);
					return;
				}
			User user = usi.getUserById(request.getParameter("user_to_edit_id"));
			if(request.getParameter("oldPassword").equals(user.getPassword())){
				user.setPassword(request.getParameter("newPassword"));
				if(usi.updateUser(user)) request.setAttribute("message", "该用户密码修改成功");
				else request.setAttribute("message", "该用户密码修改失败");
			} else request.setAttribute("message", "旧密码错误，该用户密码未修改");
			request.setAttribute("isEdit", true);
			request.setAttribute("user_to_edit", usi.getUserById(request.getParameter("user_to_edit_id")));
		}
		request.getRequestDispatcher("/WEB-INF/page/userEdit.jsp").forward(request, response);
	}
}
