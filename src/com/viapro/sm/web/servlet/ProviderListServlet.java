package com.viapro.sm.web.servlet;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.viapro.sm.bean.Provider;
import com.viapro.sm.service.impl.ProviderServiceImpl;
import com.viapro.sm.util.Page;

public class ProviderListServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	ProviderServiceImpl psi = null;

	@Override
	public void init() throws ServletException {
		super.init();
		psi = new ProviderServiceImpl();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String providerName = request.getParameter("providerName");
		String providerDesc = request.getParameter("providerDesc");
		String currentPage = request.getParameter("currentPage");
		
		request.setAttribute("providerName", providerName);
		request.setAttribute("providerDesc", providerDesc);
		request.setAttribute("currentPage", currentPage);
		
		Page<Provider> page = psi.getProviderPage(providerName, providerDesc, currentPage);
		request.setAttribute("page", page);
		request.getRequestDispatcher("/WEB-INF/page/providerList.jsp").forward(request, response);
	}

}
