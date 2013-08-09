package com.viapro.sm.service.impl;

import java.io.Serializable;
import java.util.List;

import com.viapro.sm.bean.Bill;
import com.viapro.sm.dao.impl.BillDaoImpl;
import com.viapro.sm.service.BillService;
import com.viapro.sm.util.Page;

public class BillServiceImpl implements BillService{
	
	private BillDaoImpl bdi = null;
	
	public BillServiceImpl(){
		bdi = new BillDaoImpl();
	}
	
	@Override
	public Page<Bill> getBillPage(String productName,String paystate, String currentPage){
		return bdi.getPage(productName, paystate, currentPage);
	}
	
	@Override
	public boolean addBill(Bill bill) {
		return bdi.add(bill);
	}

	@Override
	public boolean deleteBillById(Serializable id) {
		return bdi.deleteById(id);
	}

	@Override
	public boolean updateBill(Bill bill) {
		return bdi.update(bill);
	}

	@Override
	public Bill getBillById(Serializable id) {
		return bdi.getById(id);
	}

	@Override
	public List<Bill> getAllBillList() {
		return bdi.getPageList(null, null, null, null);
	}
}
