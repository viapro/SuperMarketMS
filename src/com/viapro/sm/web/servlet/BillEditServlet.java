package com.viapro.sm.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.viapro.sm.bean.Bill;
import com.viapro.sm.service.impl.BillServiceImpl;
import com.viapro.sm.service.impl.ProviderServiceImpl;

public class BillEditServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	ProviderServiceImpl psi = null;
	BillServiceImpl bsi = null;

	@Override
	public void init() throws ServletException {
		super.init();
		psi = new ProviderServiceImpl();
		bsi = new BillServiceImpl();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		Bill bill=new Bill();
		
		request.setAttribute("currentPage", request.getParameter("currentPage"));
		request.setAttribute("productName", request.getParameter("productName"));
		request.setAttribute("payStatus", request.getParameter("payStatus"));
		request.setAttribute("providers", psi.getAllProviderList());
		
		if(request.getParameter("isDelete")!=null && request.getParameter("isDelete").equals("true")){
			String id = request.getParameter("id");
			if(bsi.deleteBillById(id))
				request.setAttribute("message", "编号为"+id+"的账单已删除");
			else request.setAttribute("message", "账单删除失败");
		} else {
			
			//加强非空判断，以防止非法的数据提交。
			for(String param : new String[]{request.getParameter("id"),request.getParameter("amount"),request.getParameter("product_name"),
					request.getParameter("money"),request.getParameter("pay_state"),request.getParameter("providerId")})
				if(param==null || param.equals("")) {
					request.getRequestDispatcher("/error.jsp").forward(request, response);
					return;
				}
			
			bill.setId(Integer.valueOf(request.getParameter("id")));
			bill.setProductName(request.getParameter("product_name"));
			bill.setAmount(Integer.valueOf(request.getParameter("amount")));
			bill.setMoney(Integer.valueOf(request.getParameter("money")));
			bill.setPaystate(Integer.valueOf(request.getParameter("pay_state")));
			bill.setProviderId(Integer.valueOf(request.getParameter("providerId")));
			bill.setProductDesc(request.getParameter("productDesc"));
			
			if(request.getParameter("isAdd")!=null && request.getParameter("isAdd").equals("true")){
				if(bsi.addBill(bill))
					request.setAttribute("message", "编号为"+bill.getId().toString()+"的账单已添加");
				else{
					request.setAttribute("bill_to_add", bill);
					request.setAttribute("message", "编号为"+bill.getId().toString()+"的账单已存在，请修改后重新提交");
					request.getRequestDispatcher("GotoBillEditPage.do").forward(request, response);
					return;
				}
			} else if(request.getParameter("isUpdate")!=null && request.getParameter("isUpdate").equals("true")){
				if(bsi.updateBill(bill)) request.setAttribute("message", "编号为"+bill.getId().toString()+"的账单已修改");
				else request.setAttribute("message", "账单修改失败");
			}
		}
		request.getRequestDispatcher("BillList.do").forward(request, response);
	}

}
