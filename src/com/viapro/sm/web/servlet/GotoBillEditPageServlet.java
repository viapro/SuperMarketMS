package com.viapro.sm.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.viapro.sm.bean.Bill;
import com.viapro.sm.service.impl.BillServiceImpl;
import com.viapro.sm.service.impl.ProviderServiceImpl;

public class GotoBillEditPageServlet extends HttpServlet {

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
		request.setAttribute("productName", request.getParameter("productName"));
		request.setAttribute("payStatus", request.getParameter("payStatus"));
		if(request.getParameter("isAdd")!=null && request.getParameter("isAdd").equals("true")){
			request.setAttribute("isEdit", false);
		}
		if(request.getParameter("isEdit")!=null && request.getParameter("isEdit").equals("true")){
			Bill bill = bsi.getBillById(request.getParameter("bill_to_edit_id"));
			request.setAttribute("bill_to_edit", bill);
			request.setAttribute("isEdit", true);
		}
		request.setAttribute("providers", psi.getAllProviderList());
		request.getRequestDispatcher("/WEB-INF/page/billEdit.jsp").forward(request, response);
	}

}
