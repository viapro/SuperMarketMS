package com.viapro.sm.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.viapro.sm.bean.Bill;
import com.viapro.sm.service.impl.BillServiceImpl;
import com.viapro.sm.service.impl.ProviderServiceImpl;
import com.viapro.sm.util.Page;

public class BillListServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private BillServiceImpl bsi = null;
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
		String productName = request.getParameter("productName");
		String payStatus = request.getParameter("payStatus");
		String currentPage = request.getParameter("currentPage");
		
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("productName", productName);
		request.setAttribute("payStatus", payStatus);
		
		request.setAttribute("providers",psi.getAllProviderList());
		Page<Bill> page = bsi.getBillPage(productName, payStatus, currentPage);
		request.setAttribute("page", page);
		request.getRequestDispatcher("/WEB-INF/page/billList.jsp").forward(request, response);
	}

}
