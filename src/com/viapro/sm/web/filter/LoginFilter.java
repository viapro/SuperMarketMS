package com.viapro.sm.web.filter;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

import com.viapro.sm.bean.User;

@WebFilter("/LoginFilter")
public class LoginFilter implements Filter {

	private Set<String> initUrl = null;

	public LoginFilter() {
	}

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		
		String path = req.getServletPath();
		// 如果访问的路径是 Login.do或Logout.do放行
		if (path.equals("/Login.do")||path.equals("/Logout.do")) {
			chain.doFilter(request, response);
			return;
		}

		// 验证用户的登陆状态（1正常登陆 2没有登陆）
		User user = (User) req.getSession().getAttribute("user");
		// 如果没有登陆（拦截，并导向到登陆页面）
		if (user == null) {
			request.getRequestDispatcher("/error.jsp").forward(request, response);
			return;
		} else {
			// 判断访问路径，是否有权限访问
			if (initUrl.contains(path)) {
				// 如果是经理，放行
				if (user.getPrivilege() == 0) {		
					chain.doFilter(request, response);
					return;
				} else {	// 如果没有， 跳转到错误页面
					request.getRequestDispatcher("/error.jsp").forward(request, response);
					return;
				}
			} else {
				chain.doFilter(request, response);
				return;
			}
		}
	}

	public void init(FilterConfig fConfig) throws ServletException {
		initUrl = new HashSet<String>();
		initUrl.add("/GotoProviderEditPage.do");
		initUrl.add("/ProviderList.do");
		initUrl.add("/ProviderEdit.do");
		initUrl.add("/GotoUserEditPage.do");
		initUrl.add("/UserList.do");
		initUrl.add("/UserEdit.do");
	}

}
