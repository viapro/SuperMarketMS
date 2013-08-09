package com.viapro.sm.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.viapro.sm.bean.Provider;
import com.viapro.sm.service.impl.ProviderServiceImpl;

public class ProviderEditServlet extends HttpServlet {

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
		
		request.setAttribute("currentPage", request.getParameter("currentPage"));
		request.setAttribute("providerName", request.getParameter("providerName"));
		request.setAttribute("providerDesc", request.getParameter("providerDesc"));//需要字符转换
		
		if(request.getParameter("isDelete")!=null && request.getParameter("isDelete").equals("true")){
			String id = request.getParameter("id");
			if(psi.deleteProviderById(id))
				request.setAttribute("message", "编号为"+id+"的供应商已删除");
			else request.setAttribute("message", "编号为"+id+"的供应商正在合作中，不能被删除");
		} else {
			//加强非空判断
			for(String param : new String[]{request.getParameter("id"),request.getParameter("proName")})
			if(param==null || param.equals("")) {
				request.getRequestDispatcher("/error.jsp").forward(request, response);
				return;
			}
			Provider provider = new Provider();
			provider.setId(Integer.valueOf(request.getParameter("id")));
			provider.setProName(request.getParameter("proName"));
			provider.setProDesc(request.getParameter("proDesc"));
			provider.setContact(request.getParameter("contact"));
			provider.setTel(request.getParameter("tel"));
			provider.setFax(request.getParameter("fax"));
			provider.setAddress(request.getParameter("address"));
			
			if(request.getParameter("isAdd")!=null && request.getParameter("isAdd").equals("true")){
				if(psi.addProvider(provider)) request.setAttribute("message", "编号为"+provider.getId()+"的供应商已添加");
				else{
					request.setAttribute("provider_to_add", provider);
					request.setAttribute("message", "编号为"+provider.getId()+"的供应商已存在，请修改编号后重新提交");
					request.getRequestDispatcher("GotoProviderEditPage.do").forward(request, response);
					return;
				}
			}else if(request.getParameter("isUpdate")!=null && request.getParameter("isUpdate").equals("true")){
				if(psi.updateProvider(provider)) request.setAttribute("message", "编号为"+provider.getId()+"的供应商已修改");
				else request.setAttribute("message", "供应商修改失败");
			}
		}
		request.getRequestDispatcher("ProviderList.do").forward(request, response);
	}

}
