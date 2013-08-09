package com.viapro.sm.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.viapro.sm.bean.Provider;
import com.viapro.sm.service.impl.BillServiceImpl;
import com.viapro.sm.service.impl.ProviderServiceImpl;

public class GotoProviderEditPageServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	BillServiceImpl bsi = null;
	ProviderServiceImpl psi = null;

	@Override
	public void init() throws ServletException {
		super.init();
		bsi = new BillServiceImpl();
		psi = new ProviderServiceImpl();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setAttribute("currentPage", request.getParameter("currentPage"));
		request.setAttribute("providerName", request.getParameter("providerName"));
		request.setAttribute("providerDesc", request.getParameter("providerDesc"));
		
		if(request.getParameter("isAdd")!=null && request.getParameter("isAdd").equals("true"))
			request.setAttribute("isEdit", false);
		else if(request.getParameter("isEdit")!=null && request.getParameter("isEdit").equals("true")){
			Provider prvoider = psi.getProviderById(request.getParameter("provider_to_edit_id"));
			request.setAttribute("provider_to_edit", prvoider);
			request.setAttribute("isEdit", true);
		}
		request.getRequestDispatcher("/WEB-INF/page/providerEdit.jsp").forward(request, response);
	}

}
